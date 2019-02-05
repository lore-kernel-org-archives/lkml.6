Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59458C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2839F2081B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 06:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="egX4DuQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbfBEGi2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 01:38:28 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42093 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfBEGi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 01:38:27 -0500
Received: by mail-lf1-f67.google.com with SMTP id l10so1764287lfh.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 22:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1maxEcAchvdDqjmsVVf1k9ghg1pzhvcvogbSDxjjLyw=;
        b=egX4DuQdez5eWKyCpHtTxxQaXppdDKd/qZPI/B7IndY+GW7MkhzxTFzJPbMSkYSR4C
         0zmFuEZhRNoIieV1sXO5cyOBCPblrqLYfaz7OqS3y+sM+LHLkb4imkHHlsdtFY47ygnn
         tUcR05K+Gm25BzwL2ln9EyKEyguRS0pFTb2tM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1maxEcAchvdDqjmsVVf1k9ghg1pzhvcvogbSDxjjLyw=;
        b=BrFdn5UqcRUY8+IWqcNZddgXoTkOWCFL307WoTkT7sJPeqoD+oTf8/HFysGd2askVy
         8hPCJ8ZNc+E0osOe6EFZcoYSSebnlH0kAhoyhD3V+Ef3OGb+54YXhaSgVAM91TzktUsJ
         Uc8At8RZ1E2s8Qno1hXEJ3BkHWdgNjUxOnaj2TAkBtT2zOPd7MqwqjbfXYERVm5kqbu3
         w3u2mQOiB/4YYo77knw32l3D0CnmPbPfXhzjU8ewwd8TKrwILpmPR4CmB8Q27MAgT+j3
         /TGCCOWFHG+2a1YOAlfAJ6vFVBafraIYZlVlUk5QcoCucOhrK2FFPY23I6KSaOB3SR4D
         28uQ==
X-Gm-Message-State: AHQUAuZjfc/Rrw3oXxMHYrU1N9U1/6+ODS4T10KJMCKwS9fTCd1m8OfW
        NAbypGKuX22du26dnGzyykRHbF69r/rzTEFSe/QrPA==
X-Google-Smtp-Source: AHgI3IbpfebIb0gE7qtiqIux2zE6Ec/pPg67lAW6z1wxsn1XZeO+XyLjjNVMmDtlMhAdzr0gbBb9nTeMLCi8fL2ow/U=
X-Received: by 2002:a19:9813:: with SMTP id a19mr1975976lfe.103.1549348705060;
 Mon, 04 Feb 2019 22:38:25 -0800 (PST)
MIME-Version: 1.0
References: <20190204103608.651205056@linuxfoundation.org>
In-Reply-To: <20190204103608.651205056@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 5 Feb 2019 12:08:14 +0530
Message-ID: <CA+G9fYu5b4Zk2ibs2f400NKVmVcFayxP+nkRMyY-qYXo0zjWVg@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/46] 4.14.98-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2019 at 16:15, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.14.98 release.
> There are 46 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Feb  6 10:35:31 UTC 2019.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.98-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

NOTE:
LTP syscalls fanotify09 test case PASS now.
The fanotify fix back ported to 4.14

Summary
------------------------------------------------------------------------

kernel: 4.14.98-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 0576694f34d99f183fb11743e8ef11e39e0349bf
git describe: v4.14.97-47-g0576694f34d9
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.97-47-g0576694f34d9

No regressions (compared to build v4.14.96-71-g9dc1bec76994)

Fixes (compared to build v4.14.96-71-g9dc1bec76994)
LTP syscalls fanotify09 test case PASS now.
The fanotify fix back ported to 4.14

Ran 22303 total tests in the following environments and test suites.

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
