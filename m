Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B74FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE52D2077C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 12:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE52D2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeJJT1e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:27:34 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53005 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbeJJT1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:27:34 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1gADFD-000075-OT; Wed, 10 Oct 2018 14:05:39 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1gADFD-0007No-8H; Wed, 10 Oct 2018 14:05:39 +0200
Date:   Wed, 10 Oct 2018 14:05:39 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: max98988: add I2C dependency
Message-ID: <20181010120539.ija2n7chqrtx2fdh@pengutronix.de>
References: <20181010083758.2874864-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181010083758.2874864-1-arnd@arndb.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 14:01:13 up 20 days, 15 min, 25 users,  load average: 0.06, 0.03,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 18-10-10 10:37, Arnd Bergmann wrote:
> max98988 only builds with I2C support enabled, otherwise we get a build error:
> 
> sound/soc/codecs/max98088.c:1789:1: error: data definition has no type or storage class [-Werror]
>  module_i2c_driver(max98088_i2c_driver);
>  ^~~~~~~~~~~~~~~~~
> sound/soc/codecs/max98088.c:1789:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
> sound/soc/codecs/max98088.c:1789:1: error: parameter names (without types) in function declaration [-Werror]
> sound/soc/codecs/max98088.c:1780:26: error: 'max98088_i2c_driver' defined but not used [-Werror=unused-variable]
> 
> Fixes: 24ae67c58250 ("ASoC: max98988: make it selectable")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for covering the issue.

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>

Regrads,
Marco

> ---
>  sound/soc/codecs/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 3c6bd6019b92..774d38310875 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -641,6 +641,7 @@ config SND_SOC_LM49453
>  
>  config SND_SOC_MAX98088
>  	tristate "Maxim MAX98088/9 Low-Power, Stereo Audio Codec"
> +	depends on I2C
>  
>  config SND_SOC_MAX98090
>         tristate
> -- 
> 2.18.0
> 
> 
