Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8156BC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E76A20827
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E76A20827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbeJ2SWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:22:12 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:64317
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729467AbeJ2SWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:22:12 -0400
X-IronPort-AV: E=Sophos;i="5.54,439,1534802400"; 
   d="scan'208";a="283652620"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Oct 2018 10:34:08 +0100
Date:   Mon, 29 Oct 2018 10:34:00 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Liviu Dudau <liviu.dudau@arm.com>
cc:     kernel-janitors@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] ARM: vexpress/spc: constify clk_ops structure
In-Reply-To: <20181029091756.GA1167@e110455-lin.cambridge.arm.com>
Message-ID: <alpine.DEB.2.20.1810291033270.3755@hadrien>
References: <1540619262-22681-1-git-send-email-Julia.Lawall@lip6.fr> <1540619262-22681-3-git-send-email-Julia.Lawall@lip6.fr> <20181029091756.GA1167@e110455-lin.cambridge.arm.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1340634172-1540805640=:3755"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--8323329-1340634172-1540805640=:3755
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 29 Oct 2018, Liviu Dudau wrote:

> On Sat, Oct 27, 2018 at 07:47:36AM +0200, Julia Lawall wrote:
> > The clk_ops structure is only stored in the ops field of a
> > clk_init_data structure.  This field is const, so the clk_ops
> > structure can be const as well.
> >
> > Identified and transformed using Coccinelle.
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> Acked-by: Liviu Dudau <liviu.dudau@arm.com>
>
> Are you going to send the series to the arm-soc maintainers directly or
> you want us to cherry-pick this patch into the Versatile tree?

Please do with it whatever seems best.

Thanks,
julia

>
> Best regards,
> Liviu
>
> >
> > ---
> >  arch/arm/mach-vexpress/spc.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/mach-vexpress/spc.c b/arch/arm/mach-vexpress/spc.c
> > index 0f5381d13494..611f22de48cb 100644
> > --- a/arch/arm/mach-vexpress/spc.c
> > +++ b/arch/arm/mach-vexpress/spc.c
> > @@ -521,7 +521,7 @@ static int spc_set_rate(struct clk_hw *hw, unsigned long rate,
> >  	return ve_spc_set_performance(spc->cluster, rate / 1000);
> >  }
> >
> > -static struct clk_ops clk_spc_ops = {
> > +static const struct clk_ops clk_spc_ops = {
> >  	.recalc_rate = spc_recalc_rate,
> >  	.round_rate = spc_round_rate,
> >  	.set_rate = spc_set_rate,
> >
>
> --
> ====================
> | I would like to |
> | fix the world,  |
> | but they're not |
> | giving me the   |
>  \ source code!  /
>   ---------------
>     ¯\_(ツ)_/¯
>
--8323329-1340634172-1540805640=:3755--
