Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1953286-1518200453-2-1901411949550135630
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518200451; b=NqWdNuVJ7tUcwg30wpgh6PgHCQ2dZ7HrekT5eFAbFsAdFh9
    VoGTNoCdz43tkMF6PQ4KuMtcJZKjqiU4T7uiUSdf4oUlRb4WkJmk2lmhNms1eVmQ
    xRbNtGllsFUHSait32wP8Q+lPOgx4VUlqlmCZOfCH/FaLHo5Jcc6Swd0DSJqCa2D
    HQyVBBRezNZ3fYsS9Q+I1oggFKE7pvTCxkpxD5FRO9tbX9iNRWGfhmJsJ/7ch15G
    vZ1LIJjnIb+H+i1FBB6zRg2PRQB51TGjpwBgMKKnfpPXN4it8a+o7t2MrF042b/N
    +f2K0XqXB/RBnO9ZUA4eJdJ7quJLPriYzkxw8cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1518200451; bh=b9rYOmMoMdQaVQJDGcHPVNC5pfJMvEX35y+frvA1w5E=; b=O
    w/TOieczRZBmbo1SzFo9/G2qlV5JWVZdEZrLpBxwQDGl81BOSyUimuRy9xMncxUH
    BqSra0cnJgw3V8BIsG93tPQj9bwgnSTp7bM0T8J03hVTDyV4hxS3ApRuLFSF/dv1
    g6PPe0BeI/OTLwmsPw2UJF0XU3kvJdoroJFe4xvk+CDQtJtIf7GFYGaUsyt0dkYK
    G9exnSq5Qnbx7Noc8Vjym5Mlma5mwxn9e8TgkZOtmmrAOJ6icYQoQ1ufl5Huq8xb
    WRcicB3YHiajXvYlDbWrfH4UDhy2TpV2MXJT3nflFBtVR7tL5uNfpZxFXXcuD2B6
    ozSSQb46+kVX+mTOMQxEw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=UKJWKrg9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=UKJWKrg9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=UKJWKrg9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dkim=pass (1024-bit rsa key sha256) header.d=codeaurora.org header.i=@codeaurora.org header.b=UKJWKrg9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=codeaurora.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codeaurora.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751151AbeBISUt (ORCPT <rfc822;greg@kroah.com>);
        Fri, 9 Feb 2018 13:20:49 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:37558 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbeBISUt (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 9 Feb 2018 13:20:49 -0500
X-Remote-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Remote-Spam-Level: 
X-Remote-Spam-Status: No, score=-2.8 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,T_DKIM_INVALID autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 51A5760117
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=timur@codeaurora.org
Subject: Re: [PATCH 4.14 00/22] 4.14.19-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        akpm@linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180209133934.024795822@linuxfoundation.org>
 <CAOZdJXUqWbNT9uQfcVtau=FTzp61m6xiLpwwDF-8e=5bF2vonw@mail.gmail.com>
 <20180209181813.GA16911@kroah.com>
From: Timur Tabi <timur@codeaurora.org>
Message-ID: <91adffbd-09da-9624-8f6b-9e79e8f2172a@codeaurora.org>
Date: Fri, 9 Feb 2018 12:20:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180209181813.GA16911@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/09/2018 12:18 PM, Greg Kroah-Hartman wrote:
> Oops, yeah, I'll pick them up for the next release, sorry.  Was
> traveling all this week and with the middle of the merge window, finding
> all of the stable patches that can be applied right now was hard.  After
> 4.16-rc1 is out, it will get easier.

No problem.  I just want to make sure they weren't completely forgotten.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
