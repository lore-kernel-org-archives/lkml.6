Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3270031-1525805301-2-5894874560267268421
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
    1525805301; b=m21/mNIQkZuAAlnEHyRSp7Y+eksivsNU6uHx7TL5qHXlaBBwIE
    9gPVz2RTjuKHuFwxLV4dc0LgR36FZdbAZOYrZNBezKyiKgLGDOeLUkba/kqyWkPb
    UHsrlCNiZZ+3MhPBlltJXvzJ/GWf7CuoluJpuAoQSjqPL0Keypgvms8omvFmLacG
    9rm1r5ffNpd9fZLJgC/uVLQsfXr4d8F4nvU4j8CoV9OLm6NQxQGD9KLOQLc87VE3
    VFKwntDJmHuzwu0WocLFgGj36GeGVi1rgrzoHW3FKa9agK1/tAxAiVRi/kuc4GpZ
    f1lf91u9mGHaydXJsS415ONmmjlqQihB3kYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1525805301; bh=4ul1ccE9V3J
    O7nVL8LTS9sugp2m2a0HL+m1OFJK0HUI=; b=KB1vwNjpkv2I8/NutIxFUNRQD2u
    vBoPltOqR7x2uTbG0ya+pmCsHEww68SHPPt0X7GvkzXcC1p8dL9nxz6CZ9YN/hlp
    M/N2ljmNc2bFqe3E11P5TULR2bfMdxQZtfOmJcdiqsrMmv0obPbql2VEnZRGmiRX
    /8Cxdh8kfmIr/KCf0UMwHbud8pc9STvOhVXQfSfJ6EXSt4YnKpOxJ4N8wC7HN/2d
    tHuoO8d7/L4nWGoxS46vyG3++FqCd4itsGm/4kdH7bgaYhSiSXTt/YWacR4oLXQi
    h5erKUwVfZEd3XYlfALFSRR+/rXCsvropCuFnYdTOSd5A57MWPUZI1g7bYg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=HO/VdjDD x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=HO/VdjDD x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDTh7YCOfzmllfpotLY2M1PZ84gdGBx/RF4qjQyefwp+hDodjtpo47YqyaFW37xYDhHelzT6ao+NPlassql1a5xKzjLc/6K+z8mySrKVT2G/hVCENLVU
    DgJiStGk3EmNzRuCt6X/6H2QoeMUEoPiS1fjcUIQZVeMTCXSto87YKYihYvYX9ff2fuW2ZcIIT3c4p7TRpnizktB1X1GkeYs3OTLYR8G1HYA7BR/W0O7uMJE
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=0JwXymvhWcgA:10
    a=VUJBJC2UJ8kA:10 a=ag1SF4gXAAAA:8 a=VwQbUJbxAAAA:8 a=UhOjoZm1NaWo7w_ywRQA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755402AbeEHSsT (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 14:48:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:51868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755181AbeEHSsS (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 8 May 2018 14:48:18 -0400
Date: Tue, 8 May 2018 20:48:03 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4.16 00/52] 4.16.8-stable review
Message-ID: <20180508184803.GA13126@kroah.com>
References: <20180508073928.058320984@linuxfoundation.org>
 <CA+G9fYt9Zsa6jEW_s1ud-vxJFZrG_YgEbqazUWkaHgj6vvTLTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYt9Zsa6jEW_s1ud-vxJFZrG_YgEbqazUWkaHgj6vvTLTw@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 08, 2018 at 11:26:41PM +0530, Naresh Kamboju wrote:
> On 8 May 2018 at 13:39, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > This is the start of the stable review cycle for the 4.16.8 release.
> > There are 52 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu May 10 07:38:51 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.8-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.

Thanks for testing all three of these and letting me know.

greg k-h
