Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 198E4C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C729B218A6
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 16:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548521683;
	bh=U97JhAc67TlIoQxUSKMiEuA/BMeDSBdzpp3PIvkto18=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=QRVlm4SopKasoGAv65zgYqTiBhByB9hc9bQ0p4fhTSiJgDFIh3zUSZxvAXfUlqzrN
	 zVViFhqNRyGFspiSONX/v2Ww8gBcWjAfxxo0Lhg2r/doOq5CaTylUlf/erpn3OzMxo
	 LRN8KcvxVUqPu/qc25NIaZ5gglkFUMaQzVNtgXHs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbfAZQym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 11:54:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:43172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfAZQyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 11:54:41 -0500
Received: from bbrezillon (unknown [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66E9621872;
        Sat, 26 Jan 2019 16:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548521681;
        bh=U97JhAc67TlIoQxUSKMiEuA/BMeDSBdzpp3PIvkto18=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DGeHc5v5OwpsLrtBKuw5LKAZtnbOM1h3gUlVB+JpQVIoI9ZFI388RiN1YZs2GYCUc
         NH1xt5YrV0NkoLod8XeOTNgAUbQM66STTm60psyzC9xptsRDww83fVfCdNNjACkiOa
         k87uIPS9qbh24NlaJ9ZDpSTWSCC5Bxu3pFRuRvlo=
Date:   Sat, 26 Jan 2019 17:54:29 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mtd: rawnand: mark expected switch fall-throughs
Message-ID: <20190126175429.65e6bfd8@bbrezillon>
In-Reply-To: <853a267c-807b-c613-6662-93730a0b4c33@embeddedor.com>
References: <20190125210950.GA27855@embeddedor>
        <20190126105208.221a2051@bbrezillon>
        <853a267c-807b-c613-6662-93730a0b4c33@embeddedor.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Jan 2019 07:48:50 -0600
"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:

> Hey Boris,
> 
> On 1/26/19 3:52 AM, Boris Brezillon wrote:
> > On Fri, 25 Jan 2019 15:09:50 -0600
> > "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
> >   
> >> diff --git a/drivers/mtd/nand/raw/nandsim.c b/drivers/mtd/nand/raw/nandsim.c
> >> index 933d1a629c51..d33e15dc4cdc 100644
> >> --- a/drivers/mtd/nand/raw/nandsim.c
> >> +++ b/drivers/mtd/nand/raw/nandsim.c
> >> @@ -2251,9 +2251,10 @@ static int __init ns_init_module(void)
> >>  
> >>  	switch (bbt) {
> >>  	case 2:
> >> -		 chip->bbt_options |= NAND_BBT_NO_OOB;
> >> +		chip->bbt_options |= NAND_BBT_NO_OOB;
> >> +		/* fall through */
> >>  	case 1:
> >> -		 chip->bbt_options |= NAND_BBT_USE_FLASH;
> >> +		chip->bbt_options |= NAND_BBT_USE_FLASH;  
> > 
> > You miss a '/* fall through */' here.
> >   
> 
> Not really.  Notice that in this case the code falls through
> to a break statement.

Still find it weird to mandate fall through comments in all cases but
this one...

> 
> >>  	case 0:
> >>  		break;
> >>  	default:  
> 
> Thanks
> --
> Gustavo
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

