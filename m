Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE2BC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 20:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A26258BC
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 20:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A26258BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752573AbeGAUyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 16:54:38 -0400
Received: from smtprelay0165.hostedemail.com ([216.40.44.165]:41869 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752461AbeGAUyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 16:54:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 60552182CF66C;
        Sun,  1 Jul 2018 20:54:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: side86_450e51033495f
X-Filterd-Recvd-Size: 2059
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Sun,  1 Jul 2018 20:54:34 +0000 (UTC)
Message-ID: <cdc8383433a1f67f4d5f5d9c528e116ee10c7466.camel@perches.com>
Subject: Re: [PATCH v3 2/2] ubi: expose the volume CRC check skip flag
From:   Joe Perches <joe@perches.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>, dedekind1@gmail.com,
        dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com
Date:   Sun, 01 Jul 2018 13:54:32 -0700
In-Reply-To: <20180701223347.2cef133b@bbrezillon>
References: <cover.6d66955e7c1848c8255870deb42eddb69bd276f3.1530169759.git-series.quentin.schulz@bootlin.com>
         <0ace6202bddb495ae0e632ae2fd0346f99fcdab4.1530169759.git-series.quentin.schulz@bootlin.com>
         <382648641.QZzOm4Mo72@blindfold> <20180701223347.2cef133b@bbrezillon>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-07-01 at 22:33 +0200, Boris Brezillon wrote:
> On Sun, 01 Jul 2018 21:35:57 +0200 Richard Weinberger <richard@nod.at> wrote:
> > Am Donnerstag, 28. Juni 2018, 09:40:53 CEST schrieb Quentin Schulz:
> > > Now that we have the logic for skipping CRC check for static UBI volumes
> > > in the core, let's expose it to users.
[]
> > > diff --git a/drivers/mtd/ubi/cdev.c b/drivers/mtd/ubi/cdev.c
[]
> > > @@ -622,6 +622,10 @@ static int verify_mkvol_req(const struct ubi_device *ubi,
> > >  	    req->vol_type != UBI_STATIC_VOLUME)
> > >  		goto bad;
> > >  
> > > +	if (req->flags & UBI_VOL_SKIP_CRC_CHECK_FLG &&
> 
> Oops, missed that req->flags & UBI_VOL_SKIP_CRC_CHECK_FLG check was
> missing parens (checkpatch --strict should complain about that).

Why should checkpatch complain?
& has higher precedence than &&.

