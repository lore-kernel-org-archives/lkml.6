Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B53C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8721D206B7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 03:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WX3l9cQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbfAHDVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 22:21:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44863 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727266AbfAHDVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 22:21:38 -0500
Received: by mail-pf1-f196.google.com with SMTP id u6so1179083pfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 19:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B+IMLFXA2HBWr9n3CSZyHCQgAJd6sL2aKSC1pqE1yWE=;
        b=WX3l9cQXAerAtlqzLWevVcUeVb4gVgyUZyAa/aKBpcH5JJlCCpQcp/ML9NGBHKC7d3
         4iAr6S7xUuHV7z50ahXhQMPoTf9cuLg5Ep7B1KS1UGK/lqlFV5LH1BZ59coxCl52ddh3
         l2/retWusX1Hr95GA3I5NSNCjWROYNJ8j9c/NwZWvsNBVboBqg+5ZiCQoBwT143njRUp
         RwZ5wJkvBkSavlLI1Cuqa5VuuOrK0RYf75To+U9n2qAMr5iwnwTKqdfgV6e/toZ5t+Q7
         TYlF0qJLWQsJn1tZ6AwFa79kJ5cSJDlyhTNy7Zh3Gd7bQfcrgINyHuQoWX/byYyaXldY
         Y+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B+IMLFXA2HBWr9n3CSZyHCQgAJd6sL2aKSC1pqE1yWE=;
        b=OeMkY7vsbleo37TQCoCoEwY6v1gRumF1naUvU5DBvRGSuIwikw4THhwCvxhH4pe5BX
         3MopQtTT4ppITySMTLuWXGYet3wPqoqnwbTMTYWWuyHOjWfP3pYcJkdOjDZTGJhSITxq
         15qKnTwxoKUgDcBJskSorXGqJVoBQoNPIzDWSgw7QtAWQsCqFhNka4sGM+ziXdkVnkDh
         eWq2l7e8Yxf5QsnBYNKRaYLIXOqyPCehIZTlUlEFXj4jRR1rfw+boMOEqXJhxyoUVpJR
         7FQrzzCDzHLTg6vEFacph+VwdYl83NAKqQVvnpc9dJ5nlTG96+giZD74cTBl8npyy5IM
         H5kg==
X-Gm-Message-State: AJcUukcJ+RZtPRAXye5U8w04zogmZ/+Ea1gQo4wybIKHthH2/ec6igwm
        Y/QrP3ZaraGrwByVqj3oJ4V9zQ==
X-Google-Smtp-Source: ALg8bN5J9Ayv2qMrnhkeIeSu00a3FeZWz1Wn9K3Qy5L9lHz3l96YMI3YTtvbfFlnyNcTRCafy+4sMA==
X-Received: by 2002:a62:61c3:: with SMTP id v186mr79602pfb.55.1546917696839;
        Mon, 07 Jan 2019 19:21:36 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id d80sm188498451pfm.146.2019.01.07.19.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 19:21:35 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gghxP-0006zF-5N; Mon, 07 Jan 2019 20:21:35 -0700
Date:   Mon, 7 Jan 2019 20:21:35 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joe Perches <joe@perches.com>
Cc:     Gal Pressman <galpress@amazon.com>,
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
Subject: Re: [PATCH v3] coding-style: Clarify the expectations around bool
Message-ID: <20190108032135.GD5336@ziepe.ca>
References: <20190107211117.GA24142@ziepe.ca>
 <8ec3603317f477fe9923b87499a33da7a2cf81ff.camel@perches.com>
 <20190107232513.GA5336@ziepe.ca>
 <9bc80bb861899633ba93e6c81d36d2201b05936b.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bc80bb861899633ba93e6c81d36d2201b05936b.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 04:38:50PM -0800, Joe Perches wrote:
> On Mon, 2019-01-07 at 16:25 -0700, Jason Gunthorpe wrote:
> > On Mon, Jan 07, 2019 at 02:10:22PM -0800, Joe Perches wrote:
> > > On Mon, 2019-01-07 at 14:11 -0700, Jason Gunthorpe wrote:
> > > > There has been some confusion since checkpatch started warning about bool
> > > > use in structures, and people have been avoiding using it.
> > > > 
> > > > Many people feel there is still a legitimate place for bool in structures,
> > > > so provide some guidance on bool usage derived from the entire thread that
> > > > spawned the checkpatch warning.
> > > 
> > > Thanks Jason.
> > > 
> > > It'd be nice to combine this with some better checkpatch warning or
> > > even a removal of that misleading warning from checkpatch
> > > altogether.
> > 
> > Okay, do you have a preference?
> 
> Yes.

Great, done, thanks

Jason
