Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B68C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320472174E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 11:30:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320472174E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728926AbeHMOMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 10:12:07 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:50998 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbeHMOMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 10:12:07 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 323FC6088978;
        Mon, 13 Aug 2018 13:30:14 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id vV0K9XRPpUNM; Mon, 13 Aug 2018 13:30:13 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DE4936088980;
        Mon, 13 Aug 2018 13:30:13 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id gC7G4ax4TNfU; Mon, 13 Aug 2018 13:30:13 +0200 (CEST)
Received: from blindfold.localnet (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id A22556088978;
        Mon, 13 Aug 2018 13:30:13 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-mtd@lists.infradead.org, David Gstir <david@sigma-star.at>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH 05/25] ubifs: implement ubifs_lpt_lookup using ubifs_pnode_lookup
Date:   Mon, 13 Aug 2018 13:30:13 +0200
Message-ID: <3522568.rp1UpMI3Wl@blindfold>
In-Reply-To: <20180813081238.crujoer2qprhn27y@pengutronix.de>
References: <20180704124137.13396-1-s.hauer@pengutronix.de> <8387142.nbJ7LYRgBX@blindfold> <20180813081238.crujoer2qprhn27y@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 13. August 2018, 10:12:38 CEST schrieb Sascha Hauer:
> > Can you please add a helper function for that? These shift games are
> > always confusing and not easy to spot.
> 
> Do you have a suggestion for a helper function? lpt.c is full of rather
> non obvious arithmetic operations and I couldn't find a helper function
> that could be reused at least once in the code.
> 
> I tried with:
> 
> static int lnum_to_pnode_num(struct ubifs_info *c, int lnum)
> {
> 	return (lnum - c->main_first) >> UBIFS_LPT_FANOUT_SHIFT;
> }
> 
> But I am not sure this really improves things

I had exactly such helpers in mind.
The lpt code translates often LEB numbers in both direction.
So, the helpers should have more than one user.

Long story short, I don't force you to add such helper and such.
Just thought while you are here you can try to make the code more
readable.

I think we both agree that lpt.c is not really review friendly. ;)

Thanks,
//richard




