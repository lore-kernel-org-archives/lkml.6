Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FACC04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F1220863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Hm/OWZXy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F1220863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbeK3Kqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:46:30 -0500
Received: from mail-pg1-f171.google.com ([209.85.215.171]:40462 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeK3Kqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:46:30 -0500
Received: by mail-pg1-f171.google.com with SMTP id z10so1636946pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gq+RaHYE+vIpE6U0mIMOGkjeoTdxOyooBu5UtkUngBM=;
        b=Hm/OWZXyRHl2hxYnP5oP162CG4rhO010cMhNPinXO48mhsuC+42Dekz8k7DMqb6EjA
         w1uSk7xRXTmrNpMPIPGKK6b0E4JqW8kSd+6NZHHKY8gUVXluu3ZhPMqMUhYR8JkBO1sU
         NkTfuFQLq64qYo9P5KY94q0MPP38CdKim2TSkNZjzL3Ti058TWQwu8qWt/A4KUO+xLgG
         P15Q6NTjz/xrVdlsI0FPjq3N2x60Ik/qpvE9pf3wvi5/XsxfEqz5AFutWNLqat+qqWk0
         OShToZaa5wtkWjYr+sQYQxklbiQCPFZIN9hfVFtmE075IuzjpQztVtOLvSXhapAqx7bV
         WRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gq+RaHYE+vIpE6U0mIMOGkjeoTdxOyooBu5UtkUngBM=;
        b=sAed/AzCG/qBCb1Gwn0c7iHHm41SOiTV5NpQrDCEDtyyJr8K0821gxPKPvIHwm5xLy
         hOopSNbnbGuAhgpBXEWYejbAklayIUElBLhdPXbcwCw5/eUE0mbKwxW9IVtTlMgml+bu
         Q19BnlEA6EYx7UiCCRxlu+0vg+bqVkSpsVqvch7+0Nr6tKpARsSrFENOveGmQUtoNMMq
         OxWXyIlIdCiVXXU28Or2jYOT7IW7tm6luCLttHbHtk7U6wO8RqeZkDtKARmUhjrI4lWM
         1KtgwSeR4qr0m7vaece1vhT4QP4t2B/SP/rihL3JIdDhUGS5q6/COmY2ZYkU7POaSWKP
         JgxQ==
X-Gm-Message-State: AA+aEWYBgjK9LXGKMP7ivj7jHlFQnZkXt3SERvP2rrYmG5LQNF1v5jMm
        n4Jhtymit4JhLOv6KgcjWTX8pg==
X-Google-Smtp-Source: AFSGD/W3ZNRuMy2OtMHsCH/cUHFHCXdM957rt1G8WlJpxxwT44i1KyLuzBY53vkwk7OBQN53W7jHgg==
X-Received: by 2002:a63:7154:: with SMTP id b20mr2955753pgn.342.1543534755686;
        Thu, 29 Nov 2018 15:39:15 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id u137sm8427960pfc.140.2018.11.29.15.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 15:39:15 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gSVtq-0002xJ-7e; Thu, 29 Nov 2018 16:39:14 -0700
Date:   Thu, 29 Nov 2018 16:39:14 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Colin King <colin.king@canonical.com>
Cc:     Christian Benvenuti <benve@cisco.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/drivers: fix spelling mistake "initalize" ->
 "initialize"
Message-ID: <20181129233914.GA11331@ziepe.ca>
References: <20181128151116.13216-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181128151116.13216-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 03:11:16PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Fix spelling mistake in usnic_err error message
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/infiniband/hw/usnic/usnic_ib_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-next

Thanks,
Jason
