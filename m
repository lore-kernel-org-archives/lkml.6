Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE45C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65EDC20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="ElrZTSqt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65EDC20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390215AbeHASMp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:12:45 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44312 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389836AbeHASMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:12:45 -0400
Received: by mail-qt0-f196.google.com with SMTP id b15-v6so20526082qtp.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 09:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jTLGWpgqCyvqaPeODeGNNaLOck8/amA8MikEaNKjB/g=;
        b=ElrZTSqts1z2+nvuGXoEWW83WeCax4OtBDwoZukUyJOmfzVbmvQOAZfjHcc5WtUX5u
         N/NK8nQuK17oytWjzXi8GKuDnzwaAod0jGtXqqFFCB5wYTyG/dVulQuiSdcZtR4wXft6
         SO9CRL4ho0xMxFYV2iVE264bkiiLxaIn9RxBuw//KrxG5VC37u1oaPVpHBVH2d/ZMQnf
         KcWete2pzJCkDzFaZv29L+KVxj6Pz5/1yBERIs5YabSVIwzscbkTOw4FhkBjZFj4el5d
         aD5UzAMrWv4nbIy6G1wZja/5uZJo89jU2nufEXRnu2fEgOm15JD1UH0ksZDZz4kyRHC0
         /uiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jTLGWpgqCyvqaPeODeGNNaLOck8/amA8MikEaNKjB/g=;
        b=Vcp35tyl+qJyzmDwSNMKVVCB6wMnzA3w95lzEp16IAIAyZDPPutAn7JOgYRh73/1cX
         lOKnSB7dRAwF0hpUVrL+7k6TNsJnSvyLvgnbAhXxTi7H4fNwYWnUsVHJQYEg1UOX7xhx
         tRJHg6RnGUxV9S08c6LKp7ptyJ730Lq6uo4L4aauh2gga8FrnUhtfhZI9oj+Xj/6to8t
         1pKcuKYJBEelDauNTzO5N+SRpIKl5FIOooPrtwSS43IB91UPpN9X3yW0PjYnIoRoLGzx
         IOI1dcQs8B4mAt2YFeROGYzMqZiY/7eOCl2ZV88K0ixzQBX0kr17DY69eEx+QnwNwjcZ
         lyhw==
X-Gm-Message-State: AOUpUlHgOH5Jaek3n02a9GEmaf681i2nk5A4Jv+y1/xtERAMC2vHAL70
        JC+R/IRu/J1Ud1nZzj63fxU1+w==
X-Google-Smtp-Source: AAOMgpfx1IJ0QaXjC7bEkJsW4Bo9griN2WJlJ0QapajNDim8rYtWZlom81OToYiEVM1OMgZAzzXiIg==
X-Received: by 2002:ac8:4457:: with SMTP id m23-v6mr26027333qtn.289.1533140774522;
        Wed, 01 Aug 2018 09:26:14 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id 190-v6sm9979233qkg.31.2018.08.01.09.26.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 09:26:13 -0700 (PDT)
Date:   Wed, 1 Aug 2018 12:26:13 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <jbacik@fb.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH v2] block: make iolatency avg_lat exponentially decay
Message-ID: <20180801162612.neoq7sm5wzxl6fiu@destiny>
References: <20180801002559.36261-1-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180801002559.36261-1-dennisszhou@gmail.com>
User-Agent: NeoMutt/20170714 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 05:25:59PM -0700, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> Currently, avg_lat is calculated by accumulating the mean of every
> window in a long running cumulative average. As time goes on, the metric
> becomes less and less useful due to the accumulated history.
> 
> This patch reuses the same calculation done in load averages to make the
> avg_lat metric more lively. Unlike load averages, the avg only advances
> when a window elapses (due to an io). Idle periods extend the most
> recent window. Bucketing is used to limit the history of avg_lat by
> binding it to the window size. So, the window range for 1/exp (decay
> rate) is [1 min, 2.5 min) when windows elapse immediately.
> 
> The current sample window size is exposed in the debug info to enable
> calculation of the window range.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Fix the nits and you can add

Acked-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
