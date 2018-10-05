Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A915DC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622BD20875
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:11:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 622BD20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbeJETJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:09:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42037 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727558AbeJETJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:09:27 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C37EC2074F; Fri,  5 Oct 2018 14:10:57 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-28-153.w90-88.abo.wanadoo.fr [90.88.148.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 51D6320701;
        Fri,  5 Oct 2018 14:10:57 +0200 (CEST)
Date:   Fri, 5 Oct 2018 14:10:57 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v10 10/10] mtd: maps: gpio-addr-flash: Add support for
 device-tree devices
Message-ID: <20181005141057.0f1b0a9b@bbrezillon>
In-Reply-To: <CAPybu_0TbeN+-F6zwN8XOMuY1EpgE6GRi=ExDx6O3Yun9kXjYQ@mail.gmail.com>
References: <20181004142942.11887-1-ricardo.ribalda@gmail.com>
        <20181004142942.11887-2-ricardo.ribalda@gmail.com>
        <20181005002125.12fd229f@bbrezillon>
        <CAPybu_26HST5xGfhE6MoVTRZok_gfDqN=ZOAesuEMVskdrCpLA@mail.gmail.com>
        <20181005090811.6b7e9957@bbrezillon>
        <CAPybu_38xH2Cv+eONQmEJ1i6k=oiQM=WrcwOFR29LbtRvWfKXA@mail.gmail.com>
        <20181005103730.57d52e3c@bbrezillon>
        <CAPybu_1RMcro3xLNW5mbybYdObCTq=QwXgk+RT6hcmRGTh6s7A@mail.gmail.com>
        <20181005121235.7e64b64a@bbrezillon>
        <CAPybu_0TbeN+-F6zwN8XOMuY1EpgE6GRi=ExDx6O3Yun9kXjYQ@mail.gmail.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Oct 2018 14:04:52 +0200
Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:

> Hi Boris
> On Fri, Oct 5, 2018 at 12:12 PM Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> >
> > On Fri, 5 Oct 2018 11:54:18 +0200
> > Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> wrote:
> >  
> > > Hi Boris
> > >
> > > Just seen that  you already did the rebase at
> > > https://github.com/bbrezillon/linux-0day/commits/mtd/physmap-cleanup
> > >
> > > Thanks for that.
> > >
> > > I am about to test it in real hw (unless you want me wait)  
> >
> > Sure, go ahead and test it.
> >
> > Thanks,
> >
> > Boris  
> I had to change this on your patchset to have it working on hw:
> https://pastebin.com/78A7yhJ9
> 
> If you send the patchset to the mailing list I can review it patch by patch.
> 
> Also
> mtd: maps: Prepare merging of physmap and physmap_of
> 
> I do not think that can be bisected. (Not sure, I have to test it)

Okay, I'll have a look.

> 
> I add the diff to the mail, but gmail will probably scramble the
> lines(yes I know I have to use other mail client)

The diff looks good, I'll fix that an send a push a new version.

Thanks,

Boris
