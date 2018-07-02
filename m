Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8B5C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:47:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF54254D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 06:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF54254D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753534AbeGBGrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 02:47:00 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46172 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752420AbeGBGq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 02:46:57 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 16ED8207BE; Mon,  2 Jul 2018 08:46:55 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id C4884203B4;
        Mon,  2 Jul 2018 08:46:54 +0200 (CEST)
Date:   Mon, 2 Jul 2018 08:46:53 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Joe Perches <joe@perches.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        dedekind1@gmail.com, dwmw2@infradead.org,
        computersforpeace@gmail.com, marek.vasut@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH v3 2/2] ubi: expose the volume CRC check skip flag
Message-ID: <20180702084653.566d54bb@bbrezillon>
In-Reply-To: <cdc8383433a1f67f4d5f5d9c528e116ee10c7466.camel@perches.com>
References: <cover.6d66955e7c1848c8255870deb42eddb69bd276f3.1530169759.git-series.quentin.schulz@bootlin.com>
        <0ace6202bddb495ae0e632ae2fd0346f99fcdab4.1530169759.git-series.quentin.schulz@bootlin.com>
        <382648641.QZzOm4Mo72@blindfold>
        <20180701223347.2cef133b@bbrezillon>
        <cdc8383433a1f67f4d5f5d9c528e116ee10c7466.camel@perches.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 01 Jul 2018 13:54:32 -0700
Joe Perches <joe@perches.com> wrote:

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
> 

Yes, I know, but I remember checkpatch complaining about that in one
of my patch (maybe it was a slightly different case though). Anyway, I
double checked and, as you report, checkpatch does not complain, so
please ignore this comment (sorry for the noise).


