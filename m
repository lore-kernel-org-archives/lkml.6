Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88664C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54DFB208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 22:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Vtn0694E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391267AbfAOWyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 17:54:05 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38124 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387560AbfAOWyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 17:54:05 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so1988141plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jan 2019 14:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3kUtm/mfHhiXQsUFeQ4zvDQRbFvifwr7uvgTF51S1Dg=;
        b=Vtn0694EeqeyOnHvSrue7wZw+Gle9pDEunAwcXtNsEG8kgR9HvZj36eBKKDIHNvLQA
         SfO5YdK6FBe76sCkfLoOnu0WBa+yGNF0dpqmHr7bh+ec+1ehWDn0i8WDk+Ii9LN+v28t
         aAyXamfH+V48IqacruiVLpeTG3j/Dccn3Y1BWCTYacSX1KijC9hH3wWiCip0rcFHlaF0
         NxYeb+Sm1z88yHNfM/ST1mtwFnkQzdn8hJF9VcDzcbBcw4EcewRfuxZ50/PsLdkYOPPk
         fPl7POhrsNAA67Bit7wYaxKRrUalnDHjtUE4tAUL7vxwqIAYNjHti6iHsZsmmrn4VaHu
         qlPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3kUtm/mfHhiXQsUFeQ4zvDQRbFvifwr7uvgTF51S1Dg=;
        b=krdmLz4mskFtkNfe5eA1I/Y4+zezbqELABp7JG+I3fq6kmTF2zTJFsE3IToL+4GLdT
         DQPX6z70z19JQZJPLvCqZ6NWHsAzlrh8FNhaxdq8kDZEWvDCbxvCQr4GfAzmxYl3gHAw
         edC47dj+SEekdHwXFuymGTXaGEk7WLXT8jOsENCuRcnu0YZH8s3IoZWh6jv+b3lwSyLX
         uN7nk/jxXGPjkrgg+lE8oFeebHdKLCu+xdngWQtv+iYnNwK2aNVHRG9By/1+DVY3lIHA
         yFvPBgLVRKzx1sKv6Z8Ltl913YpigLZTaMDOWQHGWUpiMkS3VsKYtrjps/3kC3I0D/Iv
         q0wA==
X-Gm-Message-State: AJcUukcX9htUNmFAfByXpajkUQUTTf1fC4icrnE2791Jo1nXsZUkd0vv
        QGHesVcNRL+pgcRtQxSoRCO/eQ==
X-Google-Smtp-Source: ALg8bN6iuu6GsS81DxPkmkUVso8QYbvvTouc2mQtDFzGCyEnmeXv/N3bHlBdj9lzA2zQQjcWiCRE+g==
X-Received: by 2002:a17:902:f24:: with SMTP id 33mr6569866ply.65.1547592844735;
        Tue, 15 Jan 2019 14:54:04 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id t3sm4105265pgv.31.2019.01.15.14.54.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 14:54:03 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gjXat-0004qE-3Z; Tue, 15 Jan 2019 15:54:03 -0700
Date:   Tue, 15 Jan 2019 15:54:03 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: Replace kzalloc with kcalloc
Message-ID: <20190115225403.GA18581@ziepe.ca>
References: <20190115060048.GA9911@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115060048.GA9911@embeddedor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 12:00:48AM -0600, Gustavo A. R. Silva wrote:
> Replace kzalloc() function with its 2-factor argument form, kcalloc().
> 
> This patch replaces cases of:
> 
> 	kzalloc(a * b, gfp)
> 
> with:
> 	kcalloc(a, b, gfp)
> 
> This code was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> Acked-by: Leon Romanovsky <leonro@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next

Thanks,
Jason
