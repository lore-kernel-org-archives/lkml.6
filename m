Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA3A8C070C3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 02:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E1F720652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 02:44:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="U2Y/w/mg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PYoyE8Re"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E1F720652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbeJOK1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 06:27:55 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38697 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726262AbeJOK1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 06:27:55 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 68A2F21B2D;
        Sun, 14 Oct 2018 22:44:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sun, 14 Oct 2018 22:44:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=message-id:subject:from:to:cc:date
        :in-reply-to:references:content-type:mime-version
        :content-transfer-encoding; s=fm1; bh=3EmHbdL+JmgkbkCKCbopsyOyS8
        KZzv7tydkv2GAXMY0=; b=U2Y/w/mgWudduz8PdVxGlBJ3Q/CqUPOWapwbh1865I
        AmIpB9TaQfvZLgeBDwzG+z5vldznB+X7LOb5ZQMKGUYoHsOZ/i9XY579OhHjD5fE
        y3OgoPG20/2PWZA2LZtcQ5jjoqSekmF7FEyx/H/yrtfYDRg5XTNeip5fZo4fBBst
        HkRw20Hhy4EMibx3P0LESLW48+aSZEEIsi5WrbmCyVCbDf8sMHpHU3Y4XGDoY6EM
        NBMe4LrR0Xsf7DNcRBQv2nmmKHKh1LpJk2cEJTqdYWATloO2O8ozCXxC2y2mQtb1
        yyLjs3jyU5vcFlM0Eg/DcJoJxKSx3QQUrZ8KT+uzJ5VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=3EmHbdL+JmgkbkCKCbopsyOyS8KZzv7tydkv2GAXM
        Y0=; b=PYoyE8RewoGY8PU/PBnsvhPVYQDu8cSqzQ0ZiPPIluvlbkx5zpZCreZQ/
        /ZQaCBmeaLeJ9zSA2IDcxuxHpJcu0fBNKaV7vuVNQk9vIi6HN16fUDPX8cXy7B5E
        4v3iMijC3LbwkeA1yW697oWPfIjvY+ChazKJrvHpYFlE1zBx2W5ghLnTy6jeBRvo
        exqIvNFFs4lsSYkZI8mMCs6YwhmZtIft714pFg7lJ2d17oEbcJH3QcvAPClRREzP
        cS0M31ZT50VjDiPTG0QgbzGm4CyQkqW89pBXfU/7paJxhsBWI6aQstyAVAkYc0tP
        OzPqz297VSi5ZRT4cyU+QM0v9eMhw==
X-ME-Sender: <xms:Gf_DW2RpVCQX2rpRKiEjhoCDeN61bi19_zkxyc777DojNdbHWPMcCg>
X-ME-Proxy: <xmx:Gf_DW6NlQpWRMxywh82P1NL38q5X8FsfKaGBGnmJR7wSZTzHgiBgVQ>
    <xmx:Gf_DW6VP9KIu-OGYN7407buriNVPA6SBW6P_pWsgR2f3nijDJIWDLQ>
    <xmx:Gf_DW6jmZv96fNQligFmHXAN-jdQRA0yZdA0sYAtgm-No9c_vZzUKw>
    <xmx:Gf_DWy_c4Yij-tyiKPM0-4VqtZ1fwiTLqSZoNIjDLfZCfAIOlHBwvQ>
    <xmx:Gf_DW5QD9wZ9ncy-Vz0BWUk1cNQ3Avj3sGTxQEYxC-yT81bGWA3yMQ>
    <xmx:Gv_DW5eza3KpZNCHKBsrTEzjfHQk28ueYFv1Ob1QOH-v5lenlFjRzQ>
Received: from v4 (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id CFF93E40E6;
        Sun, 14 Oct 2018 22:44:39 -0400 (EDT)
Message-ID: <336fc885b7b3246d7434998514a38fc0b754c865.camel@mendozajonas.com>
Subject: Re: [RFC PATCH 2/2] net/ncsi: Configure multi-package,
 multi-channel modes with failover
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     Justin.Lee1@Dell.com, netdev@vger.kernel.org
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Date:   Mon, 15 Oct 2018 13:44:36 +1100
In-Reply-To: <d648d156e08c4b2a8135f54abe0e9474@AUSX13MPS302.AMER.DELL.COM>
References: <20181009035815.5246-1-sam@mendozajonas.com>
         <20181009035815.5246-2-sam@mendozajonas.com>
         <d97bb52a060a40cf8e03a49eb82a285f@AUSX13MPS302.AMER.DELL.COM>
         <8548f1872badb35588d5506da21f0d89bea71127.camel@mendozajonas.com>
         <e20a7a3da4ca4aec913800355cd6cdaf@AUSX13MPS302.AMER.DELL.COM>
         <cdf6fa4a6d7a506f84c9d9925d8f621b398a2fff.camel@mendozajonas.com>
         <d648d156e08c4b2a8135f54abe0e9474@AUSX13MPS302.AMER.DELL.COM>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-12 at 19:16 +0000, Justin.Lee1@Dell.com wrote:
> > > > > > +
> > > > > > +	NCSI_FOR_EACH_CHANNEL(np, channel) {
> > > > > > +		ncm = &channel->modes[NCSI_MODE_TX_ENABLE];
> > > > > > +		/* Another channel is already Tx */
> > > > > > +		if (ncm->enable)
> > > > > > +			return false;
> > > > > > +	}
> 
> As we don't suspend the old channel when we call the ncsi_stop_dev() function,
> this will always be false and we will not set it to the right channel.
> If mutli_channel is enabled, suppose that we only need to send TX enable/disable
> when  the link is changed.

Ah, good point. I was working on improving the ncsi_stop_dev/ncsi_start_dev
interactions in a separate patch but we're going to need to fix it for
multi_channel to work properly. I'll look into that and include it in this
series.

<snip>

> > > > > > -	if (!found) {
> > > > > > +	if (!with_link && found) {
> > > > > > +		netdev_info(ndp->ndev.dev,
> > > > > > +			    "NCSI: No channel with link found, configuring channel %u\n",
> > > > > > +			    found->id);
> > > > > > +		spin_lock_irqsave(&ndp->lock, flags);
> > > > > > +		list_add_tail_rcu(&found->link, &ndp->channel_queue);
> > > > > > +		spin_unlock_irqrestore(&ndp->lock, flags);
> 
> If multi-channel is enabled and without the link, the last found channel would be added again.

Yep, I've fixed this up by checking whether anything has been added to the
channel queue instead.

Thanks,
Sam


