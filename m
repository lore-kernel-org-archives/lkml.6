Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2363342-1527185867-2-13847361297454962363
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527185866; b=nHVGUQSaGYQ1eS0ayQ4PtHgJ8P9g4zZLr/5WX2vkI4ZVhCUmd/
    /KP1senbZ9+FRXBnjUJ58ukYm60GBAG8UUyM8WTrtuUfaPB6fyZO5NNdbpq3S27S
    xBtaN/7lpHUmI1SL3jbSVStxbov4MZQAw06siol0hn4qSsIMa9gdDs6YXnmD27bv
    tmXzHSIN4u5eK4pKsE7j/ifs1w1xqEBTfOQkq80Xi6f2GU4fC6yC5udBd+aHVSlQ
    KBnyevOasVHdeWwkJzfgM4gq7ewqo7mOiN6rOk8MpjCdsOZR6shADOqCauTdaUMF
    jzW0v4FTrVgqEbjvD91EcM3bKGGoJUGgKl1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1527185866; bh=sfNQTG7KmMd
    i7mI1gmsZC19jcOoPsVDyg7YrvarniZQ=; b=XoHSb8SkGYiPTMYSeA1CiSHtmnc
    yZ6kXuhLY0PCdlaHniP4sSan/9hVWxXrHNrIbjQJUihrSag4gpTIyYxMV5aP/VKq
    Pcys3Ze+KOOm/GCEd4NbCXWKgk4CQpJO7nqJiZeKtcjguvy7M0r+2dRiNTDJOqeN
    AaLEo5jiSv2wUo6tcjt6EpYVQTWUw4QNjGXJ4fd9LLeouVl+GW5Cvx2aU0QEHKy1
    1NwDD8vokXLuwhHTxQcZHKYBdeVH9kpkxTRCs8T0Zg00z6+fu4kynf4DqsM++8ci
    bqfnAXMlClXpnsMl5FkoeYqmhTKlZBlQ8F8v9Occ1RRmQD9VGOHhMUYKqpQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=roeck-us.net header.i=@roeck-us.net header.b=aWwjQ1iZ
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=roeck-us.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=roeck-us.net header.i=@roeck-us.net header.b=aWwjQ1iZ
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=roeck-us.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDf824iaV3AARvFD83zexkkJOTC6m+UZptUDLT54xsxqSBvrvviFVTP6xM2P+XkrJqmAfSlHnrBdLMrqSxZtSYQbHKn1QTgY01luju8a+spQUdmuLmEc
    qT4OIPE9Bd9mqX3WfgUttbabyXg8h7t2D02TPDCYXWtrrEYOtGrGNxn1poHv97ROv3Dw2o+faAXQbs9EUYFatc0vNRzDxwwh5Cr1P1euNwczyCoSCb1njewi
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19
    a=IkcTkHD0fZMA:10 a=zhKW8NK6TxkA:10 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=KKAkSRfTAAAA:8 a=hoNvzSjMHB4-H4mimd4A:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030599AbeEXSRm (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 14:17:42 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:35997 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030513AbeEXSRl (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 24 May 2018 14:17:41 -0400
Date: Thu, 24 May 2018 11:17:39 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org,
        ben.hutchings@codethink.co.uk, stable@vger.kernel.org,
        akpm@linux-foundation.org, torvalds@linux-foundation.org
Subject: Re: [PATCH 4.4 00/92] 4.4.133-stable review
Message-ID: <20180524181739.GB13327@roeck-us.net>
References: <20180524093159.286472249@linuxfoundation.org>
 <20180524180652.7bqyquqfe2nqdxfg@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180524180652.7bqyquqfe2nqdxfg@xps>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 24, 2018 at 01:06:52PM -0500, Dan Rue wrote:
> On Thu, May 24, 2018 at 11:37:37AM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.133 release.
> > There are 92 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sat May 26 09:31:28 UTC 2018.
> > Anything received after that time might be too late.
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.
> 
> Summary
> ------------------------------------------------------------------------
> 
> kernel: 4.4.133-rc1
> git repo: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> git branch: linux-4.4.y
> git commit: 915a3d7cdea9daa9e9fb6b855f10c1312e6910c4
> git describe: v4.4.132-93-g915a3d7cdea9
> Test details: https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/build/v4.4.132-93-g915a3d7cdea9
> 
> 
> No regressions (compared to build v4.4.132-71-g180635995c36)
> 

Shouldn't this compare against v4.4.132 ?

I looked into kselftest/rtnetlink.sh test results.
The test history is a bit confusing.

- v4.4.131-57-ge33795f7a573 and earlier passed
- v4.4.132 failed 
- v4.4.132-30-ga102378c6551 passed
...
- v4.4.132-70-gaa7ab28e9c5e passed
- v4.4.132-71-g180635995c36 and later failed

Does that mean that this specific test is unreliable ?

Thanks,
Guenter

> 
> Ran 6863 total tests in the following environments and test suites.
> 
> Environments
> --------------
> - juno-r2 - arm64
> - qemu_arm
> - qemu_x86_64
> - x15 - arm
> - x86_64
> 
> Test Suites
> -----------
> * boot
> * kselftest
> * ltp-cap_bounds-tests
> * ltp-containers-tests
> * ltp-fcntl-locktests-tests
> * ltp-filecaps-tests
> * ltp-fs-tests
> * ltp-fs_bind-tests
> * ltp-fs_perms_simple-tests
> * ltp-fsx-tests
> * ltp-hugetlb-tests
> * ltp-io-tests
> * ltp-ipc-tests
> * ltp-math-tests
> * ltp-nptl-tests
> * ltp-pty-tests
> * ltp-sched-tests
> * ltp-securebits-tests
> * ltp-syscalls-tests
> * ltp-timers-tests
> * libhugetlbfs
> * kselftest-vsyscall-mode-native
> * kselftest-vsyscall-mode-none
> 
> Summary
> ------------------------------------------------------------------------
> 
> kernel: 4.4.133-rc1
> git repo: https://git.linaro.org/lkft/arm64-stable-rc.git
> git branch: 4.4.133-rc1-hikey-20180524-200
> git commit: 9a1fc06621f38daaaa47feeaa1eeaf38db532433
> git describe: 4.4.133-rc1-hikey-20180524-200
> Test details: https://qa-reports.linaro.org/lkft/linaro-hikey-stable-rc-4.4-oe/build/4.4.133-rc1-hikey-20180524-200
> 
> 
> No regressions (compared to build 4.4.133-rc1-hikey-20180521-198)
> 
> 
> Ran 2610 total tests in the following environments and test suites.
> 
> Environments
> --------------
> - hi6220-hikey - arm64
> - qemu_arm64
> 
> Test Suites
> -----------
> * boot
> * kselftest
> * libhugetlbfs
> * ltp-cap_bounds-tests
> * ltp-containers-tests
> * ltp-fcntl-locktests-tests
> * ltp-filecaps-tests
> * ltp-fs-tests
> * ltp-fs_bind-tests
> * ltp-fs_perms_simple-tests
> * ltp-fsx-tests
> * ltp-hugetlb-tests
> * ltp-io-tests
> * ltp-ipc-tests
> * ltp-math-tests
> * ltp-nptl-tests
> * ltp-pty-tests
> * ltp-sched-tests
> * ltp-securebits-tests
> * ltp-syscalls-tests
> * ltp-timers-tests
> 
> -- 
> Linaro LKFT
> https://lkft.linaro.org
