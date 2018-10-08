Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7C6C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:00:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BA302085B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 19:00:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ro0Ma40J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BA302085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbeJICNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:13:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43242 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727375AbeJICNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:13:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=dGMHdm1H7bwMq0qw5mBgi6DHe3UQS2TVRqkoOgq0AF8=; b=ro0Ma40JY6ZucjpTYc6WLMJN5
        15OpcPm8kdVtsnrdGQ9fPiC26hI5pgdKvuco1UkPcLJve6S8RwhKd7EQahfyOZ+e+w1V5tnN3+cei
        6u5z/b66GcVK2K/AlWeK+gP4jwq9Ol/ZMxDODIq8C/+6PCzP9yAJ3mBGt1o2SQrcaMAWHqFzcAINp
        ITGb2VMF9E6qFPDBiBwBmS5I9sDiqO0/zeLPNubH6Rdb2OCL382jsQGafQzcZILoR/iCYqBx1IRMv
        eDjF9JbtlHMcZPJD18PTSHzQGQMgXH172/K7nhZZpeRLJdb+HtBrzEp4bS2JVqE1HG/89QMqOw9xz
        sqP2CwmDg==;
Received: from [179.183.98.126] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9ale-0006dF-F2; Mon, 08 Oct 2018 19:00:34 +0000
Date:   Mon, 8 Oct 2018 16:00:29 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, tfiga@chromium.org,
        jcliang@chromium.org, shik@chromium.org
Subject: Re: [PATCH] media: vivid: Support 480p for webcam capture
Message-ID: <20181008160029.1bd1f5a8@coco.lan>
In-Reply-To: <931ca67d-3ac6-afc1-f933-c9733d561767@xs4all.nl>
References: <20181003070656.193854-1-keiichiw@chromium.org>
        <b2dc51d7-fc92-2e7b-3a07-55a076b95d8b@ideasonboard.com>
        <20181008140302.2239633f@coco.lan>
        <00b0a8af-b7a5-cb49-0684-0fd0efefa196@xs4all.nl>
        <20181008152348.7ef6d77e@coco.lan>
        <931ca67d-3ac6-afc1-f933-c9733d561767@xs4all.nl>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 8 Oct 2018 20:31:10 +0200
Hans Verkuil <hverkuil@xs4all.nl> escreveu:

> > (gdb) list *vivid_fillbuff+0x1e9b
> > 0x1936b is in vivid_fillbuff (drivers/media/platform/vivid/vivid-kthread-cap.c:495).
> > 490					ms % 1000,
> > 491					buf->vb.sequence,
> > 492					(dev->field_cap == V4L2_FIELD_ALTERNATE) ?
> > 493						(buf->vb.field == V4L2_FIELD_TOP ?
> > 494						 " top" : " bottom") : "");
> > 495			tpg_gen_text(tpg, basep, line++ * line_height, 16, str);
> > 496		}
> > 497		if (dev->osd_mode == 0) {
> > 498			snprintf(str, sizeof(str), " %dx%d, input %d ",
> > 499					dev->src_rect.width, dev->src_rect.height, dev->input);
> >   
> 
> There is a bug with hflip handling in that function. Nothing to do with the
> resolution. I could reproduce it by just checking the hflip control.
> I'll investigate.

Ah! Well, as I said, I got it only once last week while trying to use
vivid for some event racing test. I didn't have time to actually
seek. On that time, the bug only manifested when I changed the frame
rate.

Thanks,
Mauro
