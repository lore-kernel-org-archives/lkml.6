Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594B9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27010206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 12:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyatHmZ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfAHL77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 06:59:59 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36111 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbfAHL74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 06:59:56 -0500
Received: by mail-ed1-f67.google.com with SMTP id f23so3956452edb.3;
        Tue, 08 Jan 2019 03:59:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ttMPPfzGhkTRjOqOVfXi/CX+MXqstyiEoSXAANSpmRI=;
        b=EyatHmZ/w06QSBPOrjoi9GEgGx216r3aSACm0x6D18GwKJ4e1ENl3qcIP8EcT2TU5a
         hqoq/DyAIcTBlHgJgDOtsWc3zJ8d/K98w4sGs00Ke2Mij2IOE4GFkO2OE5MzuSVVOG00
         2/Luef/4WjyCz2fIdTbLW1Q6HupsDpRV+l9t9dzmmKfcIVGL6EM0BRshmCy7fr6Fdhvw
         8wfU+S7SnvFJp7XIHNvXaHY2D4zj8mPqBtSoBCRdzFejEea2C2fb5I8N3vah3W7SXwkp
         O+BXPZ5pjPYfhDLyBtWDHPOBr4yCVSSnk3UMEUA6JbiuaRVOF4MzBDXuIEPJFv7QHSDJ
         rf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ttMPPfzGhkTRjOqOVfXi/CX+MXqstyiEoSXAANSpmRI=;
        b=Po515Ux7hWaBtL51wt7Herhgq2OPsFWk5oaSiNlZbWwsB/pwSixU5HzSXMOc8RfolN
         IlX7P78R8sSwDp6+uUs3fnhZ+f9YcJDCAW6zHlyXgUYIrQcBorUC5PkLx1ZwX6J9an6G
         vTElUq5DgZ9I2zs0kTq3ShSNmHFIAzpJUGedBrcEOFm/GiLCJCpTI9/+NLbp1r4UOBw2
         Qfje/AMo6uJWz4Q31cA4u4LssseZKycaE/ldpG4QtCHezhK3+0K+2SSJv0DUuFAqYRjq
         puz7EsFfouN+t3k9kOl/Z3ApMn7qT5FlQnNuuMNp7uabHvAN+DHaAvuycHYSz9G4juWM
         04Nw==
X-Gm-Message-State: AJcUukca0iPPGCh8Wj35B9TjmguqdjnqlU9qvBDvjJ1vOfWcQLxBZlOO
        Dt5W9zxymS/t7qroBU8yKiVw0OgL
X-Google-Smtp-Source: ALg8bN56GkCa/NdPCaX/mU2Bx+Il3clJSu0OHFiId3lH+MJPa75JAz7K46Qs773BhRE7tHTuqVUhfQ==
X-Received: by 2002:a17:906:46c7:: with SMTP id k7-v6mr1640838ejs.230.1546948794709;
        Tue, 08 Jan 2019 03:59:54 -0800 (PST)
Received: from [192.168.8.147] (98.85.136.77.rev.sfr.net. [77.136.85.98])
        by smtp.gmail.com with ESMTPSA id s36sm33273313edb.43.2019.01.08.03.59.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 03:59:53 -0800 (PST)
Subject: Re: [PATCH] net/core/neighbour: tell kmemleak about hash tables
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org
References: <154693980088.104235.16222977463502002037.stgit@buzz>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <1e75f0ad-11f1-7325-b7a5-a7e21e8ee704@gmail.com>
Date:   Tue, 8 Jan 2019 03:59:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <154693980088.104235.16222977463502002037.stgit@buzz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/08/2019 01:30 AM, Konstantin Khlebnikov wrote:
> This fixes false-positive kmemleak reports about leaked neighbour entries:
> 
> unreferenced object 0xffff8885c6e4d0a8 (size 1024):


size 1024 object : should have been allocated by kzalloc(), right ?

>   comm "softirq", pid 0, jiffies 4294922664 (age 167640.804s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 20 2c f3 83 ff ff ff ff  ........ ,......
>     08 c0 ef 5f 84 88 ff ff 01 8c 7d 02 01 00 00 00  ..._......}.....
>   backtrace:
>     [<00000000748509fe>] ip6_finish_output2+0x887/0x1e40
>     [<0000000036d7a0d8>] ip6_output+0x1ba/0x600
>     [<0000000027ea7dba>] ip6_send_skb+0x92/0x2f0
>     [<00000000d6e2111d>] udp_v6_send_skb.isra.24+0x680/0x15e0
>     [<000000000668a8be>] udpv6_sendmsg+0x18c9/0x27a0
>     [<000000004bd5fa90>] sock_sendmsg+0xb3/0xf0
>     [<000000008227b29f>] ___sys_sendmsg+0x745/0x8f0
>     [<000000008698009d>] __sys_sendmsg+0xde/0x170
>     [<00000000889dacf1>] do_syscall_64+0x9b/0x400
>     [<0000000081cdb353>] entry_SYSCALL_64_after_hwframe+0x49/0xbe
>     [<000000005767ed39>] 0xffffffffffffffff
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  net/core/neighbour.c |   13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 763a7b08df67..3e27a779f288 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -18,6 +18,7 @@
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/slab.h>
> +#include <linux/kmemleak.h>
>  #include <linux/types.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -443,12 +444,14 @@ static struct neigh_hash_table *neigh_hash_alloc(unsigned int shift)
>  	ret = kmalloc(sizeof(*ret), GFP_ATOMIC);
>  	if (!ret)
>  		return NULL;
> -	if (size <= PAGE_SIZE)
> +	if (size <= PAGE_SIZE) {
>  		buckets = kzalloc(size, GFP_ATOMIC);
> -	else
> +	} else {
>  		buckets = (struct neighbour __rcu **)
>  			  __get_free_pages(GFP_ATOMIC | __GFP_ZERO,
>  					   get_order(size));
> +		kmemleak_alloc(buckets, size, 0, GFP_ATOMIC);
> +	}
>  	if (!buckets) {
>  		kfree(ret);
>  		return NULL;
> @@ -468,10 +471,12 @@ static void neigh_hash_free_rcu(struct rcu_head *head)
>  	size_t size = (1 << nht->hash_shift) * sizeof(struct neighbour *);
>  	struct neighbour __rcu **buckets = nht->hash_buckets;
>  
> -	if (size <= PAGE_SIZE)
> +	if (size <= PAGE_SIZE) {
>  		kfree(buckets);
> -	else
> +	} else {
> +		kmemleak_free(buckets);
>  		free_pages((unsigned long)buckets, get_order(size));
> +	}
>  	kfree(nht);
>  }
>  
> 
