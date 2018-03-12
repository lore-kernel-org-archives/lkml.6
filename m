Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4187132-1520848425-2-17492495962234466893
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
    t=1520848424; b=GyHBnV7W4/nBLFvWiWjm+oHOi9gN/rVSZWKJWJa6nSQvQWj
    9KoH9WrTCmU+vLOfsmOaP+kST1XILKuStV/CavNO8OCJyzO2CH4dQ0amosxaadFI
    azc2mnAWQp8SatL5pDclQ2Vbe0EXbICOQlyzu+xLyEahBMO3PzWg3fmj4Meao7wV
    OU87N+2EPpuquw9vQ9SZ9A8UtZmXgqDYwAivbLVRUZLc6qM0+Q+n/DATTta1QDin
    rgJoYppqW52bFR1pEsor5o2paIXggIleL1c0bisIpcGOVA0VPkJZlf3gDHKKknTz
    zfSNeWlZQsAovFzLoVosLJzjbW9DHTNtKPqlnPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520848424; bh=5FfzLosg4XY9bWsPFGFGLCiBQOuzvs/zEHHuZCGNtCE=; b=L
    xkY2cfliGAPMRd1k84XNJEs+e92/7W37cQh8RacmnOwBG30swgWeY+yFEWTtGB6T
    iRTg8RAuEKLYHbaE5s2/YRxAzeELAKSWTdUeaNNo6SuHdF+TR35NZqkReniw1a6G
    dN3d2PaxZkPhZk3rvKadMi0/bM+2ja5kd8Dnvpr5fqsSEhUc+QBpA2w0rvd5D9mu
    UrA+pK2TO6HvLK5V8q2yu1IbS5uxIopfDBf/P6IKbfQ1AiEXEJJDM4g3+JlLf1wk
    wOSrRMpdarDdqXOyV9hVkQEJN0oeIDOavedU5IWbaHuaSKWpuvEtiC9iLjBVvNhe
    S4e0+GJvwtvrsRlSMKL5g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=jhQsM99G x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tCKzA5HG;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=jhQsM99G x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tCKzA5HG;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752130AbeCLJwn (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 05:52:43 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35885 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752278AbeCLJwk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Mar 2018 05:52:40 -0400
X-Google-Smtp-Source: AG47ELvYlf3ZaKdYJsfbK0LL0W7D2fP6inkiA1IjzsLH5WpgPjMe7B+WkunC9lE4xQ7clatWxKwQBqPg/8nUT3ITBjE=
MIME-Version: 1.0
In-Reply-To: <20180310001828.476933393@linuxfoundation.org>
References: <20180310001828.476933393@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 12 Mar 2018 15:22:38 +0530
Message-ID: <CA+G9fYv+BzdqOQmA6DLvW7rfVLNGN1w=KxDUDmRQR8cQhi0-SQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 0/9] 4.14.26-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
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

On 10 March 2018 at 05:49, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.14.26 release.
> There are 9 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Mon Mar 12 00:18:16 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.26-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.14.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

NOTE:
Two of the dragonboard-410c boot failures are due to infrastructure failure=
.

Summary
------------------------------------------------------------------------

kernel: 4.14.26
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: 96427a5164f3eff6ee6eb924dbb53adb6eaa082d
git describe: v4.14.26
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.26


No regressions (compared to build v4.14.25-10-gcf6424f29452)

Boards, architectures and test suites:
-------------------------------------

dragonboard-410c
* boot - pass: 20, fail: 2
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
* ltp-fs_bind-tests - pass: 2,
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
* kselftest - pass: 62, skip: 20,
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
* kselftest - pass: 41, skip: 19, fail: 2
* libhugetlbfs - pass: 87, skip: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 62, skip: 17, fail: 2
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
