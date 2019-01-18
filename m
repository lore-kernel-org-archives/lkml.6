Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB68FC07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DD52087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729414AbfARTsH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:48:07 -0500
Received: from muru.com ([72.249.23.125]:34284 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729262AbfARTsG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:48:06 -0500
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7597E8047;
        Fri, 18 Jan 2019 19:48:12 +0000 (UTC)
Date:   Fri, 18 Jan 2019 11:48:02 -0800
From:   Tony Lindgren <tony@atomide.com>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Discussions about the Letux Kernel <letux-kernel@openphoenux.org>,
        paul@pwsan.com, sboyd@kernel.org, mturquette@baylibre.com,
        linux-kernel@vger.kernel.org, t-kristo@ti.com,
        bcousson@baylibre.com, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, Keerthy <j-keerthy@ti.com>
Subject: Re: [Letux-kernel] [PATCH v3 3/3] arm: omap_hwmod disable ick
 autoidling when a hwmod requires that
Message-ID: <20190118194802.GZ5544@atomide.com>
References: <20190116220429.9136-1-andreas@kemnade.info>
 <20190116220429.9136-4-andreas@kemnade.info>
 <20190118154807.GV5544@atomide.com>
 <20190118181827.7163bee4@aktux>
 <20190118183630.GX5544@atomide.com>
 <20190118203832.3be7975e@aktux>
 <20190118204204.44db353f@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118204204.44db353f@aktux>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andreas Kemnade <andreas@kemnade.info> [190118 19:42]:
> On Fri, 18 Jan 2019 20:38:47 +0100
> Andreas Kemnade <andreas@kemnade.info> wrote:
> 
> > Hi,
> > 
> > On Fri, 18 Jan 2019 10:36:30 -0800
> > Tony Lindgren <tony@atomide.com> wrote:
> > 
> > [...]
> > > til the next workaround.
> > >   
> > > > That flags also causes the iclk being enabled/disabled
> > > > manually.    
> > > 
> > > Yes but SWSUP_IDLE for the interface clock to me currently
> > > just means:
> > > 
> > > "manually enable and disable ocp interface clock"
> > >   
> > well, if we want to manually disable it and not automatically,
> > we have to disable autoidle or it will be automatically disabled.
> > 
> > Disabling it manually when it is already auto-disabled (by autoidle) is
> > just practically a no-op towards the clock.
> > 
> > > and with your changes it becomes:
> > > 
> > > "manually enable and disable ocp interface clock and block
> > >  autoidle while in use".
> > > 
> > > So aren't we now changing the way things behave in general
> > > for SWSUP_IDLE?
> > >   
> > Yes, we are, so proper testing is needed. But If I read those comments
> > it was always intended this way but not fully implemented because it
> > appeared to be more work like needing a usecounter (which my patchset
> > also adds) for that autoidle flag.
> > 
> and there are quite few hwmods marked by this flag. 
> And then there are those clocks marked by this flags (on am33xx) which
> do not have that autoidle feature at all, so the risk is not too high.

Keerthy, can you please test this series on top of the
related clock patches with your am335x PM test cases?

Regards,

Tony


