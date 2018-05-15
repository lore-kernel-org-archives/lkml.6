Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2020282-1526364696-2-718116525551839462
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526364695; b=jB2e1pKeJRVx/1erVB8ehnHb8oVrEtkPgqCEQbUOgi51xF+vbI
    zU2ovSITrdXkxCiAYq+FQ87Ek32mMjXZrKPE5vlKQQEjhxisu07Zh9NGnUP4SspV
    5flfqVHk2Pq4dZ4V1wqUrzmoaJjXAlZRzaY3NaOzlgq840b1x6xpMlthl99WfpCJ
    lr8f8ySACpVB7WOg74RNfdfPoYOUc97AKYVnG2zEyr+39YmyEmp3uFPOQHLfdhq4
    vR0bYXExF6sucnpqQBfWjtT7Ph+kX8KK5EZ1t9mYLkUfRGrjQgUVzlM97XmvHt0V
    zwKYNvSRdsxiIs8Zfj85waLGalkyB2/0z+Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526364695;
    bh=+qqKPJDAGu0BejEvlAUokiiCxt+jd2PF/spQ3beYLNQ=; b=jl5lcQLoMACq
    D+b4BBHzttmrqCjvuWcoI8mL56qRe93pnMxpkseRXoH4VjIuaa8ZOY+uAdCEaYDj
    ru7rzM4UMdaI+f86CWPqQ/SW3yzCU+r4fTYSDmdibXREvlUHCYl/+P4So5CNpAzQ
    cmXBAuCCFxh43nbTHLTjxOIUdM9+aQ/FzR0z1bYxAiQZb8I59tG7c56/emfn9DzW
    lT7e2yGJ7eT+Gn12Zsb7zMf/jGS3602/P0o/j/nojzxKDcUOu3NLoCsRR7O+uLVw
    45RH2UnXALgdy4J+HIH0KApE+mOkJW5FA4KwOPP2LKbG/Ka8IdZgujZJUmMmr5U8
    fsVf0dEE/g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
    header.i=@linaro.org header.b=i5MG9L1b x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=JlbEgl++;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
      header.i=@linaro.org header.b=i5MG9L1b x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=JlbEgl++;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfC3JdOnzBGJON9if2oLUopZWxkmzGoClq5hOm94ljABB97SR/HC0NdyRXrGv0sVgGHkiEXVEr1jx+gdU2yyL3adJjcjtHix2Lg++YWW9A3QI1l2F9k+A
    BS0fgUqf2hkd+8PcjK7lkJN+iq8/D/Ji3VwQg77WEb9Ayli14Enw9Ufhmcxoc4y5AjhJXOXXVyztE7uP7Mwfo/YiEgcvOSyY1F//LnDsWT843ifeP/FxQGyd
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=_yzArvceousA:10
    a=VUJBJC2UJ8kA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
    a=QkmShpKx7UJm5Tc08a0A:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeEOGLc (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 02:11:32 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34344 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752155AbeEOGLb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 May 2018 02:11:31 -0400
X-Google-Smtp-Source: AB8JxZocacq7dNCKFtutAd+VjFdheBgcr1n2sV5Y3DsHx61ngj4PFW3qUsEEXJHiQ6R77s5MVF3ounNBbA63F0K4HxA=
MIME-Version: 1.0
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 15 May 2018 11:41:29 +0530
Message-ID: <CA+G9fYt+MmxpZL6jzrqxwj_9d=FJ3d+Z=xA1MbWzeTdhzYLYzQ@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/56] 4.4.132-stable review
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

On 14 May 2018 at 12:18, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wr=
ote:
> This is the start of the stable review cycle for the 4.4.132 release.
> There are 56 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed May 16 06:47:39 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.132-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-4.4.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.4.132-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: e33795f7a573385b26763104b63355823de20e4b
git describe: v4.4.131-57-ge33795f7a573
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.131-57-ge33795f7a573


No regressions (compared to build v4.4.131-51-g9aa0dca71729)

Boards, architectures and test suites:
-------------------------------------

juno-r2 - arm64
* boot - pass: 21
* kselftest - skip: 37, pass: 29
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 53, pass: 28
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
* ltp-syscalls-tests - skip: 140, pass: 1010
* ltp-timers-tests - pass: 13

qemu_x86_64
* boot - pass: 20
* kselftest - skip: 40, pass: 40
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
* ltp-syscalls-tests - skip: 155, pass: 995
* ltp-timers-tests - pass: 13

x15 - arm
* boot - pass: 20
* kselftest - skip: 36, pass: 29
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
* ltp-syscalls-tests - skip: 78, pass: 1072
* ltp-timers-tests - pass: 13

x86_64
* boot - pass: 22
* kselftest - skip: 37, pass: 41
* kselftest-vsyscall-mode-native - fail: 1, skip: 37, pass: 40
* kselftest-vsyscall-mode-none - skip: 37, pass: 41
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
* ltp-syscalls-tests - skip: 119, pass: 1031
* ltp-timers-tests - pass: 13

Hikey board test results,

Summary
------------------------------------------------------------------------

kernel: 4.4.132-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git tag: 4.4.132-rc1-hikey-20180514-190
git commit: 36ca71c104750c04fb621d8fce5843a66a21fa88
git describe: 4.4.132-rc1-hikey-20180514-190
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.132-rc1-hikey-20180514-190

No regressions (compared to build 4.4.132-rc1-hikey-20180511-188)

Boards, architectures and test suites:
-------------------------------------

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - pass: 27, skip: 38
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 28, skip: 53
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
* ltp-syscalls-tests - pass: 1008, skip: 142
* ltp-timers-tests - pass: 13,

--=20
Linaro QA (BETA)
https://qa-reports.linaro.org
