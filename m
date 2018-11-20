Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A3BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6B12080C
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 02:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SR9jqmhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6B12080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731836AbeKTNNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 08:13:53 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40280 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728794AbeKTNNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 08:13:52 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so235011pfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Nov 2018 18:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BHkbtNvMLbLuIMAwi7snocSkhgR95jxZ77GlQYCvGW4=;
        b=SR9jqmhNXGOLL6oBfDpA4L4G5Nd4TBuPRpj+2aC+/x4OmYuUJ78RCHYritI/m17WMJ
         6bltvBfLQKb5R5qy9AwOPYbDEprfKhcFRujQR1xqEa7+lYvMh34uNc9I0gRWqp9yozGU
         YggtQdCGbH70j50JJ+XUSeiwCX7lWz/8zA7s9CoQZAWx9iEnibgZeifmNdxWuMeuf/yW
         PXw/PGqYjlTYVL0mWb6gSwSER41Srbimr55a1DawSqFW62hpiNT5mP8Hx7ASRIaF/mL+
         CLAdpfj7EkS59x8y9ASLL419CSRLgV96rdufF83OWc67M+VAYFXtOKQKywqmW5plPHSY
         hzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BHkbtNvMLbLuIMAwi7snocSkhgR95jxZ77GlQYCvGW4=;
        b=bMOS58brjuV3DsD3QTrFp+7DN7VGqnkHTf2a6lmvGGMrnm22gOL7ZoG1aNj00pidBq
         hLYmsW/RxaSZnFEW1nIJstEm+E8tAtDTMWiuPnPEzxOBcG7Gs3TjXh48Cm6SMRIxL4Gy
         3Tdjwqoggo8dk+hGb8f5w5UAYS6gTI2BE0nHBOsZb3ztu/aSz8Tw6KOEQNDiAoDwWhIA
         evNMhEIuKX3K284kJlcZBAn/yLPQiloBdA4upEr2ZhebIR/9bfBf8yLKULD+Zxd4CviB
         oSHccKTfQ4CXna7P2pUXEFJam7c0qtVfjziGtJr3Yl3U6KvfaIQFhn6dyQ5ZVlhkxUUz
         Nadw==
X-Gm-Message-State: AGRZ1gK/1uRqbnCGLZWqfC9rDzIzN5xtr7ROs1voFB86Y+9wZAw+TZNR
        yXLxgpH67K2pyTltatVF7RY=
X-Google-Smtp-Source: AFSGD/WMRqq0xkeLn6FQbvo8TGb4hAHSJQ/d3RpQaUoJXp7pHlD7oefwCxQoic2xkPU+8pobXHgh5Q==
X-Received: by 2002:a63:4665:: with SMTP id v37mr204309pgk.425.1542682023606;
        Mon, 19 Nov 2018 18:47:03 -0800 (PST)
Received: from localhost ([175.223.45.197])
        by smtp.gmail.com with ESMTPSA id p15-v6sm70724036pfj.72.2018.11.19.18.47.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 18:47:02 -0800 (PST)
Date:   Tue, 20 Nov 2018 11:46:59 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 3/6] zram: introduce ZRAM_IDLE flag
Message-ID: <20181120024659.GC4231@jagdpanzerIV>
References: <20181116072035.155108-1-minchan@kernel.org>
 <20181116072035.155108-4-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116072035.155108-4-minchan@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On (11/16/18 16:20), Minchan Kim wrote:
[..]
> +static ssize_t idle_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t len)
> +{
> +	struct zram *zram = dev_to_zram(dev);
> +	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
> +	int index;
> +
> +	down_read(&zram->init_lock);
> +	if (!init_done(zram)) {
> +		up_read(&zram->init_lock);
> +		return -EINVAL;
> +	}
> +
> +	for (index = 0; index < nr_pages; index++) {
> +		zram_slot_lock(zram, index);
> +		if (!zram_allocated(zram, index))
> +			goto next;
> +
> +		zram_set_flag(zram, index, ZRAM_IDLE);
> +next:
> +		zram_slot_unlock(zram, index);
> +	}
> +
> +	up_read(&zram->init_lock);
> +
> +	return len;
> +}

This is one way of doing it.

The other one could, probabaly, be a bit more friendly to the cache
lines and CPU cycles. Basically, have a static timestamp variable,
which would keep the timestamp of last idle_store().

static idle_snapshot_ts;

static ssize_t idle_store(struct device *dev,
			  struct device_attribute *attr,
			  const char *buf, size_t len)
{
	idle_snapshot_ts = ktime();
}

And then in read_block_state() compare handle access time and
idle_snapshot_ts (if it's not 0). If the page was not modified/access
since the last idle_snapshot_ts (handle access time <= idle_snapshot_ts),
then it's idle, otherwise (handle access time > idle_snapshot_ts) it's
not idle.

Would this do the trick?

	-ss
