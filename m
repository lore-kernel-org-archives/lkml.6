Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7794AC64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 23:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37C51218B0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 23:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="RgF+01Pp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbeLXXMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 18:12:32 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35648 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbeLXXMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 18:12:31 -0500
Received: by mail-pl1-f195.google.com with SMTP id p8so5997233plo.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 15:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VnsvBREq9o+zfsWgqB6eTBoRuDqOLjY+Nyv6Il1PQ7g=;
        b=RgF+01PpEEnQu/GNPM/NUIkEYDWnhTDsWxA+AUIrhGbefyNVtM5BUtGowVgtjsjh+2
         9TtCFTsiUDvrtX0+4m3p+cyMfi+VqYfZSUoQyIRNauC0WxaBnT055dS5JMICHvahkJQS
         FLle3W4HfP6Iicvi5cZKrqUkKMf8+gm5mqBPLPodJuipCaNUC4nFTZMbzJybXTOeh/2R
         dD2a0dkXtwmuo1DGVetJVREplay3GKe+uzAN+Rq3t5H4Bt2szB3lSfevArkAU90KUpHZ
         basCRVRT/n2szJyKve264wovaqOqp9qe/eB2WHbNwEZjf8vXe7OdKbHdbb5rQtHUNXxM
         Vtrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VnsvBREq9o+zfsWgqB6eTBoRuDqOLjY+Nyv6Il1PQ7g=;
        b=S2D4G42FckcGYcEaJB7uEB9go47VraZgsgd/DfpT76lv1palotSWLv+ItkDfRlrM7s
         SLcyohQ0g0P6KrTDxmQ0r8k2gdWwjbTG44JweHZ/1VcjqxrQe3vjUHT2RCRPT3Je9Z9R
         MVV8L4kSL0jBTcXUycOCLf0HErwzWG15aZeLJapCnz0lKfPctVG+JR/EszvnAFSNynT3
         AB+zV7OAQJuApNWO3lvtKVG9PyAmZVt6esPwVw+q+si9uYMxX8jg1O8MLNJESAzcjxFg
         WUNE6Gyrtev9vD4WN6YeEbVLgw0UGYza5JFySKgGAhm8FDty7fVt1l+JQTaXjgSiiqoT
         Bwtg==
X-Gm-Message-State: AJcUukfMa/4tz483G0R+HpCifQVwgOwSvW1XGli5spF1pCic4O2ND/Rz
        gTVKO05AwJMtO6WM8YfFIX22Rw==
X-Google-Smtp-Source: ALg8bN4MnBqMc32/pZL6zSLx/nenuWnZVoNPT/mKsJyHcR5bvUwNLxqtuX8LPUf8uf9dz4pUl73XMA==
X-Received: by 2002:a17:902:e290:: with SMTP id cf16mr14803496plb.81.1545693150829;
        Mon, 24 Dec 2018 15:12:30 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id 85sm49264066pfw.17.2018.12.24.15.12.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Dec 2018 15:12:29 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gbZOe-0007bE-RZ; Mon, 24 Dec 2018 16:12:28 -0700
Date:   Mon, 24 Dec 2018 16:12:28 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Joe Perches <joe@perches.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Tariq Toukan <tariqt@mellanox.com>, xavier.huwei@huawei.com,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Stephen Warren <swarren@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: Re: rfc: bool structure members (was Re: [PATCH V3] net/mlx4: Get
 rid of page operation after dma_alloc_coherent)
Message-ID: <20181224231228.GB17036@ziepe.ca>
References: <20181219182031.8675-1-swarren@wwwdotorg.org>
 <20181220174318.GA21404@ziepe.ca>
 <20181220174448.GA21149@lst.de>
 <1545328145.185366.500.camel@acm.org>
 <072c2d9d187daf0672bf54ab035e47a05fd1cd1d.camel@perches.com>
 <20181221033159.GF23877@ziepe.ca>
 <b906bec0fd12d25474561263087a26b8b0519fe4.camel@perches.com>
 <20181221235230.GC13168@ziepe.ca>
 <dc6d4923-63bd-e133-310b-7b164b0c92f5@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc6d4923-63bd-e133-310b-7b164b0c92f5@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 23, 2018 at 06:42:20PM +0200, Gal Pressman wrote:
> On 22-Dec-18 01:52, Jason Gunthorpe wrote:
> > On Thu, Dec 20, 2018 at 09:12:43PM -0800, Joe Perches wrote:
> >> Care to submit a coding_style.rst patch or
> >> improve the one below this?
> > 
> > I took yours and revised it a little bit. I spent some time looking at
> > assembly and decided to drop the performance note, the number of cases
> > that run into overhead seems pretty small and probably already
> > requires !! to be correct. There is also an equally unlikely gain, ie
> > 'if (a & b)' optimizes a tiny bit better for bool types.
> > 
> > I also added a small intro on bool, as I know some people are
> > unfamiliar with C11 _Bool and might think bool is just '#define bool
> > u8'
> > 
> > (for those added to the cc) I'm looking at cases, like the patch that
> > spawned this, where the struct has a single bool and no performance
> > considerations. As CH said, seeing that get converted to int due to
> > checkpatch is worse than having used bool. Using u8 won't make this
> > struct smaller or faster.
> > 
> 
> Since a "Using bool" section is added, perhaps it's worth documenting the bool
> usage as a function parameter [1]?
> 
> [1] https://www.spinics.net/lists/linux-rdma/msg72336.html

I'm not really sure how to express that as something concrete.. That
specific case clearly called out for a flags as it was a widely used
API - maybe less spread out cases like static functions or something
are OK??

Jason
