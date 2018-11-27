Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC032C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E59208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 18:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cAr2ZtGr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98E59208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730722AbeK1Fxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 00:53:47 -0500
Received: from casper.infradead.org ([85.118.1.10]:59898 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726445AbeK1Fxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 00:53:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OW+Cblqm1Hd66bjTTIY0lTY8R8whJWvkFXct5ge9zhA=; b=cAr2ZtGr2EeftMIn/+t36KJWoH
        l+nZUXlOCTjMq3OO5+7m3W1vs/PvqSN3yif8GXYZky5tlusIDeCMcTMR2QMOC5pD5yiybbZvF1Q8h
        f153duPmuiQfwQ0b+fMFPBpDAQ5M8ikJonT00ZNAsDx/O80Vn6YS1/bHgawFwcCPzfkG4D49KfmDM
        ILp4r4/lTPXlDKMGsx4vZ+ILk10+SRq7tLjXXnuU8F2za2KBDyP936Kd8dR0l2ncJUeiwtG98IWYw
        YW+VH4frhRGnz9271fh4OZevdorQlBpt4H6Zne6L00/42/9KdbijbU4oZ8NRDzyLX48IbOleJYXI3
        QbgRpCtw==;
Received: from 177.17.130.159.dynamic.adsl.gvt.net.br ([177.17.130.159] helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRiVY-0005K1-Ot; Tue, 27 Nov 2018 18:54:53 +0000
Date:   Tue, 27 Nov 2018 16:54:47 -0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-media@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCHv18 01/35] Documentation: v4l: document request API
Message-ID: <20181127165447.6e421cd7@coco.lan>
In-Reply-To: <alpine.DEB.2.21.1811231343490.2603@nanos.tec.linutronix.de>
References: <20180814142047.93856-1-hverkuil@xs4all.nl>
        <20180814142047.93856-2-hverkuil@xs4all.nl>
        <alpine.DEB.2.21.1811121048400.14703@nanos.tec.linutronix.de>
        <20181118115215.5ebc681c@coco.lan>
        <20181123075157.077758c0@coco.lan>
        <alpine.DEB.2.21.1811231134100.2603@nanos.tec.linutronix.de>
        <20181123102908.2ec61ce4@coco.lan>
        <alpine.DEB.2.21.1811231343490.2603@nanos.tec.linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 23 Nov 2018 13:44:24 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> escreveu:

> On Fri, 23 Nov 2018, Mauro Carvalho Chehab wrote:
> > Ok, I'll use then the enclosed patch, replacing them by a free
> > form license info, adding a TODO at the end, as a reminder.  
> 
> LGTM. Thanks for fixing this.

Thanks for reviewing it.

Added to my fixes branch. I'll push upstream later this week.

Thanks,
Mauro
