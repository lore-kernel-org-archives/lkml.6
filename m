Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43926C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0847122504
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 14:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="au2Pdffi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0847122504
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbeKLXzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 18:55:23 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43690 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728505AbeKLXzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 18:55:23 -0500
Received: by mail-lj1-f193.google.com with SMTP id g26-v6so7683103lja.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 06:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+KPbkn5urFFfkzfZS0TvEZfq4tyZAQJ0Uw9KelL5tKc=;
        b=au2PdffixVQAszlTF6RP4KZRSQDTS06/HCtTsKz7xUyb7F4Uguyv8eBk7xbtx0BDwx
         liyWPor+NJMJGcjLxfLUt/A9eVjNwrMuiGSZ7zf0vowyZ5c3m19OB/A5GPWFp3OZDSBH
         LRIgGBKnbouKPbWOi2Yg/i5HTAMTrUEGy+4ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+KPbkn5urFFfkzfZS0TvEZfq4tyZAQJ0Uw9KelL5tKc=;
        b=Czl90/ZHUecKWiV4DLFZ7VCNWwZEdC/H25V19fWFYngJjG3LDnuCJgCV2yqFoioBol
         Q4IOt27fKJ5eNSJcR6JN3D1CH2sDoCpKmOlrqSgY/EJNoLQH6pEpf8YuIcF/X0nJ42qS
         MpPbGHvtHSaXiJxw6SlpSJb2fqvKyPNUj8zyusww2NYBBgfsNN1JthaC9n98dc43MoUl
         kj12cOSDmPRZGNrjhP96vlfHDwJ0zwAdfaiPzt7G7ji+eOpVnmQaH0dfjcghCcYJXa8o
         +ob9JFttxm+HSrEMaq/UEgJmoBVyIhm8mrKbSO1Ex0Q/y0VGFvZ7dpgkyUVLSFje+e+8
         SCSA==
X-Gm-Message-State: AGRZ1gKDD5wnNMBA5HhoyQTurSkvN5Lv4mRbLCLp+v3rtfcc8P5Z4Dpu
        aRpbza7cvD3N3bTAZzbHJQbIkjwIrneEGnsXXcfDsg==
X-Google-Smtp-Source: AJdET5cmWAfCFYOMABLNi0qoQ73pKfCMg4rgFUB8ctt10DfGNtPRaVp5BLnUlW12tA4Dfn7Z1dEpgtNb+DWdk3ZD/TQ=
X-Received: by 2002:a2e:5152:: with SMTP id b18-v6mr678746lje.88.1542031317882;
 Mon, 12 Nov 2018 06:01:57 -0800 (PST)
MIME-Version: 1.0
References: <20181111221647.665769131@linuxfoundation.org>
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Mon, 12 Nov 2018 19:31:46 +0530
Message-ID: <CA+G9fYvZ+cTSWtAjW5SY6vAZSaAnW2HJGaOHsASzK5hy423zqA@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/222] 4.14.81-stable review
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

On Mon, 12 Nov 2018 at 04:02, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.81 release.
> There are 222 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Nov 13 22:15:32 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.81-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.14.81-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 8ea94372bf0017762d8c4f9e2a53800304820e0e
git describe: v4.14.80-223-g8ea94372bf00
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.80-223-g8ea94372bf00

No regressions (compared to build v4.14.80)

Ran 21309 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- i386
- juno-r2 - arm64
- qemu_arm
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
* ltp-cve-tests
* ltp-fcntl-locktests-tests
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
* ltp-containers-tests
* ltp-filecaps-tests
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--
Linaro LKFT
https://lkft.linaro.org
