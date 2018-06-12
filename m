Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 423A8C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB826208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 04:31:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QY7RoVaq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB826208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754079AbeFLEbw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 00:31:52 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36995 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752816AbeFLEbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 00:31:50 -0400
Received: by mail-pg0-f67.google.com with SMTP id r21-v6so10491815pgv.4;
        Mon, 11 Jun 2018 21:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r7jgtGQSAaQdAS4oMWnSmS7E1ybyBaI261oGPDkfhL8=;
        b=QY7RoVaq6tjRt5n4bQ2R8x4tZlS9v6Q7PLJs+woSPMDQuTaD4Fl8yL61RCV69Oane3
         DC/PPxESjX97gyaEVikiFZnI2LH4iTtgBu1AIWPnmzQYUShm2vOeo2ebUpHE+m/00rIu
         hOS2jKoNuMQ6OuxzbtXBlkD9V3D/AaP2HSuC28wsIkyBfW9kaPE9uVydfQDCa/k6AeAW
         NLf7v786JgS467MBuXxHdAKA374S7PkDq2yTEnTaB/mfBYYCUzL2ThqF+Gdqz6O8/1wy
         tVFSGT/OM9ULHziDHZ9QbB7lbVJbVtrXObL3/vUg8AqvoY79KhfXW0QbGjLpOZNHXGo9
         CA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r7jgtGQSAaQdAS4oMWnSmS7E1ybyBaI261oGPDkfhL8=;
        b=Baw+CQ/nzQRxEo5H7irA6pBodXcH1pCAva6LxrTwMKoFQv+pFU8nCT+S59TOMUIB0l
         MTIm/ZQSdARPau7GhNeNmgnAwvvTK0uLsWQGDDn9Fp2GnJx/eys4P87/o2F5uogLj2hi
         4Uf5pCAc1mGwRRnObChFWUUIiUmH5m2YPzSJ9mVOqXkyLX44zJ3LsoLD8Y1DLNJukHdr
         UxOYDMbS3ioAw/abcxxw3FB68cRX//13AO7zA/rDxnCeaGhe1uLBxQz0NmOWCUWFUghP
         StaiRm/j3ntRSl0arxT8TDTbNCvVkHde4EraMOgSFMQ0a27T7LZ0vvHirUy1Y/NqoxSZ
         wISQ==
X-Gm-Message-State: APt69E2L5CraqIteEPL9PLczK6lSZwUN/mO28NrPr/YkikvV1M870X6e
        gzRxbiBGPzKqIDUHeRUmA+2kats1
X-Google-Smtp-Source: ADUXVKJ5zS1Erd2SqpUqgsEsn4VbIFHERk38qvT95CfvLjqrIEund7O8jNt6TJpk6WiVMXSqqkjF6A==
X-Received: by 2002:a65:468e:: with SMTP id h14-v6mr1695245pgr.89.1528777909726;
        Mon, 11 Jun 2018 21:31:49 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id a8-v6sm23429111pfe.72.2018.06.11.21.31.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 21:31:48 -0700 (PDT)
Subject: Re: [PATCH] net: add error handling for kmem_cache_create
To:     Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Wei Wang <weiwan@google.com>, Martin KaFai Lau <kafai@fb.com>,
        Kees Cook <keescook@chromium.org>,
        Eric Dumazet <edumazet@google.com>,
        Florian Westphal <fw@strlen.de>, Joe Perches <joe@perches.com>,
        linux-decnet-user@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1528777798-40722-1-git-send-email-jiazhouyang09@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <17050ede-26b7-dfa5-91c5-e94da3e336e6@gmail.com>
Date:   Mon, 11 Jun 2018 21:31:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1528777798-40722-1-git-send-email-jiazhouyang09@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/11/2018 09:29 PM, Zhouyang Jia wrote:
> When kmem_cache_create fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling kmem_cache_create.
> 
> Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
> ---
>  net/decnet/dn_route.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/decnet/dn_route.c b/net/decnet/dn_route.c
> index e747650..2b743c7 100644
> --- a/net/decnet/dn_route.c
> +++ b/net/decnet/dn_route.c
> @@ -1861,6 +1861,9 @@ void __init dn_route_init(void)
>  	dn_dst_ops.kmem_cachep =
>  		kmem_cache_create("dn_dst_cache", sizeof(struct dn_route), 0,
>  				  SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL);
> +	if (!dn_dst_ops.kmem_cachep)
> +		panic("Failed to create dn_dst_cache cache\n");
> +

Not needed, since SLAB_PANIC would have paniced the box earlier.

>  	dst_entries_init(&dn_dst_ops);
>  	timer_setup(&dn_route_timer, dn_dst_check_expire, 0);
>  	dn_route_timer.expires = jiffies + decnet_dst_gc_interval * HZ;
> 
