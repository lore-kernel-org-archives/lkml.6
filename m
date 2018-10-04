Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B907BC64EBD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A79721473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 16:08:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A79721473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeJDXCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 19:02:44 -0400
Received: from muru.com ([72.249.23.125]:58268 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727721AbeJDXCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 19:02:44 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 641C7809C;
        Thu,  4 Oct 2018 16:13:17 +0000 (UTC)
Date:   Thu, 4 Oct 2018 09:08:45 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>, mturquette@baylibre.com,
        sboyd@kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        paul@pwsan.com, letux-kernel@openphoenux.org,
        Suman Anna <s-anna@ti.com>
Subject: Re: [PATCH RFC 0/2] mach-omap2: handle autoidle denial
Message-ID: <20181004160845.GG5662@atomide.com>
References: <20181004055147.23048-1-andreas@kemnade.info>
 <20181004142558.GB5662@atomide.com>
 <013b01a1-2593-bdc0-dd9a-e5a114388067@ti.com>
 <20181004150751.GF5662@atomide.com>
 <5373dfa1-4134-6d3f-0b66-46eef723d43f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5373dfa1-4134-6d3f-0b66-46eef723d43f@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [181004 15:53]:
> On 04/10/18 18:07, Tony Lindgren wrote:
> > * Tero Kristo <t-kristo@ti.com> [181004 14:47]:
> > > On 04/10/18 17:25, Tony Lindgren wrote:
> > > > It seems we should just provide a generic interface for
> > > > clk_allow_autoidle() and clk_deny_autoidle()? Otherwise we'll
> > > > be forever stuck with pdata callbacks it seems.
> > > 
> > > The TI clock driver is actually providing these APIs, so that should be
> > > fine. I don't think there is any use / need for pdata callbacks atm, it just
> > > happens hwmod core is calling these at the moment which might have confused
> > > you.
> > 
> > Hmm OK. So do we already have some way to deny autoidle for a
> > clock from ti-sysc.c driver without pdata callbacks?
> > 
> > Suman pointed out few days ago that for a reset driver to work
> > we must do clkdm_deny_idle() and clkdm_allow_idle() as the hwmod
> > code does. I gues that really just boils down to doing clk deny
> > idle and allow idle on the clockdomain clkctrl clock?
> 
> Clkdm handling is done via pdata callbacks, that is a separate topic from
> iclk autoidle. Iclk:s are effectively only for omap3, clkdm autoidle /
> deny_idle etc. are a generic mechanism that must be used on omap4+ if you
> want to prevent autoidle of certain domains/IPs.

OK thanks.

Tony
