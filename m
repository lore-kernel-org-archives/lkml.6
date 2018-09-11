Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1A1C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCCCA2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 08:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="BSVfNSOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCCCA2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeIKNuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 09:50:22 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46745 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbeIKNuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 09:50:21 -0400
Received: by mail-lj1-f195.google.com with SMTP id 203-v6so20162971ljj.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 01:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D/du7rdVPX4SEeCObez1WJf1uKijQfbjcN5X8AigYMM=;
        b=BSVfNSOozYmUqZDSlezzDrMks9HsyCD844/FlG0Ky0WCEpu+rkpFRX1jIcXb3R+FeJ
         luHrbm5tP5wSVEapeuwSX7ar+sSkP2DhlIE9NwgZmtJ0jH2erCSUhx00GhoJI7Y7cppR
         nsgaXkfAp+37xzxdvqyoIX2O0+zk2p7tHvqHC16+PH27DIhbR0CUPbBRxm0JL+y3O0nL
         8z3rnX+IXsvbAS9JnhOWDrHlzQnUoGruUYSawIJfuVYhvKz6vXoW0Uzn3/QKtUy2DkYl
         hbCHz+pIQzNjCCTCQYkzV9hq93AhXYtR9UEWt3lbSSPXTbz4iEKZPR+uueKKxLEn65U4
         xQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D/du7rdVPX4SEeCObez1WJf1uKijQfbjcN5X8AigYMM=;
        b=KKo/bpPfrLY8PhRRbUqEjT1nEn6eYa4iWP+ZFJm0lb4cmN1zGVR3zr3YDu94Z70eb9
         hZZzil0Zn5A7mkGumKy56VmYsG68r8oK5Ol2SWjr7+l1dwLwOERJHe41+9HOyD6cjcAd
         7XuZHd5OsXCsNzOuPwCqod78wUYluUSP8zRkgpWezkf1kkcrsv05TsVPn/dxpofelNb3
         eWCodBNCZLAZ2/Hr2QjOgiEL7PYYmJZu1Wl7D3oE1SoHruXCPD+ztwZbk8JpOMPbBso4
         VfIEKH15mMUDuNoS09GOLPcN/0tmNPiG36NApPv/9JKvzI93XCQSfvd3BD1YUGrf+/nE
         UUQQ==
X-Gm-Message-State: APzg51BtLfAZZvnohPwfHn4QZkMrxJj9QRTqu672eXgSOTmYIzW+w5SB
        UZVBPe9OZZuKxnjC9Zyk4OJsJW+YLHA=
X-Google-Smtp-Source: ANB0VdaxGxBCLS+k2rUBrOBaAWmkpv6prcrzRkLYVFSDkQDnKWKkHJdcDXdl9dBHX93eKNWp6U11jQ==
X-Received: by 2002:a2e:9c82:: with SMTP id x2-v6mr2749864lji.131.1536655921102;
        Tue, 11 Sep 2018 01:52:01 -0700 (PDT)
Received: from [192.168.0.126] ([31.173.81.2])
        by smtp.gmail.com with ESMTPSA id n22-v6sm3123188lfh.59.2018.09.11.01.51.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 01:51:59 -0700 (PDT)
Subject: Re: [PATCH] net: ipv4: Use BUG_ON directly instead of a if condition
 followed by BUG
To:     zhong jiang <zhongjiang@huawei.com>, davem@davemloft.net,
        edumazet@google.com
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1536590282-23899-1-git-send-email-zhongjiang@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <a000b5a4-2907-70f9-70ed-7e1c6a797876@cogentembedded.com>
Date:   Tue, 11 Sep 2018 11:51:59 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1536590282-23899-1-git-send-email-zhongjiang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/2018 5:38 PM, zhong jiang wrote:

> The if condition can be removed if we use BUG_ON directly.
> The issule is detected with the help of Coccinelle.

   Issue?

> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>   net/ipv4/tcp_input.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 62508a2..893bde3 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -4934,8 +4934,8 @@ void tcp_rbtree_insert(struct rb_root *root, struct sk_buff *skb)
>   			BUG_ON(offset < 0);
>   			if (size > 0) {
>   				size = min(copy, size);
> -				if (skb_copy_bits(skb, offset, skb_put(nskb, size), size))
> -					BUG();
> +				BUG(skb_copy_bits(skb, offset,

    You said BUG_ON()?

> +						  skb_put(nskb, size), size));
>   				TCP_SKB_CB(nskb)->end_seq += size;
>   				copy -= size;
>   				start += size;
> @@ -5327,8 +5327,8 @@ static void tcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcphdr *t
>   		/* Is the urgent pointer pointing into this packet? */
>   		if (ptr < skb->len) {
>   			u8 tmp;
> -			if (skb_copy_bits(skb, ptr, &tmp, 1))
> -				BUG();
> +
> +			BUG(skb_copy_bits(skb, ptr, &tmp, 1));

    Likewise.

[...]

MBR, Sergei
