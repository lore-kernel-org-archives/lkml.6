Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6430EC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E2B2077C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E2B2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbeJHXAw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:00:52 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:46999 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJHXAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:00:52 -0400
Received: from [192.168.178.69] ([109.104.43.45]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MFbFW-1fudFT1018-00H8Qd; Mon, 08 Oct 2018 17:48:05 +0200
Received: from [192.168.178.69] ([109.104.43.45]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MFbFW-1fudFT1018-00H8Qd; Mon, 08 Oct 2018 17:48:05 +0200
Subject: Re: [PATCH] staging: bcm2835-camera: remove extraneous setting of
 dev->colourfx.enable
To:     Colin King <colin.king@canonical.com>,
        Eric Anholt <eric@anholt.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        Dave Stevenson <dave.stevenson@raspberrypi.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181008145012.31312-1-colin.king@canonical.com>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Message-ID: <d753df4f-e812-c366-0b1d-9ff804da0ab5@i2se.com>
Date:   Mon, 8 Oct 2018 17:48:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181008145012.31312-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:/KPLSaJ0XuU0E4jjgisYTC5q9VIHWN+hNrpVGCmNw3kk7w/t7lx
 iqfc38VH9dFWzVyfeQ7YF4+r2dCfFHJlqzHiY/fz0KHeDSMvHJ5f50xENb4aYu3eDrR6CTy
 dM5/qLLxrWULBAPCBPouT79uHwpeQaT9xKeRSP3tgt0To9IaXjnARBGaGB23QvuBl9jKCnI
 8ZcRcynoZuCnI2PeXSHtQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:gIzu1McW1vw=:6sJZFzIqLoyM/0PpypX6TX
 2p3Dg2BQl2SBFF1NIJdsicPyNXTlj28y8nNHHuS7yRepHzfAUePkapm3/TGz5ddDUb8wuPGjK
 7xXaGrHZ5d05lx/6UZgPHfqcRBUbboNBN6odmo/Ta81pN/LjA4YpVJZOBAuRuOLpjP+AG8Mxu
 J/Vto9y18/0SbavlbuhfEPcyUvoNhuZ1jdt4U4dG8EyzjQidUPs9wLNe8Y04wy6mjiJJFdk3i
 qmZUZfRdfKR0/G+ogpAjEff1nne7a0clFLyGqTRWNS0JeKvXrM+/Y+S4dTVcAM18sPhSuV/Uy
 ZWyl3efL5M37rhEtxwkcNYqRiZBQtsYPAv+ly1HVfluiTNvQyASzbTzW6EjA6CX/RF6JEpqEm
 prlmDET4vOJi9f1rjTBcTKqA+IMwVrh/S3DGiWnRIksBib6cNP6JYxmCAdwZf6d2Qb0ICezDl
 scLiyNhTQwNUFfVD8top6rqMHJNZr8qOdqci7DEaZLEFW+dlo6qK7nxWF+0uPOKthS6cHv+dy
 qfLwMANZMszK5yEeXp74LfWtLbjT3trFBHFZ2BX7WqlUg/ZGE3DOzArYWroE6Pu7YIC6GT6a9
 pApoGgoLzbstY4ayI2B765j3lhkdo+j084OPkhbyjLi1p6tiLHqJMTfrhMVpKYl3LuYwbPeIm
 yCMnIblBuIM9eM/JsHNWYNUrwyxUb0pmpso8RT5pKMplV9LrGZYOthSPiZWGYkoMboKCEm3Z+
 0a2okkb6Liqjij6k
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

Am 08.10.2018 um 16:50 schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently dev->colourfx.enable is being set twice, hence the first
> occurrance is redundant and can be removed, so remove it. This minor
> issue was introduced by commit 7b3ad5abf027 ("staging: Import the
> BCM2835 MMAL-based V4L2 camera driver.").
>
> Detected by CoverityScan CID#1419711 ("Unused value")
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/vc04_services/bcm2835-camera/controls.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/controls.c b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> index a2c55cb2192a..99831dd4365d 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/controls.c
> +++ b/drivers/staging/vc04_services/bcm2835-camera/controls.c
> @@ -588,7 +588,6 @@ static int ctrl_set_colfx(struct bm2835_mmal_dev *dev,
>  
>  	control = &dev->component[MMAL_COMPONENT_CAMERA]->control;
>  
> -	dev->colourfx.enable = (ctrl->val & 0xff00) >> 8;
>  	dev->colourfx.enable = ctrl->val & 0xff;
>  
>  	ret = vchiq_mmal_port_parameter_set(dev->instance, control,

as long as the current behavior is correct, i'm okay with this patch.
But the byte masking looks suspicious, so i hope Dave can clarify that.

Thanks Stefan
