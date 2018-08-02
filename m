Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD07C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A5320C09
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="glgJ23vr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39A5320C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727142AbeHBIrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:47:10 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39802 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbeHBIrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:47:10 -0400
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so957987lji.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 23:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fagzDcCichf1gcyD+kdyaQ1u5vYECVyaR1ANTrhbU2c=;
        b=glgJ23vrN18qNpGiVU2xMgH2lQGW13YIOMEkKqTJjPiLeam7AXzbUT/uqi3jj06lFP
         rU6ZwF9gTd0qAnjyhkvrt/MCLY3zaz6GPkGiLW6K5MRGqLnFX9ghjlvAy11I4SepE1Zc
         ASqm75zMwi0Ij++V3/gMHFl5cTBZPByfgcjz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fagzDcCichf1gcyD+kdyaQ1u5vYECVyaR1ANTrhbU2c=;
        b=EDLh10s/lm9lkg+qirJvg9Gr0Kp2nUYFRSeDPQesJChbuJ9WmINiewOciuC5ILYhde
         QGPMprt2y6N9y8L5cR+kEXt6Gmgs5DUlWS5ym/f0gJBhMJu74UWMHLqA96NNwHNxPjfI
         Jw8an01b2Kho+LkaMHg8qtEt2yY6eMmQhN8Mr9FR+h2UuUAajgQd5p3mT7+dA2ziiXn1
         geJ4wUbDcvLFBOhLPMRjaniEJNh8yAfRn3NISNQjKPZWWZKMXiNNnbr3abeevHHDVIcL
         ZkSqJ2yv6czCDUoF8eLUakhoywCxwrsSzptYRQr22nN6prPskdcf39dC/ci0iICR4NIa
         J7Cw==
X-Gm-Message-State: AOUpUlFQexqmX3p4sXH6svolefBYCcahwdKyD6OEkUEO5zCU8DlaaLjn
        HPUJw7nPVdGppAM2t2SpQlVuaFdxjJMHk2ptAA91lw==
X-Google-Smtp-Source: AAOMgpcJSlF6jUnTykVthYQtG0qyW7E/1pFFn7Wp6GFOGil3QEYdlH1PHl4SFXzrCScdcObhqsjn0AMuJBnrWS46jas=
X-Received: by 2002:a2e:9e55:: with SMTP id g21-v6mr1156375ljk.116.1533193045189;
 Wed, 01 Aug 2018 23:57:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a19:169b:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 23:57:24 -0700 (PDT)
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 2 Aug 2018 12:27:24 +0530
Message-ID: <CA+G9fYtXfNtufXr=_w4Rdq-WaYXb52yeY7x58k5oMJcHP28r7Q@mail.gmail.com>
Subject: Re: [PATCH 4.17 000/336] 4.17.12-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 August 2018 at 22:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.17.12 release.
> There are 336 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri Aug  3 16:49:21 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.17.12-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.17.12-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.17.y
git commit: a7e0b37ac7bfee2dc0e9560d86ac518979244313
git describe: v4.17.11-337-ga7e0b37ac7bf
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.17-oe/bu=
ild/v4.17.11-337-ga7e0b37ac7bf

No regressions (compared to build v4.17.11-337-g90ebeb339f8f)


Ran 13775 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
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
