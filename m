Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-216422-1526670609-2-12221198983947826367
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
    1526670609; b=kj2XeL8QjMz3zDtJEaRBhhFmS5xGQMRAa7V3PBk1a/BJ5BKT6z
    64gWQHs726aNm7JpsWYGm0fEUflchQSBrTz0apkpi4/J0/ptCnyTkkPwTUmex0z/
    nc4ZVOSaMN43RtQPo2rSDGiXbz8qn+0I5q/oYiqrParJXdv5oyeJD+zP8n8pc2Hc
    KUldKW2lLkhfd9HocuukDwIIBUdGsYAVCFriWYnf/YGG8t0yKP1M8041pJ2ui/UI
    FcDF02CzC5Wbp8gGhrD2mqsBUGksP9MQP/Jyz35llPcQdDbK0POkiQvGwwxMVKsn
    KAUUv4nC/lX5ddL7WES3nT19jJspwR204ghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526670609;
    bh=5krIwXqh9qYkuc/aQ09nX6QywMC0cTE5Ftq66C4BCUs=; b=DuGR702HONYA
    BPfffJKlk1TKLKJFK1/Q9cBVTUwz6l0et2/6x1WU/0ELzT53e+CICtgcwtwZ0gx1
    uf0zaZvlTZ3vXWXOcCLrKuNfk0s6yU5UNI2ROUW+c+3x10aYYCTSGI2vVyAgP8SQ
    uUegd7rmRAW4QTCwxz8LfSHa7l/qn8zfwadFnnr4tNhFKNm3eNAjrpEKN27J4slU
    u6ouTZE/knO0oG9uGcp6rvwWMq8bh3gvnIV0QMoDUw1WGoKgn0A+pCzydHJCZWlX
    Tqj5zHGLaqNCK9Cf1oXPaZX+4CsY2FGxMdYm/wovU4wbWQi5Zy0B1rdMjSyLZnCc
    4fSnS/6QXg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
    header.i=@linaro.org header.b=gzR0eSjL x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=qxl06FqK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
      header.i=@linaro.org header.b=gzR0eSjL x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=qxl06FqK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH54XTw4Q1EEx1STd1HLikBNFjH2LgGkUtC5XbNTxcEqNswLTSFhNT0O6mompH5KDBgBb/t9+4T9c9+B8ZQXnq8SOwFS3aq2N3Nt+Aumk3c33vS2w7H8
    B/ZjOPcapKCqpzCAJ8Q51Xj+RB+iiSrZ8D0QvhxaCQqBGjTpJuvw4VHAdpocyNHHsFS7BW4+CmuK+dFgEzYyLQYQndu/qtki0x9rMTLlEIxt/TuD4cNXZNik
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=WWs0EKWmijYA:10
    a=VUJBJC2UJ8kA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
    a=XnOWzLnHPDZs9IGggqEA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbeERTKF (ORCPT <rfc822;greg@kroah.com>);
        Fri, 18 May 2018 15:10:05 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35673 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeERTKE (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 18 May 2018 15:10:04 -0400
X-Google-Smtp-Source: AB8JxZrGvUy8M2Jkiz8D1srjXbexv01as66K1uXy1nZsyqlyVR9iTwMOaHof/rpB1ofqe0JGf4TGZdQtxl0KtrowFnE=
MIME-Version: 1.0
In-Reply-To: <20180518081530.331586165@linuxfoundation.org>
References: <20180518081530.331586165@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 19 May 2018 00:40:01 +0530
Message-ID: <CA+G9fYvo1_0T+PEQ94+qpjBjwvX33h7CypT88_dVRGPg99nJ+Q@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/45] 4.14.42-stable review
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

On 18 May 2018 at 13:45, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wr=
ote:
> This is the start of the stable review cycle for the 4.14.42 release.
> There are 45 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun May 20 08:15:14 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.42-rc1.gz
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

kernel: 4.14.42-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 879085a4c525940c6c3b08d6a2f49fc064bf02a8
git describe: v4.14.41-46-g879085a4c525
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.41-46-g879085a4c525


No regressions (compared to build v4.14.41-44-g1134b348cdb5)

Boards, architectures and test suites:
-------------------------------------

dragonboard-410c
* boot - pass: 20
* kselftest - skip: 27, pass: 41
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
* ltp-syscalls-tests - skip: 134, pass: 1016
* ltp-timers-tests - pass: 13

hi6220-hikey - arm64
* boot - pass: 20
* kselftest - skip: 23, pass: 44
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
* ltp-syscalls-tests - skip: 135, pass: 1015
* ltp-timers-tests - pass: 13

juno-r2 - arm64
* boot - pass: 20
* kselftest - skip: 25, pass: 43
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
* ltp-syscalls-tests - skip: 134, pass: 1016
* ltp-timers-tests - pass: 13

qemu_arm
* boot - pass: 21
* kselftest - fail: 2, skip: 29, pass: 37
* libhugetlbfs - pass: 2
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
* ltp-syscalls-tests - fail: 3, skip: 92, pass: 1055
* ltp-timers-tests - pass: 13

qemu_arm64
* boot - pass: 21
* kselftest - skip: 29, pass: 41
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
* ltp-sched-tests - skip: 6, pass: 8
* ltp-securebits-tests - pass: 4
* ltp-syscalls-tests - fail: 2, skip: 156, pass: 992
* ltp-timers-tests - pass: 13

qemu_x86_64
* boot - pass: 20
* kselftest - skip: 30, pass: 50
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
* ltp-syscalls-tests - skip: 152, pass: 998
* ltp-timers-tests - pass: 13

x15 - arm
* boot - pass: 20
* kselftest - fail: 2, skip: 26, pass: 36
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
* kselftest - skip: 22, pass: 54
* kselftest-vsyscall-mode-native - fail: 1, skip: 22, pass: 53
* kselftest-vsyscall-mode-none - skip: 21, pass: 54
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
