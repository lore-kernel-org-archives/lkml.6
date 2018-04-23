Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1816868-1524520700-2-3696703344138697362
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524520700; b=r7LZ7ldNWQbjQ50UClyFdIvmPbGjUiGIEJAWsACKRg7zGKVAwW
    a7qC8Sj0rBUtXA9NBDUE4TPPrKJIMLevpBoR1Zb5Oja/SXcdpB40oSH9oRkYhiWz
    nfCqlYRRBeUvhz0uHlbGl4JwClOAkKcgthdZJp+ag9/4Od0BYz1F26qMfdEn6q5s
    Z1V8/LBqJfVvioRQgRO59Il6udyPuFftqw11aQoE1cpJWclFIVf3Q4ZQIv6zsNXS
    ap2zlpKtCtWAky2zDFddVTk9yH2C99e8LToh21GvldsMinkeKmIeriz+3xBaxG1B
    fGvVAq/SX/ZdGVIKiHKERhtFmaXT2vfmrhfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524520700; bh=rf0mLltV89GIegDKSx2afxvme/FD61
    AxuC072U4uZA0=; b=F6d5nvDEJxsFz4JG1pHixgEdP35aIcvtnjLxP1vpKTnCRV
    E7bIACsIUyNteVI7MhazwTDsKG+SjewHocK7hPrla85lbSUhZtcakPkBzvWE0RuF
    FKQPbUiduuJRey11FP9MR95s8TC+QHtwl1fCmVzDq5p4VtWarDdXr9HogXb89qmV
    wesMrvK22Y2XKvjHAdxwSG9eP9Qlc25rMD/zfUbS94WnEfkqk9txaGDeMAxXnhh9
    X6c7FyzuMA/KnURDVoMY6R9uUCkHBG+yCDm+M9fCwdC57LHXGOM6cIG/wlrzGATy
    N/Mfgkv+MfNbtWd+/iH4szFsCVcv3caKT8GWncgQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=roeck-us.net header.i=@roeck-us.net header.b=eAwlE2iX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=roeck-us.net header.i=@roeck-us.net header.b=eAwlE2iX x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfD1vs/8n28CBkIVJtgDzKuWKN6tf7iB/Yo+Zlzi5Nj/LrkJ6QGrel/z/+Nsk1X6mQ6U1P+8UUEQ03IhrkvPgeouMNLIGwX21S2poSacvGEezxjgOblbk
    jGqttxMrxh3gmLSstHClvMveW3ityFDK3a+m2nFUn1fJRAj5vx7pTdcJijmYHvntpYAmNStqGWz66w0sLSCqJcbvi4VO3l7jufx9A0knZsgrIwAkpOAuSQZt
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=9+rZDBEiDlHhcck0kWbJtElFXBc=:19
    a=kj9zAlcOel0A:10 a=xRDiy12qv0EA:10 a=Kd1tUaAdevIA:10 a=YWtRXzOXAAAA:8
    a=D8g-P50eFrOuDghlfXQA:9 a=CjuIK1q_8ugA:10 a=XosyFl2cby_8ldcV-F0Q:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932315AbeDWV6Q (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 17:58:16 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:41539 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932291AbeDWV6P (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 17:58:15 -0400
Date: Mon, 23 Apr 2018 14:58:13 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.16 000/196] 4.16.4-stable review
Message-ID: <20180423215813.GA3976@roeck-us.net>
References: <20180422135104.278511750@linuxfoundation.org>
 <20180423165605.GE12958@roeck-us.net>
 <20180423180607.GA27360@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423180607.GA27360@kroah.com>
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

On Mon, Apr 23, 2018 at 08:06:07PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 23, 2018 at 09:56:05AM -0700, Guenter Roeck wrote:
> > On Sun, Apr 22, 2018 at 03:50:20PM +0200, Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 4.16.4 release.
> > > There are 196 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > > 
> > > Responses should be made by Tue Apr 24 13:50:16 UTC 2018.
> > > Anything received after that time might be too late.
> > > 
> > 
> > For v4.16.3-197-g405d1f8:
> > 
> > Build results:
> > 	total: 143 pass: 143 fail: 0
> > Qemu test results:
> > 	total: 139 pass: 139 fail: 0
> > 
> > Details are available at http://kerneltests.org/builders.
> 
> Thanks for testing all of these.  I've pushed out new trees for 4.16.y,
> 4.14.y, and 4.9.y so I'll watch your builders to make sure all is good
> with them.
> 
Still no failures after rebuilding all three releases.

Guenter
