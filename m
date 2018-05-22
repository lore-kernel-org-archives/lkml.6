Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2401354-1526987343-2-6353422447315194936
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
    1526987341; b=TphXPVycqxES2QwWqCy6PSRypHjlvwd+xXMQxx8BxLV3Bb7aep
    FhNdX5d7xkw0jUt4R/rblzjq0TR7cUBczfH7iBPmphcYLg0ZG7IRlffXR8CrF2ju
    /1sc6jyh1Ajpxc5wbPa4oix5MCHM0Jju4FJ1+3IWXvn9AcuJuTccRBr6AHMrA/i5
    q50flOghpJplfG7MxdBphFOy6e54FO0wQTFY+Fcb1xTSt2c8vwQzZOXen/oFISJi
    Xsyi+toDxrjrM2RfFw7+2El4kvrI9zlydaykSVhQ8j0lmwyRU8dr2QZ8K5I4TI7j
    JIM3EeFgEtQitAWI+8otGMPDlNmgaiENwaxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526987341;
    bh=ijC9ED3rYsjwt+jRWCs+/2o0wt6emy6zvHQj6BscDXU=; b=MdTudWmHP9mD
    UzdzHk5kzwCU7lfQruhxqXRxapmm1pe679DiYTv0Z4pg42wpTTkhnzyRrbhUh22I
    NSuloBBRacPdTkBF10Yci1WVFYO4yy/B8FvLVF32X8VJ6liQ7Mm9mym8uzaEvP4t
    z/UQq1x3DofAfyVxvrxYIK50vnT06KpaMfay4pSIYrNTlqg57jcfdJCch8lJ6pDb
    e7U8NWiju6+FGSpCunhtGQkP3gEvT4xODBNWu2s25AkBrkvh+HP4ZnazD4pqZaST
    Bkutxmmrm4Pi+r1x6Yy4B00IAYNKUbXrCT5D3KstBoYA6pA8jzhFJs05qgy7fNoH
    +qUN05sWHQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
    header.i=@linaro.org header.b=AVYafdZD x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=PvNVV6eR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
      header.i=@linaro.org header.b=AVYafdZD x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=PvNVV6eR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH5nlD4FflAJvt/UhbeZJl6X5gC3kovNIQ9mrujEIXBVpoZ0aOaQTgPl8VozBt7LDL4/FpUUPMa/jIvasiu60IkpNwW8eiN0zJd7envqk3KuhUMPJTC5
    XAQoXLDVFXf8Ee63C+gR2ziRDaC5eJMzrOcvSnb8TiZk3N8GWn0St+MwMFHzdXZzRp/rbm+Q/IBK++tjQIjIfFDIRFODmAT513Hu/nwsa6y0hmUxOhkxKBdG
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=ptgvbpQxxUAA:10
    a=VUJBJC2UJ8kA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
    a=gWx1A5luGpKtexyLMGYA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751689AbeEVLI6 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 07:08:58 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:36315 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751676AbeEVLI5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 22 May 2018 07:08:57 -0400
X-Google-Smtp-Source: AB8JxZrez3rLk+iEc8FEF/JCh6DTmryllfts65lZr2vMlatzztVuldm5DiNg8w6s10nn8um3zsc2Y60aVF9oG3Y3Epg=
MIME-Version: 1.0
In-Reply-To: <20180521210420.222671977@linuxfoundation.org>
References: <20180521210420.222671977@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 22 May 2018 16:38:56 +0530
Message-ID: <CA+G9fYsL4EccV6+QBmU_Ky-5nCwkC32YNN0ETX=RkuEdc2fgrw@mail.gmail.com>
Subject: Re: [PATCH 4.9 00/87] 4.9.102-stable review
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

On 22 May 2018 at 02:40, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wr=
ote:
> This is the start of the stable review cycle for the 4.9.102 release.
> There are 87 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue May 22 21:03:57 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.9.102-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.9.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

NOTE:
kselftest rtnetlink.sh test case failed on all device.
Which is not a regression which used to SKIP pass and now run and fail.
Bug reported to investigate,
https://bugs.linaro.org/show_bug.cgi?id=3D3834

Summary
------------------------------------------------------------------------

kernel: 4.9.102-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.9.y
git commit: c410143620854fe106977e99aec1b73e1bd0a3f5
git describe: v4.9.101-88-gc41014362085
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/bui=
ld/v4.9.101-88-gc41014362085

No regressions (compared to build v4.9.101-35-g336a062e8ff5)
------------------------------------------------------------------------

Boards, architectures and test suites:
-------------------------------------
dragonboard-410c
* boot - pass: 21,
* kselftest - pass: 35, fail: 1, skip: 32
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 4,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 57, skip: 6
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 14,
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1015, skip: 135
* ltp-timers-tests - pass: 13,

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - pass: 34, fail: 1, skip: 29
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 57, skip: 6
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1014, skip: 136
* ltp-timers-tests - pass: 13,

juno-r2 - arm64
* boot - pass: 22,
* kselftest - pass: 35, fail: 1, skip: 28
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 114, skip: 12
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 10, skip: 4
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1015, skip: 135
* ltp-timers-tests - pass: 13,

qemu_arm
* boot - pass: 20,
* kselftest - pass: 35, fail: 1, skip: 32
* libhugetlbfs - pass: 1,
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 63, skip: 18
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 58, skip: 5
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 21, skip: 1
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 7, skip: 7
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1056, fail: 2, skip: 92
* ltp-timers-tests - pass: 13,

qemu_arm64
* boot - pass: 20,
* kselftest - pass: 36, fail: 1, skip: 33
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
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
* ltp-sched-tests - pass: 8, skip: 6
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 991, fail: 2, skip: 157
* ltp-timers-tests - pass: 13,

qemu_x86_64
* boot - pass: 20,
* kselftest - pass: 48, fail: 1, skip: 33
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
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
* ltp-sched-tests - pass: 13, skip: 1
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 998, skip: 152
* ltp-timers-tests - pass: 13,

x15 - arm
* boot - pass: 20,
* kselftest - pass: 34, fail: 1, skip: 29
* libhugetlbfs - pass: 87, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 63, skip: 18
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 58, skip: 5
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 20, skip: 2
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 13, skip: 1
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1075, skip: 75
* ltp-timers-tests - pass: 13,

x86_64
* boot - pass: 22,
* kselftest - pass: 51, fail: 1, skip: 30
* kselftest-vsyscall-mode-native - pass: 50, fail: 2, skip: 30
* kselftest-vsyscall-mode-none - pass: 51, fail: 1, skip: 30
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 58, skip: 5
* ltp-fs_bind-tests - pass: 2,
* ltp-fs_perms_simple-tests - pass: 19,
* ltp-fsx-tests - pass: 2,
* ltp-hugetlb-tests - pass: 22,
* ltp-io-tests - pass: 3,
* ltp-ipc-tests - pass: 9,
* ltp-math-tests - pass: 11,
* ltp-nptl-tests - pass: 2,
* ltp-pty-tests - pass: 4,
* ltp-sched-tests - pass: 9, skip: 5
* ltp-securebits-tests - pass: 4,
* ltp-syscalls-tests - pass: 1034, skip: 116
* ltp-timers-tests - pass: 13,

--=20
Linaro QA (BETA)
https://qa-reports.linaro.org
