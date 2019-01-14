Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7D1C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67C38214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbfANVHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:07:18 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.122]:15094 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726777AbfANVHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:07:17 -0500
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway32.websitewelcome.com (Postfix) with ESMTP id E8FC24E924
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 15:07:16 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id j9S0g1CZK4FKpj9S0gRX3R; Mon, 14 Jan 2019 15:07:16 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=50882 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gj9S0-000bzK-El; Mon, 14 Jan 2019 15:07:16 -0600
Subject: Re: [PATCH] lib/cmdline.c:: annotate implicit fall throughs
To:     Mathieu Malaterre <malat@debian.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20190114202143.14130-1-malat@debian.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <5f05caf6-836e-bc2b-cd2b-009ed1073a5b@embeddedor.com>
Date:   Mon, 14 Jan 2019 15:07:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114202143.14130-1-malat@debian.org>
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
X-Exim-ID: 1gj9S0-000bzK-El
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:50882
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/19 2:21 PM, Mathieu Malaterre wrote:
> There is a plan to build the kernel with -Wimplicit-fallthrough and
> these places in the code produced warnings (W=1). Fix them up.
> 
> This commit remove the following warnings:
> 
>    lib/cmdline.c:137:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    lib/cmdline.c:140:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    lib/cmdline.c:143:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    lib/cmdline.c:146:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
>    lib/cmdline.c:149:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Acked-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

> ---
>   lib/cmdline.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/lib/cmdline.c b/lib/cmdline.c
> index 171c19b6888e..dc59d6216318 100644
> --- a/lib/cmdline.c
> +++ b/lib/cmdline.c
> @@ -135,18 +135,23 @@ unsigned long long memparse(const char *ptr, char **retptr)
>   	case 'E':
>   	case 'e':
>   		ret <<= 10;
> +		/* fall through */
>   	case 'P':
>   	case 'p':
>   		ret <<= 10;
> +		/* fall through */
>   	case 'T':
>   	case 't':
>   		ret <<= 10;
> +		/* fall through */
>   	case 'G':
>   	case 'g':
>   		ret <<= 10;
> +		/* fall through */
>   	case 'M':
>   	case 'm':
>   		ret <<= 10;
> +		/* fall through */
>   	case 'K':
>   	case 'k':
>   		ret <<= 10;
> 
