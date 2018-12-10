Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F64CC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE9E2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 13:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2+RXh19Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEE9E2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeLJNfK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 08:35:10 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:41122 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbeLJNfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 08:35:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=80ws1goE5Ryom/NsKdNbe+Q5w0XIAXK3mR7RGe+VUD8=;
        b=2+RXh19QbACP7Zxs+XjQJJPTAeG+pcFGolqhwUiDCGIENX2BNxe1p+MARMyldN0I6eB25NBqUDro5cYuzTiX0A1hMw95oXwCeVPfWRua9guqxP6NsXK9qVXV3SjkMkyaSp/KNkeJPgtKKSotMdm2BA1RiRBz4YruXuyeacuCzUs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gWLi8-0001LB-NK; Mon, 10 Dec 2018 14:35:00 +0100
Date:   Mon, 10 Dec 2018 14:35:00 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     David Miller <davem@davemloft.net>
Cc:     hkallweit1@gmail.com, sfr@canb.auug.org.au, netdev@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        f.fainelli@gmail.com
Subject: Re: linux-next: Signed-off-by missing for commits in the net-next
 tree
Message-ID: <20181210133500.GB4660@lunn.ch>
References: <20181210080045.0e67ad79@canb.auug.org.au>
 <20181209211139.GB21186@lunn.ch>
 <011f5be3-4bc1-2e64-0ddf-b43b8dbc4dcd@gmail.com>
 <20181209.162805.1102172618676272423.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181209.162805.1102172618676272423.davem@davemloft.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The problem here is the '--' delimiter, Andrew should have either
> used nothing or something else.

I picked -- because it was not --- !

Anyway, lesson learned. But i kind of expect it will happen again to
others, since the "Submitting Patches" documentation just mentions ---
and does not say that other similar markers may also trigger the magic
scissors.

	Andrew
