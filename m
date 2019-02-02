Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123A7C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C890421736
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 13:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549114268;
	bh=1gY2hOeLHhSzQ5G894my2ziGlBHN6TYeMJr5fQWQMg4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=XyOUYGwpb7/k87JkyL9eyFqp5rIdCLHNBAAEu++VMmRWCP0bZ40HSajINibbs2Grh
	 KPX8cCunGy3B3E2Aa0MkcE7WzxH1870QpT3KAaShULaz4OlhWOhohmiUfiqb/ubaxE
	 G6RNarXWskRi2OsQIg3ZzHdVDcGfrDoHg1gGT+kQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbfBBNbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 08:31:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:42282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727961AbfBBNbG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 08:31:06 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7188320869;
        Sat,  2 Feb 2019 13:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549114265;
        bh=1gY2hOeLHhSzQ5G894my2ziGlBHN6TYeMJr5fQWQMg4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GhmfSMSFU83ARO6wJmCvItpVnqdbGiZmxSzmVotq2qAG87o2Z8m/J5f2yvi8+C3Kz
         tqr6dkqHJ9JQd1Njq5XTNPBnAbGyQp2B4TWC0TSiB3vaNNpLaSj6oaol4i31hMcNuZ
         Ycar7kFJCA6WwkirF5nNUcEc7Mnzf0Iuxd7CC83U=
Date:   Sat, 2 Feb 2019 14:30:54 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <alexandre.belloni@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <Cyrille.Pitchen@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <robh+dt@kernel.org>, <linux-spi@vger.kernel.org>,
        <Ludovic.Desroches@microchip.com>, <broonie@kernel.org>,
        <linux-mtd@lists.infradead.org>, <bugalski.piotr@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 13/13] spi: atmel-quadspi: add support for sam9x60
 qspi controller
Message-ID: <20190202143054.4db7c465@bbrezillon>
In-Reply-To: <57d4d4b2-e765-1255-0b89-a4fd61f6c1e0@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
        <20190202040653.1217-14-tudor.ambarus@microchip.com>
        <20190202082910.0e60a757@bbrezillon>
        <57d4d4b2-e765-1255-0b89-a4fd61f6c1e0@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Feb 2019 08:58:25 +0000
<Tudor.Ambarus@microchip.com> wrote:

> >> @@ -117,6 +120,7 @@
> >>  #define QSPI_IFR_CRM                    BIT(14)
> >>  #define QSPI_IFR_NBDUM_MASK             GENMASK(20, 16)
> >>  #define QSPI_IFR_NBDUM(n)               (((n) << 16) & QSPI_IFR_NBDUM_MASK)
> >> +#define QSPI_IFR_APBTFRTYP_READ		BIT(24)  
> > 
> > Maybe add a comment saying it's only available on SAM9X60 or prefix it
> > with SAM9X60.  
> 
> I'll add a comment. The macro name is more generic how it is now and can be used
> by future versions of the IP. Hypothetically speaking, if we rename it to
> QSPI_IFR_SAM9x60_TFSFR_READ and other sam9x will come out, then I'll have to
> rename this macro again, to make it more generic.	

Okay.


> >> +static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
> >> +			      const struct spi_mem_op *op,
> >> +			      struct atmel_qspi_cfg *cfg)
> >> +{
> >> +	void __iomem *base = aq->regs;
> >> +	int ret;
> >> +
> >> +	/* Set the QSPI controller in Serial Memory Mode */
> >> +	if (aq->smm != QSPI_MR_SMM) {
> >> +		writel_relaxed(QSPI_MR_SMM, base + QSPI_MR);  
> > 
> > 					    aq->reqs +
> > 
> > and you can get rid of base.  
> 
> I will wait your reasons on this, see 3/13

ad->regs is only dereferenced once in this function, so there's even
less reasons to add a local var. 
