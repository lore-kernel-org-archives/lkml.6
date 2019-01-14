Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DE5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16F72064C
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfANVPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:15:36 -0500
Received: from gateway23.websitewelcome.com ([192.185.50.250]:25465 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726777AbfANVPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:15:35 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway23.websitewelcome.com (Postfix) with ESMTP id A27CA3BD50
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 15:15:34 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id j9a2gKtGj2qH7j9a2gyec3; Mon, 14 Jan 2019 15:15:34 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=50914 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gj9a2-000gNf-8a; Mon, 14 Jan 2019 15:15:34 -0600
Subject: Re: [PATCH] capabilities:: annotate implicit fall through
To:     Mathieu Malaterre <malat@debian.org>,
        Serge Hallyn <serge@hallyn.com>
Cc:     linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190114202835.15878-1-malat@debian.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <7cba59f5-d59a-f8fe-9717-0ecbab47eeaf@embeddedor.com>
Date:   Mon, 14 Jan 2019 15:15:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114202835.15878-1-malat@debian.org>
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
X-Exim-ID: 1gj9a2-000gNf-8a
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:50914
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 21
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/19 2:28 PM, Mathieu Malaterre wrote:
> There is a plan to build the kernel with -Wimplicit-fallthrough and
> this place in the code produced a warning (W=1).
> 
> In this particular case change put the fall through comment on a single
> line so as to match the regular expression expected by GCC.
> 
> This commit remove the following warning:
> 
>    kernel/capability.c:95:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Acked-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks

> ---
>   kernel/capability.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/kernel/capability.c b/kernel/capability.c
> index 1e1c0236f55b..e60be18b98e2 100644
> --- a/kernel/capability.c
> +++ b/kernel/capability.c
> @@ -93,9 +93,7 @@ static int cap_validate_magic(cap_user_header_t header, unsigned *tocopy)
>   		break;
>   	case _LINUX_CAPABILITY_VERSION_2:
>   		warn_deprecated_v2();
> -		/*
> -		 * fall through - v3 is otherwise equivalent to v2.
> -		 */
> +		/* fall through - v3 is otherwise equivalent to v2. */
>   	case _LINUX_CAPABILITY_VERSION_3:
>   		*tocopy = _LINUX_CAPABILITY_U32S_3;
>   		break;
> 
