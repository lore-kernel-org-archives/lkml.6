Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A86AC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEDC3204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 15:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="G4Z1KGcm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730683AbfAOPOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 10:14:05 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46739 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbfAOPOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 10:14:05 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so1342375pgp.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 07:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gvcrVGBeH/udJyWosupO807MtSU2G9zk8J/wtcc9hNQ=;
        b=G4Z1KGcmqM2IFk4lXQfYRs8zq4UhXeKEg9JARVEHm/y+BwrSMaDmbZmZL6YvP5Q4Jt
         ZsVxtq2KMwHzUbf461SKdO1Zqi5+V7OUaGciPheNzMI29/N2oCGrqx94whTdnwIQUuaD
         PZsIFr+yHA1VHranAdQ4u+2hBQFhIYqdBkMHabMdW8Slu77fcce6Zq7acgYB6fyYYCW5
         LqGClrJqLO37/5Wam6qFUta9tNAgB06aUQEwk4ILfKZaD025O1ygOgeOrUmMk1jWTgmx
         vdh2PGiMZ+cVuU5ewXiqmW6pC8xr0cryx/9FN1w856rRDarMvwlghuAWxl0A6JBMQ5vk
         sqJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gvcrVGBeH/udJyWosupO807MtSU2G9zk8J/wtcc9hNQ=;
        b=l5GI31AlKSPUcX7+jKQ7sYjOQ2Y2L2q1i609bz1a5Sy/3b4CeMR4la+/Z8X/taiPsC
         a9W24G/6tJZZVFQdJivo3ddSOCSqSHXKpm33dCNzX9xFdcU2mgCc0xMkmHccyrS+syl9
         b7pNYQ7KEr4yK44Z25au2Cy+TxtEpEIqs1PACfjrxiSUTSL6yLwwtQKxDKD+RSpGz73O
         dDPYtzGTQ/dHS5UZJXiebQ3O64989/1VA1kDQvL6U5Qz7EzRR5xdSONozRet3ETLZjIj
         rrZNS+KfqrGMCn7PK93hV7umGgzyEamNSvEwGDc34IuyC/sn3lpwqi7Rr74HS0ldXiec
         Nygw==
X-Gm-Message-State: AJcUukcQCTkcfzJhLXgOaYw+tyIYFvzbqmEXgEy3a5U90lgk6U3jYUgO
        tQLqHDW0fBbzpYmPhxLRh0oUpXEUuQg=
X-Google-Smtp-Source: ALg8bN7jTTWWN/jexkjN5sA/X9p/yvWobH7kp3RCv9odiyQ5mO83HWT+XvwAp+1Ow6srNcIN46DQkg==
X-Received: by 2002:a63:dd15:: with SMTP id t21mr4064496pgg.347.1547565243921;
        Tue, 15 Jan 2019 07:14:03 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id b7sm5394855pfa.52.2019.01.15.07.14.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 07:14:03 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gjQPi-0005ut-9t; Tue, 15 Jan 2019 08:14:02 -0700
Date:   Tue, 15 Jan 2019 08:14:02 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joel Nider <joeln@il.ibm.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] docs-rst: Convert user verbs doc to rst
Message-ID: <20190115151402.GA22045@ziepe.ca>
References: <1547547991-5314-1-git-send-email-joeln@il.ibm.com>
 <1547547991-5314-2-git-send-email-joeln@il.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547547991-5314-2-git-send-email-joeln@il.ibm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 12:26:30PM +0200, Joel Nider wrote:
> Move user_verbs from infiniband to userspace while changing the
> format. Replace the existing Documentation/infiniband/user_verbs.txt
> with Documentation/userspace-api/user_verbs.rst. No substantial changes
> to the content - just some minor reformatting to have the rendering
> come out nicely.
> 
> Since this documents a userspace API, its home should be with the
> other userspace API docs.
> 
> This is in preparation for updating the content in a subsequent
> patch.
> 
> Signed-off-by: Joel Nider <joeln@il.ibm.com>
> ---
>  Documentation/infiniband/user_verbs.txt    | 69 -----------------------------
>  Documentation/userspace-api/index.rst      |  1 +
>  Documentation/userspace-api/user_verbs.rst | 70 ++++++++++++++++++++++++++++++
>  3 files changed, 71 insertions(+), 69 deletions(-)
>  delete mode 100644 Documentation/infiniband/user_verbs.txt
>  create mode 100644 Documentation/userspace-api/user_verbs.rst

Need to update MAINTAINERS for the new file.. Maybe call this
rdma_user_verbs.rst as we could also have rdma_umad, rdma_cm, etc
 
Jason
