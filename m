Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F2CC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5145F2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5145F2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbeLDQqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:46:02 -0500
Received: from muru.com ([72.249.23.125]:56392 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbeLDQqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:46:01 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 3F47580FA;
        Tue,  4 Dec 2018 16:46:03 +0000 (UTC)
Date:   Tue, 4 Dec 2018 08:45:57 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Stephen Boyd <sboyd@kernel.org>, Tero Kristo <t-kristo@ti.com>,
        bcousson@baylibre.com, letux-kernel@openphoenux.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, mturquette@baylibre.com, paul@pwsan.com
Subject: Re: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle
 ops
Message-ID: <20181204164556.GB6707@atomide.com>
References: <154353750560.88331.11814738542436183126@swboyd.mtv.corp.google.com>
 <20181130071534.0a6cd455@kemnade.info>
 <154356242517.88331.8496814814468751012@swboyd.mtv.corp.google.com>
 <9eb7b090-4803-d389-4112-3bf058385b2e@ti.com>
 <154356463284.88331.13323307899580657085@swboyd.mtv.corp.google.com>
 <eca27a46-2ca3-1a02-c0c8-c1c00b3b2f46@ti.com>
 <20181130153729.GG53235@atomide.com>
 <154362191595.88331.15503578806026771935@swboyd.mtv.corp.google.com>
 <20181203153910.GA6707@atomide.com>
 <20181203172246.0e767a16@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203172246.0e767a16@kemnade.info>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [181204 06:17]:
> On Mon, 3 Dec 2018 07:39:10 -0800
> Tony Lindgren <tony@atomide.com> wrote:
> > The consumer device stays active just fine with PM runtime
> > calls. So yes, the problem is keeping a clock controller forced
> > active for the period of consumer device reset. Other than
> > that typically autoidle can be just kept enabled.
> > 
> Are we still talking about the same problem? Maybe I am losing track
> here. Just to make sure. 
> The patch series was about disabling autoidle for devices which cannot
> work with it during normal operation. Not during reset or something
> like that. 
> Or is the keep-clock-active-during-reset just a requirement for bigger
> restructuring ideas?

Yeah there are two issues: The fix needed for the issue you brought up,
and also how to let a reset driver to block autoidle for reset.

Regards,

Tony

