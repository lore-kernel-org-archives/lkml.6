Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2435039-1524549693-2-7478236832408212274
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524549692; b=bikSn7dKYgPZ/n1/p2Wdu+jysI8R4onRl0Tsy9UlBod2X6TM5X
    6tMLYmmIExVlTsdxyxFf40lY7qjGZgYOTe9TbqGfIHHOrNaPohehpCS0TKhKgjNL
    7jMoVOFkY4G82LAAliXRwpNrEJkrhaEac2IbOvfQjYcN2P8pGphUaqFK2Ssy8J0L
    W8a9RZ/2iLW9hR9xdy5pNhk9BHIcCTVvevxNOVRDcp0Jr668LO561lae3dg2xs2j
    Xs4U83OQ8uAhi3BQN11OMdZYEq0MBNEl40vsCUZOyUaoxv07jKzklWRujrzt5uKN
    VLJzOON/AjmNfXt4mYydjuCQO/FCjy0sP1+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524549692;
    bh=bKyAlr67DT3Zt0IIHdrZ4zIOHJ/cxaxN0UgaDZ3GA34=; b=HdQNjG9gC6SU
    C91yXPR0FI36M5CUhVe+uLync0WT0u7/qiUXLEItkaMIPZ2scaGceuNppVvVkQo9
    eMRVy/e75W4oKhGqjyeUOBE+G+qcZ6MMOUxMgwqeLYb3kySvqc6z3/lYbRgzjTDV
    gZVQN5Q8He822B/OrIK4BDkhao+fDvcMMv4Iyrn4aefJlFPXyMvnuyMG64dHGT5y
    YKPfTn2D9gWashrGbZiBc40z/JX9szYSh/bH1nh02lMvBRm/E7ft0F5uvFjao1qY
    5Vl5zsjon+G1qWJW/rOLbUiFQ5R8fL4Uln+GAEhrCKkR4z7JG5BY64SbTRzHsRY6
    YRZCrt+0dw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Arl6p8/r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tObXp2wv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Arl6p8/r x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tObXp2wv;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO/egjQAgDpOxw4olYy3sbHjIKjDfSW2lyeX42R1wJ4lucGqi2/5spQEi/0c0kHVCLb2n7WunTE5Dk28zGgtK/y9t2V+BmDz/A39G/8oDPL5B/O6EHEL
    eZq0usaKlbIQrhZgzSsD4GbHHr/i/T44+aksZXGsnIH3d2Vd+NrwBu/4kl4WEdw3N3BMi32SOw+/CxxKjezPRCiK9J38D7p/FQCVq0hWQ9HhMk0KtX+LXVwU
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=mxXUtGV5dC8A:10
    a=Kd1tUaAdevIA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
    a=U_hORyKSyVAHIXlPy4IA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755969AbeDXGBb (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 02:01:31 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:45098 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752110AbeDXGBa (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 24 Apr 2018 02:01:30 -0400
X-Google-Smtp-Source: AB8JxZptABQ5Y+fHDA+sM49NEQPedG4P0g/fQaJ7gYprDCT86hrrJrAXqpyFPvrjrerczpBTktGOgx6qAYsb8UY4+dI=
MIME-Version: 1.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 24 Apr 2018 11:31:27 +0530
Message-ID: <CA+G9fYs94xCb+hzFymcAbumR0+a-kGmcAqd4U3jxtLeyxBWzpg@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/164] 4.14.36-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
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

On 22 April 2018 at 19:21, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.14.36 release.
> There are 164 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue Apr 24 13:51:05 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.36-rc1.gz
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

NOTE:
Few comments inline regarding the reported failures.
You may ignore these infrastructure failures.

Summary
------------------------------------------------------------------------

kernel: 4.14.36-rc3
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.14.y
git commit: c6b7e0921276555df40b59366fb6bf123b5b0816
git describe: v4.14.35-164-gc6b7e0921276
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.14-oe/bu=
ild/v4.14.35-164-gc6b7e0921276


No regressions (compared to build v4.14.35-165-g7474ba098676)

Boards, architectures and test suites:
-------------------------------------

dragonboard-410c
* boot - pass: 19, fail: 1
  ^ infrastructure issues
* kselftest - skip: 20, pass: 42, fail: 6
   ^ kselftest failures caused by kselftest upgrade to 4.16 (in all cases
  in this report)
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 57,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 134, pass: 1016,
* ltp-timers-tests - pass: 13,

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - skip: 17, pass: 45, fail: 6
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 57,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - skip: 1, pass: 21,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 4, pass: 10,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 135, pass: 1015,
* ltp-timers-tests - pass: 13,

juno-r2 - arm64
* boot - pass: 20,
* kselftest - skip: 18, pass: 44, fail: 6
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 57,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 4, pass: 10,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 134, pass: 1016,
* ltp-timers-tests - pass: 13,

qemu_arm
* boot - pass: 15, fail: 5
  ^ infrastructure issues
* kselftest - skip: 24, pass: 38, fail: 6
* libhugetlbfs - pass: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 62, fail: 2
* ltp-fs-tests - skip: 5, pass: 58,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - skip: 1, pass: 21,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-securebits-tests - pass: 4,

qemu_arm64
* boot - pass: 20,
* kselftest - skip: 24, pass: 42, fail: 4
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 57,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-securebits-tests - pass: 4,
* ltp-timers-tests - pass: 13,

qemu_x86_64
* boot - pass: 22,
* kselftest - skip: 25, pass: 51, fail: 4
* kselftest-vsyscall-mode-native - skip: 25, pass: 51, fail: 4
* kselftest-vsyscall-mode-none - skip: 25, pass: 51, fail: 4
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 6, pass: 57,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 1, pass: 13,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 148, pass: 1002,
* ltp-timers-tests - pass: 13,

x15 - arm
* boot - pass: 20,
* kselftest - skip: 19, pass: 38, fail: 8
* libhugetlbfs - skip: 1, pass: 87,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 18, pass: 63,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 5, pass: 58,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - skip: 2, pass: 20,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 1, pass: 13,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 75, pass: 1075,
* ltp-timers-tests - pass: 13,

x86_64
* boot - pass: 22,
* kselftest - skip: 19, pass: 55, fail: 6
* kselftest-vsyscall-mode-native - skip: 19, pass: 54, fail: 7
* kselftest-vsyscall-mode-none - skip: 19, pass: 55, fail: 6
* libhugetlbfs - skip: 1, pass: 90,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - skip: 17, pass: 64,
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - skip: 5, pass: 58,
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - skip: 5, pass: 9,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - skip: 116, pass: 1034,
* ltp-timers-tests - pass: 13,

--=20
Linaro QA (BETA)
https://qa-reports.linaro.org
