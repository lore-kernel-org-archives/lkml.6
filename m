Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254A0ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA57320661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 10:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA57320661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbeGTLg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 07:36:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42517 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727755AbeGTLg6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 07:36:58 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 87E3820730; Fri, 20 Jul 2018 12:49:16 +0200 (CEST)
Received: from windsurf (unknown [80.255.6.130])
        by mail.bootlin.com (Postfix) with ESMTPSA id F2C1920717;
        Fri, 20 Jul 2018 12:49:15 +0200 (CEST)
Date:   Fri, 20 Jul 2018 12:49:15 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Evan Wang <xswang@marvell.com>
Subject: Re: linux-next: manual merge of the pci tree with Linus' tree
Message-ID: <20180720124915.47ead719@windsurf>
In-Reply-To: <20180720091553.GA23214@red-moon>
References: <20180720110310.6d07e86e@canb.auug.org.au>
        <20180720091553.GA23214@red-moon>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, 20 Jul 2018 10:15:53 +0100, Lorenzo Pieralisi wrote:

> >   		switch (resource_type(res)) {
> >   		case IORESOURCE_IO:
> > - 			advk_pcie_set_ob_win(pcie, 1,
> > - 					     upper_32_bits(res->start),
> > - 					     lower_32_bits(res->start),
> > - 					     0,	0xF8000000, 0,
> > - 					     lower_32_bits(res->start),
> > - 					     OB_PCIE_IO);
> >  -			err = pci_remap_iospace(res, iobase);
> >  +			err = devm_pci_remap_iospace(dev, res, iobase);
> >   			if (err) {
> >   				dev_warn(dev, "error %d: failed to map resource %pR\n",
> >   					 err, res);  
> 
> Hi Stephen,
> 
> thanks for fixing this up, the fix looks fine to me (Thomas please
> confirm), if it is I would ask Bjorn please to send it upstream when the
> time for the PCI pull request comes.

I confirm that the fix looks good to me. Thanks Stephen for fixing it
up.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
