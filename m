Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 697D4C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20EDF2086B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 08:25:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20EDF2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xs4all.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbeIJNSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 09:18:09 -0400
Received: from lb3-smtp-cloud7.xs4all.net ([194.109.24.31]:48960 "EHLO
        lb3-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727639AbeIJNSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 09:18:09 -0400
Received: from [192.168.2.10] ([212.251.195.8])
        by smtp-cloud7.xs4all.net with ESMTPA
        id zHVNf0sCPw2L8zHVQfJFVe; Mon, 10 Sep 2018 10:25:16 +0200
Subject: Re: [PATCH v2 4/4] media: cedrus: Select the sunxi SRAM driver in
 Kconfig
To:     Paul Kocialkowski <contact@paulk.fr>, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com, Randy Li <ayaka@soulik.info>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
References: <20180909191015.20902-1-contact@paulk.fr>
 <20180909191015.20902-5-contact@paulk.fr>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <16fd7291-f51b-b0bc-4299-97adbe197e54@xs4all.nl>
Date:   Mon, 10 Sep 2018 10:25:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180909191015.20902-5-contact@paulk.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfKM2pR5g4cCbyblYaFwjuh2d8m8dV9rVgIeB8Q16LgcZcVETeGvsYXPOMHJVDx6GoUdU0mZnOWHIqRH22yvpmg8asuMeq9sXEWZpA8WFCaCakLH7wREW
 r5WNrZGvdEozqFgwMzdUdzW5aoPmE8/J0kA4dx7fmiI8acvP5IW5zKhVlCU0418fEY38TSOmckAd3LPWY/YIIx6vf+OH5Sg6QqythpuYF6wiGsP8mSzuxJxS
 UHzIExDGOZR/evhWS/+p1vblQvijIAk8SIWMQSEU/X1x8g7cKyMEMObPtTAgOTCdDDpKGmmrfwfdrvLacRA3x7fniSzFTobiOTW6lXqro1qJnzd5wUkILzOk
 QqGOwiz2RIwRhoHOCamdzYH1ninjKGJV0MrBoq0SR2FyE8MVfOyDf3Nd9eKjZJGrVGf4X27Qe0JUMIBeym9OwcxBkLgRwxXGy0cUASbDctOeJIXETDGbVqq5
 pX7Tumltlu6c+JycOhJ4GzjfyGX2sC4qMZbf/WoA4cBefFa8w5ju1iOPXFt3AhgvuEZgGyhSaNM+I+iKZJc6p6JV6JgrplMeyI9Fx/OKMzZC4EGbBFqZkdGc
 hrson1nXClWO8mf7D4RC289KWb8mokuSLKB6KdloVxnvQx3bza6xjK+eSBWPznYUaqxl/Arjjkijc6/GxEZokH4ghwkAezvp4HBP9vjmpVUjUYMMSxe6iYcU
 czKtg+i5AV7kZ89iqvrWHyTTReyhpqBG6CoqTDRqsvWtVovFe4NmikFBvsncfezMJPdA6BtVU31Jju/r1Xzs1WoH4n3hGsSvyiUftcCUi5NdmRLS1Wfj1GxB
 NMh2XC1PQjReEjIuTlc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2018 09:10 PM, Paul Kocialkowski wrote:
> Since the sunxi SRAM driver is required to build the Cedrus driver,
> select it in Kconfig.
> 
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  drivers/staging/media/sunxi/cedrus/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/media/sunxi/cedrus/Kconfig b/drivers/staging/media/sunxi/cedrus/Kconfig
> index afd7d7ee0388..3b06283e4bf3 100644
> --- a/drivers/staging/media/sunxi/cedrus/Kconfig
> +++ b/drivers/staging/media/sunxi/cedrus/Kconfig
> @@ -3,6 +3,7 @@ config VIDEO_SUNXI_CEDRUS
>  	depends on VIDEO_DEV && VIDEO_V4L2 && MEDIA_CONTROLLER
>  	depends on HAS_DMA
>  	depends on OF
> +	select SUNXI_SRAM
>  	select VIDEOBUF2_DMA_CONTIG
>  	select MEDIA_REQUEST_API

I noticed this select, but CONFIG_MEDIA_REQUEST_API doesn't exist. It's
probably from an old version and I have dropped it from the patch that
added this.

No need for you to do anything.

>  	select V4L2_MEM2MEM_DEV
> 

Regards,

	Hans
