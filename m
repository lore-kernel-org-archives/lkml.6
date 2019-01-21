Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8D1C37121
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A75220861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 19:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfAUT6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 14:58:07 -0500
Received: from muru.com ([72.249.23.125]:34562 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727796AbfAUT6H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 14:58:07 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 1ABBC80C0;
        Mon, 21 Jan 2019 19:58:14 +0000 (UTC)
Date:   Mon, 21 Jan 2019 11:58:03 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcousson@baylibre.com,
        paul@pwsan.com, letux-kernel@openphoenux.org
Subject: Re: [PATCH v3 0/3] mach-omap2: handle autoidle denial
Message-ID: <20190121195803.GH5544@atomide.com>
References: <20190116220429.9136-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116220429.9136-1-andreas@kemnade.info>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [190116 14:04]:
> On the gta04 with a dm3730 omap_hdq does not work properly when the
> device enters lower power states. Idling uart1 and 2 is enough
> to show up that problem, if there are no other things enabled.
> Further research reveals that hdq iclk must not be turned off during
> transfers, also according to the TRM. That fact is also correctly described
> in the flags but the code to handle that is incomplete.
> 
> To handle multiple users of a single ick, autoidle is disabled
> when a user of that ick requires that (has the OCPIF_SWSUP_IDLE))
> 
> Changes v3:
> - replace CLK_IS_BASIC
> 
> Changes v2:
> - uses spinlocks instead of mutexes
> - invert counter logic
> - check whether clock type is basic

For this series it's best to merge it all via the
clock tree along with the related clock patches:

Acked-by: Tony Lindgren <tony@atomide.com>
