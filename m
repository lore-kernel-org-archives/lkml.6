Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26897C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF0D023FFF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 14:48:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5EndWMi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF0D023FFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933157AbeGFOsn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 10:48:43 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38906 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753915AbeGFOsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 10:48:42 -0400
Received: by mail-pf0-f195.google.com with SMTP id j17-v6so8651230pfn.5;
        Fri, 06 Jul 2018 07:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+/9KVHOzBAXJiD5uqvSDJJ8/Fg6+k+QIJneve1jOLJE=;
        b=n5EndWMiDCkLsi1yVqTvv4GNCmLrl+5q4bf/ktXWzSA4GaqBGxPVTTDl6f62bR6frR
         UvSobEia0QOLzr1oSqwVdt7AFVUqc+j/MVyP/ym8z4DuXYrC/9wqXAlqrKNpCMWBBG+s
         46o64C29KUtrZy/QIJxYO3ikZygjd8cwT+C/WxxYvNKSThGbT36alkrbJHKdQMVg3mMy
         hSpiPV4UAJg85Vmrbop9XRN6HFwDFCuXdLgO0kt277qCRaMzydjAYvrZT9FxWhbEm8H/
         icfnkNE6vPU056D2vo0yIC+w007NgeijdRRh19P5fvMeD/Ue66w39PLgMVaDRHgXhiOL
         lgzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+/9KVHOzBAXJiD5uqvSDJJ8/Fg6+k+QIJneve1jOLJE=;
        b=sddfpFSvxIuOtDe7c5IPefKcwGV5CEfeYx7sGHBRMmzMpa05lDiWO2j8SiATs22vR8
         ohMS0Oe649NbvLtXFdBtm2lWJYzkBJbmUlbF7u0/crOIxvhVBgzszcJfHD7KX+lS+dW6
         jq69MZsqhhxmY41r1ApPlXZwci8Ca4AtBEaQs2V50TcDZFWhjpipepZ7W8gVWQp9AHOP
         1kf4ugnRpL4MU6I64Pbbzbv//viAHpA68lSayzzITC+ywrw69XDDhLwopMIcdiH3NXjL
         cy4w/fQhYFJe2EgfIfFhjygTl8Cdn0T5GebB1PcT3qonONzVRZUQc+2lYKktncf6QW7j
         Qz1w==
X-Gm-Message-State: APt69E1Ot0I2vsWOvoKjOqTml7H/KL9z5EZJWPf/5em80R/4g56YPFRA
        OTHm86oDVTqvVwfBV+Gx8p7M0QEv
X-Google-Smtp-Source: AAOMgpc2d49tGUHDUs4uvGvfmsFzcrcVBjzTXZpz/jkXMQGzEKHOipK6g03H8dv7y8z0cgJ55mvG/g==
X-Received: by 2002:a63:35c3:: with SMTP id c186-v6mr9619379pga.217.1530888521403;
        Fri, 06 Jul 2018 07:48:41 -0700 (PDT)
Received: from dsa-mb.local ([2601:284:8200:5cfb:e5bb:a0b3:1b35:a097])
        by smtp.googlemail.com with ESMTPSA id i89-v6sm25751817pfi.170.2018.07.06.07.48.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 07:48:40 -0700 (PDT)
Subject: Re: [PATCH] ipv4: fib: avoid NULL dereference
To:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org
Cc:     Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        "David S . Miller" <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev@vger.kernel.org
References: <20180706142836.1822-1-mark.rutland@arm.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <92672813-153a-eccb-dbee-4b59bbf657f1@gmail.com>
Date:   Fri, 6 Jul 2018 08:49:14 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <20180706142836.1822-1-mark.rutland@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/18 8:28 AM, Mark Rutland wrote:
> diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
> index 5bc0c89e81e4..8d98c8162554 100644
> --- a/net/ipv4/fib_trie.c
> +++ b/net/ipv4/fib_trie.c
> @@ -497,11 +497,11 @@ static void tnode_free(struct key_vector *tn)
>  	struct callback_head *head = &tn_info(tn)->rcu;
>  
>  	while (head) {
> +		tn = container_of(head, struct tnode, rcu)->kv;
> +
>  		head = head->next;
>  		tnode_free_size += TNODE_SIZE(1ul << tn->bits);
>  		node_free(tn);

you are changing tn before the above 2 calls are made on the tn passed in


> -
> -		tn = container_of(head, struct tnode, rcu)->kv;
>  	}
>  
>  	if (tnode_free_size >= PAGE_SIZE * sync_pages) {
> 

