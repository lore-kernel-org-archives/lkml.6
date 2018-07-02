Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5F5C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643DD2150A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643DD2150A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932148AbeGBGtc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 02:49:32 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:42237 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753229AbeGBGta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 02:49:30 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fZseO-0001jF-Pd; Mon, 02 Jul 2018 08:49:28 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1fZseM-0006v2-LF; Mon, 02 Jul 2018 08:49:26 +0200
Date:   Mon, 2 Jul 2018 08:49:26 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gavin Schenk <g.schenk@eckelmann.de>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] siox: don't create a thread without starting it
Message-ID: <20180702064926.sxx4wj5mxiywxkva@pengutronix.de>
References: <20180626073134.GW2458@hirez.programming.kicks-ass.net>
 <20180628075742.8991-1-u.kleine-koenig@pengutronix.de>
 <20180629073858.5gwpfwqo2ccb4jaa@pengutronix.de>
 <20180702093404.747c4148@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180702093404.747c4148@canb.auug.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Jul 02, 2018 at 09:34:04AM +1000, Stephen Rothwell wrote:
> On Fri, 29 Jun 2018 09:38:58 +0200 Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:
> >
> > On Thu, Jun 28, 2018 at 09:57:42AM +0200, Uwe Kleine-König wrote:
> > > Greg, you applied the initial patches creating drivers/siox. I assume
> > > you will continue to apply siox patches and tell if I should search a
> > > different path for these.  
> > 
> > I put the two patches that I'd like to get in during the next merge
> > window into a branch in my repository:
> > 
> > 	https://git.pengutronix.de/git/ukl/linux siox/next
> > 
> > I assume you wouldn't object to add this branch to linux-next?
> 
> Added from today. 

Ok, great. 

> Is this a continuing effort, or should I just remove the tree once
> Greg has merged it?

I expect the patch count to be zero for most future releases because
there are probably no users apart from Eckelmann. On the other hand if
we still need a patch it would continue to be good to have the exposure
in next.

So I'd say, if it reduces your burden feel free to drop it and if there
is something relevant later, it seems to be easy enough to readd it
then.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
