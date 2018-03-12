Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4134551-1520847149-2-10920790659065901719
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enfrro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520847148; b=Nh2mFtJAZxv24ANdhEb9zimzlT5h2GQmqxakdwfv9zK7bD+
    Q0sPc5iOGOIqfFqDZUXsfXAGwGVn0FKO0mq58b0+26tprzMQKFzCoFx+WRFOjz1Q
    jOvQvDApI2eW6gqwFyC6eVFyknfC9Fwrwu7z10zgzxqbV78R6WhPEylKVm6L3yOs
    OtRW4PDabMskTacRlm0qYAqkAruFcDLh/5xc1luDjxHWd+zfdg/RoNWlMPzxYmLo
    LBz1TK2UJG+xRTOjAAK/mIZ8Os8lV4M7AlOSzzJXelUO85kwMaOHq/8RxoYQn3jz
    sTl5hNMSJ75zQ9mnb1cn/qVdvVJMxskG5r2nulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520847148; bh=yEIjc4kawYf7q1nTDz4X9pwyvVblQr73ia1KYhb16BI=; b=F
    zChUc8mdiTUHWP8oP6j5MbsQzNBrgoUCT5UPhzHUXq+urgc4+DKy0xh6kAXq+/a1
    t6Mqw8+VQBwjhnTsk2HrA5b9WCF4qG7KPEpgAKj2wZZHAot0ruIc7iBFixL65GrY
    O7lhlkIcJqT5l8VR7bf6FQSzoJYz8iiXIGRMsgzLUTchdqZLVCeRDbNZgil5kyxN
    zl/xLILuVdLzG0AhJQ/kYvMt89VZKNt0+3/RyYRerk3j8TJa8K9EPjEV32857XPD
    LYWDsL5YAQy/AO91JcjRKbNp5NewE803og4QKw3YMXCVgNOAXRcr3k8Y7qvFEJLS
    IgEdtM2JuZwhSac1Q1c9A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=JVcw/UDy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rQ0klI8b;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=JVcw/UDy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=rQ0klI8b;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932217AbeCLJcZ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 05:32:25 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41933 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932231AbeCLJcY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Mar 2018 05:32:24 -0400
