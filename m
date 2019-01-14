Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63CFC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A0B20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfANVXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:23:05 -0500
Received: from gateway22.websitewelcome.com ([192.185.47.179]:36891 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726777AbfANVXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:23:04 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 990FE38364
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 15:13:36 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id j9Y8gEKpNYTGMj9Y8gyXTj; Mon, 14 Jan 2019 15:13:36 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=50908 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gj9Y8-000fQM-5F; Mon, 14 Jan 2019 15:13:36 -0600
Subject: Re: [PATCH] drm/dp: annotate implicit fall throughs
To:     Mathieu Malaterre <malat@debian.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20190114202748.15584-1-malat@debian.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <1d2a0c58-2419-9c43-b0d6-a8c1b387c240@embeddedor.com>
Date:   Mon, 14 Jan 2019 15:13:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114202748.15584-1-malat@debian.org>
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
X-Exim-ID: 1gj9Y8-000fQM-5F
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:50908
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 17
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/19 2:27 PM, Mathieu Malaterre wrote:
> There is a plan to build the kernel with -Wimplicit-fallthrough and
> these places in the code produced warnings (W=1). Fix them up.
> 
> This commit remove the following warnings:
> 
>    include/linux/compiler.h:77:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    include/asm-generic/bug.h:134:2: note: in expansion of macro 'unlikely'
>    drivers/gpu/drm/drm_dp_helper.c:155:3: note: in expansion of macro 'WARN'
>    include/linux/compiler.h:77:22: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    include/asm-generic/bug.h:134:2: note: in expansion of macro 'unlikely'
>    drivers/gpu/drm/drm_dp_helper.c:173:3: note: in expansion of macro 'WARN'
>    drivers/gpu/drm/drm_dp_helper.c:547:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
Acked-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

> ---
>   drivers/gpu/drm/drm_dp_helper.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
> index 516e82d0ed50..26835d174939 100644
> --- a/drivers/gpu/drm/drm_dp_helper.c
> +++ b/drivers/gpu/drm/drm_dp_helper.c
> @@ -154,6 +154,7 @@ u8 drm_dp_link_rate_to_bw_code(int link_rate)
>   	default:
>   		WARN(1, "unknown DP link rate %d, using %x\n", link_rate,
>   		     DP_LINK_BW_1_62);
> +		/* fall through */
>   	case 162000:
>   		return DP_LINK_BW_1_62;
>   	case 270000:
> @@ -171,6 +172,7 @@ int drm_dp_bw_code_to_link_rate(u8 link_bw)
>   	switch (link_bw) {
>   	default:
>   		WARN(1, "unknown DP link BW code %x, using 162000\n", link_bw);
> +		/* fall through */
>   	case DP_LINK_BW_1_62:
>   		return 162000;
>   	case DP_LINK_BW_2_7:
> @@ -552,6 +554,7 @@ int drm_dp_downstream_max_bpc(const u8 dpcd[DP_RECEIVER_CAP_SIZE],
>   		case DP_DS_16BPC:
>   			return 16;
>   		}
> +		/* fall through */
>   	default:
>   		return 0;
>   	}
> 
