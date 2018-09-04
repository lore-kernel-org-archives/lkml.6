Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74646C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA3A2077C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 21:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NKpr7F91"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA3A2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbeIEBvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 21:51:23 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38140 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbeIEBvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 21:51:23 -0400
Received: by mail-pf1-f194.google.com with SMTP id x17-v6so2317384pfh.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 14:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=x6uKxs3AEs7EhL+w+SN9yjJKB3/rhDg5u7ESLlqibjc=;
        b=NKpr7F91h4XNAqM2ywgDC8SO8yqh9z2RWj6MWyF+pw9Rm/d4S+xAY6fV0nmdLsKfAw
         Ljpfq5BQyITlUIGqGgclj/7dsQmQOGRtgjZU8JF61Bg+XYJs4s1Gj18MahfnawMImcXn
         4v5dvvgUNM5zKmEjes3K9vPdYgqPMbep+BZn1o1zYFscy8jxbQkN+JBkditcnXy+Q1Sb
         Urz09WHe8iRnHUxHzRQWFmDwZqiDGtPDLYQUptGJ3BoWSmLazsI+aaKBddM2yRyiR14M
         k/7Adsq6QQpGFMQOQO6hCKgGcAzA7sPQrbF8smMa1ONENoKz5aH8lNsLy8EmFaN7xv+H
         37DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=x6uKxs3AEs7EhL+w+SN9yjJKB3/rhDg5u7ESLlqibjc=;
        b=KFWkxp8hQaVG44nEbmVexxeZ74ufs9z1rWMrn61UBmUMsbhHI6L1aeg9+p9fpSWnyV
         77vW0A5fDCCGmMjIRfyQ62h86gBac73TkWDyWp9RAVGq+SYyNNfma5PglHQeNa1s6hnj
         uRvrL16HGNf7WQBrQRZvEtdzboV3ehEbeZe/UzSTRmPz/8LAtUzeqHNA6o9dU/we/gsH
         Gb/Yx7zAZBf1guaTGKhUJKiqfkLZjPFM3K7KIMPhzABhc7w+1XdCNBrYsbpYK4FpFsbu
         WiozsG4yU2htm7IwAtThcNqApIkjPUii11m8PufiML2P79ZxNXsR0FR1AoGwXnzyAtnJ
         8iUw==
X-Gm-Message-State: APzg51A/lhmIjDDswINyQFCYzK0K8qiRyWvMNol0w57hi9Q0CuBGzNHi
        1VM7W+YbBOgMNgecyEJuYDDbDw==
X-Google-Smtp-Source: ANB0VdZIztPiwgQj9XXaMT2UaT2YZpweBdczfEqZcHaHQQGWcNX5KVP7WUBetI0aKp03DDEcRKxIDg==
X-Received: by 2002:a63:e001:: with SMTP id e1-v6mr7150698pgh.380.1536096266618;
        Tue, 04 Sep 2018 14:24:26 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id r12-v6sm29540136pfh.79.2018.09.04.14.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 14:24:26 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1fxIoD-0004sN-Dr; Tue, 04 Sep 2018 15:24:25 -0600
Date:   Tue, 4 Sep 2018 15:24:25 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jann Horn <jannh@google.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Sean Hefty <sean.hefty@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/ucma: check fd type in ucma_migrate_id()
Message-ID: <20180904212425.GD18686@ziepe.ca>
References: <20180903165414.248309-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903165414.248309-1-jannh@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 06:54:14PM +0200, Jann Horn wrote:
> The current code grabs the private_data of whatever file descriptor
> userspace has supplied and implicitly casts it to a `struct ucma_file *`,
> potentially causing a type confusion.
> 
> This is probably fine in practice because the pointer is only used for
> comparisons, it is never actually dereferenced; and even in the
> comparisons, it is unlikely that a file from another filesystem would have
> a ->private_data pointer that happens to also be valid in this context.
> But ->private_data is not always guaranteed to be a valid pointer to an
> object owned by the file's filesystem; for example, some filesystems just
> cram numbers in there.
> 
> Check the type of the supplied file descriptor to be safe, analogous to how
> other places in the kernel do it.
> 
> Fixes: 88314e4dda1e ("RDMA/cma: add support for rdma_migrate_id()")
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> Only compile-tested, because I don't have an environment in which I
> could test this.
> 
>  drivers/infiniband/core/ucma.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Yep, this looks right to me also, applied to for-rc, thanks

Jason
