Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F21C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99E8321905
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbfABQe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 11:34:28 -0500
Received: from ivanoab6.miniserver.com ([5.153.251.140]:36622 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729256AbfABQe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 11:34:28 -0500
X-Greylist: delayed 1643 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Jan 2019 11:34:27 EST
Received: from [192.168.17.6] (helo=smaug.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1gejTM-0000tg-MM; Wed, 02 Jan 2019 16:34:24 +0000
Received: from amistad.kot-begemot.co.uk ([192.168.3.89])
        by smaug.kot-begemot.co.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1gejTK-0005bA-BG; Wed, 02 Jan 2019 16:34:24 +0000
Subject: Re: [PATCH 2/2] um: vector: Use 'kmalloc_array' instead of 'kmalloc'
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        jdike@addtoit.com, richard@nod.at, rppt@linux.vnet.ibm.com,
        akpm@linux-foundation.org, yuehaibing@huawei.com,
        keescook@chromium.org
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20181226075449.11071-1-christophe.jaillet@wanadoo.fr>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys Limited
Message-ID: <49451efd-0984-ab88-eef9-4dfd8b8473a7@cambridgegreys.com>
Date:   Wed, 2 Jan 2019 16:34:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20181226075449.11071-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/26/18 7:54 AM, Christophe JAILLET wrote:
> Use 'kmalloc_array' instead of 'kmalloc' when appropriate.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> I don't know why it has not already been replaced in 6da2ec56059c
> ("treewide: kmalloc() -> kmalloc_array()".
> ---
>   arch/um/drivers/vector_kern.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 5b917716289d..dee5246bda81 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -507,12 +507,12 @@ static struct vector_queue *create_queue(
>   		return NULL;
>   	result->max_depth = max_size;
>   	result->dev = vp->dev;
> -	result->mmsg_vector = kmalloc(
> -		(sizeof(struct mmsghdr) * max_size), GFP_KERNEL);
> +	result->mmsg_vector = kmalloc_array(max_size, sizeof(struct mmsghdr),
> +					    GFP_KERNEL);
>   	if (result->mmsg_vector == NULL)
>   		goto out_mmsg_fail;
> -	result->skbuff_vector = kmalloc(
> -		(sizeof(void *) * max_size), GFP_KERNEL);
> +	result->skbuff_vector = kmalloc_array(max_size, sizeof(void *),
> +					      GFP_KERNEL);
>   	if (result->skbuff_vector == NULL)
>   		goto out_skb_fail;
>   
> 

Acked-by: Anton Ivanov <anton.ivanov at cambridgegreys.com>

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/
