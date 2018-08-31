Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E0FC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDAB2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="Ned2hdW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BDAB2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbeHaTxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:53:37 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:45392 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbeHaTxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:53:37 -0400
Received: by mail-qt0-f196.google.com with SMTP id g44-v6so14969699qtb.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 08:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nuFNt6MCancQNI3iR/De5cCHy3/7r6A9CMgcd5Jtrpg=;
        b=Ned2hdW+c4ekVJhYUok8ynF4fmDNMaboUbzphHYLRJTD6CN6CxdJClw6Iy1QMnKwXV
         jTKG3rfbDqvYA/Go+t7E4pLVzkWixFGtuQ6sPZS1zSrXnF4K+rRlObqzqL1uAhLJJYUO
         xSlnQZYtyuDPFevh8bQf/iu9bHHl1WVsfzqioOCtMotEcUNFN1JDyPu5sPfbvFSHHqMp
         aGYW2T6vugkXBZ25eqmLEvdFUxpYrKgKZP4stdmbY4MWbviYV3sC9SecSJ151RB2Zmdc
         wJJ/0X3Ws2qBup1WR8kgl6Lx2+O+zz4JxIt3luRPJOtwTGUCr0dTmhSFnQC9Dikq77JH
         tg1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nuFNt6MCancQNI3iR/De5cCHy3/7r6A9CMgcd5Jtrpg=;
        b=cWB3JAnABqQbd3EZQqSUCkK73TxwW5wsc1PmPw/Cqybs5vEvMeqcxFVLThhLYxY3VH
         horb9oQ7dKyfxhkQA/Anps3L1uFB/+FVuwxeC5DzzJw3Cya3fwvVweEBhKF+WT0ZgEOB
         3CdGTX8AirY2Z1GNInMsJ5UAKcqRpoyU2rQ715rljGbFt3wXjlBPlbSlKHD4xJKtza0O
         uOfUTUQs9JgDyBovI6UxCjwUBfdE0rEUCRIbBxevygVTLZY2amcqM6cCCD7APfGiYkrt
         nc6gHMXLDLHOv30LuaQJKmLQhgfZbycNns49JbGB7Sdp+Ry+rm674/6rVfhnAhJxGqz1
         NshA==
X-Gm-Message-State: APzg51A4XRRTy8daNBhG3i7rq3wKcKvYeDlc7KzKlivWei2X5SI0Jl1w
        7xqsqJHgtPJctFak7fsh318XhA==
X-Google-Smtp-Source: ANB0VdYih0+3d9UD7z6weeD/J8ekfMQ8fUT2UZbQod3hDGM/zvz34a0hQsjFzskVA6Po0hu884oB5A==
X-Received: by 2002:aed:3ec5:: with SMTP id o5-v6mr16875282qtf.270.1535730331584;
        Fri, 31 Aug 2018 08:45:31 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id n41-v6sm6824779qtn.73.2018.08.31.08.45.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 08:45:30 -0700 (PDT)
Date:   Fri, 31 Aug 2018 11:45:29 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Dennis Zhou <dennisszhou@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>, kernel-team@fb.com,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/15] blkcg: associate writeback bios with a blkg
Message-ID: <20180831154528.y4x67cr7lr5bi4bf@destiny>
References: <20180831015356.69796-1-dennisszhou@gmail.com>
 <20180831015356.69796-10-dennisszhou@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831015356.69796-10-dennisszhou@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:53:50PM -0400, Dennis Zhou wrote:
> From: "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>
> 
> One of the goals of this series is to remove a separate reference to
> the css of the bio. This can and should be accessed via bio_blkcg. In
> this patch, the wbc_init_bio call is changed such that it must be called
> after a queue has been associated with the bio.
> 
> Signed-off-by: Dennis Zhou <dennisszhou@gmail.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
