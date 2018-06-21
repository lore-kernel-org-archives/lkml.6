Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2361EC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37EB20846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VV1eWXs6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C37EB20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933196AbeFUKyT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:54:19 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42164 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754359AbeFUKxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:53:36 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20180621105333euoutp02ece74ff1653d85a91c262b958d45fe68~6J3aEDSdH0695306953euoutp02k
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 10:53:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20180621105333euoutp02ece74ff1653d85a91c262b958d45fe68~6J3aEDSdH0695306953euoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1529578413;
        bh=5kBzIvkTsPEw+hEp0zS+PUTi/qysHZz8EhyYoblemiQ=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=VV1eWXs6mrs95R9p7eseRa/FoSqXQ8v2+Guue890JSMTwf2fPopo041I1+cyfK3Gl
         kFOLS90qqQ4KwMPXeD3u1z0sHUHWg0tG4VAtIzhobYgsEZVPmSX7qh8L5PX0RPThoF
         IQZbmsRj2d0i2vnNxXZWp/gnmZ57NzTBbf58fHT8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180621105331eucas1p2459727bc27eecb7ac318cba998afb179~6J3YdJYR83238332383eucas1p2Q;
        Thu, 21 Jun 2018 10:53:31 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 0E.47.05700.AA38B2B5; Thu, 21
        Jun 2018 11:53:30 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180621105329eucas1p2b6eeacae41ec8a3468c5126214dde228~6J3WB-Iyl0596805968eucas1p2C;
        Thu, 21 Jun 2018 10:53:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20180621105328eusmtrp1d9a6b0ce7336959c2716d518a3a431e0~6J3VBkGi01737117371eusmtrp11;
        Thu, 21 Jun 2018 10:53:28 +0000 (GMT)
X-AuditID: cbfec7f2-5ffe19c000011644-5e-5b2b83aadcaf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 5E.77.04183.7A38B2B5; Thu, 21
        Jun 2018 11:53:27 +0100 (BST)
