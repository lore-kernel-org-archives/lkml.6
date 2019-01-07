Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637D9C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30AC5206B7
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:00:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dhDqo4iw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbfAGTAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:00:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45120 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfAGTAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:00:09 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so592549pfd.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 11:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Rnn75Of4j1EMaY2hrLBbOjqdnaHFcmW93vTveFw6A+U=;
        b=dhDqo4iw+tw7Hfc8IA1gEhtp/iljfCM5hjz7kmYZSpebHiE3PCHkodcRQ5Di9bIhe7
         sYpuTbdtCMeUCaDBGvi0qN3kn7G7mWz7ORPVbI5VkTyCazYnwAQ6cZj28cRJomeSDtj9
         XZNEaJ0993HwifSjNNrPNJkh0n4hc5jgxAAl3wO28J3iQy8HCF+jzG2rU/sUh+iAvOlz
         rGTF98v5Ol3kgKsbLQtWwFrrG8f8k7n9lO9TjG9roKzXaY1fuqeHSp0PcEX0/eMxbv6E
         XANRBOq1pAAm2Y63DTcWvYadfiAfZLlwLMfqw75IpAfmNNvHCqRiSWjSt2QEpSsPJo6G
         q1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Rnn75Of4j1EMaY2hrLBbOjqdnaHFcmW93vTveFw6A+U=;
        b=RWVSiG/sNEKG64eiPAQ0j4lrqz6KGEhtiqy19kc2OMq3/tOfCEQiPCXBphxJoXgXPq
         ApGG52E5SpibkIgUVRAqNzYazaoOvsY0p0/6to0NNS0gu8eodWoPO7OjRJ2W8K1fGdAR
         QAEKvm3psnyGfJ6TOoxwXqwXiS1SmEYgD6KzZ96uw2O3c8P/7kNOqoErQzerv/H1D9PV
         l1T6Wn+Oe7eA7fWV35y9kh20QltUEE4THh5t0TqygJIHiCP9/NMQKEckyRQeBovdMlOY
         3aOb+6PwzgnhBiDnKSCYfkUqsg7qP8tY8r0tw2ZQHte3ZCzr7kGxiKvN+/aKRB3Zh/Lk
         m3uA==
X-Gm-Message-State: AJcUukdOhlResvFaPywuEwy+3SdR2EnD7SeH2yNscpodVhDB71Az3ZZ2
        6U9MxkCbDFH0L6aYHVY+M8Kv3A==
X-Google-Smtp-Source: ALg8bN6WNLHjYrkMktzZIJxDtSAjLqsQy2px/5v9BIFXr15xul3p1HGXP66qD+OMXKE3aYJTsebE3A==
X-Received: by 2002:a63:da45:: with SMTP id l5mr12002402pgj.111.1546887608639;
        Mon, 07 Jan 2019 11:00:08 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id 125sm115588965pfd.124.2019.01.07.11.00.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 11:00:07 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gga86-0006FX-Vn; Mon, 07 Jan 2019 12:00:06 -0700
Date:   Mon, 7 Jan 2019 12:00:06 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/core: Use struct_size() in kzalloc()
Message-ID: <20190107190006.GA23891@ziepe.ca>
References: <20190104181558.GA2403@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104181558.GA2403@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 04, 2019 at 12:15:58PM -0600, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding the
> size of a structure that has a zero-sized array at the end, along with memory
> for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can now
> use the new struct_size() helper:
> 
> instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/infiniband/core/sa_query.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Applied to for-next, thanks

Jason
