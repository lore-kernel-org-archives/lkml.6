Return-Path: <naresh.kamboju@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1521655585; cv=none;
        d=google.com; s=arc-20160816;
        b=yl8Lww/gzYZz7M+nEcMAp+pk+fb0UAunXlm+YFmyhwc6mlR3dKFW0Z03wxt8+x0M9A
         x6/V8mx7o71F+8JCeWYMklEJuWHGPyPIz5P6ljslpAQ+fosvDRiT8C76DFpd6cIAIYdF
         jdSrlR1PH1edBh2U3R+xgDUc26FOHtgNaBEEOoljtayFfnJYjjv0Rdzrc3+lpOCWMafZ
         udvAsbNOkyC2YyjI6IcU5ZbVyg/B+YvCziI+sGtMQEO/MPM8HkvcKdrZAhddRzFZWsoD
         9QenCuSfqr6FnokNh3DRQFE3+KuLj1gH1m73+1KtOVOaM9pD64NtDC4Wqpb4J+niC3Bh
         kKag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=ZQfc9a3r+jXCx0A5crXkKMNEKX/+g85GFGx1ORaUYNo=;
        b=OXixufOD0XyARnTLjoRURh8mnzJdelMjCx/2HE5cVz8WofOt7YG6kEVNpG71J1DxHG
         0kmNneVkRblPM26ZmsHTNMkjHn73KNsu+MQ1fVP/J5wHO7Tm7X/F1g8dwpCi/jjRDwoO
         vr8WSuht0wymFiA8GmISOJ2+OjYwNwcohh/yIeIcmgPkMku/ggmhQ2g4QOpYjwfVNenE
         dIfXTVRZnH6wm6uNECZlB1l3n0J1MPcOF8mEMdL2ltoiiYYj9N3Z7QETVJaeiGxHi3X/
         X7wzf4g272iH1jhLrxi4mqlckxNUg/AIcuU0AmcKh52ufnMuHGXEHnvKYsPhuWWJ7QrI
         GCiQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=EOUm7mOr;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=EOUm7mOr;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELuoEnPEhhey+ATV2L5qSdy146/tJYfUwmBskG/2qn3ivhuKJ+yAIPmR9bOQ4NsIJA6Gcpolg5+edX2e3EB8jBE=
MIME-Version: 1.0
In-Reply-To: <20180321132005.GB27151@kroah.com>
References: <20180319180751.172155436@linuxfoundation.org> <20180320074945.GA10034@kroah.com>
 <20180321132005.GB27151@kroah.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 21 Mar 2018 23:36:23 +0530
Message-ID: <CA+G9fYvS0TvPOWv-u_ykZnC2X=xoTecLKF4-BNZstv=goA+LFg@mail.gmail.com>
Subject: Re: [PATCH 4.9 000/241] 4.9.89-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
	Ben Hutchings <ben.hutchings@codethink.co.uk>, Shuah Khan <shuahkh@osg.samsung.com>,
	lkft-triage@lists.linaro.org, patches@kernelci.org,
	linux- stable <stable@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595391137042363427?=
X-GMAIL-MSGID: =?utf-8?q?1595571526741248023?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 21 March 2018 at 18:50, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Mar 20, 2018 at 08:49:45AM +0100, Greg Kroah-Hartman wrote:
>> On Mon, Mar 19, 2018 at 07:04:25PM +0100, Greg Kroah-Hartman wrote:
>> > This is the start of the stable review cycle for the 4.9.89 release.
>> > There are 241 patches in this series, all will be posted as a response
>> > to this one.  If anyone has any issues with these being applied, pleas=
e
>> > let me know.
>> >
>> > Responses should be made by Wed Mar 21 18:07:03 UTC 2018.
>> > Anything received after that time might be too late.
>> >
>> > The whole patch series can be found in one patch at:
>> >     https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4=
.9.89-rc1.gz
>> > or in the git tree and branch at:
>> >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git linux-4.9.y
>> > and the diffstat can be found below.
>>
>> -rc2 is out to fix a bunch of arm32 build errors:
>>       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4=
.9.89-rc2.gz
>>
>
> And -rc3 is out to fix some more arm32 build errors, as well as an x86
> one I noticed showed up in the build tests:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.89-rc3.gz


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.9.89-rc3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 369cbfd2394b6ea1d767813ffa7fb01f6e5fc68c
git describe: v4.9.88-238-g369cbfd2394b
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.88-238-g369cbfd2394b


No regressions (compared to build v4.9.88-239-g393003b009f8)

Boards, architectures and test suites:
-------------------------------------

dragonboard-410c - arm64
* boot - pass: 20
* kselftest - skip: 27, pass: 36
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
* kselftest - skip: 24, pass: 39
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
* kselftest - skip: 23, pass: 40
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
* kselftest - skip: 28, pass: 52
* kselftest-vsyscall-mode-native - skip: 28, pass: 52
* kselftest-vsyscall-mode-none - skip: 28, pass: 52
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
* kselftest - skip: 24, pass: 38
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
* ltp-syscalls-tests - skip: 97, pass: 1053
* ltp-timers-tests - skip: 1, pass: 12

x86_64
* boot - pass: 22
* kselftest - skip: 25, fail: 1, pass: 54
* kselftest-vsyscall-mode-native - skip: 25, fail: 1, pass: 54
* kselftest-vsyscall-mode-none - skip: 25, fail: 2, pass: 53
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

>
> _______________________________________________
> Lkft-triage mailing list
> Lkft-triage@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/lkft-triage
