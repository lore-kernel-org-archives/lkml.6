Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF730C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD650208A3
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHelIyTE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD650208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728402AbeKLAW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 19:22:56 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:39203 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbeKLAW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 19:22:56 -0500
Received: by mail-pg1-f195.google.com with SMTP id r9-v6so2873010pgv.6;
        Sun, 11 Nov 2018 06:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VeD3un/q4zgsizWU4ltBR+n7y7PYhqkaZE3ZLZKw1IM=;
        b=SHelIyTEEdjzt+kmXdyAnBzwGNUOFJ3h4EdMIS43Rlz4TGFeMzNDLOu9CaKR5V3J4f
         3+/VcbVYtaN/KuWb+ttafMqU6zHsYocFzPXpbV3mZ5tSmY+Bq1ivd86id6l3XMF2P4hj
         HsPKo9by4jbBgjGZOF0oBNwlsE9MaYNB78SnmvURZ0KYm7KSMob0+259mjrZGYUae1ZH
         bd5t6XFWoBeFFAtN2DhgkS7DBt8sbzbCuUUufW1j7Nd7SPxIgxRDuvKbX+T2xY9FZPU6
         I08Gnl3ElZMl+phYojHoalkZMNM2ZRknwUADj0RNoBLwgN0YbfOiIAUqg4abn5Hi69y1
         0KuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VeD3un/q4zgsizWU4ltBR+n7y7PYhqkaZE3ZLZKw1IM=;
        b=I+97L6CB+QCOjWVzbEB9C78aDI5n54WEQVY84r2hm2NF9jI1QcVUugmAc8j5qnzU+B
         h5/P70E1qJcHUF8VBIqTmptu0EaT8rprK2h4w01IdAmY+aAWEkHe3tbsZ6TGC/MXIlg6
         WNtdqwb1NouxQ87xB5tuw11lzMY9tVXdABIyZ3AHGtCFqpea06kqTqMHhiyVMnJ7t0Pa
         5gSP64gKOyNmCqT3vNBMs8X7BvGf5pF/hWKg/YFaeHolW1sM4vY1kdiC+jaA67U5SlAO
         15OVNhujojcfa93T3ZyMJf585A4sew/ARf4Ogy6utafN4eWOEaWmdi15QS8O2/3YEfl/
         AUAw==
X-Gm-Message-State: AGRZ1gKYINj+AuYFXnqbWGuzpHxyTsdjgy8w734gqhTXKgi4hU1V29aE
        irn7HQSAOIjCkQbEtx0HYHg=
X-Google-Smtp-Source: AJdET5c9Fh7oKqdSFCTBUahrbwfUkcONwoqqf8N66Suzo7fBWlRebDQlrbvJbJCSkj+Q8iwzkCr8Pg==
X-Received: by 2002:a62:c5c6:: with SMTP id j189-v6mr16957604pfg.194.1541946852217;
        Sun, 11 Nov 2018 06:34:12 -0800 (PST)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id y29sm4210574pga.59.2018.11.11.06.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 06:34:11 -0800 (PST)
Subject: Re: [PATCH net-next v2] tcp: minor optimization in tcp ack fast path
 processing
To:     Yafang Shao <laoar.shao@gmail.com>, davem@davemloft.net,
        edumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
References: <1541938210-11797-1-git-send-email-laoar.shao@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <678e757d-7df1-4c5d-7acb-dd6b0f94a859@gmail.com>
Date:   Sun, 11 Nov 2018 06:34:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1541938210-11797-1-git-send-email-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/11/2018 04:10 AM, Yafang Shao wrote:
> Bitwise operation is a little faster.
> So I replace after() with using the flag FLAG_SND_UNA_ADVANCED as it is
> already set before.
> 
> In addtion, there's another similar improvement in tcp_cwnd_reduction().
> 
> Cc: Joe Perches <joe@perches.com>
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Signed-off-by: Eric Dumazet <edumazet@google.com>

Thanks.

