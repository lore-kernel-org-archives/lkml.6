Return-Path: <dan.rue@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1527185059; cv=none;
        d=google.com; s=arc-20160816;
        b=Juz8n690uEpynhI5/+cZy9D+Tmh5/XknzFRsMqrQbME4ckoKrJvrSOqW3Z4ZWgBumF
         YL9qe/nfD/8Y0UglX0TAc2RA39E/KsqPj1ot0gVEmIa7XEaIWuxmz7Efe9MemMX87Bs2
         sK7doYd9pfvBnTeW0LvrypgG1CVR9js6TvkDP+YBV8oSK5BPkT9axcWUlpdKt1qL/mek
         o7OIes1kyCBzO4BcZ2P3yeX4oy3u08+Ill0t+8m+vLghDXJMsCuAdLnt+0JFb2y009LY
         Zu7egC7+qKkYyfopbsUTvw0ZbQk1KdRMcWpOd8elZtPFwNnQJmiCU49B3g4MEqtIAPGC
         spsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:mail-followup-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=qDNZuALH2WYlic4+xtgVKZcDD00aNr++B57HFQGVExk=;
        b=nT47psudXjg3CHCaLuTgqlmBDQkKRMzE85XeRgamevnMDFpjbNIGSclKpa9Bx7ldkF
         my4D/HbWSYhPLtcV8QaNSz6dFKFduIrItkOuohPmZenm43rnbTPnRBW8ab/0TS5fWKIL
         BG64DlzRwMwWKQmOSjo5rVpf9JIlM4z1IGEiDYLFrHKMK+S5Vka9uBu7gATdMQPS0eer
         68LbDlAdq43JaPhR//GCgD2TyU8OlvORXz5uGubzhja3W5QSLwWx0IPFWFWHXzqxc1/6
         4niHWL2gDkJz2PWcpFQ1cKh4zDaSphjCtGKk/qm5v5fd3P7fvd0lmM1tzoKfyvNXFuB5
         YAyA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=dna5aaoz;
       spf=pass (google.com: domain of dan.rue@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=dan.rue@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=dna5aaoz;
       spf=pass (google.com: domain of dan.rue@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=dan.rue@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZptj6wEJwQ5KDPv1Xjlb6QO+PMoTTKvlJXAd9WD74YD6uWDtesxg1KY2VjqPZ7mnZWzTAYsRQ==
Date: Thu, 24 May 2018 13:04:16 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/96] 4.9.103-stable review
Message-ID: <20180524180416.2eoynar7cgda2uq5@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180524093605.602125311@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
User-Agent: NeoMutt/20180512
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601338380744330487?=
X-GMAIL-MSGID: =?utf-8?q?1601369600481182403?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 24, 2018 at 11:37:43AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.103 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat May 26 09:35:42 UTC 2018.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

You may notice the report format has changed. I've removed a lot of the
duplication that we had, while still trying to give an overall sense of
the scope of testing.

Summary
------------------------------------------------------------------------

kernel: 4.9.103-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.9.y
git commit: 190b92e2b8d4d190a6b059732180a71f1ff17c4d
git describe: v4.9.102-97-g190b92e2b8d4
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.102-97-g190b92e2b8d4


No regressions (compared to build v4.9.102)


Ran 11084 total tests in the following environments and test suites.

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
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

-- 
Linaro LKFT
https://lkft.linaro.org
