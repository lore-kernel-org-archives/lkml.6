Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 46A33C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFF0120693
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k3ljRNtm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFF0120693
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933465AbeFLHqr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:46:47 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:34733 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933183AbeFLHqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:46:45 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelnx194.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5C7joR7016854;
        Tue, 12 Jun 2018 02:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528789550;
        bh=PPfC2pz5IEKLVbg1DLCglsXK23H92gKSVmvvjUU9ugU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=k3ljRNtmICRb1hwY08qklviy2f0QYriegeHZAuQs/5q6YuOXJ4+X3DQlhZadvq9Ax
         8o2unsGFWuTheoYbYg87cBf2YUAj1MfYuVZkXnUl7b8Knf7RwCrO+GRSN0EAV3Ckyw
         70ScdkGHXejyPJgABBEG+GJ7GRigaog60SAdAPok=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5C7joXi007876;
        Tue, 12 Jun 2018 02:45:50 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 12
 Jun 2018 02:45:50 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 12 Jun 2018 02:45:50 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5C7jlJo015356;
        Tue, 12 Jun 2018 02:45:48 -0500
Subject: Re: [PATCH] ASoC: twl6040: make pointer dmic_codec_dev static
To:     Colin King <colin.king@canonical.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
        <linux-omap@vger.kernel.org>
CC:     <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180606093504.30255-1-colin.king@canonical.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <d0355575-feb2-a1fe-242a-57acf52bad1e@ti.com>
Date:   Tue, 12 Jun 2018 10:46:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180606093504.30255-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018-06-06 12:35, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The pointer dmic_codec_dev is local to the source and does not need
> to be in global scope, so make it static.
> 
> Cleans up sparse warning:
> warning: symbol 'dmic_codec_dev' was not declared. Should it be static?

can you change the subject to:
ASoC: omap-abe-twl6040: make pointer dmic_codec_dev static

With that change:
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  sound/soc/omap/omap-abe-twl6040.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/omap/omap-abe-twl6040.c b/sound/soc/omap/omap-abe-twl6040.c
> index 15ccbf479c96..d5ae9eb8c756 100644
> --- a/sound/soc/omap/omap-abe-twl6040.c
> +++ b/sound/soc/omap/omap-abe-twl6040.c
> @@ -40,7 +40,7 @@ struct abe_twl6040 {
>  	int	mclk_freq;	/* MCLK frequency speed for twl6040 */
>  };
>  
> -struct platform_device *dmic_codec_dev;
> +static struct platform_device *dmic_codec_dev;
>  
>  static int omap_abe_hw_params(struct snd_pcm_substream *substream,
>  	struct snd_pcm_hw_params *params)
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
