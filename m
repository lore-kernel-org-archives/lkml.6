Return-Path: <naresh.kamboju@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520850403; cv=none;
        d=google.com; s=arc-20160816;
        b=G4yMxXekZ7pQu+SCOxKy/GpMhaRFaOF5pWWo/U5SF+4HIBuqeMjBTPX5WwCzC7Xqxf
         fPdTzp0yNQNXJT/nNVvoa1srdwyYErO0skxGY7T/75XLFHijXd/vOO+MzbLOmQ1jffaa
         YdpMjsRuW0tNww1gOm4Ni2ApxTK9b+Vq/QdjOiPk0EmQTsUDBAnfeIjYWMz7n5bmVnu6
         Qja5701rpDNDD0dEPodOaw1/QQWCXfrX3mDiMJav9FkTbya1GvswPTIQpAugQLDZB2t3
         qzOUmS4uyFYpiEt4QC4q1GZJNNgUimlPtq36KyrcJ0sBEpM35a4WoaNp1yOuqyWWG9dW
         47qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :references:in-reply-to:mime-version:dkim-signature
         :arc-authentication-results;
        bh=fbubnu2p1FerpzXIXN79VvK/MIjSwH0JXHkJKl+hxB8=;
        b=DGt4E0TdXQauouuE2ZkL8CjPMi5Cj2V490gInpy0dbETzAAVZvnNWoCpYK3gP3qsQW
         TJu3uh54mJ5VTA4lZjPS0/S6Tt8dKnaZGuEtA5ltOeRwKejFzC807TFpRDYiB8REDOId
         9CyPVDN//uiPddQRoBkUUG6PZFRaE4om61r7xzVfGhHWV/IayUsx4UnKu3vXCxSLgIa5
         oIY77VFjX4RUv8c9RdDdlC+DaEwvRymHjLiYi2eg2ho9w1KHs9Z42ua2XhL6MpFybC5h
         PEjvv2RMFRx5AiuZUNPCSSP1FNpbC/E68byfDpoQJMjnSQLdFa3+q8Dt27VsiobRkpDs
         /8ew==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=NO1xCzGi;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=NO1xCzGi;
       spf=pass (google.com: domain of naresh.kamboju@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=naresh.kamboju@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELsJJkqgPtQqwecnOIZo+G+1CYUNekykr99LfOP47K64pCihyILloJY0UCSzMm5Z3BNVrmJZHyBA+QGellSLQxY=
MIME-Version: 1.0
In-Reply-To: <CA+G9fYuq6+s2bJ4HTX9o+bADQWQ2Q5K=8etUc=ZhZoTb-LgsTw@mail.gmail.com>
References: <20180310001824.927996722@linuxfoundation.org> <CA+G9fYuq6+s2bJ4HTX9o+bADQWQ2Q5K=8etUc=ZhZoTb-LgsTw@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 12 Mar 2018 15:56:42 +0530
Message-ID: <CA+G9fYtCAdueOhZ=BMxUks6nA0S3ito_yjsdp6DEGmnb9dqnbA@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/65] 4.9.87-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Guenter Roeck <linux@roeck-us.net>, Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
	Ben Hutchings <ben.hutchings@codethink.co.uk>, lkft-triage@lists.linaro.org,
	linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507975302163705?=
X-GMAIL-MSGID: =?utf-8?q?1594727232735953749?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 12 March 2018 at 12:32, Naresh Kamboju <naresh.kamboju@linaro.org> wrote=
:
> On 10 March 2018 at 05:48, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> This is the start of the stable review cycle for the 4.9.87 release.
>> There are 65 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Mon Mar 12 00:18:06 UTC 2018.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch=
-4.9.87-rc1.gz
>> or in the git tree and branch at:
>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git linux-4.9.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

NOTE:
ltp-fs-tests runltp_fs test run was incomplete due to infrastructure
issues and re-running test job completed.
one of the x15 device boot failures is due to infrastructure failure.

Summary
------------------------------------------------------------------------

kernel: 4.9.87
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: b67416226a0cff3f49032de36906ad1ebe5694a0
git describe: v4.9.87
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.87

No regressions (compared to build v4.9.86-66-gfaac4c330feb)
------------------------------------------------------------------------

Boards, architectures and test suites:
-------------------------------------

dragonboard-410c
* boot - pass: 20,
* kselftest - pass: 36, skip: 27,
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 2,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1002, skip: 148,
* ltp-timers-tests - pass: 12, skip: 1,

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - pass: 39, skip: 24,
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 2,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 999, skip: 151,
* ltp-timers-tests - pass: 12, skip: 1,

juno-r2 - arm64
* boot - pass: 20,
* kselftest - pass: 40, skip: 23,
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 2,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1001, skip: 149,
* ltp-timers-tests - pass: 12, skip: 1,

qemu_x86_64
* boot - pass: 20,
* kselftest - pass: 53, skip: 27,
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17,
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
* ltp-sched-tests - pass: 13, skip: 1,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1002, skip: 148,
* ltp-timers-tests - pass: 12, skip: 1,

x15 - arm
* boot - pass: 20, fail: 1
* kselftest - pass: 38, skip: 24,
* libhugetlbfs - pass: 87, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 2,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 20, skip: 2,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 13, skip: 1,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1053, skip: 97,
* ltp-timers-tests - pass: 12, skip: 1,

x86_64
* boot - pass: 20,
* kselftest - pass: 54, skip: 25, fail: 1
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 62, skip: 1,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 9, skip: 5,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1031, skip: 119,
* ltp-timers-tests - pass: 12, skip: 1,

--
Linaro QA (beta)
https://qa-reports.linaro.org
