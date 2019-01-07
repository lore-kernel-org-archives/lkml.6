Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45485C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:49:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1660C206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="LuqQjKpM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbfAGStB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:49:01 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39305 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726978AbfAGStA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:49:00 -0500
Received: by mail-pf1-f194.google.com with SMTP id r136so593172pfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 10:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nPd09LIK7wj7apwVv1NmSyQ2+UKjJpJQo8+xzpAIZp0=;
        b=LuqQjKpMB/VbF8ZSVa9AB8EVm/dz7AwLy5BcAZo9XRdgRbzN+KI81i5b8qOBIb2Z1P
         NAEA5j/1DWI2jtgy16s3yl+ZtW+sdZvp4D6T9by2tFKbX10GP2AgHteNDY+iBKnKcriK
         uollrH4OZ3kOupvPjqVbmlasy7/ttvSoXc/Md48kGa0m+fxwdMjEtAUI3vSvHtPLMeAj
         7kmLDG7DfRRhM0DFvvob66r3UEAGe6y+KhQj+JxRwfyj7ha0cygxUVmW73sVNks2ROC7
         fO+iM5U2uuamyUeiuEx4BzKp0W0dCl/EFR+5AATH3n5mH/mkO+gmkc3Zd2kyLSBo1w8g
         iFbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nPd09LIK7wj7apwVv1NmSyQ2+UKjJpJQo8+xzpAIZp0=;
        b=BKwPvEcvHF3VvHPzIm4TzHTvmCM75npQ7f7UAMH9rCk9PSwyFp2yke61hds/x1Zdhw
         otWR7q7MHgDBb5Mmaj3nmqnegd0ZB/ijrIg9Ex3vd6DYkoo64fY5hHAKJPzKzqw7IRFW
         UzIN6FwlNijuXxJ/p3SD70yvJo8EqXA04EqFyUYH33RzW+Ty+vYI89Bwn5wiAue3p445
         RJr+PJU50Q2WsglUzb5ZiPu35DrBZ6MvOuQB1/Dx+B4Pu4ht/goJk/KalXstX417lLOn
         0aUJN0kOcLttnTW0+Drzaf1bepap52yUStM5m67JPSwnzGogWkzKQLE2kuC4aHMdaASz
         VrWA==
X-Gm-Message-State: AA+aEWa+kxv7PYe6scNb6qTPpCDjuMptTQbD5xKDD3O1q/IPOgIReRqQ
        7AqmFiuhHONfhiZutE4lQBpIdRv/3Pw=
X-Google-Smtp-Source: AFSGD/Uh5e+Z3vCNgdH6WqEzgQ59VNcUjEio9hF36GBnEm88sDUAq6vue2WrEpX4J4qyjVRCm0iNBA==
X-Received: by 2002:a62:184e:: with SMTP id 75mr62937239pfy.28.1546886939585;
        Mon, 07 Jan 2019 10:48:59 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id s84sm140972949pfi.15.2019.01.07.10.48.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 10:48:58 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ggZxK-0004vA-6k; Mon, 07 Jan 2019 11:48:58 -0700
Date:   Mon, 7 Jan 2019 11:48:58 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Christian Benvenuti <benve@cisco.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/usnic: Use struct_size() in kmalloc()
Message-ID: <20190107184858.GB18875@ziepe.ca>
References: <20190107173953.GA6154@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107173953.GA6154@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 11:39:54AM -0600, Gustavo A. R. Silva wrote:
> One of the more common cases of allocation size calculations is finding
> the size of a structure that has a zero-sized array at the end, along
> with memory for some number of elements for that array. For example:
> 
> struct foo {
>     int stuff;
>     void *entry[];
> };
> 
> instance = kmalloc(sizeof(struct foo) + sizeof(void *) * count, GFP_KERNEL);
> 
> Instead of leaving these open-coded and prone to type mistakes, we can
> now use the new struct_size() helper:
> 
> instance = kmalloc(struct_size(instance, entry, count), GFP_KERNEL);
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/infiniband/hw/usnic/usnic_uiom.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Applied to for-next, thanks

Jason
