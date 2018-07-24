Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D723C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 878F020880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 19:59:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 878F020880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388652AbeGXVHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:07:52 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44487 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388466AbeGXVHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:07:52 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 783CA207AB; Tue, 24 Jul 2018 21:59:47 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2EF4B206F3;
        Tue, 24 Jul 2018 21:59:47 +0200 (CEST)
Date:   Tue, 24 Jul 2018 21:59:47 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Brian Norris <computersforpeace@gmail.com>
Cc:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, linux-mtd@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Boris BREZILLON <boris.brezillon@free-electrons.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        NeilBrown <neil@brown.name>
Subject: Re: [PATCHv3 2/2] mtd: m25p80: restore the status of SPI flash when
 exiting
Message-ID: <20180724215947.150373be@bbrezillon>
In-Reply-To: <20180724195202.GB190016@ban.mtv.corp.google.com>
References: <20171206025342.7266-1-Zhiqiang.Hou@nxp.com>
        <20171206025342.7266-3-Zhiqiang.Hou@nxp.com>
        <20180723181350.GA58212@ban.mtv.corp.google.com>
        <20180723221002.736e0830@bbrezillon>
        <CAN8TOE904WXMScHo1b2jhusz-L8eGBK=gzUUX079ZVfiFk+HoQ@mail.gmail.com>
        <20180724011811.40165a35@bbrezillon>
        <20180724195202.GB190016@ban.mtv.corp.google.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Jul 2018 12:52:02 -0700
Brian Norris <computersforpeace@gmail.com> wrote:

> > > Or even better: put this hack behind a DT flag, so that one has to
> > > admit that their board design is broken before it will even do
> > > anything. Proposal: "linux,badly-designed-flash-reset".  
> > 
> > I think we can remove the "linux," prefix. If it's badly designed, it
> > applies to all OSes, don't you think?  
> 
> Sure.
> 
> Shall I send a patch?

Yep.
