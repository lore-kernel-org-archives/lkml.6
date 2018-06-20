Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD85C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C222083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 05:27:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C222083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753832AbeFTF1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 01:27:38 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:53224 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeFTF1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 01:27:36 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DC17960A04C4;
        Wed, 20 Jun 2018 07:27:34 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HHFVIZd8n8qz; Wed, 20 Jun 2018 07:27:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 87B5760A04C6;
        Wed, 20 Jun 2018 07:27:34 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id F7UGeYFvQGYL; Wed, 20 Jun 2018 07:27:34 +0200 (CEST)
Received: from blindfold.localnet (089144203253.atnat0012.highway.a1.net [89.144.203.253])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 5BE1860A04C4;
        Wed, 20 Jun 2018 07:27:34 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Marek Vasut <marek.vasut@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, dinguyen@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com,
        computersforpeace@gmail.com, dwmw2@infradead.org,
        miquel.raynal@bootlin.com, boris.brezillon@bootlin.com,
        yamada.masahiro@socionext.com,
        "See, Chin Liang" <chin.liang.see@intel.com>
Subject: Re: [PATCH] arm: dts: socfpga: denali needs nand_x_clk too
Date:   Wed, 20 Jun 2018 07:27:27 +0200
Message-ID: <1846662.BtIxBD6EoV@blindfold>
In-Reply-To: <ba7b5ee8-c9f0-45a1-67ec-3d1f510f6c24@gmail.com>
References: <20180619120719.26921-1-richard@nod.at> <ba7b5ee8-c9f0-45a1-67ec-3d1f510f6c24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marek,

Am Mittwoch, 20. Juni 2018, 06:52:09 CEST schrieb Marek Vasut:
> On 06/19/2018 02:07 PM, Richard Weinberger wrote:
> > The denali NAND flash controller needs at least two clocks to operate,
> > nand_clk and nand_x_clk.
> > Since 1bb88666775e ("mtd: nand: denali: handle timing parameters by
> > setup_data_interface()") nand_x_clk is used to derive timing settings.
> > 
> > Signed-off-by: Richard Weinberger <richard@nod.at>
> > ---
> > Strictly speaking denali needs a ecc_clk too, but AFAIK such a clock
> > is not present on this SoC.
> > But my SoCFPGA knowledge is very limited.
> > 
> > Thanks,
> > //richard
> 
> It looks sane, but I cannot test it right now, since I'm on vacation.
> I hope Dinh/Chin can jump in.

The patch was tested by me. So, at least it is not completely untested.
BTW: I forgot to mention that it depends on Masahiro's Denali fixes.

Thanks,
//richard
