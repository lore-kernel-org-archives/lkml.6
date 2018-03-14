Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2380744-1521053664-5-317674154508553188
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521053663; b=Vyw0P22VBdFJyTjd52RqgqqQwrfckZ9auBe4py6DSy0Wnmv
    5l40GfqqYAkwIqCA0if9SY7/hIL6MLRkOQU4IWFar+TEznECBZgHXZEyOsK0jR+d
    5yiIsYGgpVGfGfz5lkc88+a0Gxn45qf9L0HhNDLxDSWixe0p+R/b+pNZnc3QWtxU
    C8Q+rGJ9lDcKECX22AsJxnzxS9UQUyjJK3owVHe/kJzM3XIRVitxfHUE6t0qaXZV
    ZW2PedCrD4damGtXYr83bBl3p94iQHsj4sH4ocq3ukPtLxKi0IbJhZyBa9RS13N/
    M3wxUr6X9BPe74fDNtooon0/GM58DXNjv3SzBig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521053663; bh=XdxNERY/+lSrP2Wi8kjEEKwdtkTWMr+KN6B0Sb7ieFo=; b=o
    3SI7RxQ3TA5GP9HPgM8zZv4mIThbL0aK0Ojhht0V8BqDSWCSzkZJI0bGY/0/zatL
    1BKFYoXbpQR5qiQoxAFzZvvPL7PxrUZoTHkM6vWBKpyP8XwrMBiU/ow8jPShgKSy
    dsjI9i7vMvtDDl7hTCRYFK41k2Id1lx4s9zCE4G0TvOajU0mZ4xYowTiWlJLZ+r3
    XmaH9sObFPLhOdwY/ZpJNVF4/ppo5KZLKfIiKrdsmV7xYzXNMou/5bSOeTmNOJO1
    LqS1u8pcjyzavb/TZOnXQa1CvZifNY8nuBWUGaVFG6iPqGRLu6QYZI11kmRBz2MC
    jX82EP0O90j3gBRrxSPqQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=AE7YAUkV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=H/E273l+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=AE7YAUkV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=H/E273l+;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbeCNSxj (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 14:53:39 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44799 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbeCNSxj (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 14 Mar 2018 14:53:39 -0400
X-Google-Smtp-Source: AG47ELtAa0o/XeDg4OHIwltMof5QOf6wcdIP4faRFgZNnj0ZPIgPj63JB/q7oD/jgdRMKMDVgPd1OXQE5n6U4va32pk=
MIME-Version: 1.0
In-Reply-To: <20180314105625.GG32615@kroah.com>
References: <20180313152320.439085687@linuxfoundation.org> <20180314105625.GG32615@kroah.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 15 Mar 2018 00:23:36 +0530
Message-ID: <CA+G9fYtf7-TD6Jvt1rZwwy3+PrHV==WDciScaxQpsvAe5SE0jQ@mail.gmail.com>
Subject: Re: [PATCH 4.15 000/146] 4.15.10-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        lkft-triage@lists.linaro.org, patches@kernelci.org,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14 March 2018 at 16:26, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Tue, Mar 13, 2018 at 04:22:47PM +0100, Greg Kroah-Hartman wrote:
>> This is the start of the stable review cycle for the 4.15.10 release.
>> There are 146 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Thu Mar 15 15:22:37 UTC 2018.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4=
.15.10-rc1.gz
>> or in the git tree and branch at:
>>       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git linux-4.15.y
>> and the diffstat can be found below.
>
> -rc2 is out to resolve a boot problem on some ARM boards:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.15.10-rc2.gz

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm, qemu_x86_64 and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.15.10-rc2
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.15.y
git commit: 2ad27e8a3cad093b4d4f5f7471ac80bdfb6bb372
git describe: v4.15.9-146-g2ad27e8a3cad
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.15-oe/bu=
ild/v4.15.9-146-g2ad27e8a3cad


No regressions (compared to build v4.15.9-147-g478762923754)

Boards, architectures and test suites:
-------------------------------------

dragonboard-410c - arm64
* boot - pass: 22, fail: 2
* kselftest - pass: 45, skip: 20,
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
* kselftest - pass: 48, skip: 17,
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
* kselftest - pass: 48, skip: 17,
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
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
* kselftest - pass: 61, skip: 21,
* libhugetlbfs - pass: 90, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 57, skip: 6,
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
* boot - pass: 20,
* kselftest - pass: 41, skip: 21,
* libhugetlbfs - pass: 87, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 63, skip: 18,
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
* kselftest - pass: 61, skip: 19,
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

>
> _______________________________________________
> Lkft-triage mailing list
> Lkft-triage@lists.linaro.org
> https://lists.linaro.org/mailman/listinfo/lkft-triage
