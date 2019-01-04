Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AFEC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7B0B206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 11:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbfADLOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 06:14:54 -0500
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:46264 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726970AbfADLOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 06:14:54 -0500
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x04BEjqi007248;
        Fri, 4 Jan 2019 05:14:45 -0600
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0a-001ae601.pphosted.com with ESMTP id 2pp7777ph0-1;
        Fri, 04 Jan 2019 05:14:44 -0600
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id 9795F611C8AC;
        Fri,  4 Jan 2019 05:17:47 -0600 (CST)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Fri, 4 Jan 2019
 11:14:44 +0000
Received: from imbe.wolfsonmicro.main (imbe.wolfsonmicro.main [198.61.95.81])
        by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id x04BEhPS014993; Fri,
 4 Jan 2019 11:14:43 GMT
Date:   Fri, 4 Jan 2019 11:14:43 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
CC:     <mazziesaccount@gmail.com>, <mikko.mutanen@fi.rohmeurope.com>,
        <heikki.haikola@fi.rohmeurope.com>, <broonie@kernel.org>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
        <linux-kernel@vger.kernel.org>, <geert@linux-m68k.org>
Subject: Re: [PATCH] regmap: regmap-irq: Make irq-type callbak optional
Message-ID: <20190104111443.GS16508@imbe.wolfsonmicro.main>
References: <20190104103115.GA10043@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190104103115.GA10043@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-12-10)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=440 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1901040101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 12:31:15PM +0200, Matti Vaittinen wrote:
> Do not register type setting callback if HW does not support
> setting the irq type. IRQ core can then handle cases where
> type setting is not supported and no regmap-irq specific handling
> is required.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  drivers/base/regmap/regmap-irq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
> index d2d0014b0d23..a387ee499b5c 100644
> --- a/drivers/base/regmap/regmap-irq.c
> +++ b/drivers/base/regmap/regmap-irq.c
> @@ -322,7 +322,6 @@ static const struct irq_chip regmap_irq_chip = {
>  	.irq_bus_sync_unlock	= regmap_irq_sync_unlock,
>  	.irq_disable		= regmap_irq_disable,
>  	.irq_enable		= regmap_irq_enable,
> -	.irq_set_type		= regmap_irq_set_type,
>  	.irq_set_wake		= regmap_irq_set_wake,
>  };
>  
> @@ -560,6 +559,9 @@ int regmap_add_irq_chip(struct regmap *map, int irq, int irq_flags,
>  	d->chip = chip;
>  	d->irq_base = irq_base;
>  
> +	if (num_type_reg)
> +		d->irq_chip.irq_set_type = regmap_irq_set_type;
> +
>  	if (chip->irq_reg_stride)
>  		d->irq_reg_stride = chip->irq_reg_stride;
>  	else

Afraid this also causes regressions at my end, still having a bit
of a look but it looks like some how this prevents properties of the
IRQ getting passed along which causes my system to not probe
properly with:

genirq: Flags mismatch irq 58. 00002088 (cs35l35) vs. 00002088 (cs35l35)
cs35l35 0-0041: Failed to request IRQ: -16

Thanks,
Charles

> -- 
> 2.14.3
> 
> 
> -- 
> Matti Vaittinen
> ROHM Semiconductors
> 
> ~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
