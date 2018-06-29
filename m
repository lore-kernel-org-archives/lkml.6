Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBBDC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A68B27B3A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 08:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A68B27B3A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966254AbeF2I4E (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 04:56:04 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51339 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966135AbeF2I4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 04:56:02 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fYpCB-0002wi-6k; Fri, 29 Jun 2018 10:55:59 +0200
Message-ID: <1530262555.22468.63.camel@pengutronix.de>
Subject: Re: [PATCH v1] ARM: dts: imx51-zii-rdu1: correct touchscreen axis
 inversion
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Nick Dyer <nick@shmanahar.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Chris Healy <cphealy@gmail.com>
Date:   Fri, 29 Jun 2018 10:55:55 +0200
In-Reply-To: <20180628225626.26203-1-nick@shmanahar.org>
References: <20180628225626.26203-1-nick@shmanahar.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, den 28.06.2018, 23:56 +0100 schrieb Nick Dyer:
> The RMI4 touchscreen driver applied inversion and axis swap in the
> wrong order, violating the DT binding for those properties. This was fixed in
> 645a397, so correct the RDU1 DT to apply the inversion to the
> correct axis.
> 
> Tested on Zii RDU1 00-5105-30 rev B
> 
> Signed-off-by: Nick Dyer <nick@shmanahar.org>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  arch/arm/boot/dts/imx51-zii-rdu1.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> index 68f5c1d5ecd0..b1d83fb08150 100644
> --- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
> +++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> @@ -553,7 +553,7 @@
>  
> >  		rmi4-f11@11 {
> >  			reg = <0x11>;
> > -			touchscreen-inverted-y;
> > +			touchscreen-inverted-x;
> >  			touchscreen-swapped-x-y;
> >  			syna,sensor-type = <1>;
> >  		};
