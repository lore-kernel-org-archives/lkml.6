Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96FCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E33214C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 04:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UJHJ+vt/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E33214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeJJLf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 07:35:56 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34931 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbeJJLfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 07:35:55 -0400
Received: by mail-lf1-f67.google.com with SMTP id r191-v6so2911616lff.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 21:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=iEtRdggnd6VnMaOVuM+wVI9+FK6p2u4twBtun5zz7A4=;
        b=UJHJ+vt/UvwYxapczj6lnjwTkRxNcgBl8JX0nfr3C00AR8IsfyDKLg3lZd/0K3MrJI
         toOc1aW8QYhkxjnpKs0oUJuKkgQZy2pSqLg4YRf/WXymZPhJmL6F5AyrBIC7ihdMlc/7
         t95G1I5T7w2E4OlzyWxgmLoOCDHYChpn8z7vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=iEtRdggnd6VnMaOVuM+wVI9+FK6p2u4twBtun5zz7A4=;
        b=XFjy+IBDsEoCZWJdR82FJ2iXM/ls+YGb4dixcXEuGB5au16nhrmiF0jFeYGj5FRDaw
         2royueuVLqKhjNr1v1jMoTlxg8NwWyhKeW/21rbtaqWMlzduhDMI/xlrCbCQNE1+4vYe
         Lr/vj8wGoygBAJ79b87ch3j4Om1Zf9YBSAzfly9uvuXF03kpxrZ0KISnxMmGyhvqufd/
         i78lrjPQZrahACBzWJ0PbxoRrqB3M+OsWM6EXpBC38iDeB2p5enm5ru471U2C3sUD2Ap
         00JYZjCokRf77HQhYpnmclnVeJ3fvdbXB4KJoba7rZQ+Ttjl+4R4hdisww9gj65UYnmu
         bTxA==
X-Gm-Message-State: ABuFfoh3Y7A29u45WyrUqOfPCMxIa+LKaO5F9UsJr9z9MGQBQ021gtMG
        owQMDKFbw5h7oJoVPxb+4+6aVSlYbnC3i/UoFxK+v0OlaJs=
X-Google-Smtp-Source: ACcGV62bZos05P12xCdNXGK2BroUlVDg7Z6W96nAETZWIFY/n06El8lIslpAXYzazFQhKp7wYiIV981uiM1sbCvmJ1M=
X-Received: by 2002:a19:6719:: with SMTP id b25-v6mr16940229lfc.54.1539144941744;
 Tue, 09 Oct 2018 21:15:41 -0700 (PDT)
MIME-Version: 1.0
References: <20181008175546.620836256@linuxfoundation.org>
In-Reply-To: <20181008175546.620836256@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 10 Oct 2018 09:45:30 +0530
Message-ID: <CA+G9fYv5qpnZAP8ex8UjmiyvaKzJAHsRxMYp0G9SzspyvNLYiw@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/59] 4.9.132-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2018 at 00:08, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.9.132 release.
> There are 59 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Oct 10 17:55:28 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.132-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.9.132-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 610c33176e692eba4072ed7afbe58d397b6e4567
git describe: v4.9.131-60-g610c33176e69
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.131-60-g610c33176e69


No regressions (compared to build v4.9.131)

No fixes (compared to build v4.9.131)


Ran 16766 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm64
- qemu_i386
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* boot
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cve-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
