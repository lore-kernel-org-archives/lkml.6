Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2341832-1527185217-2-2654709927842274104
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527185217; b=KMQojxHqhR0CeHDHaPO1HeRt1ws0UzKWbEjQ/8C9jMmO5inPHK
    ANAgtdxgMP0S6Lv7aJHkYAmrTdCF9hto/YEkDYFAqC4ZaYDdNYKlsf3ydzEBqHzL
    1jlX6doL4ySKo1jqdauuaFJvrUklQsMKbUSClDrJC2Wha4sGPFP1qxGFfXWdmUBd
    Gg5KTKLro3fFR4UsjZmEQHd0gUm5cCPQaxCnbQBBsgn3Qde/1a4d8SeY9iPS4Qwq
    JygVcbZS1jI5pcH+mlecsF2XvTvi83gHsqICa0a6yG8NodG9AoIxAla6eszaRM5m
    x1CER1NBegTcl62GbM77sLThH6I2e2aD8rGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1527185217; bh=AkzLdr/Pq2h
    u+0N7EPYACB2yuOtqvZk0jW18zivtGIw=; b=HoBO88uu8i7LfkaQSfH9iQxp0Mu
    aVi6VQX6Bq0SIjo7MhCN6MCrSY7LEKf/Tu6tGzvFazfUn1p8RxQWVgQSQGksb+0/
    UxDplvdwawi1Vlu17BhyR9CgMiNOj+Es7inpSusfQFP2gkcWPGxeWy3G4yLDLk62
    0BY9KgJ8MHlVML3xQ69NrfPV6Q1cQkgoQDUXV1Tp0Nwmgrl0x3p+Ts36fgPi0VX/
    wZU1JgqtzCtY/DZamIswm7J65HDP79nNYUU6otIfnm0K9pNxWxYIpECLCf6SGJfn
    EfzUegApdNkhRkzpdHsvh8iU7JzCUUpg148wVaeuWqDfaJEl6fVnUSnJ0rA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
    header.i=@linaro.org header.b=DMBlfWrB x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=c41StRAD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
      header.i=@linaro.org header.b=DMBlfWrB x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=c41StRAD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFdhbjHwcZG1mxHMgYqKJElmepwK7mU42Hl/+gPYwe8zkOviLvN4awlrB7wISNZZEkvc0+MFD+iOYH10Rea1K1jcJ7Df93STijMiKr06+n2TSl8ppQkD
    20aNa/YzxZsC+QOy/wDwuRekzQlmI9odH9BFl3pdDMju3ZMtryJQIxti1L6B8CmXfcxdLg6I2vz/xEhWzPsNs4j00kU5Es9Op8pHzemnD4c9lffo6XK34pYj
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=zhKW8NK6TxkA:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=cJEqwrfhkixccfMa34YA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968632AbeEXSG4 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 14:06:56 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45799 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968594AbeEXSGy (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 May 2018 14:06:54 -0400
X-Google-Smtp-Source: ADUXVKJG5Kwwi1q8v6doe9hXwsvM/cA94aXRU/IOs/XUR+aRE7HAbUOzXKShx9HexDXxPooRx6AU+w==
Date: Thu, 24 May 2018 13:06:52 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.4 00/92] 4.4.133-stable review
Message-ID: <20180524180652.7bqyquqfe2nqdxfg@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20180524093159.286472249@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
User-Agent: NeoMutt/20180512
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 24, 2018 at 11:37:37AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.133 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat May 26 09:31:28 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions on arm64, arm and x86_64.

Summary
------------------------------------------------------------------------

kernel: 4.4.133-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.4.y
git commit: 915a3d7cdea9daa9e9fb6b855f10c1312e6910c4
git describe: v4.4.132-93-g915a3d7cdea9
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4.4.132-93-g915a3d7cdea9


No regressions (compared to build v4.4.132-71-g180635995c36)


Ran 6863 total tests in the following environments and test suites.

Environments
--------------
- juno-r2 - arm64
- qemu_arm
- qemu_x86_64
- x15 - arm
- x86_64

Test Suites
-----------
* boot
* kselftest
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests
* libhugetlbfs
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

Summary
------------------------------------------------------------------------

kernel: 4.4.133-rc1
git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
git branch: 4.4.133-rc1-hikey-20180524-200
git commit: 9a1fc06621f38daaaa47feeaa1eeaf38db532433
git describe: 4.4.133-rc1-hikey-20180524-200
Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4-oe/build/4.4.133-rc1-hikey-20180524-200


No regressions (compared to build 4.4.133-rc1-hikey-20180521-198)


Ran 2610 total tests in the following environments and test suites.

Environments
--------------
- hi6220-hikey - arm64
- qemu_arm64

Test Suites
-----------
* boot
* kselftest
* libhugetlbfs
* ltp-cap_bounds-tests
* ltp-containers-tests
* ltp-fcntl-locktests-tests
* ltp-filecaps-tests
* ltp-fs-tests
* ltp-fs_bind-tests
* ltp-fs_perms_simple-tests
* ltp-fsx-tests
* ltp-hugetlb-tests
* ltp-io-tests
* ltp-ipc-tests
* ltp-math-tests
* ltp-nptl-tests
* ltp-pty-tests
* ltp-sched-tests
* ltp-securebits-tests
* ltp-syscalls-tests
* ltp-timers-tests

-- 
Linaro LKFT
https://lkft.linaro.org
