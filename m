Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86C4EC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:18:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 569BB2084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 09:18:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 569BB2084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbeJAPzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 11:55:19 -0400
Received: from foss.arm.com ([217.140.101.70]:45414 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728961AbeJAPzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 11:55:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F99A7A9;
        Mon,  1 Oct 2018 02:18:31 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D532E3F5B3;
        Mon,  1 Oct 2018 02:18:30 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 6A27E1AE322F; Mon,  1 Oct 2018 10:18:54 +0100 (BST)
Date:   Mon, 1 Oct 2018 10:18:54 +0100
From:   Will Deacon <will.deacon@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] perf: Convert to using %pOFn instead of device_node.name
Message-ID: <20181001091853.GA29682@arm.com>
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-38-robh@kernel.org>
 <20180828170258.GD19825@arm.com>
 <CAL_Jsq+L+vvfh_Co6FXkyhBbwct16t8sWsw3J7hmXP4uaJaaPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+L+vvfh_Co6FXkyhBbwct16t8sWsw3J7hmXP4uaJaaPg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 28, 2018 at 04:19:07PM -0500, Rob Herring wrote:
> On Tue, Aug 28, 2018 at 12:02 PM Will Deacon <will.deacon@arm.com> wrote:
> >
> > On Mon, Aug 27, 2018 at 08:52:39PM -0500, Rob Herring wrote:
> > > In preparation to remove the node name pointer from struct device_node,
> > > convert printf users to use the %pOFn format specifier.
> > >
> > > Cc: Will Deacon <will.deacon@arm.com>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  drivers/perf/arm_pmu_platform.c | 6 +++---
> > >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > Cheers, I can queue this up for 4.20. Let me know if you'd rather take it
> > along with the name pointer removal instead.
> 
> I assumed you were going to take this since I didn't say otherwise,
> but looks like it is not in linux-next. Please take thru your tree.

Sorry, slipped through the cracks. I'll get it queued asap for the merge
window.

Will
