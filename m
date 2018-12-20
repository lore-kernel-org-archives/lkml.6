Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1E18C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E727217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 11:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545306241;
	bh=2+9PEL8XoQkd6aKSID064UknhUqf2jk739VsyIll1yE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fSv1AND0ejGFNZVur2qfVbNPA+MSx5XEwlN4NyRQGwo/aTBps5hWg9cePAYsEzF8D
	 woHeq+Ta62U2x68U6Q0ojzvJKRGD7VI4vNWyxxr/OIWvlVpFP5TZhDh32rSzAdFLwY
	 y5gCn6vGr/8pGbRtTwzF+Gvdxq7AIZOfKtCmiV4c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbeLTLoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 06:44:00 -0500
Received: from casper.infradead.org ([85.118.1.10]:42426 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbeLTLoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 06:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2VRR382a8PxcCCOQMxdwOCpzI+Vr/u2FSWqqkIlkEi0=; b=pmqthJOuiDgI0XCoqURow4TjQT
        O/E2Kfuzni7iWNFJzDU1o4XRJM2ua/DoA8Rk0lyH59xAiATipEziS247mQtAP1BWGoHbTWs1Sk5w9
        TvmcpIsaUh320sVb1Q2LtfwFYfkHVlyzntDqne2LKqhWYlSeB70l9FFbyjUZKJ77zZ4BvyHP8rxha
        Pl5feBfVfUSu4uZgqVgsugH4prHY/R04Qupn/k4xcCqi3NlGWW1xlmZaH4WjHdKYpd6ygqadUsVsH
        BUEk5FWNdAxnCmqCO3auO0WLwF+6ksISX70GyzBrUT0KDW/QtDlk0uC8Drx6qz3xQFFfDZZmgsED4
        TOcoAtAw==;
Received: from [191.33.191.108] (helo=coco.lan)
        by casper.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gZwk3-0006P0-HL; Thu, 20 Dec 2018 11:43:52 +0000
Date:   Thu, 20 Dec 2018 09:43:46 -0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Tree for Dec 11
Message-ID: <20181220094337.36d9aed3@coco.lan>
In-Reply-To: <20181219144423.089e46b9@canb.auug.org.au>
References: <20181211182627.42b79e40@canb.auug.org.au>
        <20181211173851.GA29028@roeck-us.net>
        <20181211180437.GA28010@flashbox>
        <20181212093632.774c0603@canb.auug.org.au>
        <20181219144423.089e46b9@canb.auug.org.au>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 19 Dec 2018 14:44:23 +1100
Stephen Rothwell <sfr@canb.auug.org.au> escreveu:

> Hi all,
> 
> On Wed, 12 Dec 2018 09:36:32 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Tue, 11 Dec 2018 11:04:37 -0700 Nathan Chancellor <natechancellor@gmail.com> wrote:  
> > >
> > > On Tue, Dec 11, 2018 at 09:38:51AM -0800, Guenter Roeck wrote:    
> > > > Build results:
> > > > 	total: 152 pass: 150 fail: 2
> > > > Failed builds: 
> > > > 	arm:allmodconfig 
> > > > 	arm64:allmodconfig 
> > > > Qemu test results:
> > > > 	total: 337 pass: 137 fail: 200
> > > > 
> > > > Build failures:
> > > > 
> > > > arm:
> > > > 
> > > > In file included from drivers/media/pci/ddbridge/ddbridge.h:22:0,
> > > >                  from drivers/media/pci/ddbridge/ddbridge-ci.c:19:
> > > > arch/arm/include/asm/irq.h:35:50: error: unknown type name 'cpumask_t'
> > > >       
> > > 
> > > Just FYI, I noticed this one yesterday on next-20181210 and sent a patch:
> > > https://lore.kernel.org/linux-media/20181210233514.3069-1-natechancellor@gmail.com/    
> > 
> > I have added that patch after the v4l-dvb tree for today.  
> 
> I am still applying that patch ...

Sorry for taking so long with that. Patch applied, thanks!

Thanks,
Mauro
