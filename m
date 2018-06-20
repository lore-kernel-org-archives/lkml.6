Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E81DC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19890208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19890208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932753AbeFTIlA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:41:00 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:35419 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932411AbeFTIkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:40:37 -0400
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1fVY76-0000Ln-Qu; Wed, 20 Jun 2018 10:05:12 +0200
Message-ID: <1529481910.7211.27.camel@pengutronix.de>
Subject: Re: [PATCH v1] ARM: dts: imx51-zii-rdu1: fix touchscreen pinctrl
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Nick Dyer <nick@shmanahar.org>, Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Chris Healy <cphealy@gmail.com>
Date:   Wed, 20 Jun 2018 10:05:10 +0200
In-Reply-To: <20180619220719.3200-1-nick@shmanahar.org>
References: <20180619220719.3200-1-nick@shmanahar.org>
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

Hi Nick,

Am Dienstag, den 19.06.2018, 23:07 +0100 schrieb Nick Dyer:
> The pinctrl settings were incorrect for the touchscreen interrupt line, causing
> an interrupt storm. This change has been tested with both the atmel_mxt_ts and
> RMI4 drivers on the RDU1 units.
> 
> > Signed-off-by: Nick Dyer <nick@shmanahar.org>
> ---
>  arch/arm/boot/dts/imx51-zii-rdu1.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> index df9eca94d812..4d12ba54ba15 100644
> --- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
> +++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
> @@ -770,8 +770,8 @@
>  
> >  	pinctrl_ts: tsgrp {
> >  		fsl,pins = <
> > > -			MX51_PAD_CSI1_D8__GPIO3_12		0x85
> > > -			MX51_PAD_CSI1_D9__GPIO3_13		0x85
> > > +			MX51_PAD_CSI1_D8__GPIO3_12		4
> +			MX51_PAD_CSI1_D9__GPIO3_13		(1<<16)

Please don't move away from using hex notation for the padctrl
settings.

Thanks,
Lucas
