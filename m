Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1141603-1521281635-2-17594781326977619237
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
    t=1521281634; b=HUa8VQVvBPHlry68wHwfvhlaEfagTmp9gVj0oT+v1Q75EPi
    u1wk+iIsDWWlWaVpKcOuZA7D/UXwfacK3wynXQKHwri58CjgDaJflWZv0PaYFX8G
    c4V6M+5pmP0it0/iSllH4ZuN3Z4k25AJiLad4g2YcHPEprdQ/A4wGsPNLd6v4lTv
    UBKuc4+nJFqciaL+9Sr1DL9vErJaWLCo/oirI3Bk3vNRwtYRuRKYHjf732VXnOjm
    Le5UMBBy8rG9MKcqY0dGOoyxCwgIU3J33ukJy+uFza2jkDa7sxiCt3Ha/tzRrwJm
    rtH9lHCbtWVzVeJHReknGtQDAGC8jC2s9WfiDig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521281634; bh=2vLpEdQ91knCFhAiwhg0IedrFJ0YAoP63euxsrxc4Tk=; b=Z
    RrX7aqziYjjAlYFag0fW8NnK/b2jVF/OHLPX5LD5kg6maYLXhjOepAPEVO1CIvAY
    31Iit+QuxRkkijVBmYTv62C8XbF1/DxzBMFjzlLIK3Mx74sg6M6biG+WhpVw1xT3
    6IX3BAPNIYpTAYLgTPai1OfuFCooppSZgALqScd0bR1SSD1a5yD3UHmCTvtDH8LV
    EytJelUt8BtwLh3VJVTyPtyrvCzLgEegmnP+OYkh5HaJxJUjumBV5lJ1cryyNSKT
    7tvKhwPibTNQuaGPae5UD6++jqcDjtqt3b3pdXm2H47BpfcAZZfyB/+RXqrzDuJW
    xFlyrHhdoc/Rx/NPGUUrA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=hzGRlxle x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=b3F68IJc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=hzGRlxle x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=b3F68IJc;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752463AbeCQKNv (ORCPT <rfc822;greg@kroah.com>);
        Sat, 17 Mar 2018 06:13:51 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:45307 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752676AbeCQKLs (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Mar 2018 06:11:48 -0400
X-Google-Smtp-Source: AG47ELshx+KvO4cSzhAuKOynxjdkofX4f/lQX1/BtiDxtVx4IyMU3Gb3XV/9GsU2J3AGgr2CdQxEw7RwOPYGthf12BE=
MIME-Version: 1.0
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 17 Mar 2018 15:41:45 +0530
Message-ID: <CA+G9fYvnq9wEat-96JAshHpn4Pvf+7CZZi8Z47Y5afQSiK6rfg@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/63] 4.4.122-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 16 March 2018 at 20:52, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.4.122 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Mar 18 15:22:41 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.122-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64 and arm.


NOTE:
CONFIG_LEGACY_VSYSCALL_EMULATE=3Dy is enabled from config as default.
Enabled vsyscall=3Dnative and vsyscall=3Dnone from kernel command line for =
testing
selftests/x86/test_vsyscall test case on x86_64 and qemu_x86_64.

test_vdso_64 failed on x86_64 device when vsyscall=3Dnone is enabled.
We will investigate this new test failure.

Summary
------------------------------------------------------------------------

kernel: 4.4.122-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: d7facaec9c1eb3d2703ce89b2ab81207eb7a4e6c
git describe: v4.4.121-64-gd7facaec9c1e
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.121-64-gd7facaec9c1e


No regressions (compared to build v4.4.121)

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

kernel: 4.4.122-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git tag: 4.4.122-rc1-hikey-20180316-150
git commit: f4e336912f0cb6dc3a56a014c5f495b37099d067
git describe: 4.4.122-rc1-hikey-20180316-150
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.122-rc1-hikey-20180316-150


No regressions (compared to build 4.4.121-rc1-hikey-20180310-148)

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
* ltp-sched-tests - skip: 4, pass: 10
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - skip: 154, pass: 996
* ltp-timers-tests - skip: 1, pass: 12

--
Linaro QA (beta)
https://qa-reports.linaro.org
