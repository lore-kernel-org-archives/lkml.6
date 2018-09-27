Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BDFC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7950621710
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 18:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="TVia+H8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7950621710
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbeI1BOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 21:14:18 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37798 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728590AbeI1BOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 21:14:18 -0400
Received: by mail-io1-f68.google.com with SMTP id v14-v6so2668905iob.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 11:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AejKBxcld1fBFFg7tYQzQKzorIZyLeJ0kNLqUFXBqnc=;
        b=TVia+H8xHy3+1hhdUOL54ewhkFd0kE2VH+1ocOg1zYlr9E/hCqI/AP1VFrJw6E6i2f
         58hfYREFA6ZVsjP6rB7R5I6DROs6QOnj9RYHsU/PsGo8dxFk26HFgLN/kwTRCIIy7654
         5icaYVj4N8d6sy/7dHHIRt5lPnhCgnLShYK4D9ExNeVgDNrSM9bOMyssUxDAF0yY1tJ7
         sLjWwxbwzyrwb5xWi4y7zVqV132QrWBiqVFIQzNHhxBN/kSjh8s3NegJ8++ri6jg/1ON
         D92EgFUqFCiYHM9FdH2Q2pmOKGgHvdnhuZaOq46s9NdiZFe3XKRWPoFLcmwNrhyJYG0k
         Kl9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AejKBxcld1fBFFg7tYQzQKzorIZyLeJ0kNLqUFXBqnc=;
        b=Zsbz7QUPT8hHX35Bi25MiSMnFRxQxABmYyOp4KiVJG4lf1ddkyoptJ5JaZwlteSXYv
         127v/bVfboz4JftBlmef1XqYxYt9pI53mFB4OK16WvfATbQ96l6fGm/GWthdUfoGsZyN
         jBiEsLUMrXwy8aNa8o8dJpFdBOuWYn5vVfM2p6sBJmnerCiijU0//WS/wHDXp5msrg0g
         0qlhYJkNqnrmG35KDNx1rc5sjZJL2O1BNFrn1I0yIzbY3je/VoJFSi2VvLBk6cpgpv67
         f8qIThN2IJHU8ep2NAz8Rm4TX0R0FY9aDwK4k9Y5RwWQMRZGW4eXKgaOAz9kYoxePyAT
         CsAQ==
X-Gm-Message-State: ABuFfoiGBmBEwq7h0WVRURbpa0NL9/16tSFqc4yFxrBCVKAgfQwbRbdG
        AvWkmnWBhlDZ5pQU1bFLNhXJTA==
X-Google-Smtp-Source: ACcGV61vzdvVruHnfWmZIv1peCgMxnfA+ZcK9jwxJLeRTHILmcbwUp2w+La0iqjveIcaGyp1kg1NeQ==
X-Received: by 2002:a6b:a15:: with SMTP id z21-v6mr2137241ioi.57.1538074478332;
        Thu, 27 Sep 2018 11:54:38 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id v126-v6sm1332245ith.12.2018.09.27.11.54.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 11:54:37 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g5bQq-0005d3-29; Thu, 27 Sep 2018 12:54:36 -0600
Date:   Thu, 27 Sep 2018 12:54:36 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Lijun Ou <oulijun@huawei.com>, Wei Hu <xavier.huwei@huawei.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/hns: fix spelling mistake "reseved" -> "reserved"
Message-ID: <20180927185436.GA19130@ziepe.ca>
References: <20180927132430.25172-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180927132430.25172-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 02:24:30PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in dev_err error message
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied to for-next, thanks

Jason
