Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966403AbeEYL1n (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 07:27:43 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37459 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966232AbeEYL1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 07:27:41 -0400
X-Google-Smtp-Source: ADUXVKK72d7x4V4U56yI+Mk0CRUUbgnfr65W1SzJVk4SIFUJvuG1Bcm5SjOrnbcxEEiegHALBVA2Kg==
Subject: Re: [PATCH] ath6kl: mark expected switch fall-throughs
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180524231322.GA22704@embeddedor.com>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <060f93a0-7210-79b6-37a7-cd8900719d40@cogentembedded.com>
Date: Fri, 25 May 2018 14:27:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180524231322.GA22704@embeddedor.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 5/25/2018 2:13 AM, Gustavo A. R. Silva wrote:

> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>   drivers/net/wireless/ath/ath6kl/cfg80211.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath6kl/cfg80211.c b/drivers/net/wireless/ath/ath6kl/cfg80211.c
> index 2ba8cf3..29e32cd 100644
> --- a/drivers/net/wireless/ath/ath6kl/cfg80211.c
> +++ b/drivers/net/wireless/ath/ath6kl/cfg80211.c
> @@ -3898,17 +3898,17 @@ int ath6kl_cfg80211_init(struct ath6kl *ar)
>   	wiphy->max_scan_ie_len = 1000; /* FIX: what is correct limit? */
>   	switch (ar->hw.cap) {
>   	case WMI_11AN_CAP:
> -		ht = true;
> +		ht = true; /* fall through */
>   	case WMI_11A_CAP:
>   		band_5gig = true;
>   		break;
>   	case WMI_11GN_CAP:
> -		ht = true;
> +		ht = true; /* fall through */
>   	case WMI_11G_CAP:
>   		band_2gig = true;
>   		break;
>   	case WMI_11AGN_CAP:
> -		ht = true;
> +		ht = true; /* fall through */
>   	case WMI_11AG_CAP:
>   		band_2gig = true;
>   		band_5gig = true;

    Hm, typically such comments are done on a line of their own, have never 
seen this style...

MBR, Sergei
