Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8342C433F5
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 04:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FD1520843
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 04:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7eI7eQe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FD1520843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726195AbeIBIkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 04:40:19 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40241 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbeIBIkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 04:40:19 -0400
Received: by mail-it0-f68.google.com with SMTP id h23-v6so11844833ita.5;
        Sat, 01 Sep 2018 21:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ApP2+YiEfgwgHWz8v8+4aqX/fq/oys/vbPbLOvrHig0=;
        b=O7eI7eQe5nsJtNvfdR2J6BLM9ChTfLheF15dMF9TnYhKsEnEgpTkE6s2LdFnGXdHBz
         QUMCc3JXWUEN+JmK0Y1igNKbxa82MyQgJ3fi9UBv6jbGlPguLhISYXA0g7yTbf7neSXQ
         V8G4JwE1Z+dUicYoZvrFXR1iCLKQwAyYAygKpTw5/NagCBCcgEhQXJYrurZp6vG0iNU0
         h5yPF27p3Xu5E80jvQ5uMY/CBBtxIvubgmRDcyR1dM6qcaOc30O/8nrqMcb858eO856L
         v10xbBS9RjvMp2OHjIFVpQNEoB7SDeVdWzHsBiqmUU6pxAST5fn27fJA2ydUZG5CuGjP
         bxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ApP2+YiEfgwgHWz8v8+4aqX/fq/oys/vbPbLOvrHig0=;
        b=m038eHyH7xJvz1ryDrPymbWWOn/d6fecR2LKGACKcUFUj6dkmUYuYQkRvtPazJqkkB
         +Tv0rtH7xtPOlyljnbLxa/T/uFe+YCZIBfw+gqSjxnAJxFGO1c3P3K5JCxH9lQosd2fL
         77gIMvRbpy6dRlvJQjCnibcm7x4SwncbvKOgbSVAUOwssVOM3dO7bH5Eog+LtjFG5pZy
         omC6Gpxa49RfaDX1vCObBR3szB8nAmnR9w/XnRtBL85kM4Sa1MNQCwY1WnUXIrUTzwRE
         Zmgsq7ljbeAVJgEUVnp4k/Sw+trHmF82PsqIQN7n2zL5MlZ56blqAB8xXN5JMZ04OXLx
         a49g==
X-Gm-Message-State: APzg51BvMTL1ZzofoZk5nNc+P5sSHZ56xdVDuwqJsrtSlVOPFKw3+WGy
        VrJLBFy7BV5eBEsKrAsbbaiMrJ+u
X-Google-Smtp-Source: ANB0VdaOy0klDUDpn+CrpJAgAbx188T6vsRaZna/9AbEDQiiiFHh99ar74laTmioHN/VoRx45pm9yw==
X-Received: by 2002:a24:d786:: with SMTP id y128-v6mr2020180itg.140.1535862357570;
        Sat, 01 Sep 2018 21:25:57 -0700 (PDT)
Received: from dsa-mb.local ([2601:284:8200:5cfb:895c:498:52ef:1a1f])
        by smtp.googlemail.com with ESMTPSA id 68-v6sm4616944itx.19.2018.09.01.21.25.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 01 Sep 2018 21:25:56 -0700 (PDT)
Subject: Re: [PATCH] net: ipv6: route: Fix a sleep-in-atomic-context bug in
 ip6_convert_metrics()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, davem@davemloft.net,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180901111958.26529-1-baijiaju1990@gmail.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <4cbf0c0c-ec8b-d953-8ff8-c5cab4d10441@gmail.com>
Date:   Sat, 1 Sep 2018 22:25:55 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180901111958.26529-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/18 5:19 AM, Jia-Ju Bai wrote:
> The kernel module may sleep with holding a spinlock.
...

> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index ec18b3ce8b6d..d15e72def7c1 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -2742,7 +2742,7 @@ static int ip6_convert_metrics(struct net *net, struct fib6_info *rt,
>  	if (!cfg->fc_mx)
>  		return 0;
>  
> -	p = kzalloc(sizeof(*rt->fib6_metrics), GFP_KERNEL);
> +	p = kzalloc(sizeof(*rt->fib6_metrics), GFP_ATOMIC);
>  	if (unlikely(!p))
>  		return -ENOMEM;
>  
> 

This is the wrong solution. I'll take care of it next week after the
holiday weekend.
