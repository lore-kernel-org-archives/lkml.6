Return-Path: <naresh.kamboju@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525803187; cv=none;
        d=google.com; s=arc-20160816;
        b=CT18J9widzlER2IEdyXyVQ3+9VGDjjzrOdwP2WT/7z6oMQVDyJR7dpc5IOKwSCdkbJ
         B+mWWKyxk2Boo0CtwFSxBPfciDByUHpPD855nIPue6rBq0oSVAEM4inv8BNUMyMmmcqT
         SrNX5xEgW56/Pc8xbDWhWBR806djJbfrS4jLCxY1KfV+MW651y6d4rkePZEOBaglh9U1
         ln1BJThuAAUqpvPq5Cvs71Opp3W0TDXvDFdnDFq9cPFjwhMOD55tGi1hpWyDz9QHaGRg
         NLP7IfNsdMQJr8yzGVe+EMl/x36E/4B2C0EXwiMXroX0HPVDuLnYv4dhugCqlWIKxUAX
         ZcZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=E4WrvZmJgt5ovp8WcpHSmBSZ1BvcSFtx2FGWRPx5VEI=;
        b=W/zpx6K3wyR+LM7okUIeJc/v2y99banngT2+OZmRiY6Ypo92rkHH/RBIynS/LiE0WY
         Ir9MOF1DHCst5ZlyJsoO0de8K+R/s0VsV5cIe0g0FU773qIffc4XeX7uJXQJ57eppif3
         qjWmeD02asyCxMJXDJrIn/2q7u+WQtl2QEJ36+ZyrRm3ppvQXgREsl0unKhglyQOdR3O
         0wWmNi4Nv3KlKIYF97pWVsk6Tar2sLkDtPl9sXwWNzeS2a1JFpEaPEnFpIAbE8pDW1RU
         lQurBuOCJLqHSgFSMb+2iDxp91XJ441O31pE/9fDhvOnuFrIBRMLWAXMOr73bZKSQNvj
         nfyg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Nglp/hhu;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Nglp/hhu;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZoWhEro3mvrMpNdYDqwuW2YdZJGIXPQOGFjEsvS3MHil1CamVecEJbXGv+HJ+63b/eaFvKbY82w6JEvjjs4Qn0=
MIME-Version: 1.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 8 May 2018 23:43:06 +0530
Message-ID: <CA+G9fYtSFy=XF-c5QuEwqfy7JPcvJRRmO07Gy7AZ6mJtG3LKYA@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/32] 4.9.99-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>, Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>, lkft-triage@lists.linaro.org,
	linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599883077500588538?=
X-GMAIL-MSGID: =?utf-8?q?1599920603598806783?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 8 May 2018 at 13:40, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wro=
te:
> This is the start of the stable review cycle for the 4.9.99 release.
> There are 32 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu May 10 07:39:44 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.99-rc1.gz
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

kernel: 4.9.99-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 6e28bacfe4aa523ece3838a9d50e7612d41be723
git describe: v4.9.98-33-g6e28bacfe4aa
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.98-33-g6e28bacfe4aa


No regressions (compared to build v4.9.98-8-g5918d4b6b7ff)

Boards, architectures and test suites:
-------------------------------------

dragonboard-410c
* boot - pass: 20
* kselftest - skip: 32, pass: 34
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 6, pass: 57
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - skip: 1, pass: 21
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - pass: 14
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 135, pass: 1015
* ltp-timers-tests - pass: 13

hi6220-hikey - arm64
* boot - pass: 20
* kselftest - skip: 29, pass: 36
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 6, pass: 57
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - skip: 1, pass: 21
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 4, pass: 10
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 136, pass: 1014
* ltp-timers-tests - pass: 13

juno-r2 - arm64
* boot - pass: 20
* kselftest - skip: 29, pass: 37
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 6, pass: 57
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - pass: 22
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 4, pass: 10
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 135, pass: 1015
* ltp-timers-tests - pass: 13

qemu_arm
* boot - fail: 12, pass: 8
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 18, pass: 63
* ltp-fcntl-locktests-tests - pass: 2
* ltp-hugetlb-tests - skip: 1, pass: 21
* ltp-ipc-tests - pass: 9
* ltp-pty-tests - pass: 4
* ltp-syscalls-tests - skip: 92, fail: 3, pass: 1055

qemu_arm64
* boot - pass: 20
* kselftest - skip: 33, pass: 35
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 6, pass: 57
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - pass: 22
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 6, pass: 8
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 157, fail: 2, pass: 991
* ltp-timers-tests - pass: 13

qemu_x86_64
* boot - pass: 22
* kselftest - skip: 33, pass: 47
* kselftest-vsyscall-mode-native - skip: 33, pass: 47
* kselftest-vsyscall-mode-none - skip: 33, pass: 47
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 6, pass: 57
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - pass: 22
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 1, pass: 13
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 152, pass: 998
* ltp-timers-tests - pass: 13

x15 - arm
* boot - pass: 20
* kselftest - skip: 29, pass: 36
* libhugetlbfs - skip: 1, pass: 87
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 18, pass: 63
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 5, pass: 58
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - skip: 2, pass: 20
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 1, pass: 13
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 75, pass: 1075
* ltp-timers-tests - pass: 13

x86_64
* boot - pass: 22
* kselftest - skip: 30, pass: 50
* kselftest-vsyscall-mode-native - skip: 30, fail: 1, pass: 49
* kselftest-vsyscall-mode-none - skip: 30, pass: 50
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 5, pass: 58
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 1
* ltp-hugetlb-tests - pass: 22
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 5, pass: 9
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 116, pass: 1034
* ltp-timers-tests - pass: 13

--=20
Linaro QA (BETA)
https://qa-reports.linaro.org
