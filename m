Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2341832-1527186385-2-7919070944597863685
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
    1527186384; b=MHOEzeCFEcaVaP3bMMRgir++7KUNr0drl2PCedOlsX9A93amut
    bCiYybJtqoQIM7rFxKTUSJTru8UdsrQ8Y5xRaBey0LUagL8r7qM4qjbT0uiVy7ID
    EYPb99gZXicwHzM0tmFvSO321+WmoWaBg0Tr+RTmBqDVenRaxtNNwt9WXhL+QRAD
    uoC9cADL+36ZMeVtH6VCfuM+EKYSc16CotV2Pr/jqn4tmA1q38i8oVzXaDALHh/8
    v11S9w8EwbzvuohDUf0qLcVO4PQiVmBnwBUDejBig8xziy6j5RZXLDHy/7McZL1i
    JN3YR/HSLtzR/lOYPuMzLI/XBTR5pmWUfXXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1527186384; bh=cf5k9Urmww1
    1ZYZCtbEkmqlu0lCg+ppNwo2TvEz1BUE=; b=HdFF18wzkde0SCVZnh4lQkFgVG5
    PIxmMNpgfQAmVmPmAhdYf20ncBk32gVTBDLhcBRxwsB4ZzsNgeQlxCut5nwAYvr+
    x2t0vwozDRmajWO/znMCkGLAS+zIjrZP4v0g6n+165XDCJYcOk4iwoEAU7BwHhxN
    fX4Ofpvh9gRVWsiUdkSRSK0emg/a3//7c1OWcMMb/WrR/uv9mfIINZwqVdjgAZmk
    HO1idjzO7TCt2j2ewly26pFru9vCusFX2YDL1T0B2dMXNnXUWspiprE7Mck3qPz4
    3b6/ecPmDhWZn02h5Rt22K2fK7liqnJelqy7lP5vq6VX8MbOrn0Ci7F1ZLw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
    header.i=@linaro.org header.b=Mj/YHN4J x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=hq0z2bZk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org
      header.i=@linaro.org header.b=Mj/YHN4J x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=hq0z2bZk;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFTbmGjUwL4bEGsBXOLeDUZyqqWvQA4fLBsNzfZZVFY1e/qacKB1ng2tmdES4K+JiQdFGgYY8gk/npd7TBL777yEoIyBDDAyW+kLI6wNtQ0HO+/3pXM8
    G9SKH+z0iF9uuIGWLPqdH7ljLL8okQZi79DzsO4gw+p9y3QD3/I4k9yTiQD0MsL6f5FuSCu7+X88flI1GIGeOLEDVe65r9YLKFysw5getIMjzTduFTbDp2rs
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=KzI24OduxaQA:10
    a=VUJBJC2UJ8kA:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
    a=65_gGtAMOFPBDM89JUAA:9 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031077AbeEXS0W (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 14:26:22 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38000 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030479AbeEXS0V (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 May 2018 14:26:21 -0400
X-Google-Smtp-Source: ADUXVKILVS3SIXtEwGdA1TwNykM0CsaynYtET0zBp0PPDsxAEzMcOaDbwUcz08qCTt7HiC6f/VO1+w==
Date: Thu, 24 May 2018 13:26:19 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
Subject: Re: [PATCH 4.16 000/161] 4.16.12-stable review
Message-ID: <20180524182619.aggbumplo6kaoouu@xps>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org,
        linux@roeck-us.net
References: <20180524093018.331893860@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
User-Agent: NeoMutt/20180512
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 24, 2018 at 11:37:05AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.16.12 release.
> There are 161 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat May 26 09:29:22 UTC 2018.
> Anything received after that time might be too late.

Results from Linaro’s test farm.
No regressions detected.

The times03 regression noted below failed while running on a shared host
under emulation (QEMU). This is a false failure, which has been fixed in
the most recent version of LTP already (see
https://github.com/linux-test-project/ltp/commit/ed01f6a05c77f65cb5d1089474c9a0e2129c581a).

Summary
------------------------------------------------------------------------

kernel: 4.16.12-rc1
git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
git branch: linux-4.16.y
git commit: ec693ff0154a1ad11520223f3c1d2eb5b13cabf1
git describe: v4.16.11-162-gec693ff0154a
Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.16-oe/build/v4.16.11-162-gec693ff0154a

Regressions (compared to build v4.16.11)
------------------------------------------------------------------------

qemu_arm:
  ltp-syscalls-tests:
    * times03

    * test src: git://github.com/linux-test-project/ltp.git


Ran 11196 total tests in the following environments and test suites.

Environments
--------------
- dragonboard-410c - arm64
- hi6220-hikey - arm64
- juno-r2 - arm64
- qemu_arm
- qemu_arm64
- qemu_x86_64
- x15 - arm
- x86_64

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
* kselftest-vsyscall-mode-native
* kselftest-vsyscall-mode-none

-- 
Linaro LKFT
https://lkft.linaro.org
