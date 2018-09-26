Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EC9C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D0DD2082C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="u9ArkGJo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D0DD2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbeIZPWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:22:47 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:53560 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbeIZPWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:22:46 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8Q9Adc1006729;
        Wed, 26 Sep 2018 04:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1537953039;
        bh=MmDKsYoJcYv9orrIv2Lw2qehsP483MhGgH59Lsg5lbY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=u9ArkGJojcs0uuvDIYzBo3BvyYg0ZLF3dgYQFbGb+B3Il1O7uAS3OdmnYiikLNVpU
         7CRFqXRbnr4rrQT7DZuUyDkmeuMLHUxzjxph2wQ34yBJufEVthlG6GRCmNAqli2dhm
         bTHGpEprhHgxUHYrovRWUXg5Ezz/HgkqSQbyR9c8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8Q9AdSL002172;
        Wed, 26 Sep 2018 04:10:39 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 26
 Sep 2018 04:10:39 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 26 Sep 2018 04:10:39 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8Q9AatS000904;
        Wed, 26 Sep 2018 04:10:37 -0500
Subject: Re: [PATCH -next] drm/omap: remove set but not used variable
 'frame_height'
To:     YueHaibing <yuehaibing@huawei.com>,
        David Airlie <airlied@linux.ie>,
        "Andrew F. Davis" <afd@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sre@kernel.org>,
        Benoit Parrot <bparrot@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
CC:     <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <1536667253-5792-1-git-send-email-yuehaibing@huawei.com>
From:   Tomi Valkeinen <tomi.valkeinen@ti.com>
Message-ID: <6825cc17-dc77-4aec-852d-28a1a06c2881@ti.com>
Date:   Wed, 26 Sep 2018 12:10:36 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536667253-5792-1-git-send-email-yuehaibing@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/18 15:00, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/omapdrm/dss/dispc.c: In function 'dispc_ovl_setup_common':
> drivers/gpu/drm/omapdrm/dss/dispc.c:2627:19: warning:
>  variable 'frame_height' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/omapdrm/dss/dispc.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/omapdrm/dss/dispc.c b/drivers/gpu/drm/omapdrm/dss/dispc.c
> index e61a959..7c23f23 100644
> --- a/drivers/gpu/drm/omapdrm/dss/dispc.c
> +++ b/drivers/gpu/drm/omapdrm/dss/dispc.c
> @@ -2624,7 +2624,7 @@ static int dispc_ovl_setup_common(struct dispc_device *dispc,
>  	unsigned int offset0, offset1;
>  	s32 row_inc;
>  	s32 pix_inc;
> -	u16 frame_width, frame_height;
> +	u16 frame_width;
>  	unsigned int field_offset = 0;
>  	u16 in_height = height;
>  	u16 in_width = width;
> @@ -2714,13 +2714,10 @@ static int dispc_ovl_setup_common(struct dispc_device *dispc,
>  	row_inc = 0;
>  	pix_inc = 0;
>  
> -	if (plane == OMAP_DSS_WB) {
> +	if (plane == OMAP_DSS_WB)
>  		frame_width = out_width;
> -		frame_height = out_height;
> -	} else {
> +	else
>  		frame_width = in_width;
> -		frame_height = height;
> -	}
>  
>  	calc_offset(screen_width, frame_width,
>  			fourcc, fieldmode, field_offset,
> 
> 
> 

Thanks, applied.

 Tomi

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
