Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7782C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD7D5214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 21:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfANVIz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 16:08:55 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.36]:16397 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726788AbfANVIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 16:08:55 -0500
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id 8A40569FF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 15:08:52 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id j9TYgKlhD2qH7j9TYgyX5d; Mon, 14 Jan 2019 15:08:52 -0600
X-Authority-Reason: nr=8
Received: from [189.250.130.205] (port=50892 helo=[192.168.43.131])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gj9TY-000d62-3D; Mon, 14 Jan 2019 15:08:52 -0600
Subject: Re: [PATCH] lib/assoc_array: annotate implicit fall through
To:     Mathieu Malaterre <malat@debian.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-kernel@vger.kernel.org
References: <20190114202454.14551-1-malat@debian.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <475381f8-3fdf-5b5e-da34-23d57ae757e7@embeddedor.com>
Date:   Mon, 14 Jan 2019 15:08:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114202454.14551-1-malat@debian.org>
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
X-Exim-ID: 1gj9TY-000d62-3D
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.43.131]) [189.250.130.205]:50892
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 9
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/19 2:24 PM, Mathieu Malaterre wrote:
> There is a plan to build the kernel with -Wimplicit-fallthrough and
> this place in the code produced a warning (W=1).
> 
> This commit remove the following warning:
> 
>    lib/assoc_array.c:1110:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Acked-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

> ---
>   lib/assoc_array.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/lib/assoc_array.c b/lib/assoc_array.c
> index c6659cb37033..0b61d3b77e5c 100644
> --- a/lib/assoc_array.c
> +++ b/lib/assoc_array.c
> @@ -1115,6 +1115,7 @@ struct assoc_array_edit *assoc_array_delete(struct assoc_array *array,
>   						index_key))
>   				goto found_leaf;
>   		}
> +		/* fall through */
>   	case assoc_array_walk_tree_empty:
>   	case assoc_array_walk_found_wrong_shortcut:
>   	default:
> 
