Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2341777-1520527611-2-8212801789920864500
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
    t=1520527611; b=CeWBLlYN9hbLDTs1qocDVtBSFJdclMBTC3Yh/wJzuMaQCBw
    En0vCEyFYRza3m7VKRC3INVNn/TV9ay9wQcFxk9kVRb1Z8bvn20DQNU941jVjsNd
    5a/NQ9SQGtMEs7r6LJD2FSLpbLzIyVuMIPqxEiAYk5ZhItiSv0Vl4knt2hDg1mbc
    TVlO8zaAeVgEDBrjupZiguW50fYn9IDETIbwjFb0E8qqjVZhnNFs4nEyPktHp/bc
    nikSSooJYLa3xskk64XNpqNBNPYU14g2yaC4DMfWs/wQdD/txgNHanqKHWXLeSjC
    MaDNh5PvehL/ZEniU7ER7JMFYawvotlPtjFv34A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520527611; bh=oKZWLhsD5hagx9tTtU5yNDr+gw
    mZaIOW7anHLs8tFUA=; b=SonValyByUBIfXEPf+LjOIgfSlStYXwlqbtJj0jiJH
    Ph8MJ+wK1KQtALvlSzzm9x882E+X1AwCOEmIoGR4lpraNldPh4awuLRdTEG7xxM8
    Ucik08dupUZwQ6Tz2IfioJp5cWBnEw9z8gCXeBi+M8oMP5pbhGrHC4qTfJd67rxy
    B4U0eYk0t3rjnpL9jusVJXMedj9BlS4XriDz9j3dGDgkHFbYDTtQZo/CH4lh1dz1
    jVvYxslie4HFoQ+ZLU7DQAC3IooSc7+/q3Mn6qoWWJN72uWPeErqUOE0P22nNHls
    vn8QcMOfJIB56Nf/0iuwYxLtluqicURy4veahCeKzXNA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=XSxK2Ooa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=XSxK2Ooa x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbeCHQqQ (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 11:46:16 -0500
Received: from lelnx194.ext.ti.com ([198.47.27.80]:20801 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752094AbeCHQqP (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 8 Mar 2018 11:46:15 -0500
Date: Thu, 8 Mar 2018 10:46:13 -0600
From: Bin Liu <b-liu@ti.com>
To: Merlijn Wajer <merlijn@wizzup.org>
CC: <ivo.g.dimitrov.75@gmail.com>, <linux-omap@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] usb: musb: Fix external abort in musb_remove
Message-ID: <20180308164613.GH14921@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>,
        Merlijn Wajer <merlijn@wizzup.org>, ivo.g.dimitrov.75@gmail.com,
        linux-omap@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180308093121.11943-1-merlijn@wizzup.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180308093121.11943-1-merlijn@wizzup.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Thu, Mar 08, 2018 at 10:31:21AM +0100, Merlijn Wajer wrote:
> This fixes an oops on unbind / module unload. The fix is similar to the
> one in this commit: 0c3aae9bd59978fb8c3557d7883380bef0f2cfa1 (USB: musb:
> fix late external abort on suspend), which only fixes the issue for
> musb_suspend.
> 
> musb_remove function now also flushes any work and also calls
> musb_platform_exit before disabling runtime pm.
> 
> Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
> ---
> 
> If I understand commit 0c3aae9bd59978fb8c3557d7883380bef0f2cfa1 correctly,
> this patch should also be backported to 4.9 (and newer kernels).
> 
> I have verified that this works on the Nokia N900, RX-51. The problem did not
> occur on the Motorola Droid 4, but I have yet to test if this patch causes
> issues there.
> 
>  drivers/usb/musb/musb_core.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> index e2e95071328a..4fb0f345c04e 100644
> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -2472,13 +2472,19 @@ static int musb_remove(struct platform_device *pdev)
>  	musb_platform_disable(musb);
>  	spin_lock_irqsave(&musb->lock, flags);
>  	musb_disable_interrupts(musb);
> +
> +	musb->flush_irq_work = true;
> +	while (flush_delayed_work(&musb->irq_work))
> +		;
> +	musb->flush_irq_work = false;

No need to flush, the work is already cancelled at this point.

> +
>  	musb_writeb(musb->mregs, MUSB_DEVCTL, 0);
> +	musb_platform_exit(musb);

This can be move down to out side of holding the spinlock,

>  	spin_unlock_irqrestore(&musb->lock, flags);

to here.

>  
>  	pm_runtime_dont_use_autosuspend(musb->controller);
>  	pm_runtime_put_sync(musb->controller);
>  	pm_runtime_disable(musb->controller);
> -	musb_platform_exit(musb);
>  	musb_phy_callback = NULL;
>  	if (musb->dma_controller)
>  		musb_dma_controller_destroy(musb->dma_controller);
> -- 

Thanks for the patch.

Regards,
-Bin.
