Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00C6C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 00:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35682086C
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 00:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="ejM+C0I7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wdaPGbVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A35682086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbeKHKOl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 05:14:41 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:47967 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727786AbeKHKOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 05:14:41 -0500
X-Greylist: delayed 391 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Nov 2018 05:14:40 EST
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id F1C5E21D07;
        Wed,  7 Nov 2018 19:35:18 -0500 (EST)
Received: from web3 ([10.202.2.213])
  by compute4.internal (MEProxy); Wed, 07 Nov 2018 19:35:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=
        message-id:from:to:cc:mime-version:content-transfer-encoding
        :content-type:date:in-reply-to:subject:references; s=fm1; bh=Cpd
        eR+5f5k+fLW+3h2NLtz/RbLYBe2uG5dh0Y/J1mLI=; b=ejM+C0I7Eri069us7zS
        /k2kn9OnjqGGoW+Jx7LjOLfC8yOS4H37B2Q3wBB7cOW44RTvXbBHb1b8YHV7z4D3
        Zm0QZBGUq7sUTzJ+KUpb21sGgcjDx9JQpfbFojyZnwI7nGeIc5jaOfv9Bjgfm+fc
        b20u//vG9tIzcWq3tiBFseJi8Jta6E029Qdz8uyshbOt4fKAtZlZELv/M0Cyye88
        RrJ2yOUkekEI4wT+4TUq/1njTlLEgs3Iw+r9tV+4LRQYSQBlpXLt6wjUXWfKu9Dv
        8ofCDp2lotGiTv4usemFx2BGpw8erfZPxzeTWITntrmUfd/2fs+YrZfZqEJOnQkO
        9Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=CpdeR+5f5k+fLW+3h2NLtz/RbLYBe2uG5dh0Y/J1m
        LI=; b=wdaPGbVE8teFCftGMUpL4/q6kVloatO0sFCE8DIIdPeaRnlrH2337UUtG
        +V+fz8RqjEv0CcsoEnB3ZY2Xf660xb+eyzx2+sYS8GDhJMtB1otJ22LXK00b5oUT
        EJ9HZ0comDz/SXkSn7rPXIfmrYP1yG0k/4EkFNh7huPsPAN+HN+lTFPi5rXmKRMS
        efL7bTSIi4Q2KzCS2sMKd9pouCAnLMu3czZJUa6xAuFZPmYV9IMb3ohpPccZ1fZg
        hmVWtGECnhNwpr+4FjZEKsPxd/NA20JPtMvLScZj9cA3p0212roP5T3nE8C7YQr5
        wqm/c2ATiZ8A4BPgEXSYleQ4nOt3A==
X-ME-Sender: <xms:xITjWwrTrVYc13HJk4OxVPMa_zgUsGNaeDYiUcRW_JSZ1Y_MHbJS9g>
X-ME-Proxy: <xmx:xITjW1q2cfYBi9eo-LTTDC7eQrvdEEBoJILvrNcMn4F-9Gs1_UYhlw>
    <xmx:xITjW8MTsyGopdYqY3QTYBusp183Wif_M38fpWTa39OvcwMdCTHQKg>
    <xmx:xYTjW_Ubpc_GZ3h-pE4S89ehBgTMiUeLDaeA8GQ4V7_U75yOZkFfkg>
    <xmx:xYTjW3uWAj_M6AF_pFAnf05ig1nM14yTGuAepBVyU-YfKsNNP5axGg>
    <xmx:xYTjWy2p5RHJ_BR_duhStK8eiFyeTbvnltSElW1AypINWBk8YNG4Bg>
    <xmx:xoTjW34TkGhjrafecQUpzVyFD_7-ZOhC2LeVGeX-JnxhRBPWHZbj5g>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id D47769E4F3; Wed,  7 Nov 2018 19:35:16 -0500 (EST)
Message-Id: <1541637316.1471870.1569457840.5A56DC54@webmail.messagingengine.com>
From:   Andrew Jeffery <andrew@aj.id.au>
To:     Julia Lawall <Julia.Lawall@lip6.fr>,
        Felipe Balbi <balbi@kernel.org>
Cc:     kernel-janitors@vger.kernel.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-d469da0c
Date:   Thu, 08 Nov 2018 11:05:16 +1030
In-Reply-To: <1540916399-22426-1-git-send-email-Julia.Lawall@lip6.fr>
Subject: Re: [PATCH] usb: gadget: aspeed-vhub: constify usb_gadget_ops structure
References: <1540916399-22426-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2018, at 02:49, Julia Lawall wrote:
> The usb_gadget_ops structure can be const as it is only stored in
> the ops field of a usb_gadget structure and this field is const.
> 
> Done with the help of Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> 
> ---
>  drivers/usb/gadget/udc/aspeed-vhub/dev.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/aspeed-vhub/dev.c b/drivers/usb/
> gadget/udc/aspeed-vhub/dev.c
> index f0233912bace..6b1b16b17d7d 100644
> --- a/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> +++ b/drivers/usb/gadget/udc/aspeed-vhub/dev.c
> @@ -438,7 +438,7 @@ static int ast_vhub_udc_stop(struct usb_gadget 
> *gadget)
>  	return 0;
>  }
>  
> -static struct usb_gadget_ops ast_vhub_udc_ops = {
> +static const struct usb_gadget_ops ast_vhub_udc_ops = {
>  	.get_frame	= ast_vhub_udc_get_frame,
>  	.wakeup		= ast_vhub_udc_wakeup,
>  	.pullup		= ast_vhub_udc_pullup,
> 
