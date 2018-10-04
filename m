Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B397C64EBD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C3ED20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C3ED20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeJDVTd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:19:33 -0400
Received: from muru.com ([72.249.23.125]:58180 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbeJDVTd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:19:33 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 13605809C;
        Thu,  4 Oct 2018 14:30:29 +0000 (UTC)
Date:   Thu, 4 Oct 2018 07:25:58 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul@pwsan.com,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH RFC 0/2] mach-omap2: handle autoidle denial
Message-ID: <20181004142558.GB5662@atomide.com>
References: <20181004055147.23048-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004055147.23048-1-andreas@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [181004 05:56]:
> On the gta04 with a dm3730 omap_hdq does not work properly when the
> device enters lower power states. Idling uart1 and 2 is enough
> to show up that problem, if there are no other things enabled.
> Further research reveals that hdq iclk must not be turned off during
> transfers, also according to the TRM. That fact is also correctly described
> in the flags but the code to handle that is incomplete.
> 
> Since the order is first disable all autoidles, then disable selected
> and then enable all, we need to either change that order or add
> a usecount. Since it is done only in init, we could think about changing
> order.

These patches look OK to me, assuming Tero will review them more
closely.

It seems we should just provide a generic interface for
clk_allow_autoidle() and clk_deny_autoidle()? Otherwise we'll
be forever stuck with pdata callbacks it seems.

Regards,

Tony
