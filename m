Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4146530-1519429353-2-15471685424892901304
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519429352; b=v+ANeB4Fz9pXuaxdCLGqfIaJNG86ORYPN1Mnn2RnYun30fv
    mRA3NJ5650LeUoNclSDV7hEZ/g0Kd+O+xEsaiHM7lyl37v9nWjpyPRGPBVgMRH3N
    bKrxtXo68YPtcjP6Gk5FWWW9wHkEIy7b9qwpBgY4LfGp+ZCLL8wsp0U8zo6KEtUY
    udt2/AMYrRf0AFB0mPFgymfnR9M8AzltRsKULvRLEOEAs+OKU5HddX3gvgJuPNIE
    TWYGbtVIsCdHIJ8HuEdJryCZ5e78nV8ES5s4DbdQ7L/QTF1wUN/jBbFq0o3/YLf8
    EplAlBgIby/lELe1k3VLqBtGs9HfJxyRrI5Dijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1519429352; bh=svRxSqc
    QLrnsGt/EEdKba8vimBmsweEPDKLMYN8/Un4=; b=mZUkzGj6yVxypTC2vWkEhjM
    3P2T33LNZFHen2NDzTYIudGVCtCNa21uvgGL6A3dxJ4xvMHYxYUa8UzT/rZGecus
    f1hI+qVETzpDHY+YGFyW6HThgfsRUAxMwNfgOtvkGNXM6SNVNGTebZE+i/8J34hs
    ECAEDlvBwtCyyznvJ3+40zA/Gk5Q+PJz51/+Y7Vc6RywXpR6nlr2yAy+gfqeLw0R
    ZL9LFKvkHMpMts0Gli+jMHvrplyjETKFSrRMLgu61v+wSVJD/nEDHYF2SgYTTfX8
    nFysonNsJ4cefXjK7+ZzHJhhej5ziLJF/P/08wvsIuM0WtqsOYzMWryoHp8EcMw=
    =
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Yttap/hy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RGYqploa;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Yttap/hy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RGYqploa;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbeBWXm3 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 18:42:29 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:53826 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752134AbeBWXm2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 18:42:28 -0500
X-Google-Smtp-Source: AG47ELuSl2wchOMaQaShnfSxLqcH/QUWvs0i/7CEgnfIgLpHq6Rebcny0MEFS3l+AvBcCOA8AWpXfQ==
Date: Fri, 23 Feb 2018 17:42:26 -0600
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/193] 4.4.118-stable review
Message-ID: <20180223234226.rsz6snkoihy5hjtb@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180223170325.997716448@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180223170325.997716448@linuxfoundation.org>
User-Agent: NeoMutt/20171215
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 23, 2018 at 07:23:53PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.118 release.
> There are 193 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Feb 25 17:02:20 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.118-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.4.118-rc1
git repo:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.4.y
git commit: 5468668278fb027d3101294c021c57bb000f7962
git describe: v4.4.117-194-g5468668278fb
Test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4.4.117-194-g5468668278fb


No regressions (compared to build v4.4.117-62-g0cf542b26c74)

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

Summary
------------------------------------------------------------------------

kernel: 4.4.118-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git tag: 4.4.118-rc1-hikey-20180223-139
git commit: 8cfc89f9b1c6bd4f522109f2a4f4baf7991070f8
git describe: 4.4.118-rc1-hikey-20180223-139
Test details:
https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4-oe/build/4.4.118-rc1-hikey-20180223-139


No regressions (compared to build 4.4.118-rc1-hikey-20180223-138)

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
