Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009E7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB4F20883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 15:48:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbfARPsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 10:48:11 -0500
Received: from muru.com ([72.249.23.125]:34200 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726902AbfARPsL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 10:48:11 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 725648047;
        Fri, 18 Jan 2019 15:48:17 +0000 (UTC)
Date:   Fri, 18 Jan 2019 07:48:07 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcousson@baylibre.com,
        paul@pwsan.com, letux-kernel@openphoenux.org
Subject: Re: [PATCH v3 3/3] arm: omap_hwmod disable ick autoidling when a
 hwmod requires that
Message-ID: <20190118154807.GV5544@atomide.com>
References: <20190116220429.9136-1-andreas@kemnade.info>
 <20190116220429.9136-4-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116220429.9136-4-andreas@kemnade.info>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Andreas Kemnade <andreas@kemnade.info> [190116 22:04]:
> Deny autoidle for hwmods with the OCPIF_SWSUP_IDLE flag,
> that makes hwmods working properly which cannot handle
> autoidle properly in lower power states.

Sorry if I'm still missing something :)

But doesn't this now block autoidle for all modules
with OCPIF_SWSUP_IDLE even if they work just fine with
autoidle?

I think what you want to do is keep clocks enabled
while in use?

If so, how about using HWMOD_CLKDM_NOAUTO:

"HWMOD_CLKDM_NOAUTO: Allows the hwmod's clockdomain to
 be prevented from entering HW_AUTO while hwmod is
 active."

> Affected is e. g. the omap_hdq.

Have you already tried what happens if you just tag
omap_hdq with HWMOD_CLKDM_NOAUTO?

Regards,

Tony
