Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B68DC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:05:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5228020873
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbfANVFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:05:05 -0500
Received: from gateway20.websitewelcome.com ([192.185.44.20]:23003 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726899AbfANVE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:04:59 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 6ED4F400F2233
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 15:04:58 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id j9Pmg19iE4FKpj9PmgRUDP; Mon, 14 Jan 2019 15:04:58 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=50864 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gj9Pl-000agy-Q1; Mon, 14 Jan 2019 15:04:58 -0600
Subject: Re: [PATCH] lib/siphash.c:: annotate implicit fall throughs
To:     Mathieu Malaterre <malat@debian.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
References: <20190114201911.13725-1-malat@debian.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <481e4a45-29fb-7546-74c7-f23f61f9dc4c@embeddedor.com>
Date:   Mon, 14 Jan 2019 15:04:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114201911.13725-1-malat@debian.org>
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
X-Exim-ID: 1gj9Pl-000agy-Q1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:50864
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/19 2:19 PM, Mathieu Malaterre wrote:
> There is a plan to build the kernel with -Wimplicit-fallthrough and
> these places in the code produced warnings (W=1). Fix them up.
> 
> This commit remove the following warnings:
> 
>    lib/siphash.c:71:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    lib/siphash.c:72:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    lib/siphash.c:73:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    lib/siphash.c:75:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    lib/siphash.c:434:12: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>


Acked-by: Gustavo A. R. Silva <gustavo@embeddedor.com>


> ---
>   lib/siphash.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/lib/siphash.c b/lib/siphash.c
> index 3ae58b4edad6..b95624f5aa34 100644
> --- a/lib/siphash.c
> +++ b/lib/siphash.c
> @@ -69,10 +69,14 @@ u64 __siphash_aligned(const void *data, size_t len, const siphash_key_t *key)
>   #else
>   	switch (left) {
>   	case 7: b |= ((u64)end[6]) << 48;
> +		/* fall through */
>   	case 6: b |= ((u64)end[5]) << 40;
> +		/* fall through */
>   	case 5: b |= ((u64)end[4]) << 32;
> +		/* fall through */
>   	case 4: b |= le32_to_cpup(data); break;
>   	case 3: b |= ((u64)end[2]) << 16;
> +		/* fall through */
>   	case 2: b |= le16_to_cpup(data); break;
>   	case 1: b |= end[0];
>   	}
> @@ -432,6 +436,7 @@ u32 __hsiphash_aligned(const void *data, size_t len, const hsiphash_key_t *key)
>   	}
>   	switch (left) {
>   	case 3: b |= ((u32)end[2]) << 16;
> +		/* fall through */
>   	case 2: b |= le16_to_cpup(data); break;
>   	case 1: b |= end[0];
>   	}
> 
