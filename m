Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871A4C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47A4820863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 10:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="UnW5kO+1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47A4820863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbeK2VFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:05:22 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35852 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727248AbeK2VFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 16:05:14 -0500
Received: by mail-lf1-f66.google.com with SMTP id a16so981251lfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 02:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HbxN6WX1QJU+9RRAsjsTRo1+u7xCCwC0lAnxCYOVPno=;
        b=UnW5kO+1LGKEgIz1lM+bDmzs96y8jKCjCFcKxUzegsbJYj73Dt7NSQ+WOunl97TzqO
         vJytSMHl0FdRHXxJZ6w7JaF3V7dsCifUMD/hp96ExHNWu1Q4UXHlJ3blhQn94UN+mexs
         g7TmqXEmRr6xAhX01/I7cxbKghQl/YM/9WIjufbdnJHmG+pGddJfee63eLqVOEblYC1l
         mbQaAT2CdfaqY5+opASBi30fBkqj2FJ+gUSFxuCAiO0FlCdZbYb63eUitIsi+L7VrTcr
         Oz4mnWPNOgK5QLyUUgt7IWcz53MTqeWyfM3bv0ozkqLsHCrQv7LVZxiumsl+VeqBbxpp
         TMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HbxN6WX1QJU+9RRAsjsTRo1+u7xCCwC0lAnxCYOVPno=;
        b=S5smKAtCcvnmLqHFJihI6JqPrqX6z3N8DtoiVN4XJW1r6doheOvYGmcj+nqdzcaWAF
         RtK/+QljQFLBgDksHWymOgeftcCiAxprsOPtqe5cTaRuSKHYDNvS1za+IIZKw8Nmwuaa
         lYEPdRoAr9NIWQK44uZQy1DIpoLFNXE2upAATtDWl+GfoDx3sYCFwlejQysx0lrXhQBf
         W57NpVo5KqBHpYAmgH0zqBjOhq0iAn0AAj371KeNz8nUKgAXnFPMnEgtlXFM7pUgHBl5
         f+mponIKP5cIhuz4w94teixbcb9iR0rCial1PcdxaG/rHpTRaBQ/wVtPOyoZex4oKSrb
         rk0A==
X-Gm-Message-State: AA+aEWbv4LZZpw3hqVRM7054hf9cg1ar6n8TYFfevax3VIEEJWGbPMuq
        p+uWIWG4JUb4Z1PaB6ZoGC7www==
X-Google-Smtp-Source: AFSGD/U3P/o39bCBehNz1oB3zdqsFN+ypm2pTSQwR7LwmWcRAECXwP8h/RdOJoSKRmqaJvbtT6OGQw==
X-Received: by 2002:a19:4849:: with SMTP id v70mr587258lfa.62.1543485624886;
        Thu, 29 Nov 2018 02:00:24 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.83.97])
        by smtp.gmail.com with ESMTPSA id u26-v6sm209609lji.22.2018.11.29.02.00.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 02:00:24 -0800 (PST)
Subject: Re: [PATCH AUTOSEL 4.19 15/68] batman-adv: Expand merged fragment
 buffer for full packet
To:     Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>,
        netdev@vger.kernel.org
References: <20181129055559.159228-1-sashal@kernel.org>
 <20181129055559.159228-15-sashal@kernel.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <cad9ec40-5125-9bef-0e9e-5c70783a5cb7@cogentembedded.com>
Date:   Thu, 29 Nov 2018 13:00:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181129055559.159228-15-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-MW
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 11/29/2018 08:55 AM, Sasha Levin wrote:

> From: Sven Eckelmann <sven@narfation.org>
> 
> [ Upstream commit d7d8bbb40a5b1f682ee6589e212934f4c6b8ad60 ]
> 
> The complete size ("total_size") of the fragmented packet is stored in the
> fragment header and in the size of the fragment chain. When the fragments
> are ready for merge, the skbuff's tail of the first fragment is expanded to
> have enough room after the data pointer for at least total_size. This means
> that it gets expanded by total_size - first_skb->len.
> 
> But this is ignoring the fact that after expanding the buffer, the fragment
> header is pulled by from this buffer. Assuming that the tailroom of the

   Pulled by what?

> buffer was already 0, the buffer after the data pointer of the skbuff is
> now only total_size - len(fragment_header) large. When the merge function
> is then processing the remaining fragments, the code to copy the data over
> to the merged skbuff will cause an skb_over_panic when it tries to actually
> put enough data to fill the total_size bytes of the packet.
> 
> The size of the skb_pull must therefore also be taken into account when the
> buffer's tailroom is expanded.
> 
> Fixes: 610bfc6bc99b ("batman-adv: Receive fragmented packets and merge")
> Reported-by: Martin Weinelt <martin@darmstadt.freifunk.net>
> Co-authored-by: Linus Lüssing <linus.luessing@c0d3.blue>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
[...]

MBR, Sergei
