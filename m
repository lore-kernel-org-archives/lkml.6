Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C324BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55C1A21906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NGkGJJN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388491AbeLUBKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 20:10:41 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38664 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388455AbeLUBKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 20:10:41 -0500
Received: by mail-lf1-f67.google.com with SMTP id p86so2743410lfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 17:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gYWLLzJSqx+MozPaMeEKVny6eU7FvL1vRg/59e3uyRE=;
        b=NGkGJJN8EqoJozRUF86WvovWTiFASrI2d3Sk7hxqVe1WMeTdPxPqOJmR3rjMQi/tST
         x2fMDpsiAqxgwHU641Hi4eKyu6rEPYtJ90Ue/ihiIO/b0V2qJRtbaICn8yojLtoCTN+v
         rQmFW05cPUrg4Hr6N0oEX1C6i+Y6pyKDytsug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gYWLLzJSqx+MozPaMeEKVny6eU7FvL1vRg/59e3uyRE=;
        b=hhGkjOQC5Hf65wPGpT8A8WPJ/wEAyhVzDLEMYB3m+MA9+Qirv1/bOi67EZRCzD/c1v
         0ptk1+//0U/paYJIWJKzebCfQBdyw9oeccryAT5rQILz3UvwE3WBUS/OgQTqIrNMwo3C
         ajNFUvtjJxW2EPkdByOcF7D90EuaxwCbHOQpnq70uFO6tiEzU/BNs6LYvRaj6GnEbrsO
         +Dpt9WA+xdHN/Jy8oqIRvXKSsQknRPB1a8W1E0FntqO/Q36INjeQbtZlEGUerQrMgKA9
         qrD41RKA539IRFLJ9KpudRQGR+xL8anl5FpsNy9Xy/eyq4C19fuFjLL++ZriR+9IZk35
         xP3Q==
X-Gm-Message-State: AA+aEWYahU+xZNov3y7D1J4hDUvonsJ/XSnipUOU5yPyaEwafZKYimtW
        3oIbIxy91R6YXIyladpD0VXBbZD25Y2RppkCV8PUPg==
X-Google-Smtp-Source: AFSGD/XAA54yzBngdtOLtoE3q3vz1aUpySGTGFoAgEilLqrQgxCOhfLj41f6uFANXxyt2elz2e2XDTZfvqIHQpoCLsc=
X-Received: by 2002:a19:1d0d:: with SMTP id d13mr188445lfd.74.1545354638580;
 Thu, 20 Dec 2018 17:10:38 -0800 (PST)
MIME-Version: 1.0
References: <20181220085826.212663515@linuxfoundation.org>
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 21 Dec 2018 06:40:26 +0530
Message-ID: <CA+G9fYtBCG9+2=883D4+UienHVdFLbeMUrOW57YbK=Keuoii2A@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/40] 4.4.169-stable review
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

On Thu, 20 Dec 2018 at 14:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 4.4.169 release.
> There are 40 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Dec 22 08:58:16 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.169-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, x86_64, and i386.

Summary
------------------------------------------------------------------------

kernel: 4.4.169-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: b5873603e09c770a518857505b3b9ef6f551f3f5
git describe: v4.4.168-41-gb5873603e09c
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.168-41-gb5873603e09c

No regressions (compared to build v4.4.168)

No fixes (compared to build v4.4.168)

Ran 16857 total tests in the following environments and test suites.

Environments
--------------
- i386
- juno-r2 - arm64
- qemu_arm
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
* ltp-nptl-tests
* ltp-open-posix-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* spectre-meltdown-checker-test
* install-android-platform-tools-r2600
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

Summary
------------------------------------------------------------------------

kernel: 4.4.169-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.169-rc1-hikey-20181220-343
git commit: dd2a2220e648c510cf285ba695c29c793df082ef
git describe: 4.4.169-rc1-hikey-20181220-343
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.169-rc1-hikey-20181220-343

No regressions (compared to build 4.4.168-rc2-hikey-20181217-341)

No fixes (compared to build 4.4.168-rc2-hikey-20181217-341)

Ran 2757 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64
- qemu_arm64

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
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* spectre-meltdown-checker-test

--=20
Linaro LKFT
https://lkft.linaro.org