X-Google-Smtp-Source: AG47ELuVpNYUSG00I5F+Hl8BX+sAtAnzo4c3W3T0+BieJKd5sRdDlLJuo4LPdrjM9B3tyCoePecBQn51RZfoiIbd0jE=
MIME-Version: 1.0
In-Reply-To: <CA+G9fYuq6+s2bJ4HTX9o+bADQWQ2Q5K=8etUc=ZhZoTb-LgsTw@mail.gmail.com>
References: <20180310001824.927996722@linuxfoundation.org> <CA+G9fYuq6+s2bJ4HTX9o+bADQWQ2Q5K=8etUc=ZhZoTb-LgsTw@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 12 Mar 2018 15:02:20 +0530
Message-ID: <CA+G9fYuRMCG2yW0Tj_3TTzqYxzT3tR4wmygq+vxhqKzsHCxH9Q@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/65] 4.9.87-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
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
> Results from Linaro=E2=80=99s test farm.
> No regressions on arm64, arm and x86_64.
>
> NOTE:
> kselftests breakpoints step_after_suspend_test is a known to fail test
> on x86_64.
> Error log:
> Bail out! Failed to enter Suspend state
>
> Summary
> ------------------------------------------------------------------------
>
> kernel: 4.9.87
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able.git
> git branch: linux-4.9.y
> git commit: b67416226a0cff3f49032de36906ad1ebe5694a0
> git describe: v4.9.87
> Test details: https://qa-reports.linaro.org/lkft/linux-stable-4.9-oe/buil=
d/v4.9.87
>
>
> No regressions (compared to build v4.9.85)
>
> Boards, architectures and test suites:
> -------------------------------------
>
> hi6220-hikey - arm64
> * boot - pass: 20,
> * kselftest - pass: 39, skip: 24,
> * libhugetlbfs - pass: 90, skip: 1,
> * ltp-cap_bounds-tests - pass: 2,
> * ltp-containers-tests - pass: 64, skip: 17,
> * ltp-fcntl-locktests-tests - pass: 2,
> * ltp-filecaps-tests - pass: 2,
> * ltp-fs-tests - pass: 61, skip: 2,
> * ltp-fs_bind-tests - pass: 2,
> * ltp-fs_perms_simple-tests - pass: 19,
> * ltp-fsx-tests - pass: 2,
> * ltp-hugetlb-tests - pass: 21, skip: 1,
> * ltp-io-tests - pass: 3,
> * ltp-ipc-tests - pass: 9,
> * ltp-math-tests - pass: 11,
> * ltp-nptl-tests - pass: 2,
> * ltp-pty-tests - pass: 4,
> * ltp-sched-tests - pass: 10, skip: 4,
> * ltp-securebits-tests - pass: 4,
> * ltp-syscalls-tests - pass: 999, skip: 151,
> * ltp-timers-tests - pass: 12, skip: 1,
>
> juno-r2 - arm64
> * boot - pass: 20,
> * kselftest - pass: 40, skip: 23,
> * libhugetlbfs - pass: 90, skip: 1,
> * ltp-cap_bounds-tests - pass: 2,
> * ltp-containers-tests - pass: 64, skip: 17,
> * ltp-fcntl-locktests-tests - pass: 2,
> * ltp-filecaps-tests - pass: 2,
> * ltp-fs-tests - pass: 61, skip: 2,
> * ltp-fs_bind-tests - pass: 2,
> * ltp-fs_perms_simple-tests - pass: 19,
> * ltp-fsx-tests - pass: 2,
> * ltp-hugetlb-tests - pass: 22,
> * ltp-io-tests - pass: 3,
> * ltp-ipc-tests - pass: 9,
> * ltp-math-tests - pass: 11,
> * ltp-nptl-tests - pass: 2,
> * ltp-pty-tests - pass: 4,
> * ltp-sched-tests - pass: 10, skip: 4,
> * ltp-securebits-tests - pass: 4,
> * ltp-syscalls-tests - pass: 1001, skip: 149,
> * ltp-timers-tests - pass: 12, skip: 1,
>
> qemu_x86_64
> * boot - pass: 20,
> * kselftest - pass: 53, skip: 27,
> * libhugetlbfs - pass: 90, skip: 1,
> * ltp-cap_bounds-tests - pass: 2,
> * ltp-containers-tests - pass: 64, skip: 17,
> * ltp-fcntl-locktests-tests - pass: 2,
> * ltp-filecaps-tests - pass: 2,
> * ltp-fs-tests - pass: 57, skip: 6,
> * ltp-fs_bind-tests - pass: 2,
> * ltp-fs_perms_simple-tests - pass: 19,
> * ltp-fsx-tests - pass: 2,
> * ltp-hugetlb-tests - pass: 22,
> * ltp-io-tests - pass: 3,
> * ltp-ipc-tests - pass: 9,
> * ltp-math-tests - pass: 11,
> * ltp-nptl-tests - pass: 2,
> * ltp-pty-tests - pass: 4,
> * ltp-sched-tests - pass: 13, skip: 1,
> * ltp-securebits-tests - pass: 4,
> * ltp-syscalls-tests - pass: 1001, skip: 149,
> * ltp-timers-tests - pass: 12, skip: 1,
>
> x15 - arm
> * boot - pass: 20,
> * kselftest - pass: 38, skip: 24,
> * libhugetlbfs - pass: 87, skip: 1,
> * ltp-cap_bounds-tests - pass: 2,
> * ltp-containers-tests - pass: 64, skip: 17,
> * ltp-fcntl-locktests-tests - pass: 2,
> * ltp-filecaps-tests - pass: 2,
> * ltp-fs-tests - pass: 61, skip: 2,
> * ltp-fs_bind-tests - pass: 2,
> * ltp-fs_perms_simple-tests - pass: 19,
> * ltp-fsx-tests - pass: 2,
> * ltp-hugetlb-tests - pass: 20, skip: 2,
> * ltp-io-tests - pass: 3,
> * ltp-ipc-tests - pass: 9,
> * ltp-math-tests - pass: 11,
> * ltp-nptl-tests - pass: 2,
> * ltp-pty-tests - pass: 4,
> * ltp-sched-tests - pass: 13, skip: 1,
> * ltp-securebits-tests - pass: 4,
> * ltp-syscalls-tests - pass: 1053, skip: 97,
> * ltp-timers-tests - pass: 12, skip: 1,
>
> x86_64
> * boot - pass: 20,
> * kselftest - pass: 54, skip: 25, fail: 1
> * libhugetlbfs - pass: 90, skip: 1,
> * ltp-cap_bounds-tests - pass: 2,
> * ltp-containers-tests - pass: 63, skip: 17,
> * ltp-fcntl-locktests-tests - pass: 2,
> * ltp-filecaps-tests - pass: 2,
> * ltp-fs-tests - pass: 62, skip: 1,
> * ltp-fs_bind-tests - pass: 2,
> * ltp-fs_perms_simple-tests - pass: 19,
> * ltp-fsx-tests - pass: 2,
> * ltp-hugetlb-tests - pass: 22,
> * ltp-io-tests - pass: 3,
> * ltp-ipc-tests - pass: 9,
> * ltp-math-tests - pass: 11,
> * ltp-nptl-tests - pass: 2,
> * ltp-pty-tests - pass: 4,
> * ltp-sched-tests - pass: 9, skip: 5,
> * ltp-securebits-tests - pass: 4,
> * ltp-syscalls-tests - pass: 1030, skip: 119,
> * ltp-timers-tests - pass: 12, skip: 1,

The above summary is of stable and this one is stable-rc.

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

NOTE:
kselftests sigreturn_64 is an intermittent failure on qemu_x86_64.
dragonboard-410c boot failures are due to infrastructure issues.

Summary
------------------------------------------------------------------------

kernel: 4.15.9
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.15.y
git commit: 3eae9e93d49241dfb30be1d706b68d056b1ad29c
git describe: v4.15.9
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.15-oe/bu=
ild/v4.15.9

No regressions (compared to build v4.15.8-12-g212dd4bb587d)
------------------------------------------------------------------------


Boards, architectures and test suites:
-------------------------------------

dragonboard-410c
* boot - pass: 20, fail: 5
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

qemu_x86_64
* boot - pass: 20,
* kselftest - pass: 60, skip: 21, fail: 1
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
* ltp-syscalls-tests - pass: 1001, skip: 149,
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

>
> --
> Linaro QA (beta)
> https://qa-reports.linaro.org
