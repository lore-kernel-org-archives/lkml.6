Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9E7C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDF3D2080F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 22:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="BRnTVbI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbfBKWfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 17:35:30 -0500
Received: from mail-pl1-f175.google.com ([209.85.214.175]:39488 "EHLO
        mail-pl1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727485AbfBKWf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 17:35:29 -0500
Received: by mail-pl1-f175.google.com with SMTP id 101so243888pld.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 14:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eV9VrhERzTP5Y24TAzQWYzf/Sp/icqObQFXydBXm9lQ=;
        b=BRnTVbI6d9JJc1v7EFVmkaKwyB6ccUlqLlteBsUxDI64DE9T5Dn0jvwvbQvBGGqBki
         8MluQ7nCx/rLo69az8L3G7uVL2+/8NaDAsabk+tETKjtPV5esYxdUftiTQMrOkcGfVN9
         SIyG+oD8zKEcfS9O7PpmKgFaP6hKI7keHHV4f15suevsXWFID65aCptGY40gpuc7eB7Y
         JMKm6PI38/2hKAnL1DnnEGJoaEOGsBW8a51RyNi4YwL3k+yjSnf0ufvyzYBkuZhIDWGu
         ZLktEAGQZStdKbxsJ6+E8ylFGv6ke8YfqEs9hwSHzvW+Oz/640qevw587vMRaPNp2Idc
         rgOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eV9VrhERzTP5Y24TAzQWYzf/Sp/icqObQFXydBXm9lQ=;
        b=cBC/L+Fd38Y7URZem0xWX/SAcFNXoM2+ifEY+v8WTFofw/w2Qogh5Ad9z4yDRdrT7r
         x9DqctQ7Gr+gFWN8LMdvGE4JBCYfhkIc95IKB+0Ag+vyVytWNlFFk3xOU6saVANY5iAz
         GNsQyHpsEIOUPSY+Kj7SJuNYyvIHDKRUuiXU2TOB6tf6JbhWqrfgxaayy4d/8e48fXbn
         c4zAd4vlu28j8juk0Ftn/9KRyoQpRvIiVvB4xSOGDswyS2Hmw1bWgOnfBSxQDf/NfF1v
         Jmpu/q5bSLcpD5xL6WsPQXM+5Bs51/PuXOt2tsyzt/RC/L8R6THufJ4wTN1/mxufAIJ7
         odPw==
X-Gm-Message-State: AHQUAubQF3lWDKMSk6HINLlEBsqlcU0U/UNDpkf6DycvEv2DOGMJWhRW
        viwGXWwXw9S4xqs3jzJWcCYUYg==
X-Google-Smtp-Source: AHgI3IbCu16ECvkvK+7oRMiAgjBV8Nx+NbqeT9v4fp2DoOTlPtf4BIM4E+aDDADMo2NY2ZRkcRPvig==
X-Received: by 2002:a17:902:7683:: with SMTP id m3mr589776pll.191.1549924529261;
        Mon, 11 Feb 2019 14:35:29 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id d23sm1504876pfn.180.2019.02.11.14.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 14:35:28 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gtKAi-00023F-6G; Mon, 11 Feb 2019 15:35:28 -0700
Date:   Mon, 11 Feb 2019 15:35:28 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] RDMA/bnxt_re: fix or'ing of data into an
 uninitialized struct member
Message-ID: <20190211223528.GA7770@ziepe.ca>
References: <20190211133415.9020-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211133415.9020-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 01:34:15PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The struct member comp_mask has not been initialized however a bit
> pattern is being bitwise or'd into the member and hence other bit
> fields in comp_mask may contain any garbage from the stack. Fix this
> by making the bitwise or into an assignment.
> 
> Fixes: 95b86d1c91ad ("RDMA/bnxt_re: Update kernel user abi to pass chip context")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Acked-By: Devesh Sharma <devesh.sharma@broadcom.com>
> ---
>  drivers/infiniband/hw/bnxt_re/ib_verbs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next thanks

Jason
