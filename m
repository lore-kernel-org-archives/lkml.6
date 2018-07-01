Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24009C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 21:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C40372492A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 21:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C40372492A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeGAVBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 17:01:39 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:34736 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752504AbeGAVBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 17:01:38 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 78CC160A04C1;
        Sun,  1 Jul 2018 23:01:37 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id LkYELMxg6SZB; Sun,  1 Jul 2018 23:01:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 39D7A6093334;
        Sun,  1 Jul 2018 23:01:37 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GSlWXJ4j5_Xy; Sun,  1 Jul 2018 23:01:37 +0200 (CEST)
Received: from blindfold.localnet (213-47-184-186.cable.dynamic.surfer.at [213.47.184.186])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 15ADB609199F;
        Sun,  1 Jul 2018 23:01:37 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Joe Perches <joe@perches.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        dedekind1@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v3 2/2] ubi: expose the volume CRC check skip flag
Date:   Sun, 01 Jul 2018 23:01:30 +0200
Message-ID: <2098416.O8QMNZQyoz@blindfold>
In-Reply-To: <cdc8383433a1f67f4d5f5d9c528e116ee10c7466.camel@perches.com>
References: <cover.6d66955e7c1848c8255870deb42eddb69bd276f3.1530169759.git-series.quentin.schulz@bootlin.com> <20180701223347.2cef133b@bbrezillon> <cdc8383433a1f67f4d5f5d9c528e116ee10c7466.camel@perches.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, 1. Juli 2018, 22:54:32 CEST schrieb Joe Perches:
> On Sun, 2018-07-01 at 22:33 +0200, Boris Brezillon wrote:
> > On Sun, 01 Jul 2018 21:35:57 +0200 Richard Weinberger <richard@nod.at> wrote:
> > > Am Donnerstag, 28. Juni 2018, 09:40:53 CEST schrieb Quentin Schulz:
> > > > Now that we have the logic for skipping CRC check for static UBI volumes
> > > > in the core, let's expose it to users.
> []
> > > > diff --git a/drivers/mtd/ubi/cdev.c b/drivers/mtd/ubi/cdev.c
> []
> > > > @@ -622,6 +622,10 @@ static int verify_mkvol_req(const struct ubi_device *ubi,
> > > >  	    req->vol_type != UBI_STATIC_VOLUME)
> > > >  		goto bad;
> > > >  
> > > > +	if (req->flags & UBI_VOL_SKIP_CRC_CHECK_FLG &&
> > 
> > Oops, missed that req->flags & UBI_VOL_SKIP_CRC_CHECK_FLG check was
> > missing parens (checkpatch --strict should complain about that).
> 
> Why should checkpatch complain?
> & has higher precedence than &&.

The code is more readable.

Thanks,
//richard

