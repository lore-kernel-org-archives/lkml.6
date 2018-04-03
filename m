Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1580296-1522762179-2-13586843795261016967
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522762178; b=o5tllX9Fw4gBkoaoaON80Y+qiIPsrKcOoACeBTsyec3lvpX5ea
    zOLeR3yRk8osaHSiZ7t3eZxwowoeDnABZS19QVIhM62xUzmjS1uIkETFoeeY38VX
    X/Hykbc7KLP5bc4UhdetZCLv8cjHvKctOW0aC1MklPwL4Sp2ZL2/DR6nyDVXHvI+
    YWUssiBQoBHHwvvUw69qKmrRieHxxinPxlPE6sBz2guYtncaCmcewPTcM5diPKHE
    CujFQgL/rS+gtDhZLcwDkhc2sHV3hBSL7XgmW4bMfsflNScCh3vdtRwghGhnPa/I
    eSQNz8fjgSFeSZ5Eqxw6L4R9YpW6rymDvr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522762178; bh=UO0tKVXQnBAPV5hL8Nb9hkyd7ZT6c8
    9R0CV9h8Y+6l8=; b=H76L+WdfmyL2ywUYxyGoYSPk6aPgLlCLwi8iClXrF7px1v
    gcVzqH9J6gkCIlwl9IctOGppXzKQw1jjPpo+ft448JCHoy9OgzLPvDkIe3Ltn3gg
    rKVpfdR066rGqx5PzKnRA9BpiXrIhR3SWP7xjwB9jSpciQNarAuwXXPv3ZsdbYSL
    iuB8UKa5J99SvUEI5dxtS8Luq/R3rnijBM3VqlFwqoiras0SSrawOEPjMUgGLVvj
    sfpBKEIxbEIQUWnC81TtrnVtYDKaBom2VmpIn+tfwXin6Y9vgw5Yc6FLbOANS+7d
    weFGydOypyG1LzecN0W+ktmo658Mn2XVAoKf6/Rg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA91dnboc1oMsprcwqH3nm64RSxXOkrMeZe0dEZhmVPS6j1o1+laOHHnIz68U4WDVzz7RaXL0NND6fRXFgNtsGTGaAQ1D5kxNFk0BH92a6ppexI1GnTK
    F2vEcDMW2T+ipNSpvRDB8l4BYSm5OhCA7fGTDOiKLLWlxNMZCDfLUz9cjLA7IYQCBHoGSHtRR6Vv515QQdkoMyqMzqs3B/JXQ8dRKuL71j/7MzbPAmdafZV9
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=dZbOZ2KzAAAA:8 a=VwQbUJbxAAAA:8 a=9tZgyAcxUCubLt1n0p4A:9
    a=he3mSybw-m6AKCJ5:21 a=7Sbu8VEL8CugXy9H:21 a=CjuIK1q_8ugA:10
    a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=pRQRx_yQ9a0A:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750722AbeDCN3g (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 09:29:36 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38814 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750714AbeDCN3g (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Apr 2018 09:29:36 -0400
Date: Tue, 3 Apr 2018 15:29:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Xidong Wang <wangxidong_97@163.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Xidong Wang <2711406067@qq.com>
Subject: Re: [PATCH 1/1] taging: fbtft: fix memory leak
Message-ID: <20180403132934.GA1728@kroah.com>
References: <1522761268-7176-1-git-send-email-wangxidong_97@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522761268-7176-1-git-send-email-wangxidong_97@163.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 09:14:28PM +0800, Xidong Wang wrote:
> From: Xidong Wang <2711406067@qq.com>
> 
> In function fbtft_framebuffer_alloc(), the memory allocated by
> framebuffer_alloc() is not released on the error path that txbuflen > 0
> and txbuf, which holds the return value of devm_kzalloc(), is NULL.
> This will result in a memory leak bug.
> 
> Signed-off-by: Xidong Wang <2711406067@qq.com>
> ---
>  drivers/staging/fbtft/fbtft-core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
