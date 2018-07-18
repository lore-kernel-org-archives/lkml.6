Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB672ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88C5720850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 21:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C5720850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbeGRWVg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:21:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:41732 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbeGRWVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:21:36 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B519A20731; Wed, 18 Jul 2018 23:41:45 +0200 (CEST)
Received: from xps13 (unknown [91.224.148.103])
        by mail.bootlin.com (Postfix) with ESMTPSA id 23899206ED;
        Wed, 18 Jul 2018 23:41:44 +0200 (CEST)
Date:   Wed, 18 Jul 2018 23:41:44 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Abhishek Sahu <absahu@codeaurora.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, Andy Gross <andy.gross@linaro.org>
Subject: Re: [PATCH 4/5] mtd: rawnand: qcom: update BBT related flags
Message-ID: <20180718234144.158217f2@xps13>
In-Reply-To: <20180718233637.49a39751@bbrezillon>
References: <1530863519-5564-1-git-send-email-absahu@codeaurora.org>
        <1530863519-5564-5-git-send-email-absahu@codeaurora.org>
        <20180718231526.38046099@xps13>
        <20180718233637.49a39751@bbrezillon>
Organization: Bootlin
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

Boris Brezillon <boris.brezillon@bootlin.com> wrote on Wed, 18 Jul 2018
23:36:37 +0200:

> On Wed, 18 Jul 2018 23:15:26 +0200
> Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> 
> > Hi Abhishek,
> > 
> > Abhishek Sahu <absahu@codeaurora.org> wrote on Fri,  6 Jul 2018
> > 13:21:58 +0530:
> >   
> > > Remove the NAND_SKIP_BBTSCAN to use RAM based BBT.    
> > 
> > Unless I am understanding it the wrong way, NAND_SKIP_BBTSCAN will skip
> > the scan of the on-chip BBT and will scan every block to construct a
> > RAM, based BBT thanks to the BBM.
> > 
> > So flash based BBT is already unused and removing this flag is a
> > mistake, right?  
> 
> ->scan_bbt() is also taking care of building the in-RAM BBT based on  
> BBM when no on-flash BBT is provided, so I think it's the right thing
> to do.

Oh right. Then doing so is harmless.

Thanks for the clarification.
Miquèl
