Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 014E3C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA3CA20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FqA5QDPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3CA20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbeK0Kmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:42:51 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43390 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbeK0Kmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:42:50 -0500
Received: by mail-pf1-f193.google.com with SMTP id w73so7365764pfk.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 15:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ebb1URIHaPeF1nIJdrETEAgjonYJlTnX+jGMC5RfDtQ=;
        b=FqA5QDPL3OYBNM7rxJgszipaQ6wnxr/+AZz2EU+stDG9kigF2w6OZDV6D3ydUqznic
         +8yXt7S1MVb2jriSnfm2vWQSLIlQUnSwfcBfhVBNi+aXz8DWx+NjzOu7wUxgYuMSEaXl
         TKUMCBYpbYUp2SXS0afpcsSCWo3w+nyDB0I80qrorVgn6VI+b4na6oe1fPwZzp1AzA1T
         A/qFbSuBoPhXQNvganpFtc4wAvksjWWqdZSPpouqBex3C78rUYxTeJ5mWF/CDBSjBdGM
         1VJOv8xLtawhB19jV91HXXM/M5wjoOCa69DBvFaPXcQvWMWn8NjU+qIWX/mYmj7z2/Yb
         VUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ebb1URIHaPeF1nIJdrETEAgjonYJlTnX+jGMC5RfDtQ=;
        b=oQhV1KFh4GPJgwuyUO4K7p4IusPZV20MDDkEhD2OcHJ5OFBa/EzGGfTZQGEVmdBys8
         5VCr69QEumEbEa8TwcLrD/Z7SQwv/f1o29e+f9Z/lh1WHeigQ8kGZNRNAXKYUVJnHh4G
         4Y6934EeeC2F5brVl3MUUsIW0VX0p9mlfo+m9gKllWf6Q2JJC5fsyRyoqmBd6uaTMPJe
         zNZXJYqixifn6sMfJN9MJqnWRVnqqMqGErJ9/ENmR3UZJmuw8lxWbfdDxPwLKJ9vr45n
         1umi+uOhV1xGKB2oB9Kd6yynWl7Vj1jo/C8pWOCwcP0dh8aNOOeb8RW7DVSdb5XsBFMD
         xI/g==
X-Gm-Message-State: AGRZ1gLDnh+I3V91Pf7Rq2mrMp7NLoL6Br0UaBNFkBQYqRS7pbjiVvJp
        gdh41EauCzPZ13fUxs1GWkR3TA==
X-Google-Smtp-Source: AJdET5fWp/lAg/posOem26GloXmW5UGQLcjbmMtpX3pS3cDpFC5Ncuh/cC7gbNGXAzbvHHXlYJb2rA==
X-Received: by 2002:a62:5793:: with SMTP id i19mr30626221pfj.49.1543276020148;
        Mon, 26 Nov 2018 15:47:00 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id y6sm1876661pfl.187.2018.11.26.15.46.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 15:46:59 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gRQag-0006qX-GG; Mon, 26 Nov 2018 16:46:58 -0700
Date:   Mon, 26 Nov 2018 16:46:58 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/qib: fix spelling mistake "colescing" -> "coalescing"
Message-ID: <20181126234658.GA26284@ziepe.ca>
References: <20181126162320.27889-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181126162320.27889-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 04:23:20PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in the module description text, fix it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
> ---
>  drivers/infiniband/hw/qib/qib_pcie.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next, thanks

Jason
