Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E761C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10741218A3
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 13:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cmp8CqTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731053AbfA3NQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 08:16:45 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42246 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfA3NQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 08:16:44 -0500
Received: by mail-lj1-f196.google.com with SMTP id l15-v6so20680627lja.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 05:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ecHevTa+wmOj9nBSe0AU/HkNfi0hIoD/6bIcSgmUMJA=;
        b=cmp8CqTJ+CI0BXivUPPOi3LU3saq5xnVk63jwHcaIpeRSckgvnN9J48Ysn0DMyPWzZ
         bmEKF1wf9brhV5dq2/muB/Ys/64YEY2U2OLOQ4zAefcYpf64JN7ONyrwqQo4RpkyvnPI
         QBTqx5Om4aCqF3ULRE4DzzikBhbaFG4IgEqO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ecHevTa+wmOj9nBSe0AU/HkNfi0hIoD/6bIcSgmUMJA=;
        b=B96ej6xcxuii2GtmaDzruf8HFU4Ba6T9B0GFxoDWkHCjjvEjUSUU24Klu6bHmjzZGD
         TrFKBhwXFdVmugoyEjy90Fw75SAxP2lcj5ngKoy8KhBZh9z/9prtiVKRqUZPjRrOH/Fa
         iFyXpOSBWyLvF9EMiQpwWT1x231PtkXihTeSzxcfcrGdcvyci7knXFN9sVJF1snmgFcb
         NM5kLA0xz/cgKOgbXryVNgY13hZY4NN/iFaqm8BqDEbBmg173Dqcvbvv6w8bSlg7HBaB
         FTALdy2x2TPe8KWrzmfV7SAVqfQvd5LA7fFwLF/uhofaho3xCrDKVmyGS2Si0BnBMXRP
         4U9Q==
X-Gm-Message-State: AHQUAuYSGtQc0qO3D7sc8Ob0d8sZZzNPFZRXqTltmmuwb51VumDgj9zi
        ZASlWW53WoEC9IaWG2HIREwZ0+JJsM4kXbbUFRP5nA==
X-Google-Smtp-Source: AHgI3IaAzpgLc2bLbA99GYqOPwZS6qSr0mldes4DdzLdfY07PkCS7T75+FIHFqcTvqhXVQguf/D5Oo4XdkSQ/kMCO84=
X-Received: by 2002:a2e:3012:: with SMTP id w18-v6mr1768612ljw.75.1548854202350;
 Wed, 30 Jan 2019 05:16:42 -0800 (PST)
MIME-Version: 1.0
References: <20190129113159.567154026@linuxfoundation.org>
In-Reply-To: <20190129113159.567154026@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Wed, 30 Jan 2019 18:46:31 +0530
Message-ID: <CA+G9fYv_vGnrJ7xmFtxybV9U+VfW4fik0mX40_prnMQ2LnwSdA@mail.gmail.com>
Subject: Re: [PATCH 4.19 000/103] 4.19.19-stable review
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

On Tue, 29 Jan 2019 at 17:13, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.19.19 release.
> There are 103 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu Jan 31 11:31:30 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.19.19-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.19.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

RC2 report.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.19.19-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.19.y
git commit: d0a51a4dd99af17e1f6a0d3758b9c2a7a6c0014a
git describe: v4.19.18-104-gd0a51a4dd99a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/bu=
ild/v4.19.18-104-gd0a51a4dd99a

No Regressions (compared to build v4.19.18)

No fixes (compared to build v4.19.18)


Ran 19574 total tests in the following environments and test suites.

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
* install-android-platform-tools-r2600
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-cpuhotplug-tests
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
* ltp-mm-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* spectre-meltdown-checker-test
* ltp-open-posix-tests
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

--=20
Linaro LKFT
https://lkft.linaro.org
