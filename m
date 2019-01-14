Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342EAC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0580620657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:50:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbfANVup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:50:45 -0500
Received: from gateway33.websitewelcome.com ([192.185.146.85]:13279 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726782AbfANVun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:50:43 -0500
Received: from cm11.websitewelcome.com (cm11.websitewelcome.com [100.42.49.5])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id 27CBD16D257
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 15:50:42 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id jA82gccpIdnCejA82ghQgw; Mon, 14 Jan 2019 15:50:42 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=52134 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gjA81-000ykJ-Nh; Mon, 14 Jan 2019 15:50:41 -0600
Subject: Re: [PATCH] video: offb: annotate implicit fall throughs
To:     Mathieu Malaterre <malat@debian.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190114204044.20528-1-malat@debian.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <15854ad8-7bd5-ede7-6ce4-00122d6ba279@embeddedor.com>
Date:   Mon, 14 Jan 2019 15:50:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114204044.20528-1-malat@debian.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.130.205
X-Source-L: No
X-Exim-ID: 1gjA81-000ykJ-Nh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:52134
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 34
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/19 2:40 PM, Mathieu Malaterre wrote:
> There is a plan to build the kernel with -Wimplicit-fallthrough and
> these places in the code produced warnings (W=1). Fix them up.
> 
> This commit remove the following warnings:
> 
>    drivers/video/fbdev/offb.c:211:5: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    drivers/video/fbdev/offb.c:142:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Acked-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks
--
Gustavo

> ---
>   drivers/video/fbdev/offb.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
> index 31f769d67195..e0f0c5351306 100644
> --- a/drivers/video/fbdev/offb.c
> +++ b/drivers/video/fbdev/offb.c
> @@ -141,6 +141,7 @@ static int offb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
>   		/* Clear PALETTE_ACCESS_CNTL in DAC_CNTL */
>   		out_le32(par->cmap_adr + 0x58,
>   			 in_le32(par->cmap_adr + 0x58) & ~0x20);
> +		/* fall through */
>   	case cmap_r128:
>   		/* Set palette index & data */
>   		out_8(par->cmap_adr + 0xb0, regno);
> @@ -210,6 +211,7 @@ static int offb_blank(int blank, struct fb_info *info)
>   				/* Clear PALETTE_ACCESS_CNTL in DAC_CNTL */
>   				out_le32(par->cmap_adr + 0x58,
>   					 in_le32(par->cmap_adr + 0x58) & ~0x20);
> +				/* fall through */
>   			case cmap_r128:
>   				/* Set palette index & data */
>   				out_8(par->cmap_adr + 0xb0, i);
> 
