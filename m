Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB96EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78FB920659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 08:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfANIzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 03:55:18 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59733 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfANIzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 03:55:18 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1giy1Z-0006X4-IU; Mon, 14 Jan 2019 09:55:13 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1giy1Y-0005af-SZ; Mon, 14 Jan 2019 09:55:12 +0100
Date:   Mon, 14 Jan 2019 09:55:12 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: imx: Fix undefined symbol
Message-ID: <20190114085512.uq3triamuufzknql@pengutronix.de>
References: <20190114081558.GA7897@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190114081558.GA7897@embeddedor>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 02:15:58AM -0600, Gustavo A. R. Silva wrote:
> Fix the following compile error:
> 
> drivers/pwm/pwm-imx27.c:292:25: error: 'imx_pwm_dt_ids' undeclared
> here (not in a function); did you mean 'pwm_imx27_dt_ids'?
> 
> Fixes: 5a309d380019 ("pwm: imx: Split into two drivers")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/pwm/pwm-imx27.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pwm/pwm-imx27.c b/drivers/pwm/pwm-imx27.c
> index 8997c4c1bd03..55666cca4cee 100644
> --- a/drivers/pwm/pwm-imx27.c
> +++ b/drivers/pwm/pwm-imx27.c
> @@ -289,7 +289,7 @@ static const struct of_device_id pwm_imx27_dt_ids[] = {
>  	{ .compatible = "fsl,imx27-pwm", },
>  	{ /* sentinel */ }
>  };
> -MODULE_DEVICE_TABLE(of, imx_pwm_dt_ids);
> +MODULE_DEVICE_TABLE(of, pwm_imx27_dt_ids);

The patch is fine, you're at least the fourth person noticing this
problem (but the first to send an applicable patch). So if Thierry
doesn't want to squash the fix into the offending commit (which I would
prefer to not break bisecability), taking this one is the next best
option.

If so:
Acked-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Best regards and thanks,
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
