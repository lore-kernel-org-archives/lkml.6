Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3181716-1525803111-2-17907143804052329014
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
    1525803110; b=BiRlj29Q5aZXul35jv9C8Qxy4O0h7ty2TFoRvMcaMbBpvP5gc9
    m5CB9eabuIIqmn222L5igbaaAziI6PHX4T7W9D01Q1upFpTJpoE8DdH5E+aXmULH
    a7kv0F0xSEpBhTkV2RKY7MyxO8atX6COkXe+47vzDNhwMoDwy+sr1jwDagLPNp7t
    og7mkz396mW7g0Wgd6tendpBgRdAblON+Ye8lXnuvG7FStdSU6G/+GT/NaM364oE
    ztVlYU/ypYjgOJFbw5Ynyc1Rx5FsvApa93pSFvlsqyrRpcTlPXORuJpV9HDcFDnD
    /cd6gVnWy0BsBeM48fQgjHMgrS/XlMtlP+wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525803110;
    bh=BgfeBmuT+62f7FcUQJDZET1bqfjOVJPOFpTV3/Xyt6s=; b=m+o1b64iXzlo
    4G6cmiRMCJi8H5ZGvS3kYD/91x18pejL3Hciwhb7/ODbHd5Q4g5wMpC09Yd6FbKV
    GwhFYdEa2TWVt1258kYSC9wGYNx+kD+dFagGLzXjl+jvXByU6EKdQZtZabcMOSAs
    /oc3qtNS+SoFXDMjVRpnYhUM/mWAVpITNpeFTOLkhkTZhkOdBdle/HN+6V4oTC9f
    tcjK6I9z2jAfK9TwTjauUAiPBAS2LOs92eVyIKDgPHzUMMch+Y8S83tvPwi8dpUP
    RknnXMTLRPhutVvEenQhDzfkoWIv6Kw5c3DvIsjY5P67m3QjEKF96Z6kCwEBtjwf
    35bVPHOOHQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
    header.i=@linaro.org header.b=YmZCsjZh x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=UNbjrysK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
      header.i=@linaro.org header.b=YmZCsjZh x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=UNbjrysK;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPTd8aj2EAFMwdyaP6MO7++h3HNs4dyejreTcLE/UmCjq8pIAfkehyPKKJKvUaVgKbeD9OkcQJzqu80mZusFOHlL1DX1hbjRw4MoZSrCkd4sNs1QYuTZ
    WIzaBS/TDRiMAAjz6YBhBdrF6YptfDBeihYgecbgaLF3vSRwzvoYZW/dlSbov5F5jGZSVTpfc7jxUNbaFPzefkF5cmunydQNf54zF3FnTRlWboCXmlyimLAn
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=bdhgAJw2s1sA:10
    a=VUJBJC2UJ8kA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
    a=mN3NWnOuCihH9c8rQQ0A:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755688AbeEHSLe (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 14:11:34 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44487 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755606AbeEHSLd (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 8 May 2018 14:11:33 -0400
X-Google-Smtp-Source: AB8JxZraq2MG/W0VqfTNXEVo8Opx8q0jsvQK5CdPsKT2boIXNO2++fWYfd7/OH9kEjKMn04M/+XtmNqseP/bfGCiqpA=
MIME-Version: 1.0
In-Reply-To: <20180508074003.984433784@linuxfoundation.org>
References: <20180508074003.984433784@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 8 May 2018 23:41:30 +0530
Message-ID: <CA+G9fYvoNi9qg3Gb0cU=y9hhSZX6FKt5D151GUAnXGJ_tS4g-w@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/43] 4.14.40-stable review
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

On 8 May 2018 at 13:40, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wro=
te:
> This is the start of the stable review cycle for the 4.14.40 release.
> There are 43 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu May 10 07:39:32 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.14.40-rc1.gz
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

kernel: 4.9.99-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: 6e28bacfe4aa523ece3838a9d50e7612d41be723
git describe: v4.9.98-33-g6e28bacfe4aa
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.98-33-g6e28bacfe4aa


No regressions (compared to build v4.9.98-8-g5918d4b6b7ff)

Boards, architectures and test suites:
-------------------------------------

dragonboard-410c
* boot - pass: 20
* kselftest - skip: 32, pass: 34
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
* ltp-syscalls-tests - skip: 135, pass: 1015
* ltp-timers-tests - pass: 13

hi6220-hikey - arm64
* boot - pass: 20
* kselftest - skip: 29, pass: 36
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
* ltp-syscalls-tests - skip: 136, pass: 1014
* ltp-timers-tests - pass: 13

juno-r2 - arm64
* boot - pass: 20
* kselftest - skip: 29, pass: 37
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
* ltp-syscalls-tests - skip: 135, pass: 1015
* ltp-timers-tests - pass: 13

qemu_arm
* boot - fail: 12, pass: 8
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 18, pass: 63
* ltp-fcntl-locktests-tests - pass: 2
* ltp-hugetlb-tests - skip: 1, pass: 21
* ltp-ipc-tests - pass: 9
* ltp-pty-tests - pass: 4
* ltp-syscalls-tests - skip: 92, fail: 3, pass: 1055

qemu_arm64
* boot - pass: 20
* kselftest - skip: 33, pass: 35
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
* ltp-syscalls-tests - skip: 157, fail: 2, pass: 991
* ltp-timers-tests - pass: 13

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
* ltp-syscalls-tests - skip: 152, pass: 998
* ltp-timers-tests - pass: 13

x15 - arm
* boot - pass: 20
* kselftest - skip: 29, pass: 36
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
* kselftest - skip: 30, pass: 50
* kselftest-vsyscall-mode-native - skip: 30, fail: 1, pass: 49
* kselftest-vsyscall-mode-none - skip: 30, pass: 50
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 5, pass: 58
* ltp-fs_bind-tests - pass: 2
* ltp-fs_perms_simple-tests - pass: 19
* ltp-fsx-tests - pass: 1
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