Received: from [106.120.43.17] (unknown [106.120.43.17]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20180621105327eusmtip28afa8020005a0e3bd5d72556ad99c3ec~6J3UohhJ80573605736eusmtip2n;
        Thu, 21 Jun 2018 10:53:27 +0000 (GMT)
Subject: Re: [PATCH] drm/bridge/sii8620: fix display of packed pixel modes
 in MHL2
To:     Maciej Purski <m.purski@samsung.com>,
        dri-devel@lists.freedesktop.org
Cc:     Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
From:   Andrzej Hajda <a.hajda@samsung.com>
Date:   Thu, 21 Jun 2018 12:53:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1516706239-9104-1-git-send-email-m.purski@samsung.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7djPc7qrmrWjDS5fVLDoPXeSyaKp4y2r
        xcYZ61ktrnx9z2bROXEJu8XlXXPYLBa8vMVisfbIXXYHDo/Lfb1MHrM7ZrJ6bP/2gNXjfvdx
        Jo++LasYPT5vkgtgi+KySUnNySxLLdK3S+DKOPrlA2NBN3/F6oMaDYztPF2MnBwSAiYSH+9M
        Z+5i5OIQEljBKPH6xW8mkISQwBdGia07tCESn4ESix+wwXQ0XHvEApFYzihx5m0DlPOWUeLj
        3jnsIFXCAiESt1vXsHYxcnCICHhKnDxVDhJmFuhgklj9sw7EZhPQlPi7+SbYUBYBVYkrD76w
        gNiiAhESGyd8YgaxeQUEJU7OfAIW5xRwkWjbfZIZYo68xPa3c6BscYlbT+YzgdwgIbCPXWLb
        p4lsEM1lElu2dLJDXO0isXTpa6gPhCVeHd8CFZeROD25hwXCrpdomnmFGWJQB6PEicXLoRqs
        JQ4fvwj2DDPQ1et36YOYEgKOEitmskGYfBI33gpCnMMnMWkbKERBwrwSHW1CEDMUJe6f3coM
        YYtLLL3wlW0Co9IsJE/OQvLYLCSPzUJYu4CRZRWjeGppcW56arFhXmq5XnFibnFpXrpecn7u
        JkZgQjr97/inHYxfLyUdYhTgYFTi4b0RphUtxJpYVlyZe4hRgoNZSYT3nIl2tBBvSmJlVWpR
        fnxRaU5q8SFGaQ4WJXHeOI26KCGB9MSS1OzU1ILUIpgsEwenVAOjRNk81kC37Xq3t7lE1T0y
        ZzBi3xux1nB2V9u+b81Z4j9s/mvY7Chf+jT76dUELZaun7O/OfUUbv9TeCjcjNPhvkL+v7TX
        pw0ZfFhkFQP0o/rq7pW87i78k6s1a6EV30ofvoIjbotPn1jfkOzFkPio4PCzNT2+c2N6NjeE
        2D/J3v8tSq/iVJ8SS3FGoqEWc1FxIgAbEjOyRAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xe7rLm7WjDdZPsbToPXeSyaKp4y2r
        xcYZ61ktrnx9z2bROXEJu8XlXXPYLBa8vMVisfbIXXYHDo/Lfb1MHrM7ZrJ6bP/2gNXjfvdx
        Jo++LasYPT5vkgtgi9KzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0No+1MjJV0rezSUnN
        ySxLLdK3S9DLOPrlA2NBN3/F6oMaDYztPF2MnBwSAiYSDdcesYDYQgJLGSUuPcuFiItL7J7/
        lhnCFpb4c62LrYuRC6jmNaPEjx0b2EASwgIhEvtWzmXsYuTgEBHwlDh5qhykhlmgi0li7+t3
        7BAN0xklnu49zgjSwCagKfF3802wZl4BO4mmS4vANrAIqEpcefAF7ApRgQiJpnlr2CFqBCVO
        znwCFucUcJFo230SrJ5ZQF3iz7xLULa8xPa3c6BscYlbT+YzTWAUmoWkfRaSlllIWmYhaVnA
        yLKKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMA63Hfu5ZQdj17vgQ4wCHIxKPLw3wrSihVgT
        y4orcw8xSnAwK4nwnjPRjhbiTUmsrEotyo8vKs1JLT7EaAr03ERmKdHkfGCKyCuJNzQ1NLew
        NDQ3Njc2s1AS5z1vUBklJJCeWJKanZpakFoE08fEwSnVwNibypkcNmmR0I6m7LZ5Sdc2xZyb
        vmNWau3KsnRWK67zPVKT1h/ztHX8qnhaRHvXubPnE3lzUiNE1/3b2SE7uTPS1itt9sV/nlYy
        r1v7HRfte68da/JG0Hry51DHIt/ZHes4frtXXL3qI3uEc9+7RrX9hlI7hT99ZtEIK8yezLpk
        3mpTtsVvFJRYijMSDbWYi4oTAZUmJmrZAgAA
Message-Id: <20180621105329eucas1p2b6eeacae41ec8a3468c5126214dde228~6J3WB-Iyl0596805968eucas1p2C@eucas1p2.samsung.com>
X-CMS-MailID: 20180621105329eucas1p2b6eeacae41ec8a3468c5126214dde228
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20180123111735eucas1p167f4aef33d1aea781a892f5245ac1567
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180123111735eucas1p167f4aef33d1aea781a892f5245ac1567
References: <CGME20180123111735eucas1p167f4aef33d1aea781a892f5245ac1567@eucas1p1.samsung.com>
        <1516706239-9104-1-git-send-email-m.purski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.01.2018 12:17, Maciej Purski wrote:
> Currently packed pixel modes in MHL2 can't be displayed. The device
> automatically recognizes output format, so setting format other than
> RGB causes failure. Fix it by writing proper values to registers.
>
> Tested on MHL1 and MHL2 using various vendors' dongles both in
> DVI and HDMI mode.
>
> Signed-off-by: Maciej Purski <m.purski@samsung.com>

Another missed one, queued to drm-misc-fixes.

--
Regards
Andrzej

> ---
>  drivers/gpu/drm/bridge/sil-sii8620.c | 17 +----------------
>  1 file changed, 1 insertion(+), 16 deletions(-)
>
> diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
> index 1718c2e..e13708d 100644
> --- a/drivers/gpu/drm/bridge/sil-sii8620.c
> +++ b/drivers/gpu/drm/bridge/sil-sii8620.c
> @@ -1005,20 +1005,11 @@ static void sii8620_stop_video(struct sii8620 *ctx)
>  
>  static void sii8620_set_format(struct sii8620 *ctx)
>  {
> -	u8 out_fmt;
> -
>  	if (sii8620_is_mhl3(ctx)) {
>  		sii8620_setbits(ctx, REG_M3_P0CTRL,
>  				BIT_M3_P0CTRL_MHL3_P0_PIXEL_MODE_PACKED,
>  				ctx->use_packed_pixel ? ~0 : 0);
>  	} else {
> -		if (ctx->use_packed_pixel)
> -			sii8620_write_seq_static(ctx,
> -				REG_VID_MODE, BIT_VID_MODE_M1080P,
> -				REG_MHL_TOP_CTL, BIT_MHL_TOP_CTL_MHL_PP_SEL | 1,
> -				REG_MHLTX_CTL6, 0x60
> -			);
> -		else
>  			sii8620_write_seq_static(ctx,
>  				REG_VID_MODE, 0,
>  				REG_MHL_TOP_CTL, 1,
> @@ -1026,15 +1017,9 @@ static void sii8620_set_format(struct sii8620 *ctx)
>  			);
>  	}
>  
> -	if (ctx->use_packed_pixel)
> -		out_fmt = VAL_TPI_FORMAT(YCBCR422, FULL) |
> -			BIT_TPI_OUTPUT_CSCMODE709;
> -	else
> -		out_fmt = VAL_TPI_FORMAT(RGB, FULL);
> -
>  	sii8620_write_seq(ctx,
>  		REG_TPI_INPUT, VAL_TPI_FORMAT(RGB, FULL),
> -		REG_TPI_OUTPUT, out_fmt,
> +		REG_TPI_OUTPUT, VAL_TPI_FORMAT(RGB, FULL),
>  	);
>  }
>  


