Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5A0C65BAE
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F5221508
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="E9hm9DQK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F5221508
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbeLCJnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:43:04 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35242 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeLCJnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:43:04 -0500
Received: by mail-wm1-f65.google.com with SMTP id c126so4896173wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 01:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZZvre/H46WpeUXFq0et7nHwNI50jgdXDNyFmlD+6BSQ=;
        b=E9hm9DQKx48tCmOd36diBiaMaW0azrsRN3JZYKkoXScI7xO7td1QnW0sDRZdVktSwF
         94DTMFFdKqzY/d7GJSeIXis13a87YQ2EtrULTUuMVWlTFd9dOF6rM12eWSKkJ+Xm7voF
         G4wTM8jdRUw8nLAuGCZD1kyyB6R0W/jpiOk0ArxTW4npj7I5xae8+CFb4jMLPsmnOMwL
         xABjDPpK7GkArSxTEAhrrbWAwkIJLUsq3eQyPnjZUbm4MQVL/gUeBfrGIXl1NSgdni2s
         UkBZgvANZAaBCjobyTMQj+hb/5uReHsL6BtBoDq77M4mGFuZNoCkdc1c94P6A9GvKc8X
         BLvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ZZvre/H46WpeUXFq0et7nHwNI50jgdXDNyFmlD+6BSQ=;
        b=nok8Odua+0t8t8j2/CrWubLfWMuWIgHrJcElsT9cqUnmVc9L/UIFXlAGbqCTluzX+F
         1uDy7Yp8wCZm8kSKDfs8utRn+I40Yxpp//SDvk3/gbwXzzvKBE31mY9JF/doV6Y+1H6k
         bKHUlX9O43g1ebayIzFbBST7HZZuFhgGpHSm6ESaSKM7d8hzAoNZyC7ZI4EZ07tCmCdp
         WCc1xAhA7rMcwxujYoypx8vD8jPfxm8VfSJS6EBz4PiYqc6AJRq2Fj+usBlZ/Lvdg4fi
         3PQICfGGWu0qgjj/iZpeaOiWoTl2WRnc7+4kdP+fUqw8b2POVl7bbzKjo2tHwPfNUV9J
         wW9Q==
X-Gm-Message-State: AA+aEWYRVKwOH7jy8nYY0V2KxjlIanPYA/5BjxzYJXCLt1wNB8AQXxRY
        u46yiPFphs2fguqFHJiedBSA6A==
X-Google-Smtp-Source: AFSGD/XnTMiELjUeNxWjC6swx2wr5MBqPiwu0fqjZNBs0w9jtRK92Ex2AgowB4oVGbrXkbQAmd1RWQ==
X-Received: by 2002:a1c:e513:: with SMTP id c19mr8004574wmh.101.1543830166448;
        Mon, 03 Dec 2018 01:42:46 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id h12sm20248605wma.48.2018.12.03.01.42.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 01:42:45 -0800 (PST)
Message-ID: <d52679a197a46fa19fb44c446c52fd286ad639f2.camel@baylibre.com>
Subject: Re: [PATCH 0/3] - clk: meson8b: add the (read-only) video clock
 trees
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-amlogic@lists.infradead.org, narmstrong@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        mturquette@baylibre.com
Date:   Mon, 03 Dec 2018 10:42:44 +0100
In-Reply-To: <20181202214220.7715-1-martin.blumenstingl@googlemail.com>
References: <20181202214220.7715-1-martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-12-02 at 22:42 +0100, Martin Blumenstingl wrote:
> Martin Blumenstingl (3):
>   - clk: meson: meson8b: fix the offset of -- vid_pll_dco's N value
>   - clk: meson: meson8b: add the fractional divider for -- vid_pll_dco
>   - clk: meson: meson8b: add the read-only video clock trees
> 
>  drivers/clk/meson/meson8b.c | 746 +++++++++++++++++++++++++++++++++++-
>  drivers/clk/meson/meson8b.h |  54 ++-
>  2 files changed, 789 insertions(+), 11 deletions(-)

Looks good to me

Acked-by: Jerome Brunet <jbrunet@baylibre.com>

