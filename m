Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85DBC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6452B214DB
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 19:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="CE3eM1wH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6452B214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbeLDTym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 14:54:42 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:34480 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbeLDTyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 14:54:41 -0500
Received: by mail-yb1-f196.google.com with SMTP id a67-v6so7405654ybg.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 11:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KEmiKoLuZH21McZzbS+ZG3EgftTYemLlSyZsFUMBzK0=;
        b=CE3eM1wH8tK+rtHYU5qpr6P7pNFWJvVDn/n+QQY1lAYyhgD3pKLRyEjKULYFeTcCsa
         02D3UKuzHpNL0z7Jtt1FjqUP+ATABkn2VVhdRD8KrH3LlIiRBfVs9vTZ9vhcKywL/ndM
         9w0kvUmz4E9zJFkZM+N+dm3LWmAy1hd7+AK3rbGTGKPvEllgsE4IT6Bcg5OZxPzSGmFN
         nmJOtFeR0d7FHMxdFi5bxYkVQ2IDe9kqAQ1hg55blK5+B67rLA68/vl57cT1sXW58cG6
         lJYAPYKAor3GdHpwTzsD82EmhQb4edjuKY6o5YZOtb04dz4ArtbGxmy2zbUxtQLOgMhS
         hJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KEmiKoLuZH21McZzbS+ZG3EgftTYemLlSyZsFUMBzK0=;
        b=C0uAhqye5GAZ15KaNAnBrLKrQ1tFOQVhmfaKA11XZxGaVIE8juZIjaHR984wEMFv8Z
         x7wh0BnF178m77+BWEfeSzlr6Cp6Me/VnbZJoXE0WzQfm5Y5gi2eQAMKbkySwRYaVKgM
         OtMPg33NitObu/jqJE84do3mSMk1gPMSnMqgd4vXb8Nn4Ke+b8vLWM0Fr6k72tzJ9o1f
         bv1qQBUqwkC1YcWBYtwvGpln7aELtoMK4aP2XsbiBoEQhZfZOZOSGzN9UmFq9rHdj425
         y0ykvFJrgbn4RiuevTsvSDXQ3RE1kGuSAOsl+sp/T6MDx53ZZ2LwOvOJ4kIplHHoLf1C
         Be2g==
X-Gm-Message-State: AA+aEWZzElZVtNXnuEu+pIdGJmQ3S/WCtw19c2GPq7wmo5D0HLq3ZekL
        rdoxDY4MqK4NPrH1XxYlO60O9g==
X-Google-Smtp-Source: AFSGD/U2cjYhFlXInnxI7qEMOWmmELH91uMHtImiK7MAZyWbSTrSJasgTruMiNcL1Y5wHB/VaDtTBg==
X-Received: by 2002:a25:ca94:: with SMTP id a142mr14897560ybg.151.1543953280440;
        Tue, 04 Dec 2018 11:54:40 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x4sm20572269ywj.80.2018.12.04.11.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 11:54:39 -0800 (PST)
Date:   Tue, 4 Dec 2018 14:54:38 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/14] blkcg: change blkg reference counting to use
 percpu_ref
Message-ID: <20181204195437.cqixsk265n6dyetv@MacBook-Pro-91.local>
References: <20181204183600.99746-1-dennis@kernel.org>
 <20181204183600.99746-14-dennis@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204183600.99746-14-dennis@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 01:35:59PM -0500, Dennis Zhou wrote:
> Every bio is now associated with a blkg putting blkg_get, blkg_try_get,
> and blkg_put on the hot path. Switch over the refcnt in blkg to use
> percpu_ref.
> 
> Signed-off-by: Dennis Zhou <dennis@kernel.org>
> Acked-by: Tejun Heo <tj@kernel.org>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
