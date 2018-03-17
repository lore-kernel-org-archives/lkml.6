Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1141603-1521282080-2-11092212129373544602
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
    t=1521282079; b=EzdXu943B2H7Cn0jBkAwWguimSSwq78uQw8ldRwQ+TBfMtc
    qM613NbLMuiozIZ9+PLMIXLItv2jKYggDaUB72k5pMuH1Y5oLO7RObMVLKzNLi7e
    JvMMuCikZrq4FQADFkFidfmfNIT9aJ9GLNWV4OjsXiJulF9fM7XO/19xdtW3Qj9c
    uKWoFQ9uyxyFhrcQ2ixceMo/Se7y8231O/B9/yFVf6IBUjAsiaK6foqftMTxBlox
    CaIzgxzagwFjv/TXP5fgu0goNmgy0dhnn1u6S+IQnSHDCXCizvUueES9a0l4mp3Z
    gXV2gbmNT7kSg1VNVGZXJcJRfDLzXGh2wEPR/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521282079; bh=iq/889p49wH8f9ldkD3uZ+Dq8oaVrVMTg4dFMDdE90M=; b=R
    GNLgzy+EsU2k3GciqsXZ4AuUyCxw1l+umms/kDHWR4kYSJr+m9IC1ZueTbOSfwcd
    sZM+kfxFayxxcaAIcTOYoO2OhxberbQU7sFWSjxMYB7+8ZR5ZfL3ls1mskvmLLhT
    y7qikViqxcDRKjEBEnM3IoDvrUnUlMWuUrNCtXHElSB7hnrTHJ4TiqEgLXRl2s+3
    PyYILu3l+SMi1abcEqIRSPSiVH9ZmDTcKK+XSU1TpnxjlWvac8GbKbxSoS36EPzv
    CGVhUZGRysaERBDnhAtqNuZjB2zkRcP3hhM+iw261I2CJWjo3s/Ha3BEdjGWmAJs
    gfn9X2nBretk3vuhozj4g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=DaobkA9t x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mhFeXGr0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=DaobkA9t x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=mhFeXGr0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbeCQKVR (ORCPT <rfc822;greg@kroah.com>);
        Sat, 17 Mar 2018 06:21:17 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43396 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751832AbeCQKVQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Mar 2018 06:21:16 -0400
X-Google-Smtp-Source: AG47ELtt6cIOKKCJo+sFqEMGbtc/0Rr42ASyMwVcz/GgXoZcZefLqPMaZ328lLi3cWYn7o3G2VRNCkwjPiCOyqT0scA=
MIME-Version: 1.0
In-Reply-To: <CA+G9fYvnq9wEat-96JAshHpn4Pvf+7CZZi8Z47Y5afQSiK6rfg@mail.gmail.com>
References: <20180316152259.964532775@linuxfoundation.org> <CA+G9fYvnq9wEat-96JAshHpn4Pvf+7CZZi8Z47Y5afQSiK6rfg@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 17 Mar 2018 15:51:14 +0530
Message-ID: <CA+G9fYth=+85LuL6cQQ9TtD+E2tVz9NoqVLt5amea7C=1CpbfQ@mail.gmail.com>
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

On 17 March 2018 at 15:41, Naresh Kamboju <naresh.kamboju@linaro.org> wrote=
:
> On 16 March 2018 at 20:52, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>> This is the start of the stable review cycle for the 4.4.122 release.
>> There are 63 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
>>
>> Responses should be made by Sun Mar 18 15:22:41 UTC 2018.
>> Anything received after that time might be too late.
>>
>> The whole patch series can be found in one patch at:
>>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch=
-4.4.122-rc1.gz
>> or in the git tree and branch at:
>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stabl=
e-rc.git linux-4.4.y
>> and the diffstat can be found below.
>>
>> thanks,
>>
>> greg k-h
>
> Results from Linaro=E2=80=99s test farm.
> No regressions on arm64 and arm.
No regressions on arm64, arm, qemu_x86_64 and x86_64.

