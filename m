Return-Path: <naresh.kamboju@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1522422163; cv=none;
        d=google.com; s=arc-20160816;
        b=Ld55wPyxyGAaLXKswzDesRKO9jUpwPWasZxpfVSQMU5q07JUyt9qMREM5732Eer50r
         bRExGbQuCvvql8f/POfwy7KOrzCTqdDMnpVYp00OV0JwUmre4e3ehPMKDPdtq6EtgJZJ
         TfpA4jhmu1oX7nT3sx1xAzXh8EKf1rEe96MJcSe3qoq0KL7j4NoMuOmQXv0pDxDFD0c+
         Vmv7DyYg3HcRKSaNvtyFLciTEVNDzLOpqLkI4afvHoD689DIwCBDXuYfuHUIDSGiZ8Qt
         35aQKXI/habFYkMkeZNdzxbbIIeeceWLdern0gisak9DSadXwW9Y9o2xa4eGnRYGFfhN
         Xf8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=55VGOSaZHRJGttw0yIoSLiOYwhWnuswUY7N1vJO1Ck4=;
        b=xGJOHX9KwtIl3aEhc/d9CYTXs5G3/vfe8h7CJpu8roU3CQlFotz5S5YMPhi9t3Y1LD
         LyxL7tJtFq2HSdt5IWB83UshyqXFqAqYtb05IipLGWJyIc3GxmUVcjbEuQR7ZSTEqhmd
         NnSru8CkJcLkGYxx1wRVto8GZDAfMCg8HVsZkHJoGX+yeOxUaCF05LGVwY05RcKhtMzC
         eFDCeSfFQdQc6hXnncsm1s75tjMZ1Tlp39c9Rs3WsXOaTojv+smfmnIKyQFA9NJ4QSAR
         6DH/YCRNPBbkdPcrbanPifbwj41zfKgYF6hZQigZb44fBonqFDPK69Xfp7GTqPB2AuP9
         7CrA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=bgoJx9mp;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=bgoJx9mp;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx4/kVSFabFgqylFAFqYTp/am7HbbPYvb4hf9IumYuBs1kiEb5EXH3ymr8PT2IHBorOIWhBvouvfNCn1sQPwBsoA=
MIME-Version: 1.0
In-Reply-To: <20180329175730.190353692@linuxfoundation.org>
References: <20180329175730.190353692@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 30 Mar 2018 20:32:41 +0530
Message-ID: <CA+G9fYtbDf=bqRKp9SoiCVyzYGV0fgacTXtR5nFnKuFPPzbkNQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/43] 4.14.32-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>, Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>, lkft-triage@lists.linaro.org,
	linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596296215155327589?=
X-GMAIL-MSGID: =?utf-8?q?1596375342034653255?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 29 March 2018 at 23:29, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.14.32 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat Mar 31 17:57:12 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.32-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.14.32-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 0bfe33ac4b00bde42db5dfe11d1f2e9f364c0614
git describe: v4.14.31-44-g0bfe33ac4b00
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.31-44-g0bfe33ac4b00


No regressions (compared to build v4.14.31-44-gcc19592f68f7)

Boards, architectures and test suites:
-------------------------------------

dragonboard-410c - arm64
* boot - fail: 4, pass: 20
* kselftest - skip: 20, pass: 45
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
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
* ltp-sched-tests - pass: 14
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 148, pass: 1002
* ltp-timers-tests - skip: 1, pass: 12

hi6220-hikey - arm64
* boot - pass: 20
* kselftest - skip: 17, pass: 48
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
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
* ltp-sched-tests - skip: 4, pass: 10
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 151, pass: 999
* ltp-timers-tests - skip: 1, pass: 12

juno-r2 - arm64
* boot - pass: 20
* kselftest - skip: 17, pass: 48
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
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
* ltp-syscalls-tests - skip: 149, pass: 1001
* ltp-timers-tests - skip: 1, pass: 12

qemu_x86_64
* boot - pass: 22
* kselftest - skip: 22, pass: 58
* kselftest-vsyscall-mode-native - skip: 22, pass: 58
* kselftest-vsyscall-mode-none - skip: 22, pass: 58
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
* ltp-syscalls-tests - skip: 148, pass: 1002
* ltp-timers-tests - skip: 1, pass: 12

x15 - arm
* boot - pass: 20
* kselftest - skip: 19, fail: 2, pass: 41
* libhugetlbfs - skip: 1, fail: 1, pass: 86
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, fail: 2, pass: 62
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
* ltp-syscalls-tests - skip: 97, pass: 1053
* ltp-timers-tests - skip: 1, pass: 12

x86_64
* boot - pass: 22
* kselftest - skip: 19, pass: 61
* kselftest-vsyscall-mode-native - skip: 19, pass: 61
* kselftest-vsyscall-mode-none - skip: 19, fail: 1, pass: 60
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
* ltp-syscalls-tests - skip: 119, pass: 1031
* ltp-timers-tests - skip: 1, pass: 12

--
Linaro QA (beta)
https://qa-reports.linaro.org
