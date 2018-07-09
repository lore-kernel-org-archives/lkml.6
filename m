Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B4CC6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F310520882
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mrqbcm7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F310520882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932617AbeGIItv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:49:51 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:47074 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932508AbeGIItt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:49:49 -0400
Received: by mail-pf0-f195.google.com with SMTP id l123-v6so13185240pfl.13;
        Mon, 09 Jul 2018 01:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HatlDdLkdCGZiiH4zsg1PKKYLJ9AGUgcoOCwUB0hlNU=;
        b=Mrqbcm7WCf3eRBa0NzmPYOv7e7K1MCVcGDt7SNpy9R9cCW/5M07qb9CCCFUw4TpfIC
         IlJNcH82dFkRMJheC7ryOnvKp9AMNz0VkWnvMoKMkgjxF7aBok6QMRn25wcJKF+ua6mo
         iI7Jg6vUyktjqNTDV9QwxWTnEYyrvJMUcuXJC6nIJvbGBjaWDY1+6CFF6kUsunHGaRgs
         yqCRyc2i2EREfwov6yLuEFnrxp9LTBHSh27MvkLWNVq/w6hVr/JeCve4A56s+pRudPGM
         HIK4r0nC0VcFs2mtPIDq1S0f1AiYnwm3veJewOvi+oe1c2khwCcZeryaNxnP+K93DZn8
         GUow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HatlDdLkdCGZiiH4zsg1PKKYLJ9AGUgcoOCwUB0hlNU=;
        b=PCkGK6cDWEJW0FlCU1/STNBTJlLHVUuwVe4W0ZyjOJcmg0btsF6uaM+UWTwF1xlPTZ
         r5gMxxM18tvKE8Vo+9iYPRx8Isvc0gscsHKesknkNf5QaPgobqulleiQfwO59zxrLMx9
         TqYdyc/+Z6WaM3TWRvXEVy/tsa9CDxoy+1Gn4czil/J4EGFmc9qOd1POBiy7yXzNwVOF
         9Tn18eELJxou7nPEuExEswDatij93Qwex7QI0RCYfi/e4kyteD8v5ZrCtn4+AeYnt5uG
         gDstcNGfceV1fMQ5eSD2KAcYI5dQlfml+BT6ihcObVq7fBzTvJ3HVabved8EJljoJnR8
         rLLg==
X-Gm-Message-State: APt69E0raxxx240etMu6eGatkqgeJUnL5nGsMEywbmiceDZLhMSnYqFd
        zKR9RvD5FVnT2g5RsrZtUjo=
X-Google-Smtp-Source: AAOMgpc8TmWBJWgc8Oc9FHvIdvonM/tq2ctmc797UBGG2/nL9j72pYNS9xIbYqd1P9B4iTxGDIHY0g==
X-Received: by 2002:a63:7703:: with SMTP id s3-v6mr12381856pgc.339.1531126188525;
        Mon, 09 Jul 2018 01:49:48 -0700 (PDT)
Received: from roar.ozlabs.ibm.com ([122.99.82.10])
        by smtp.gmail.com with ESMTPSA id p18-v6sm14301279pfe.22.2018.07.09.01.49.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 01:49:47 -0700 (PDT)
Date:   Mon, 9 Jul 2018 18:49:37 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     john.hubbard@gmail.com
Cc:     Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH 0/2] mm/fs: put_user_page() proposal
Message-ID: <20180709184937.7a70c3aa@roar.ozlabs.ibm.com>
In-Reply-To: <20180709080554.21931-1-jhubbard@nvidia.com>
References: <20180709080554.21931-1-jhubbard@nvidia.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Jul 2018 01:05:52 -0700
john.hubbard@gmail.com wrote:

> From: John Hubbard <jhubbard@nvidia.com>
> 
> Hi,
> 
> With respect to tracking get_user_pages*() pages with page->dma_pinned*
> fields [1], I spent a few days retrofitting most of the get_user_pages*()
> call sites, by adding calls to a new put_user_page() function, in place
> of put_page(), where appropriate. This will work, but it's a large effort.
> 
> Design note: I didn't see anything that hinted at a way to fix this
> problem, without actually changing all of the get_user_pages*() call sites,
> so I think it's reasonable to start with that.
> 
> Anyway, it's still incomplete, but because this is a large, tree-wide
> change (that will take some time and testing), I'd like to propose a plan,
> before spamming zillions of people with put_user_page() conversion patches.
> So I picked out the first two patches to show where this is going.
> 
> Proposed steps:
> 
> Step 1:
> 
> Start with the patches here, then continue with...dozens more.
> This will eventually convert all of the call sites to use put_user_page().
> This is easy in some places, but complex in others, such as:
> 
>     -- drivers/gpu/drm/amd
>     -- bio
>     -- fuse
>     -- cifs
>     -- anything from:
>            git grep  iov_iter_get_pages | cut -f1 -d ':' | sort | uniq
> 
> The easy ones can be grouped into a single patchset, perhaps, and the
> complex ones probably each need a patchset, in order to get the in-depth
> review they'll need.
> 
> Furthermore, some of these areas I hope to attract some help on, once
> this starts going.
> 
> Step 2:
> 
> In parallel, tidy up the core patchset that was discussed in [1], (version
> 2 has already been reviewed, so I know what to do), and get it perfected
> and reviewed. Don't apply it until step 1 is all done, though.
> 
> Step 3:
> 
> Activate refcounting of dma-pinned pages (essentially, patch #5, which is
> [1]), but don't use it yet. Place a few WARN_ON_ONCE calls to start
> mopping up any missed call sites.
> 
> Step 4:
> 
> After some soak time, actually connect it up (patch #6 of [1]) and start
> taking action based on the new page->dma_pinned* fields.

You can use my decade old patch!

https://lkml.org/lkml/2009/2/17/113

The problem with blocking in clear_page_dirty_for_io is that the fs is
holding the page lock (or locks) and possibly others too. If you
expect to have a bunch of long term references hanging around on the
page, then there will be hangs and deadlocks everywhere. And if you do
not have such log term references, then page lock (or some similar lock
bit) for the duration of the DMA should be about enough?

I think it has to be more fundamental to the filesystem. Filesystem
would get callbacks to register such long term dirtying on its files.
Then it can do locking, resource allocation, -ENOTSUPP, etc.

Thanks,
Nick
