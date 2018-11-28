Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4970DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0808C2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 16:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E21Dcl8p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0808C2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbeK2D4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 22:56:17 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40756 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbeK2D4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 22:56:17 -0500
Received: by mail-pl1-f196.google.com with SMTP id u18so5092339plq.7;
        Wed, 28 Nov 2018 08:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nO0+4N14JYBT16pbRqFYBHIRL83n5NnZd2VqEG31nRE=;
        b=E21Dcl8pff2dDH/2JROGXeyJjw8ajlxM5Tox+qtshwh3pnSig/X/0/IYfnTlDY7ar2
         qHx7dwu21149cDayOkg02SNerKNjU+aX4BXGyRe5unaJy9nX5TZRcyAtUjmG5SUod3yG
         hQQ3tcT63/f/Fi0jYFm6CTqzKMfax/Dey8/8lnwTGQf3/AdK0VkwQjWCREOyFz1vxPfZ
         NSrvVd17sY067wII9RwnaWXSQOgO82ba7uoVF645gCV5tl/4HpEZCVE3wm1N4s3XlbWd
         imedV05oBqSw3sMx6SF9bveBhZ9xfXN4LrKiCEB8BLAD0xthFg8XTKa4qvag5SJ8vnZJ
         Z7Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nO0+4N14JYBT16pbRqFYBHIRL83n5NnZd2VqEG31nRE=;
        b=lHT3cJl/zeNYn/DzMnganpy8IKnTdzI6VwQDHlQG41XK8N4oeAugdqbauuCgUo5pm5
         KrhPPm7H/Bw4F2Sxpj7IrulEGxLi8XkOOsm6pSooIT8QZz5B/MYCrXushG79O2iZ5J/r
         bGYPNJnyXXHy0yXXWADwGVnqJF7nu3y+/h+mNRkmCfaaQozJu/BlGjckBlWGpo4uVj7P
         EcrbVjBVxcQ1a9sSBbOVe15ekmH6dnyxuUb16Nusm4G6SjuWmkssARpgrtOZ8hkl2RGp
         +mDn2NJS3y+qrv6wnID44KLUKvkgpcxa87UJDzwTIxFXId1W2R++sByg2B2feonTkLuc
         TNEg==
X-Gm-Message-State: AA+aEWapB8YnsrJgw5dOHhW3/btmvmvfLqpDRf9k/mGNrs98vNlD7A/+
        sNb+y7CI2PkoYaJIj67xaSse9s1I
X-Google-Smtp-Source: AFSGD/U4zQvaPAv6KHYf+tYqBIgPNzL3knA1GHQdoWer59UGierSIwyHLPubxdBaCrLP2aAQ2n9l3w==
X-Received: by 2002:a17:902:14b:: with SMTP id 69mr38178938plb.52.1543424039561;
        Wed, 28 Nov 2018 08:53:59 -0800 (PST)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id z186sm10201042pfz.119.2018.11.28.08.53.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 08:53:58 -0800 (PST)
Subject: Re: [PATCH net-next] tcp: introduce skb_rbtree_walk_safe() and use it
 in tcp_clean_rtx_queue()
From:   Eric Dumazet <eric.dumazet@gmail.com>
To:     Yafang Shao <laoar.shao@gmail.com>, davem@davemloft.net,
        edumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1543407379-3144-1-git-send-email-laoar.shao@gmail.com>
 <60467855-ea5f-3351-8b88-ffdfa60501e0@gmail.com>
Message-ID: <408125e7-bbb0-dcfb-ee19-58089802cac7@gmail.com>
Date:   Wed, 28 Nov 2018 08:53:58 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <60467855-ea5f-3351-8b88-ffdfa60501e0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/28/2018 06:44 AM, Eric Dumazet wrote:
> 

> Because we can break of the loop if the current skb is not fully acked.
> 
> So your patch would add unnecessary overhead, since the extra sk_rb_next()
> could add more extra cache line misses.

I am testing the following optimization, since we can avoid the rb_next() call
when we reached snd_una

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index f32397890b6dcbc34976954c4be142108efa04d8..6829e470f0c186a73c34dca414cd4a2b379baded 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -3126,7 +3126,8 @@ static int tcp_clean_rtx_queue(struct sock *sk, u32 prior_fack,
                if (!fully_acked)
                        break;
 
-               next = skb_rb_next(skb);
+               next = (scb->end_seq == tp->snd_una) ? NULL : skb_rb_next(skb);
+
                if (unlikely(skb == tp->retransmit_skb_hint))
                        tp->retransmit_skb_hint = NULL;
                if (unlikely(skb == tp->lost_skb_hint))

