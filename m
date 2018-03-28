Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2629663-1522251772-2-14642094653427988956
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522251770; b=vGWgQp5GUeWZs+ay8MqNWX8whbhCH5clTmHfEa3zKROz0jW
    jLltK643ATBCcsYAjcYGK/CNWPT91XWt7ZyVU+IldkJSOgxILLeUGjyBFXWaoIhN
    MNMLkf251pXq8T/nxbhUhf+gCJu8ZkEgWgm0wj86y1hNUrB8Qqn9u3BbIlqc3VWL
    SyAPQd4KlJ0vTeFmxdfQUYHHpo554+WkgsetVghDALxdCIkHWbUill3raTCAEfHi
    7QTNqQBZnPv1cwBKSAUh29lGEBfgvmp9VT6z4oRZAYds5nFBANovgNhljOxZNjzV
    F9YogA1xXr/7aAatrgm+EiJcfq1MbgP5a8PBRxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1522251770; bh=bHIUp4a
    YnFrtm2qVZrVqnkNTko3E7FFBCid26j97tVs=; b=GaURnHNEU5ZYnEeYg4zqeAd
    6g9X8cdOnQ2nIEaVjESxnnNZ3225mREykag9fpC7/vE+aGwJrVkChiP5mEDlV7Dy
    7VxRlxVbzyAuF07ICe6fSdwP9xwcsWULDPcBFQbjh7hldM+lA4JNSVqdEPH406sM
    v30m7a8mCl2ewHE0rRAnQBJUWXSuhHHxX0mhKHV8hPv1K0+l7M9xnfuKiHi9F+YS
    IA8oV9IfR8MVfHIZ36SsDDc3/H5WlkUB0Ur6nDfC3J4XYBuBvajWHrCOL6P4DlQO
    ZnV4s86kIhA6MQYCLOAjEe8yaldg+YLh7Jq3qqO6kLPuv1s0vfaB72Wsqgv4P5Q=
    =
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Yk9pGBqL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pS9qwQ50;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Yk9pGBqL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=pS9qwQ50;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJcWj/WnNZGCqoCwk/TTjBsuwHXOY3HFubXhjpHE0ydVhUs2Y2nNgPYQ0kFZfoC+rooNmO+KRBNChq9qhVVo4Rgj9n+d7tNPTx0Dhjjzd+b1t8p8eO62
    w+2dTD6cP4qkJU215UyBNlaHjn7ZI90leJ7TAu6q+zWSbEAbHhV6m3nQEqW7xn/2NBXy7EhnmeVoK4iZKAK+SAx4yVrfP9wCBQXNXPKcgcqquDK+IjQLYgsm
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=y98JahJlUwsA:10
    a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=l2Zvf5chwQsW3-vawu4A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753838AbeC1Pmt (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 11:42:49 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55666 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753924AbeC1Pms (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 11:42:48 -0400
X-Google-Smtp-Source: AIpwx49vcD9cHtxzJosVUj9XwMLjuuelJLqPtIy+V7jgTSLvnCTgJBxhuNcLYeJVRW157Y7L5S1SLw==
Date: Wed, 28 Mar 2018 10:42:46 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/43] 4.4.125-stable review
Message-ID: <20180328154246.xeo6m4galue2qsa5@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180327162716.407986916@linuxfoundation.org>
 <20180328095847.GA29144@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180328095847.GA29144@kroah.com>
User-Agent: NeoMutt/20180223
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 11:58:47AM +0200, Greg Kroah-Hartman wrote:
> On Tue, Mar 27, 2018 at 06:27:04PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.125 release.
> > There are 43 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Thu Mar 29 16:27:00 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.125-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> > and the diffstat can be found below.
> 
> -rc2 is out to fix an arm64 build breakage:
>  	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.125-rc2.gz

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.4.125-rc2
git repo:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.4.y
git commit: 6d103166a63a0a6f0eb313f608b08c52beb14a11
git describe: v4.4.124-44-g6d103166a63a
Test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4.4.124-44-g6d103166a63a


No regressions (compared to build v4.4.124-44-g9d0ab5d17182)

Boards, architectures and test suites:
-------------------------------------

juno-r2 - arm64
* boot - pass: 20
* kselftest - skip: 29, pass: 34
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 53, pass: 28
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 2, pass: 61
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
* ltp-timers-tests - skip: 1, pass: 12

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
* ltp-syscalls-tests - skip: 149, pass: 1001
* ltp-timers-tests - skip: 1, pass: 12

x15 - arm
* boot - pass: 20
* kselftest - skip: 29, pass: 33
* libhugetlbfs - skip: 1, pass: 87
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 2, pass: 61
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
* ltp-syscalls-tests - skip: 98, pass: 1052
* ltp-timers-tests - skip: 1, pass: 12

x86_64
* boot - pass: 22
* kselftest - skip: 31, fail: 1, pass: 48
* kselftest-vsyscall-mode-native - skip: 31, fail: 1, pass: 48
* kselftest-vsyscall-mode-none - skip: 31, fail: 2, pass: 47
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 17, pass: 64
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 1, pass: 62
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
* ltp-syscalls-tests - skip: 120, pass: 1030
* ltp-timers-tests - skip: 1, pass: 12

Summary
------------------------------------------------------------------------

kernel: 4.4.125-rc2
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git tag: 4.4.125-rc2-hikey-20180328-160
git commit: 127b04544014992026cee300d0c88a8eaf834b52
git describe: 4.4.125-rc2-hikey-20180328-160
Test details:
https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4-oe/build/4.4.125-rc2-hikey-20180328-160


No regressions (compared to build 4.4.124-rc1-hikey-20180323-157)

Boards, architectures and test suites:
-------------------------------------

hi6220-hikey - arm64
* boot - pass: 20
* kselftest - skip: 32, pass: 30
* libhugetlbfs - skip: 1, pass: 90
* ltp-cap_bounds-tests - pass: 2
* ltp-containers-tests - skip: 53, pass: 28
* ltp-fcntl-locktests-tests - pass: 2
* ltp-filecaps-tests - pass: 2
* ltp-fs-tests - skip: 2, pass: 61
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
* ltp-syscalls-tests - skip: 154, pass: 996
* ltp-timers-tests - skip: 1, pass: 12


--
Linaro QA (beta)
https://qa-reports.linaro.org
