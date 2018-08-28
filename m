Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA71C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBF5208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 06:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FBF5208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbeH1KpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 06:45:20 -0400
Received: from smtprelay0018.hostedemail.com ([216.40.44.18]:44280 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726446AbeH1KpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 06:45:19 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id B9268181D3417;
        Tue, 28 Aug 2018 06:55:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: bear06_2c9b594a5e147
X-Filterd-Recvd-Size: 1555
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 Aug 2018 06:55:06 +0000 (UTC)
Message-ID: <b2d9328b9cd48e768ac8062de60a95195b8ffb58.camel@perches.com>
Subject: Re: [PATCH] ARM: omap: Convert to using %pOFn instead of
 device_node.name
From:   Joe Perches <joe@perches.com>
To:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?ISO-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Paul Walmsley <paul@pwsan.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 27 Aug 2018 23:55:05 -0700
In-Reply-To: <20180828015252.28511-1-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-08-27 at 20:52 -0500, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
[]
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
[]
> @@ -738,7 +738,7 @@ static int __init _setup_clkctrl_provider(struct device_node *np)
>  	provider->size = size | 0xff;
>  	provider->node = np;
>  
> -	pr_debug("%s: %s: %x...%x [+%x]\n", __func__, np->parent->name,
> +	pr_debug("%pOF: %s: %x...%x [+%x]\n", __func__, np->parent,

Wrong argument order

I didn't look at the rest.
