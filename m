Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962B8C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495AC21521
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:23:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="ywElcmOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495AC21521
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731744AbeISUBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:01:10 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46770 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731391AbeISUBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:01:10 -0400
Received: by mail-yb1-f194.google.com with SMTP id y20-v6so2416143ybi.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 07:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CQ1dFM9Sw0pYDAvGYT6k29iUU9y9kH/dyOXYVbWUYw0=;
        b=ywElcmOA/951O4PoXvgSC4j1Au8RCiPCKT9hkusQDCaLFj6ILQvEM09Rng4zb9zAo/
         nRy71n+yVCWN7gMP4caTdIw3ZUiUc88/pIHkJYZGKcHm+PJgyoOchGj9rmJaPWubwrQY
         EqpyFpdQyHGPjcHG03hJFpnd0/Yi0nivate12o/zl3Tyl4OP8vt7UpUSL5zd72YlGibT
         Mjl/j7qTpZy30CEQnlM98l8SMbg1aMp8baXhwDpy8PmNmGgjFjqfBfyqo7Jii8M5CKfO
         1cJna+Yth6KJBoHlRk+I4mQZIxTeVGvl4uG29uEY58I8a0lfBpx3eAScU0Hf4KgTeCDp
         xoOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CQ1dFM9Sw0pYDAvGYT6k29iUU9y9kH/dyOXYVbWUYw0=;
        b=VQPsSj4Ut9r4YPJ40xo5xI2Ft8aM/6kKTgRvmsRkCDq21odM586juVcWjCg1dXawUj
         AB2qjHvhTBRGfPQBTE+WLxAKh6aOhhNGI+jVDO/b0vdJ8re70dkMnlvwATQyXpDvJwor
         effkAWc8DArtnMS24wzqcNPZ884qW2rVaWDf7Vl3nX6eZEqz1rOzMFQJXzR0e0bYDQ4M
         F+68kTf1ItDtFYVFDGYExCk518y4ksR5kzOW88l9Dr9VxZ7t5WvxN25yp2386WFeomgz
         9jKydH9KDcDvDa5k6uy5jCBvQn/PxGkyfTV2wjAWr568d0CjPpBMohPFNOZ7OeI758WZ
         SCzw==
X-Gm-Message-State: APzg51BcIjOW6Lgy7oq/Ij3T0VUwahr9hiOoHx/i7hhKS/58xXJqc+um
        UzhEeXihRAlmXDWi4qwZBTn60Q==
X-Google-Smtp-Source: ANB0VdZRNyNvlbE6Ba3sOFbqKnkN/XBxn50IWsAP/dRbVS3KpvzRbSUMHGZTviJGn+Y7QnoHGlmFEw==
X-Received: by 2002:a5b:cc5:: with SMTP id e5-v6mr4154414ybr.9.1537366980851;
        Wed, 19 Sep 2018 07:23:00 -0700 (PDT)
Received: from localhost ([2620:10d:c091:180::1:9a94])
        by smtp.gmail.com with ESMTPSA id u196-v6sm2055878ywg.68.2018.09.19.07.22.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 19 Sep 2018 07:22:59 -0700 (PDT)
Date:   Wed, 19 Sep 2018 10:22:58 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Thelen <gthelen@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: remove memcg_kmem_skip_account
Message-ID: <20180919142258.GA15400@cmpxchg.org>
References: <20180919004501.178023-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180919004501.178023-1-shakeelb@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 05:45:01PM -0700, Shakeel Butt wrote:
> The flag memcg_kmem_skip_account was added during the era of opt-out
> kmem accounting. There is no need for such flag in the opt-in world as
> there aren't any __GFP_ACCOUNT allocations within
> memcg_create_cache_enqueue().
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
