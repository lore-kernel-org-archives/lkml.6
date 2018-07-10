Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC23BC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:17:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9140D208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9140D208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933331AbeGJMR3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:17:29 -0400
Received: from mail.bootlin.com ([62.4.15.54]:34491 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933275AbeGJMR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:17:27 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 662EC20875; Tue, 10 Jul 2018 14:17:26 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-12-56.w90-88.abo.wanadoo.fr [90.88.133.56])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2D7AA2079F;
        Tue, 10 Jul 2018 14:17:16 +0200 (CEST)
Date:   Tue, 10 Jul 2018 14:17:15 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     "Bean Huo (beanhuo)" <beanhuo@micron.com>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Subject: Re: [PATCH v6 0/6] mtd: rawnand: support MT29F1G08ABAFAWP-ITE:F
Message-ID: <20180710141715.375ac6df@bbrezillon>
In-Reply-To: <60a09008ea18424eb4005839554da858@SIWEX5A.sing.micron.com>
References: <60a09008ea18424eb4005839554da858@SIWEX5A.sing.micron.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2018 11:40:08 +0000
"Bean Huo (beanhuo)" <beanhuo@micron.com> wrote:

> Hi,  Boris
> >>
> >> Okay, I think we already had this discussion, but I'm asking it again.
> >> What are the possible values for that field and what do they mean?  
> >
> >Still, it's not clear to me what "Internal ECC level" means. It seems that NAND
> >chips having on-die ECC have this field set to 10b (0x2), 00b seems to be
> >reserved for "no on-die ECC", but what are 01b and 11b reserved for?
> >  
> 
> That position identifies the part as having Internal ECC capability.  
> The 01b and 11b are reserved for future definition.  Bit 7 of READ ID Byte 4 identifies the
> device as an ECC OFF 0x0 or ECC ON 0x1.
> 
> >> Also, is it even used to encode the fact that the NAND has on-die ECC
> >> on all your NANDs? We already had the problem of incompatible ID
> >> schemes, so I wouldn't be surprised if that was the case here, hence
> >> my initial suggestion to base the detection on the model name.  
> >
> >I'd really need to have an answer on that one to take a decision. Also, I
> >couldn't find a datasheet for an IT (without E) version of the
> >MT29F1G08ABAFAWP part. Does it exist, or can we assume
> >MT29F1G08ABAFAWP chips always come with forcibly enabled on-die ECC?  
> 
> MT29F1G08ABAFAWP comes in ECC ON only.  We didn’t develop a
> MT29F1G08ABAFAWP ECC OFF version.  Bit 7 of READ ID Byte 4 identifies the
> device as an ECC OFF 0x0 or ECC ON 0x1.
> 

Okay. Can you have a look at the patches I sent an let me know if I do
the right thing?
