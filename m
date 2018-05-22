Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2357871-1526986117-2-10565035181847078335
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526986116; b=eamfxOPkWnBvsdg6UHb84/Yoa67d7PQjBojGCTnfuRoNfCGg5x
    UwMKKnU/kUkq/2SnVWCQYH8k1kNgVKDQ5vZTZ2GKUKJ0fQXZqqq8lskrSVVdcmOa
    uz7m3xJjn6llC28pjb6baUf4LRd1QPj2T90wG0h8w1u5jrLiIj9LmjRp9X71RYh1
    6oVy5NNRKfGkeB5OM12V+I7Nsxyz869jMSIdQs2dJdgRzMXHk9FqB2l+rKtcOQpT
    a+oPwaLuMCVYaGV8CoaB64ddgjjZKgC38g2ulaRHn7YVU5MfQnNN1HHM0/oerJAS
    yNzw5ZBpAp0Wx1g+93CtKithSwLmQwmlaaog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526986116;
    bh=FCAzPEoAF0K7udb5QmmZpEHnxJiZlY26p6fpZosdsAw=; b=AsSeuyjoZpH4
    mvTh/aaG4Pelf8msUFgfXJfRHNTp8ieJSt6p0c63ZD65B4z8Z8Qr5M4CoPBEwoRJ
    92coVIXskoRLWcWpLqvAYgrJHyuI4ZIKl3De9mlfGSYKmgm0Uu6L08WHUsWjwE6C
    H7TkPwppKNSOZZnzxr8QizrYBU5rxUc9fjZAZtnTlZNW5OBUx3M0FgrnEu/tFT5w
    s4HEC2MjLmqICZUqUmBEJSQPhLmvjSElNKwYrqQyPTvAJfGMoRRHBOyLABti8XBk
    T/qkWj5wCKqCfivKD9BBJgXSy6yuhdi7/mVVmUhJpgMGIlsDXb0KYzUIrVEMy+gn
    TJKCqcYpiA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
    header.i=@linaro.org header.b=es3iB70G x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=JN4Kndw5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
      header.i=@linaro.org header.b=es3iB70G x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=JN4Kndw5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAtJqsXepnnI9leeKbjMiI56KhQExCsm6FIys+BKA3tcpSmqwk3kFuNqQVopWy3wSmJrtczeB+AgD7JI0nqaxd7fjqvpnVaTXSBR0Jy6W6Nx6y6ojOfW
    /KEufSAsuczVNTOuzJeiM/xzMnyMks0PgjE8ZalNabOVDrgHAI7BpRoEyEHSmGQzssBHzoE6J+6QC9YaBEK6Tgrv5wJG9xBASrNgiFNKfP/1Nlyl/VScYm7h
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=UIbBetWhaY0A:10
    a=VUJBJC2UJ8kA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
    a=gWx1A5luGpKtexyLMGYA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751173AbeEVKse (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 06:48:34 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:42845 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750733AbeEVKsd (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 May 2018 06:48:33 -0400
X-Google-Smtp-Source: AB8JxZoQKB1pAnfG1FA0C47ZmjG+ly40m/II8p/KE9lw9D9UTd3RxakVZXvgf+eO5hm0QBE5CpZhSQXyNMHDMo65r+4=
MIME-Version: 1.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 22 May 2018 16:18:31 +0530
Message-ID: <CA+G9fYsGV7P77u8z0jhGrpMDFSMo-1PBnHPWkq4z1Z7oq6vEaw@mail.gmail.com>
Subject: Re: [PATCH 4.16 000/110] 4.16.11-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
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

On 22 May 2018 at 02:40, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wr=
ote:
> This is the start of the stable review cycle for the 4.16.11 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue May 22 21:04:14 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.16.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

NOTE:
kselftest rtnetlink.sh test case failed on all devices.
Which is not a regression which used to SKIP pass and now run and fail.
Bug reported to investigate,
https://bugs.linaro.org/show_bug.cgi?id=3D3834

Summary
------------------------------------------------------------------------

kernel: 4.16.11-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.16.y
git commit: 663daea64d0bbd800ae507d08f35706d169c6883
git describe: v4.16.10-111-g663daea64d0b
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.16-oe/bu=
ild/v4.16.10-111-g663daea64d0b

No regressions (compared to build v4.16.10-62-g473d9b275b2a)
------------------------------------------------------------------------

Boards, architectures and test suites:
-------------------------------------

dragonboard-410c - arm64
* boot - fail: 5, pass: 20
* kselftest - fail: 2, skip: 26, pass: 40
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
* ltp-syscalls-tests - skip: 133, pass: 1017
* ltp-timers-tests - pass: 13

hi6220-hikey - arm64
* boot - pass: 20
* kselftest - fail: 1, skip: 22, pass: 44
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
* ltp-syscalls-tests - skip: 134, pass: 1016
* ltp-timers-tests - pass: 13

juno-r2 - arm64
* boot - pass: 20
* kselftest - fail: 1, skip: 24, pass: 43
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
* ltp-syscalls-tests - skip: 133, pass: 1017
* ltp-timers-tests - pass: 13

qemu_arm
* boot - pass: 20
* kselftest - fail: 1, skip: 31, pass: 36
* libhugetlbfs - pass: 1
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 18, pass: 63
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 5, pass: 58
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 2
* ltp-hugetlb-tests - skip: 1, pass: 21
* ltp-io-tests - pass: 3
* ltp-ipc-tests - pass: 9
* ltp-math-tests - pass: 11
* ltp-nptl-tests - pass: 2
* ltp-pty-tests - pass: 4
* ltp-sched-tests - skip: 7, pass: 7
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - fail: 4, skip: 92, pass: 1054
* ltp-timers-tests - pass: 13

qemu_arm64
* boot - fail: 2, pass: 20
* kselftest - fail: 1, skip: 29, pass: 40
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
* ltp-syscalls-tests - fail: 2, skip: 155, pass: 993
* ltp-timers-tests - pass: 13

qemu_x86_64
* boot - pass: 20
* kselftest - fail: 1, skip: 29, pass: 52
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
* ltp-syscalls-tests - skip: 153, pass: 997
* ltp-timers-tests - pass: 13

x15 - arm
* boot - pass: 20
* kselftest - fail: 1, skip: 28, pass: 38
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
* kselftest - fail: 1, skip: 21, pass: 52
* kselftest-vsyscall-mode-native - fail: 1, skip: 20, pass: 52
* kselftest-vsyscall-mode-none - fail: 1, skip: 20, pass: 53
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 5, pass: 58
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
* ltp-syscalls-tests - skip: 116, pass: 1034
* ltp-timers-tests - pass: 13

--=20
Linaro QA (BETA)
https://qa-reports.linaro.org
