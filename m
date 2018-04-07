Return-Path: <naresh.kamboju@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523083581; cv=none;
        d=google.com; s=arc-20160816;
        b=A0uWoeLQXvEXsXXwIKovYLj66BcjIqYRCq57o5km5wd17S4EMOcruuwiFwhxE0bQjb
         PfZgZifX6W4wWppMmjwZvOdO49OaO2cicNnlJxYUurofWhk7tt5Top0DL8nGV2y2BXDW
         TozXsK+6sxiVR/xpTdt43BTnIYsnzpWA68ySsx09LHxAS/y8TUg60iDui5uYobltY8L5
         eFCLkeb5d495BBVYLVcDLuxcyUvuG51ULQmehpwmHwATMeXfJCKFKSavMe1zsKxVcKCb
         JPcwpcwlOE23WvFPjgp865gGl+zLTTSkiUjMo6OJoCpeJ8rd9onRWavaVMhRJIyaY4Gd
         mEVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=2Fd3f36gpjpUi3ADzv66LMbFlGhZ3mQoXSH9j/7TuGI=;
        b=xRd2ewi5PRazkXqzGwfbOWmVRnVaemt90dXtlQd1ZQ0XkaOMRvWPppNBuybobrVgEt
         7rVjPTr8gZhByZ9Kj64DGWMnQriYVOYuT14Cdtp3tFZcXC9pI5/AYAqF4FGHKW6/l9lO
         tYjsfji5f1+J6P/ReMMJTZn2XAp0hZQnHE9K6sCk209qTph1QVTUjYKHmvIOz2rmS1k3
         S4L5oyZcc6NUAjouJt2xSbN88XXD3TwCkC+FvzCEgA40H+0MeVd757s6Y3rdhSWcJwPd
         lEiFJMgNqD/f7N9dQSTIbw3tc7iZKuHe0VIk1I0fVYaJJleoBFyJgjME1UaovbCJUAOb
         KNVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=DU2/xq8m;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=DU2/xq8m;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4+ou5fwgFS9GtumbOTMcaK+4YthaWCit2nSEQ+WRSaznBt0/g0/aIexa7zNSoqKpNSRmBMNVhJkzyY6VkkodKw=
MIME-Version: 1.0
In-Reply-To: <20180406084305.210085169@linuxfoundation.org>
References: <20180406084305.210085169@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 7 Apr 2018 12:16:19 +0530
Message-ID: <CA+G9fYtbWmR8NH6988qeUCpSY+sF1N9LYo3zmt2p90qsWDbyWQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/72] 4.4.127-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>, Shuah Khan <shuahkh@osg.samsung.com>,
	lkft-triage@lists.linaro.org, patches@kernelci.org,
	linux- stable <stable@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597003647223423394?=
X-GMAIL-MSGID: =?utf-8?q?1597068889007722437?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 6 April 2018 at 18:53, Greg Kroah-Hartman <gregkh@linuxfoundation.org> w=
rote:
> This is the start of the stable review cycle for the 4.4.127 release.
> There are 72 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Apr  8 08:42:48 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.127-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.4.127-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: 82bd29002c6763e5558015c877c50373d1a14560
git describe: v4.4.126-73-g82bd29002c67
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.126-73-g82bd29002c67


No regressions (compared to build v4.4.126-53-gdc9629474809)

Boards, architectures and test suites:
-------------------------------------

juno-r2 - arm64
* boot - pass: 20
* kselftest - skip: 29, pass: 34
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 53, pass: 28
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 2, pass: 61
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
* ltp-syscalls-tests - skip: 152, pass: 998
* ltp-timers-tests - skip: 1, pass: 12

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
* ltp-syscalls-tests - skip: 149, pass: 1001
* ltp-timers-tests - skip: 1, pass: 12

x15 - arm
* boot - pass: 20
* kselftest - skip: 29, pass: 33
* libhugetlbfs - skip: 1, pass: 87
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 2, pass: 61
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
* ltp-syscalls-tests - skip: 98, pass: 1052

* ltp-timers-tests - skip: 1, pass: 12

x86_64
* boot - pass: 22
* kselftest - skip: 31, fail: 1, pass: 48
* kselftest-vsyscall-mode-native - skip: 31, fail: 1, pass: 48
* kselftest-vsyscall-mode-none - skip: 31, fail: 2, pass: 46
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 1, pass: 62
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - pass: 22
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 5, pass: 9
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 120, pass: 1030
* ltp-timers-tests - skip: 1, pass: 12

Hikey test results,

Summary
------------------------------------------------------------------------

kernel: 4.4.127-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git tag: 4.4.127-rc1-hikey-20180406-167
git commit: f9fe096cd3478d5e39d05b7c97cca9cf2beace79
git describe: 4.4.127-rc1-hikey-20180406-167
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.127-rc1-hikey-20180406-167

No regressions (compared to build 4.4.127-rc1-hikey-20180405-166)
------------------------------------------------------------------------

Boards, architectures and test suites:
-------------------------------------

hi6220-hikey - arm64
* boot - pass: 20
* kselftest - skip: 32, pass: 31
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 53, pass: 28
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 2, pass: 61
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - skip: 1, pass: 21
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 154, fail: 2, pass: 994
* ltp-timers-tests - skip: 1, pass: 12

--
Linaro QA (beta)
https://qa-reports.linaro.org
