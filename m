Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690C5C6778D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C7920880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 15:10:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i5JAdej6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24C7920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbeILUPO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 16:15:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56030 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbeILUPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 16:15:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2cMM9MVTRNt9cwnvQWLhBo97CFIDL+v7SbTApHgMYIg=; b=i5JAdej6/CF6dVuEZJ3SRs05I
        YkW/9pnH5uug8qkEilIThCN8TMJHeNR2OKbzaZ1lb8j50YpvAUxOI/7YFQsFLptJ48QZGzSc6F4hy
        lmyt3AGutHop8V4/afp6Rr0ORahlitHko/VidYoqEaU10fhW2LdHNY1Hfm7Sq29dZWmjnhtjvk0pc
        nJ9nYIhWykwqTPkLcJo4p4qR2yhGlGC7XfUHBLr9BM0kWh6wnALG6Bzt5ecd1CqWrCHCuhJ+Yt8d1
        5s670p2ZpaHBag3d0yVvdC7j9skvuEOrXyHyvGdCmwJxXF4NOHHaLXyhkGkSa6eVfc1P5e9t0Qj04
        ipmNyj7Ww==;
Received: from [177.97.26.110] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g06mW-0003iM-RO; Wed, 12 Sep 2018 15:10:17 +0000
Date:   Wed, 12 Sep 2018 12:10:12 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Prabhakar Lad <prabhakar.csengg@gmail.com>,
        Benoit Parrot <bparrot@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hyun Kwon <hyun.kwon@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Subject: Re: [PATCH] media: Convert to using %pOFn instead of
 device_node.name
Message-ID: <20180912121012.33cc3c21@coco.lan>
In-Reply-To: <CAL_JsqKdLoH9X_ThSr45NOqijWRBJgC7eV_iCrCXf5Jhu-dpkQ@mail.gmail.com>
References: <20180828015252.28511-1-robh@kernel.org>
        <20180828015252.28511-28-robh@kernel.org>
        <2863201.EMhOTYQe29@avalon>
        <CAL_JsqKdLoH9X_ThSr45NOqijWRBJgC7eV_iCrCXf5Jhu-dpkQ@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 28 Aug 2018 07:21:46 -0500
Rob Herring <robh@kernel.org> escreveu:

> On Tue, Aug 28, 2018 at 5:06 AM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
> >
> > Hi Rob,
> >
> > Thank you for the patch.
> >
> > On Tuesday, 28 August 2018 04:52:29 EEST Rob Herring wrote:  
> > > In preparation to remove the node name pointer from struct device_node,
> > > convert printf users to use the %pOFn format specifier.
> > >
> > > Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> > > Cc: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
> > > Cc: Benoit Parrot <bparrot@ti.com>
> > > Cc: Philipp Zabel <p.zabel@pengutronix.de>
> > > Cc: Hyun Kwon <hyun.kwon@xilinx.com>
> > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Cc: Michal Simek <michal.simek@xilinx.com>
> > > Cc: linux-media@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>  
> >
> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >
> > Which tree would you like to merge this through ?  
> 
> Media tree. There's no dependency.

Ok. I'm applying it.

> 
> Rob



Thanks,
Mauro
