Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735F3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4461E2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 17:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="A2Sft/WQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbfBVR6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 12:58:47 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:37422 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbfBVR6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 12:58:47 -0500
Received: by mail-yw1-f66.google.com with SMTP id k14so1156711ywe.4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 09:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TOEcho+GLt6cXpqefD54aAURhA+BCLd60PBO2YlEQPE=;
        b=A2Sft/WQmBlkr3es6WDbt1pSVeOb0argQnx9eefEZjBTB3xLC7GgQhNtSlJfskM1Fg
         R37WAh6H/HoHlaRlOnRQTO1uSyFx3seaP4cOLC8D3xGOLQij6ZyOTKmhRYuv88hg0ijg
         7xm7HcZJ6jcPZSmjp9oMEOtLNQQaCZ5asKyFQ2KZ9Wje3kpjOvaSVYcURl5Z21adry3/
         Ebv9NTRH2x97k/zjOmIBXlaO+9sDzWAV79QtZTjqciCnulz1ytOmQr2ncbMiS7XR1lVl
         ivnzGJeML4X2ulCkFKzGLfFJuvDnY7+MHPwhYpTTW2gf3t55yWuncKSTg+sxu8DUxHT8
         EWNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TOEcho+GLt6cXpqefD54aAURhA+BCLd60PBO2YlEQPE=;
        b=trRN4B1lEBk4F2A3E5vahTovwvrEClfCdGQb58pHfYb1lfIpCw+hz86ThOWnuoZN4m
         eSMczyQlzUu4jryPbC1p2GfJEpXNCtlIH/GFiMPEebcxc3SFr/R7tZxEd2AHNblfUUT0
         GdPBd4TY+mgZ6psMOtM3+K980GmslLwcll0XaY3bKkKMpueq4tdsXpzvim3t0IH+ImJ/
         oCCepqZXs7UZQlm/s+Xt4RywWpUQGsnWJuyC0tsFenmRQa3pCKdkYtKYt07AxnrX5MU+
         yHxT9boWFNsg7BWBPqNkjztEiCu6yY0MM0e6GraCPQ4jAda0Rug1aaYYI2AB0zpPyPM4
         YvfA==
X-Gm-Message-State: AHQUAua/grZtekBW+8Hw/fzWQDKStC1tXpNZd9ID9zVaKVx4SFNpHRxo
        JuNkx+ac9KYJMQrb+16nxRicHw==
X-Google-Smtp-Source: AHgI3IYEN0aOcdA52dHlcHW9Ome9v1T1GoRkWaUzDvIC+WxLj2bUrzb4Mk7QLwWGS88W2T4xf7csFg==
X-Received: by 2002:a81:a4d3:: with SMTP id b202mr4322592ywh.83.1550858326785;
        Fri, 22 Feb 2019 09:58:46 -0800 (PST)
Received: from localhost ([2620:10d:c091:200::1:cd3d])
        by smtp.gmail.com with ESMTPSA id n67sm2086197ywn.1.2019.02.22.09.58.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 09:58:45 -0800 (PST)
Date:   Fri, 22 Feb 2019 12:58:44 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH 1/5] mm/workingset: remove unused @mapping argument in
 workingset_eviction()
Message-ID: <20190222175844.GA15440@cmpxchg.org>
References: <20190222174337.26390-1-aryabinin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222174337.26390-1-aryabinin@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 08:43:33PM +0300, Andrey Ryabinin wrote:
> workingset_eviction() doesn't use and never did use the @mapping argument.
> Remove it.
> 
> Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Rik van Riel <riel@surriel.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
