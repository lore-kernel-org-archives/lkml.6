Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0A5C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01A5204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 18:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="O2DFiIxw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01A5204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388533AbeGXTr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 15:47:26 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:55756 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388402AbeGXTrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 15:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b2DMiG7A1PEfaMO2MlXffqU3T24jRQKQMFIngw/MW68=; b=O2DFiIxw1+F7747U/Wdmsvlk6
        RSFGJIS+83hdMIIs986EVbSh1ZbWYiV0LbBIA6mDYvU05DRtP+HPi1AtB9R8BdUQXI5cMr6oN1M5N
        kGbUHQ4en4QS+OoLUzmaU8Wox5xntmRCHPAiPDGXoGdLJ1Sfbza2vHoOjeHVUxzF5hU37hMwPP1fX
        fqDsrDVeKazIOryDmULbTUFtcUXiltW7hMK9vR7o3qz1uVuACi0xUs6JORER+3SQmFGgpl9kyvTKG
        IomPZfEmJNA9uBfNHYVLBs07/M2wbaBcvCrbvJRfSVMBjbA3D/xUg+HM58P1MWyR4Dq2iryLdzULZ
        xL9ys2amw==;
Received: from 177.41.135.13.dynamic.adsl.gvt.net.br ([177.41.135.13] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fi2Db-0005Lg-A0; Tue, 24 Jul 2018 18:39:31 +0000
Date:   Tue, 24 Jul 2018 15:39:23 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Staging subsystem List <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] media: staging: omap4iss: Include asm/cacheflush.h
 after generic includes
Message-ID: <20180724153923.0f1b9f56@coco.lan>
In-Reply-To: <CA+55aFyV=5QNJXn+t_ZDCigGi+HjM6N94DRb_E50_xUsk+VTFA@mail.gmail.com>
References: <1532381973-11856-1-git-send-email-linux@roeck-us.net>
        <20180724004110.37d0e5dc@coco.lan>
        <CA+55aFyV=5QNJXn+t_ZDCigGi+HjM6N94DRb_E50_xUsk+VTFA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 24 Jul 2018 10:37:56 -0700
Linus Torvalds <torvalds@linux-foundation.org> escreveu:

> On Mon, Jul 23, 2018 at 8:41 PM Mauro Carvalho Chehab
> <mchehab+samsung@kernel.org> wrote:
> >
> > While I won't be against merging it, IMHO a better fix would be to
> > add the includes asm/cacheflush.h needs inside it, e. g. something
> > like adding:  
> 
> No. The <asm/*> includes really should come after <linux/*>.
> 
> This is a media driver bug, plain and simple.

Works for me. Do you intend to apply it directly? Otherwise I'll
add on my tree - and likely send you during the merge window - this is
just Kconfig random COMPILE_TEST build noise, as this driver
is ARM-only (for an OMAP4 specific IP block). So, probably not worth
sending a pull request just due to that.

> We should strive to avoid adding more header includes, it's one of the
> major causes of kernel build slowdown.

Yeah, some time ago mailing lists got flooded with some janitorial's
patchset adding includes (some claiming to be needed on some archs or
under some random Kconfigs)... Compile-test ended by adding more such
stuff (for a good reason, IMHO). I wonder if are there a better way to
handle includes without slowing builds.

Thanks,
Mauro
