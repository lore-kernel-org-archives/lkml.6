Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310ABC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092C62186A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbeLTMeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:34:13 -0500
Received: from mail.bootlin.com ([62.4.15.54]:60642 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731119AbeLTMeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:34:12 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B7DB5207CF; Thu, 20 Dec 2018 13:34:09 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8784D2072C;
        Thu, 20 Dec 2018 13:33:59 +0100 (CET)
Date:   Thu, 20 Dec 2018 13:33:59 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     =?utf-8?B?Vm9rw6HEjQ==?= Michal <Michal.Vokac@ysoft.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] video: ssd1307fb: Do not hard code active-low
 reset sequence
Message-ID: <20181220123359.GF2188@piout.net>
References: <1545308005-51559-1-git-send-email-michal.vokac@ysoft.com>
 <1545308005-51559-3-git-send-email-michal.vokac@ysoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1545308005-51559-3-git-send-email-michal.vokac@ysoft.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2018 12:13:55+0000, Vokáč Michal wrote:
> The SSD130x OLED display reset signal is active low. Now the reset
> sequence is implemented in such a way that users are forced to
> define reset-gpios as GPIO_ACTIVE_HIGH in DT to make the reset work.
> 
> Do not hard code the active-low sequence into the driver but instead
> allow the user to specify the gpio as GPIO_ACTIVE_LOW to reflect
> the real world.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> Changes from v1:
>  - Add R-by from Rob
> 
>  drivers/video/fbdev/ssd1307fb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
> index 4061a20..3b361bc 100644
> --- a/drivers/video/fbdev/ssd1307fb.c
> +++ b/drivers/video/fbdev/ssd1307fb.c
> @@ -667,10 +667,10 @@ static int ssd1307fb_probe(struct i2c_client *client,
>  
>  	if (par->reset) {
>  		/* Reset the screen */
> -		gpiod_set_value_cansleep(par->reset, 0);
> -		udelay(4);
>  		gpiod_set_value_cansleep(par->reset, 1);
>  		udelay(4);
> +		gpiod_set_value_cansleep(par->reset, 0);
> +		udelay(4);
>  	}
>  
>  	if (par->vbat_reg) {
> -- 
> 2.1.4
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
