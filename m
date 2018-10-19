Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 676A6ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 008DC2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 15:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 008DC2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeJSXv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 19:51:29 -0400
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:35278 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726930AbeJSXv1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 19:51:27 -0400
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id w9JFidQ6024138;
        Fri, 19 Oct 2018 17:44:39 +0200
Date:   Fri, 19 Oct 2018 17:44:39 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Richard Genoud <richard.genoud@gmail.com>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Yelena Krivosheev <yelena@marvell.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CRC errors between mvneta and macb
Message-ID: <20181019154439.GC24045@1wt.eu>
Reply-To: linux-kernel@vger.kernel.org
References: <f6ccdfbd-7a67-ae14-5940-c7614cb143e9@sorico.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6ccdfbd-7a67-ae14-5940-c7614cb143e9@sorico.fr>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 05:15:03PM +0200, Richard Genoud wrote:
> When there's a CRC error, the TXCLK has its polarity inverted...
> That's a clue !
> 
> But this TXCLK (25MHz) is not used on the g35-ek.
> Only the REFCLK/XT2 (50MHz) is used to synchronise the PHY and the macb.
> So I guess that the TXCLK has a role to play to generate TX+/TX-

Well, just a stupid idea, maybe when this signal is inverted, the TX+/TX-
are desynchronized by half a clock and are not always properly interpreted
on the other side ?

Willy
