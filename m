Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C54C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FEEC20838
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 22:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="h2wee1T3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbfBUW7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 17:59:40 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44951 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfBUW7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 17:59:39 -0500
Received: by mail-pg1-f193.google.com with SMTP id j3so127022pgm.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 14:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jm4drYWQ+zzE9+IfJHgzMjeQ4vONzj9va9RWmBRBNa8=;
        b=h2wee1T3eGM7ZVK2rCHeA0MksTAWEdnnUQlZEjY6Nlo1cu/C8sqy7azb72EjNcNoWU
         cEnMESLt3SGZWKBCuZR6z7OL8sHYesnkkTLScD9Q5TFkMoOvbi5cw1Gz6ZN6TNI6y8d3
         yMmTGCgAJbTTJa3XBaq7UT7OXd/e41RzfdLSuRFKgXkeU0DFEIHfGSE6wKscwianDAiJ
         T6ZPxieoyZl5iDocO7tBfLWFffG0i/8jMOlbM9vCDNzXrlQv0qTaCZ6wvnOfiiVOU9Qk
         87OT3PYApUgzK7JXn4HMf8LKmG/MkK2eNriTfmimehoY2mSo1a1ZARJwFq+sWuPzEQdM
         EVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jm4drYWQ+zzE9+IfJHgzMjeQ4vONzj9va9RWmBRBNa8=;
        b=XR/ae2wbz2+wt2hH8jdJDlmqLBgV3bXlTVxmj3k3syAmNiRkTZyyJP5wt3RQZ+ZREZ
         FsKslhHctwjxqYhsbZ77JF+Yv2AXWJarQButBU+t5GJpO0LfSAQ+GZlQLkGPpFGM8Hjd
         IFTEwkqJsOymv28tppV3bcIiiMbK2Duel2hT/ke8SX2L0qDBLvYSbp2t+umtWxml4Nt9
         ffS/v/Hr7KNaxPpl+QfPfQvgNDLuNHrR215nOluYI5ea0gSeCobI8bpqEYgTGF7MWpMT
         LUrxoCTqJggNj83nxzueoq6RiNnjLsTedJMtl2aDjRJB9EtKUBaFmJVLGXO47XxuNMhO
         jekQ==
X-Gm-Message-State: AHQUAubWcEG0yb0UiC+5S06+J+pUolnEXT3glBSDThT1bdmDJlUF7h8g
        D1LQUlOSElKPPFmPSpZeuHmTyGcYdUcsQw==
X-Google-Smtp-Source: AHgI3IaaCNIIKr9l7A5Za3rx8mLVdG6YZR82ClTb05TH/Gm3hk65KOSMHslLnj3J1fKmPLTrg1Xg4g==
X-Received: by 2002:a62:4299:: with SMTP id h25mr897328pfd.165.1550789978923;
        Thu, 21 Feb 2019 14:59:38 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id c7sm126868pfa.24.2019.02.21.14.59.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 14:59:38 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gwxJZ-0002fH-9d; Thu, 21 Feb 2019 15:59:37 -0700
Date:   Thu, 21 Feb 2019 15:59:37 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jerome Glisse <jglisse@redhat.com>
Cc:     Haggai Eran <haggaie@mellanox.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Kaike Wan <kaike.wan@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Aviad Yehezkel <aviadye@mellanox.com>
Subject: Re: [PATCH 1/1] RDMA/odp: convert to use HMM for ODP
Message-ID: <20190221225937.GS17500@ziepe.ca>
References: <20190129165839.4127-1-jglisse@redhat.com>
 <20190129165839.4127-2-jglisse@redhat.com>
 <f48ed64f-22fe-c366-6a0e-1433e72b9359@mellanox.com>
 <20190212161123.GA4629@redhat.com>
 <20190220222020.GE8415@mellanox.com>
 <20190220222924.GE29398@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220222924.GE29398@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 05:29:24PM -0500, Jerome Glisse wrote:
> > > 
> > > Yes it is safe, the hmm struct has its own refcount and mirror holds a
> > > reference on it, the mm struct itself has a reference on the mm
> > > struct.
> > 
> > The issue here is that that hmm_mirror_unregister() must be a strong
> > fence that guarentees no callback is running or will run after
> > return. mmu_notifier_unregister did not provide that.
> > 
> > I think I saw locking in hmm that was doing this..
> 
> So pattern is:
>     hmm_mirror_register(mirror);
> 
>     // Safe for driver to call within HMM with mirror no matter what
> 
>     hmm_mirror_unregister(mirror)
> 
>     // Driver must no stop calling within HMM, it would be a use after
>     // free scenario

This statement is the opposite direction

I want to know that HMM doesn't allow any driver callbacks to be
running after unregister - because I am going to kfree mirror and
other memory touched by the driver callbacks.

Jason
