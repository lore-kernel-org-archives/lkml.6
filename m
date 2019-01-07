Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60166C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F262206BB
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="N5w9RSxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfAGSst (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:48:49 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36357 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfAGSss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:48:48 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so566825plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 10:48:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6g9QpSr8ohhCoA+fG0UcL6+mlfcXAx4Me3tetAza3Fk=;
        b=N5w9RSxZ6GDi/9hstTdRtJmyGmF7Xck4ok2BygW2Nye67kH6PIsIrTmsdkKtu9yvR+
         gJkWbQo9H0dmuhEzRwtdNCW1U4/kzz5ldr7M8rSrmGI+vzjQ7z5D0TBkEdROHY176c3s
         +eOFzpHgyKLndkZYZ0mE5DP+C+9RuWTStKWQ4/oku/RqIuidUxKK/eujUX5jSvSxrGjB
         RSecz2aXZakEaQuWAPc3q+ayejIGUmCkpeu4TPwCbktuLHkdUnkxM7nRKSN5k44q80He
         ZTh6mKzTDJpBcea/vttgRVzaFGkdF01TyNQdrlxPkAmAEHHUQOsyYAIUb4ToNg6hmysp
         +VFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6g9QpSr8ohhCoA+fG0UcL6+mlfcXAx4Me3tetAza3Fk=;
        b=pyGe2UnJAdWGDuxX4qvQL6hM5gNjgSRoX8nYuwts/2ZyWVvRUaRW43NsUOZw0DIWHM
         AstBj6Aj8lw9fLH0tkftkdPT4CIrEdGe5QgefYCBzXclwsWVuyGU56koExeR53lI/SOm
         g/bWKjxX99ov/jNjU4sBVksF5wGBVb/Tw7LoSyIETOW+Gp1B6xc/hprok1IRQ3gfZScN
         gkuDS+RWKTiXDEymJgsLxjQbqzv045v/iTRH3IClHZ+drE7YT412NQfbNsCsAlE0qauV
         MeAal4uYAeiOA+JkNfNof2rNUKCjTE3oH49w9JEFqa6cPTIIO9JIeBks/9HUvXMOnALj
         ZQvA==
X-Gm-Message-State: AJcUukfTPClviHjvoufVZXnJlUoziPvvrTBGzDxzdlrROmAsNRDfWPt6
        REPbwlCESW61eC6PJkjoQNGdpw==
X-Google-Smtp-Source: ALg8bN4PXLjLlirjto8yMQM0eCrCf0pDngGMRaSNRju4QuyCKg7HeoaqGOOhvUt9O0YUSUPbQxC/jQ==
X-Received: by 2002:a17:902:e002:: with SMTP id ca2mr63212211plb.103.1546886928052;
        Mon, 07 Jan 2019 10:48:48 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id u69sm120937827pfj.116.2019.01.07.10.48.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 10:48:47 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1ggZx8-0004uu-JJ; Mon, 07 Jan 2019 11:48:46 -0700
Date:   Mon, 7 Jan 2019 11:48:46 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/cm: Use struct_size() in kmalloc()
Message-ID: <20190107184846.GA18875@ziepe.ca>
References: <20190107172616.GA3099@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107172616.GA3099@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 11:26:16AM -0600, Gustavo A. R. Silva wrote:
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
>  drivers/infiniband/core/cm.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next thanks

Jason
