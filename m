Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-757978-1519715846-2-17448586268456412765
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519715845; b=VWbvBAxllXsW1ivIcM4OMfevkS0lyy0k9NWYpF3uRLbfWIB
    kyE8SY3HTLHnegZxiJU3B/XmXI1ohhfWCrpM9ICoHFCRrRxO/SwmjuBAdEZpMdBM
    1+7xqxETs+Omob74W1F+osiKCCtoEE6CTD5GmsAKpJpuu5satxQT+iW+VaF54y2d
    8+0ANXAWJSBikl9grJYRRLEj/gO2L7tZnNFrnm/PalO4fs2KCBqpRTdEF09F4jUx
    hDcCBE1iTL6o3U6cIJTG6Lj7mzbzHPQXfuAPGwPzgmDraknEzOZXOC1LXQtlaeBZ
    Bfi1EbdeVmItmnKcb4HYaAIAREQhSKCxZ2YydCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519715845; bh=taimpYeLu/jiTwHuXBrunRQy9GXV9K6w07dAWu7zKtw=; b=o
    lGPJL+WNdYq5/lKsukF6dFhnj5T/DLBOTn6sDv4MP2eAXKgmD/rwcrJh4UnCmKx0
    eA0pZDBhZHzJaJgRTVzHjufEZM+jxfr3tIw5ysNPnxguDqw3KNrbRQUk1juPHoXI
    x/by4dRcypF+avpLYxD345i0T3ZoYEQvZdCUTJZTYOBF2B49AERznK2ABTrILpY6
    YNY18yBSZoj8mnkYhgx5YGodUy1NwdSO25J0agNeyKH31yq1UetMV9qsam4zizmn
    RMsH895yTYnHkNa4ofVu6KFRYQrYrTbH0ped3aYEhans6ZNSZ7rNekdpz1e3aqvt
    IgsPVSzacIUgM2GrUF8kg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=kVnmN14j x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QmRwUwt3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=kVnmN14j x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QmRwUwt3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbeB0HRM (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 02:17:12 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37872 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752042AbeB0HRL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 02:17:11 -0500
X-Google-Smtp-Source: AG47ELsRZTSz9LEyLD9W9hZR8U25KZt02LyNxQwVpi6BB/vop+/L2ZzV5JBdNcLKkcfzENm6bf9N8ql+rCvdNBq8yqw=
MIME-Version: 1.0
In-Reply-To: <20180226201558.681421374@linuxfoundation.org>
References: <20180226201558.681421374@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 27 Feb 2018 12:47:09 +0530
Message-ID: <CA+G9fYsT1Q4RhsLdbUvNRA94xHRc_bFLnwE_Nh19Yvh0EowEGA@mail.gmail.com>
Subject: Re: [PATCH 4.4 00/22] 4.4.119-stable review
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

On 27 February 2018 at 01:46, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> This is the start of the stable review cycle for the 4.4.119 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed Feb 28 20:15:48 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-=
4.4.119-rc1.gz
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

kernel: 4.4.119-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git
git branch: linux-4.4.y
git commit: a6c6a3a6b5621c2507038cecf42c46727d327048
git describe: v4.4.118-23-ga6c6a3a6b562
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/bui=
ld/v4.4.118-23-ga6c6a3a6b562


No regressions (compared to build v4.4.118)

Boards, architectures and test suites:
-------------------------------------

juno-r2 - arm64
* boot - pass: 20,
* kselftest - pass: 34, skip: 29
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 28, skip: 53
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 2
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
* ltp-syscalls-tests - pass: 998, skip: 152
* ltp-timers-tests - pass: 12, skip: 1

x15 - arm
* boot - pass: 20,
* kselftest - pass: 33, skip: 29
* libhugetlbfs - pass: 87, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 2
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
* ltp-syscalls-tests - pass: 1052, skip: 98
* ltp-timers-tests - pass: 12, skip: 1

x86_64
* boot - pass: 20,
* kselftest - pass: 48, skip: 32
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 64, skip: 17
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 62, skip: 1
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
* ltp-syscalls-tests - pass: 1030, skip: 120
* ltp-timers-tests - pass: 12, skip: 1

Hikey test results,

Summary
------------------------------------------------------------------------

kernel: 4.4.119-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git tag: 4.4.119-rc1-hikey-20180226-143
git commit: 771d0ba89d9a09eaeca879730f10ebdd6954af6b
git describe: 4.4.119-rc1-hikey-20180226-143
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4=
-oe/build/4.4.119-rc1-hikey-20180226-143


No regressions (compared to build 4.4.118-rc1-hikey-20180224-141)

Boards, architectures and test suites:
-------------------------------------

hi6220-hikey - arm64
* boot - pass: 20,
* kselftest - pass: 31, skip: 32
* libhugetlbfs - pass: 90, skip: 1
* ltp-cap_bounds-tests - pass: 2,
* ltp-containers-tests - pass: 28, skip: 53
* ltp-fcntl-locktests-tests - pass: 2,
* ltp-filecaps-tests - pass: 2,
* ltp-fs-tests - pass: 61, skip: 2
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
* ltp-syscalls-tests - pass: 996, skip: 154
* ltp-timers-tests - pass: 12, skip: 1

--
Linaro QA (beta)
https://qa-reports.linaro.org
