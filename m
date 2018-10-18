Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A91C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A536F21477
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 23:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mendozajonas.com header.i=@mendozajonas.com header.b="JCa2LC7B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XP6d0pBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A536F21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mendozajonas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeJSHQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 03:16:06 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46595 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725934AbeJSHQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 03:16:06 -0400
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Fri, 19 Oct 2018 03:16:05 EDT
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 58B58226DF;
        Thu, 18 Oct 2018 19:05:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 18 Oct 2018 19:05:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        mendozajonas.com; h=message-id:subject:from:to:cc:date
        :in-reply-to:references:content-type:mime-version
        :content-transfer-encoding; s=fm1; bh=qReEp1SB7cdYYzkyrhBEtjS5cQ
        F4GJTebujWTxuRncA=; b=JCa2LC7BX3wwMhgy3ermK4atJ8UBvW00AVWfTv5Uz7
        E6FyWdsusA2/7U4QMmKh0nkCROMYCH69zkbprrc0rNFF8Ae8fnlB2Lk+WZCFU/Wc
        5uCO8cD8oUMVb0pYeZEuOqHO3ubQy4KW8DeFFbDV0kQbCXA0vQPtiA7Fkh/GRJ7X
        dADIiZoyzi3eoghzuVx9G5qLKCOuzYuX6WXYot3G+hx15zCHkiIVXfLcnGj8e9lc
        enhI8Uq87/e9XlxnLDyiNvtCxXWwE/GgVm4VcfNgiYe0meIMak+jiNE0Ufo26130
        3KtLntKVjSA0MMidMBc70IiXMxzFiEUFoab7IM4AmqdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=qReEp1SB7cdYYzkyrhBEtjS5cQF4GJTebujWTxuRn
        cA=; b=XP6d0pBVsU4AVtBnlDeymuNjTXbykOEcgZ5Py2pGeSXMQwiovxfWB3rLg
        hn6evMyiqcCBQK+9ZviKKB0yhk78CK1u59m6DAAyLOEgIrhIO+XtCQC6nucg8ltJ
        k+NfG/nqcHY4Ez6Pby7JAQSN3p/Bz6M2nISSPpFjeFmm7M7pkqlxPOnmjAH0s9bt
        z6icUg0t0wbFYFXn1XKp2D57u+6d8oTJdVjndIymC72obyiglUZW/sNgd3aeeNJT
        9IpygvCrq7DN5iT2IR7sm0WOCVf1q/PB+iW70MvXNRm7rAO4AUembE8Lkh/zIf95
        ZWjztn4U+E2xYxBDhhTrlPiONIDEw==
X-ME-Sender: <xms:rhHJW3tJEQF5ywNKF1yrN44Ch2XeZ6LbzIWIhuaFIsTEQcGEdopIsg>
X-ME-Proxy: <xmx:rhHJW45tDjwuG0DqaCii-vJARso8RPbcDLGB__JTeqKdgaR9Z_x9IA>
    <xmx:rhHJW_At2cW7npGkHmsB6Kpk_alsbZ_oleLis-cOyHBfIu3LnbSPvw>
    <xmx:rhHJW6YG0FK4rgBpxxREr5LzRwh_y_ezTtpbQttna5YiLhqT-vRm0Q>
    <xmx:rhHJWzJB4HDJcNXQ2rEPQ1HARKq_TS_N8n8N40UZisJPV4lfM6wDgA>
    <xmx:rhHJWzD9KdxdT-q3RybEcUG5RCFMz631eW5DUyTRWYTN_O-4SWQqww>
    <xmx:rxHJWwSceZ0OlL-WImt6Jlw7NJCnX5aJh9g2StnciXjzGhN4uutY7g>
Received: from v4 (pa49-180-141-13.pa.nsw.optusnet.com.au [49.180.141.13])
        by mail.messagingengine.com (Postfix) with ESMTPA id 14EE8E462B;
        Thu, 18 Oct 2018 19:05:14 -0400 (EDT)
Message-ID: <7f3744217190fe94bb1df879fa107593e911d7b5.camel@mendozajonas.com>
Subject: Re: [PATCH net-next 0/6] net/ncsi: Allow enabling multiple packages
 & channels
From:   Samuel Mendoza-Jonas <sam@mendozajonas.com>
To:     David Miller <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, Justin.Lee1@Dell.com,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Date:   Fri, 19 Oct 2018 10:05:09 +1100
In-Reply-To: <20181018.155647.1045018243241594303.davem@davemloft.net>
References: <20181018035917.19413-1-sam@mendozajonas.com>
         <20181018.155647.1045018243241594303.davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-10-18 at 15:56 -0700, David Miller wrote:
> From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
> Date: Thu, 18 Oct 2018 14:59:11 +1100
> 
> > This series extends the NCSI driver to configure multiple packages
> > and/or channels simultaneously. Since the RFC series this includes a few
> > extra changes to fix areas in the driver that either made this harder or
> > were roadblocks due to deviations from the NCSI specification.
> > 
> > Patches 1 & 2 fix two issues where the driver made assumptions about the
> > capabilities of the NCSI topology.
> > Patches 3 & 4 change some internal semantics slightly to make multi-mode
> > easier.
> > Patch 5 introduces a cleaner way of reconfiguring the NCSI configuration
> > and keeping track of channel states.
> > Patch 6 implements the main multi-package/multi-channel configuration,
> > configured via the Netlink interface.
> > 
> > Readers who have an interesting NCSI setup - especially multi-package
> > with HWA - please test! I think I've covered all permutations but I
> > don't have infinite hardware to test on.
> 
> This doesn't apply cleanly to net-next.  Does it depend upon changes
> applied elsewhere?  You must always make that explicit.

Ah, my mistake; I hadn't updated my net-next branch recently enough and
missed Vijay's OEM command patch. Will rebase.

> 
> Also, please explain this locking in ncsi_reset_dev():
> 
> +       NCSI_FOR_EACH_PACKAGE(ndp, np) {
> +               NCSI_FOR_EACH_CHANNEL(np, nc) {
> +                       spin_lock_irqsave(&nc->lock, flags);
> +                       enabled = nc->monitor.enabled;
> +                       state = nc->state;
> +                       spin_unlock_irqrestore(&nc->lock, flags);
> +
> +                       if (enabled)
> +                               ncsi_stop_channel_monitor(nc);
> +                       if (state == NCSI_CHANNEL_ACTIVE) {
> +                               active = nc;
> +                               break;
> +                       }
> 
> Is that really protecting anything?
> 
> Right after you drop np->lock those two values can change, the state
> of the 'nc' can change such that it isn't NCSI_CHANNEL_ACTIVE anymore
> etc.
> 
> At best this locking makes sure thatn enabled and state are consistent
> with respect to eachother, only.  It doesn't guarantee anything about
> the stability of the state of the object at all, and it can change
> right from under you.

And you've caught this correctly, I'll fix this up in the rebase to
protect actually checking the channel/monitor state.

Thanks,
Sam