* test_vdso_64 test failure on x86_64(vsyscall=3Dnone) is not a blocker for=
 rc.

>
>
> NOTE:
> CONFIG_LEGACY_VSYSCALL_EMULATE=3Dy is enabled from config as default.
> Enabled vsyscall=3Dnative and vsyscall=3Dnone from kernel command line fo=
r testing
> selftests/x86/test_vsyscall test case on x86_64 and qemu_x86_64.
>
> test_vdso_64 failed on x86_64 device when vsyscall=3Dnone is enabled.
> We will investigate this new test failure.
>
> Summary
> ------------------------------------------------------------------------
>
> kernel: 4.4.122-rc1
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
> git branch: linux-4.4.y
> git commit: d7facaec9c1eb3d2703ce89b2ab81207eb7a4e6c
> git describe: v4.4.121-64-gd7facaec9c1e
> Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/b=
uild/v4.4.121-64-gd7facaec9c1e
>
>
> No regressions (compared to build v4.4.121)
>
> Boards, architectures and test suites:
> -------------------------------------
>
> juno-r2 - arm64
> * boot - pass: 20
> * kselftest - skip: 29, pass: 34
> * libhugetlbfs - skip: 1, pass: 90
> * ltp-cap_bounds-tests - pass: 2
> * ltp-containers-tests - skip: 53, pass: 28
> * ltp-fcntl-locktests-tests - pass: 2
> * ltp-filecaps-tests - pass: 2
> * ltp-fs-tests - skip: 2, pass: 61
> * ltp-fs_bind-tests - pass: 2
> * ltp-fs_perms_simple-tests - pass: 19
> * ltp-hugetlb-tests - pass: 22
> * ltp-io-tests - pass: 3
> * ltp-ipc-tests - pass: 9
> * ltp-math-tests - pass: 11
> * ltp-nptl-tests - pass: 2
> * ltp-pty-tests - pass: 4
> * ltp-sched-tests - skip: 4, pass: 10
> * ltp-securebits-tests - pass: 4
> * ltp-syscalls-tests - skip: 152, pass: 998
> * ltp-timers-tests - skip: 1, pass: 12
>
> qemu_x86_64
> * boot - pass: 22
> * kselftest - skip: 33, pass: 47
> * kselftest-vsyscall-mode-native - skip: 33, pass: 47
> * kselftest-vsyscall-mode-none - skip: 33, pass: 47
> * libhugetlbfs - skip: 1, pass: 90
> * ltp-cap_bounds-tests - pass: 2
> * ltp-containers-tests - skip: 17, pass: 64
> * ltp-fcntl-locktests-tests - pass: 2
> * ltp-filecaps-tests - pass: 2
> * ltp-fs-tests - skip: 6, pass: 57
> * ltp-fs_bind-tests - pass: 2
> * ltp-fs_perms_simple-tests - pass: 19
> * ltp-fsx-tests - pass: 2
> * ltp-hugetlb-tests - pass: 22
> * ltp-io-tests - pass: 3
> * ltp-ipc-tests - pass: 9
> * ltp-math-tests - pass: 11
> * ltp-nptl-tests - pass: 2
> * ltp-pty-tests - pass: 4
> * ltp-sched-tests - skip: 1, pass: 13
> * ltp-securebits-tests - pass: 4
> * ltp-syscalls-tests - skip: 149, pass: 1001
> * ltp-timers-tests - skip: 1, pass: 12
>
> x15 - arm
> * boot - pass: 20
> * kselftest - skip: 29, pass: 33
> * libhugetlbfs - skip: 1, pass: 87
> * ltp-cap_bounds-tests - pass: 2
> * ltp-containers-tests - skip: 17, pass: 64
> * ltp-fcntl-locktests-tests - pass: 2
> * ltp-filecaps-tests - pass: 2
> * ltp-fs-tests - skip: 2, pass: 61
> * ltp-fs_bind-tests - pass: 2
> * ltp-fs_perms_simple-tests - pass: 19
> * ltp-fsx-tests - pass: 2
> * ltp-hugetlb-tests - skip: 2, pass: 20
> * ltp-io-tests - pass: 3
> * ltp-ipc-tests - pass: 9
> * ltp-math-tests - pass: 11
> * ltp-nptl-tests - pass: 2
> * ltp-pty-tests - pass: 4
> * ltp-sched-tests - skip: 1, pass: 13
> * ltp-securebits-tests - pass: 4
> * ltp-syscalls-tests - skip: 98, pass: 1052
> * ltp-timers-tests - skip: 1, pass: 12
>
> x86_64
> * boot - pass: 22
> * kselftest - skip: 31, fail: 1, pass: 48
> * kselftest-vsyscall-mode-native - skip: 31, fail: 1, pass: 48
> * kselftest-vsyscall-mode-none - skip: 31, fail: 2, pass: 46
> * libhugetlbfs - skip: 1, pass: 90
> * ltp-cap_bounds-tests - pass: 2
> * ltp-containers-tests - skip: 17, pass: 64
> * ltp-fcntl-locktests-tests - pass: 2
> * ltp-filecaps-tests - pass: 2
> * ltp-fs-tests - skip: 1, pass: 62
> * ltp-fs_bind-tests - pass: 2
> * ltp-fs_perms_simple-tests - pass: 19
> * ltp-fsx-tests - pass: 2
> * ltp-hugetlb-tests - pass: 22
> * ltp-io-tests - pass: 3
> * ltp-ipc-tests - pass: 9
> * ltp-math-tests - pass: 11
> * ltp-nptl-tests - pass: 2
> * ltp-pty-tests - pass: 4
> * ltp-sched-tests - skip: 5, pass: 9
> * ltp-securebits-tests - pass: 4
> * ltp-syscalls-tests - skip: 120, pass: 1030
> * ltp-timers-tests - skip: 1, pass: 12
>
> Hikey test results,
>
> Summary
> ------------------------------------------------------------------------
>
> kernel: 4.4.122-rc1
> git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
> git tag: 4.4.122-rc1-hikey-20180316-150
> git commit: f4e336912f0cb6dc3a56a014c5f495b37099d067
> git describe: 4.4.122-rc1-hikey-20180316-150
> Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4=
.4-oe/build/4.4.122-rc1-hikey-20180316-150
>
>
> No regressions (compared to build 4.4.121-rc1-hikey-20180310-148)
>
> Boards, architectures and test suites:
> -------------------------------------
>
> hi6220-hikey - arm64
> * boot - pass: 20
> * kselftest - skip: 32, pass: 31
> * libhugetlbfs - skip: 1, pass: 90
> * ltp-cap_bounds-tests - pass: 2
> * ltp-containers-tests - skip: 53, pass: 28
> * ltp-fcntl-locktests-tests - pass: 2
> * ltp-filecaps-tests - pass: 2
> * ltp-fs-tests - skip: 2, pass: 61
> * ltp-fs_bind-tests - pass: 2
> * ltp-fs_perms_simple-tests - pass: 19
> * ltp-fsx-tests - pass: 2
> * ltp-hugetlb-tests - skip: 1, pass: 21
> * ltp-io-tests - pass: 3
> * ltp-ipc-tests - pass: 9
> * ltp-math-tests - pass: 11
> * ltp-nptl-tests - pass: 2
> * ltp-pty-tests - pass: 4
> * ltp-sched-tests - skip: 4, pass: 10
> * ltp-securebits-tests - pass: 4
> * ltp-syscalls-tests - skip: 154, pass: 996
> * ltp-timers-tests - skip: 1, pass: 12
>
> --
> Linaro QA (beta)
> https://qa-reports.linaro.org
