Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8A7C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61AA20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbfANV3L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:29:11 -0500
Received: from gateway34.websitewelcome.com ([192.185.148.109]:36220 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726809AbfANV3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:29:11 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway34.websitewelcome.com (Postfix) with ESMTP id DFE4448DB08
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 15:29:10 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id j9nCgUD2ziQerj9nCgUZhM; Mon, 14 Jan 2019 15:29:10 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=51342 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gj9nC-000nhP-1k; Mon, 14 Jan 2019 15:29:10 -0600
Subject: Re: [PATCH] mmc: core: annotate implicit fall through
To:     Mathieu Malaterre <malat@debian.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190114204211.21386-1-malat@debian.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <aec71dd2-0d4c-30dc-cfc5-3167b54e87d7@embeddedor.com>
Date:   Mon, 14 Jan 2019 15:29:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114204211.21386-1-malat@debian.org>
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
X-Exim-ID: 1gj9nC-000nhP-1k
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:51342
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 25
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/19 2:42 PM, Mathieu Malaterre wrote:
> There is a plan to build the kernel with -Wimplicit-fallthrough and
> this place in the code produced a warning (W=1).
> 
> In this particular case rewrote the comment to start with the string "fall
> through", so as to match the regular expression expected by GCC. Truncate
> the comment slightly to fit the max line length of 80 characters.
> 
> This commit remove the following warning:
> 
>    drivers/mmc/core/host.c:196:14: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Acked-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks, Mathieu.

> ---
>   drivers/mmc/core/host.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index f57f5de54206..0052d6fed7c8 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -194,7 +194,7 @@ int mmc_of_parse(struct mmc_host *host)
>   	switch (bus_width) {
>   	case 8:
>   		host->caps |= MMC_CAP_8_BIT_DATA;
> -		/* Hosts capable of 8-bit transfers can also do 4 bits */
> +		/* fall through - Hosts capable of 8-bit can also do 4 bits */
>   	case 4:
>   		host->caps |= MMC_CAP_4_BIT_DATA;
>   		break;
> 
