Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2938067-1520543743-2-7460533783107196920
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520543743; b=eHcB6uoa9NB9tJ1HisZ8OvfFZh/MjB8SqYxfpV3CKGshZom
    b7Lj8c8UgNI7KPMfz6pZCAbpdmQALlv+jMoOZ2dtuHsv/YV7k1QQxtmmgJlQD74y
    vYGsN7kEOsMP0bMHBktkRZZ11a0hmXf+q5TjVGGxY+X/uOQkuShJQJhke2Puzkjb
    InOC7jPtq8zj0ZC9UQk4UYwHom2RTt9CWq27v/4SABxIUhE16wZMe70AomBjpK97
    CC5TMF8JHhouFhpaPuZt9nazNf3QpUixcLLUCRcnhY2sznwQtQi1ocpPCmA5wROz
    gT0oAcpGuyjZB+vVl0QzzCenAGnWqX57yrPPJMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520543743; bh=kohNA+xYSVu0halToK6QRL48G/
    EGumHBuLlVKTsV7tM=; b=nLY7tcrJGCNOCsXFvmYUk2OcBCD32IlMYu0neV8/Bm
    1VIVvb8kdTchAM3yePP5Yeen5lLDWLT6q7pHrTWGK5xJd9JzbK21e40AzZlJ0kE0
    cnD+M6k07DW9T+B/WHHBKuTePl37huC1F2l4paU2vZC2aBduLRfj4jlZoeg5l54W
    0FMUBLI/EERxI90OnD2sjyPv5NXIAoL3C/hnocW/Hd0EipEJFP7wkQyfJjf7E1zo
    HPi9w074zQVsQEO2mLC27/BRGuDe0wT47u7VD5XJ2k6F1CVQPCvozhkw9k1cnKw8
    gA8yusaaK/HVFoNJoJ/Rt2dai7GRGwIpievXPxE37bRw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=n7J1phn7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=n7J1phn7 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750926AbeCHVP3 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 16:15:29 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:55995 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbeCHVP2 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 8 Mar 2018 16:15:28 -0500
Date: Thu, 8 Mar 2018 15:15:25 -0600
From: Bin Liu <b-liu@ti.com>
To: Merlijn Wajer <merlijn@wizzup.org>
CC: <ivo.g.dimitrov.75@gmail.com>, <linux-omap@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: musb: Fix external abort in musb_remove
Message-ID: <20180308211525.GJ14921@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Merlijn Wajer <merlijn@wizzup.org>, ivo.g.dimitrov.75@gmail.com,
        linux-omap@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180308204049.29474-1-merlijn@wizzup.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180308204049.29474-1-merlijn@wizzup.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

please add patch version numbers in the subject when necessary. This
helps cross-referencing.

On Thu, Mar 08, 2018 at 09:40:47PM +0100, Merlijn Wajer wrote:
> This fixes an oops on unbind / module unload.
> 
> musb_remove function now calls musb_platform_exit before disabling
> runtime pm.
> 
> Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
> ---
>  drivers/usb/musb/musb_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index e2e95071328a..cf90d34f7199 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -2472,13 +2472,14 @@ static int musb_remove(struct platform_device *pdev)
>  	musb_platform_disable(musb);
>  	spin_lock_irqsave(&musb->lock, flags);
>  	musb_disable_interrupts(musb);
> -	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
>  	spin_unlock_irqrestore(&musb->lock, flags);
>  
> +	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);

Does it solve the issue if not moving this line? I'd like to have
minimum change if possible.

> +	musb_platform_exit(musb);
> +
>  	pm_runtime_dont_use_autosuspend(musb->controller);
>  	pm_runtime_put_sync(musb->controller);
>  	pm_runtime_disable(musb->controller);
> -	musb_platform_exit(musb);
>  	musb_phy_callback = NULL;
>  	if (musb->dma_controller)
>  		musb_dma_controller_destroy(musb->dma_controller);

Regards,
-Bin.

