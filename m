Return-Path: <naresh.kamboju@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526670139; cv=none;
        d=google.com; s=arc-20160816;
        b=r2rK5DLDicae45lef6LrH/qloo0KFX6mioaeqbKw84NE5u0hZt3/mGFrCpg3TpJpuH
         Ss3UY4coEwXVdmR9FqRn4MRtZF9rHjH9ryF1chJAOXfH96ypjnLwOq5wLb8mNkk/W492
         ddZ1JOTHR4BvP8a378+P5x8v5sJeZKNDK90oaSRaOE8Ht5OasA5xoiivL5q+wG6QFNpX
         k3NDN/oiw6fqWS/g+fG0u6f9907qtp741+hKGX4mbmuv12Ul0KXIFv3LJN7zq1sC7VHs
         LwVasPQa+AGfFaHFPlzpxtWyoyTBGzqok0uZsnxcKTFwIgLWVALaWXNgQyjqKulI529X
         QCww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=+90YIHBI9iQADnOtxnwQwwQBseSm7PLlZg0olsRQoMw=;
        b=hyknCvkoUEMnBG5k2N9WfRUjDWgZHcem7aoryxsGB0A/SfH7l/nIZ/ed3NmxM8JalU
         g6ogJVptXT+FwYMbvx+UNi0Nz9+Zg8tf4RBeaua3v6BU9879cxQs/Iie31r0ewwCacQm
         C3AO0ABjYWO9ji4mpa5FxA0NB+FTN2fU3vre8XTfYTWfEd+siAfo4qGs2HH+Cy3qpYPl
         kEj4ey80GqnEHugmKGW2Ln/R64GIo3e4vykk00AY91P8Q+7hBonJROzguMAPwBPT+zhA
         dlmsNakYgrdu07Og+fp2s4xXKd2Doox3k1YfPJbwhHc0ev282Rqw4ehB3k2cmqEis7mA
         S1uQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=CmyIsYwX;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=CmyIsYwX;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZp1gRCqB0/rgyHmYj5GGpCl1kqjHsocCAEJiRtqFROTzDXSYdaVyPCvbnat6IsuLxKSkw5pqKJ8iy8F9CZgO0U=
MIME-Version: 1.0
In-Reply-To: <20180518081535.096308218@linuxfoundation.org>
References: <20180518081535.096308218@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 19 May 2018 00:32:18 +0530
Message-ID: <CA+G9fYtSzWx9_EscQzXT1B4CjUjm2SVOLAybswo6zpNW8LCc1A@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/33] 4.9.101-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
	lkft-triage@lists.linaro.org, Ben Hutchings <ben.hutchings@codethink.co.uk>,
	linux- stable <stable@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600789399035311439?=
X-GMAIL-MSGID: =?utf-8?q?1600829668295193942?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 18 May 2018 at 13:45, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wr=
ote:
> This is the start of the stable review cycle for the 4.9.101 release.
> There are 33 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun May 20 08:15:20 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.101-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.9.101-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: b0935d42e12ff5b9efbdded322b1bb7187705bd3
git describe: v4.9.100-35-gb0935d42e12f
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.100-35-gb0935d42e12f


No regressions (compared to build v4.9.100-34-g16c619d3e043)

Boards, architectures and test suites:
-------------------------------------

dragonboard-410c
* boot - pass: 20,
* kselftest - pass: 34, skip: 32
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 57, skip: 6
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1015, skip: 135
* ltp-timers-tests - pass: 13,

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - pass: 35, skip: 28
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 57, skip: 6
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1014, skip: 136
* ltp-timers-tests - pass: 13,

juno-r2 - arm64
* boot - pass: 20,
* kselftest - pass: 37, skip: 29
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 57, skip: 6
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1015, skip: 135
* ltp-timers-tests - pass: 13,

qemu_arm
* boot - pass: 20,
* kselftest - pass: 34, skip: 32
* libhugetlbfs - pass: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 63, skip: 18
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 58, skip: 5
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 7, skip: 7
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1056, fail: 2, skip: 92
* ltp-timers-tests - pass: 13,

qemu_arm64
* boot - pass: 20, fail: 1,
* kselftest - pass: 35, skip: 33
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 57, skip: 6
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 8, skip: 6
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 991, fail: 2, skip: 157
* ltp-timers-tests - pass: 13,

qemu_x86_64
* boot - pass: 20,
* kselftest - pass: 47, skip: 33
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 57, skip: 6
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 13, skip: 1
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 998, skip: 152
* ltp-timers-tests - pass: 13,

x15 - arm
* boot - pass: 20,
* kselftest - pass: 36, skip: 29
* libhugetlbfs - pass: 87, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 63, skip: 18
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 58, skip: 5
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 20, skip: 2
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 13, skip: 1
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1075, skip: 75
* ltp-timers-tests - pass: 13,

x86_64
* boot - pass: 22,
* kselftest - pass: 50, skip: 30
* kselftest-vsyscall-mode-native - pass: 49, fail: 1, skip: 30
* kselftest-vsyscall-mode-none - pass: 50, skip: 30
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 58, skip: 5
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 9, skip: 5
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1032, skip: 116
* ltp-timers-tests - pass: 13,

--=20
Linaro QA (BETA)
https://qa-reports.linaro.org
