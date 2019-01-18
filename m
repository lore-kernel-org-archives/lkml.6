Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16541C1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D568020449
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 21:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cRze5ZKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbfARVFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 16:05:19 -0500
Received: from mail-pg1-f178.google.com ([209.85.215.178]:35546 "EHLO
        mail-pg1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729515AbfARVFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 16:05:19 -0500
Received: by mail-pg1-f178.google.com with SMTP id s198so6628571pgs.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 13:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bFUOytwwiQcXaEI3t9mRKnrFJLyAzZpzMg/oaViDMH8=;
        b=cRze5ZKisOrfOyIPxZfacmMuVgSk/XTEtVKo9YwRlZ5QJxuRsOA5xjQ5MqLS6ytMdc
         ZDn14VvQZM+mtrz4tPHPRSL2pOEL1XuwTirVDw3DISXsCjOf9JZtdQWgiFsHtg7eykyS
         eAwDs6SzrPQXICjiL1FHSLuXxg4HqJ6xmyJk4GI29ipAxVt+RQMnLUa96hA56V1G/qBN
         drYh2d1t0DK9w7JJEM5equBV77QKr+TAtv0Jx9MPP23BiNtqROC3szQOjvfw/stLvNwh
         XYcv2vPZJpEkgWnUL95835pRmuQ+klWRsdE0IojuiZ3u7JQ9v4sENb8EMzCUpTqOrc1Z
         281w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bFUOytwwiQcXaEI3t9mRKnrFJLyAzZpzMg/oaViDMH8=;
        b=CAp4oi/KN3HQpMEDyD6vg+jwW4eXfmcgpJCh8EnqvJPDsV0NT1WlLRFCQq7wdta6xS
         mQm9VhBVHaKAe92VzGHdfuA4tS4vZ2u87JhYkiKe+I7yMeN8KDLuBUcZevzQPxwt2Ftv
         Ya93mn0uuhuLPZgsTx/7MQYQ2/Qi2IJQGkIoDDonA0WrQeTP97Q74IvuXJuQtLfrjlTy
         VWNcvSGqj86Jk1di0Guq7qj1X2agH+ee27J5xyujmNeZHMJgSe7nJSfcZKyZRMULhR9m
         rqCE2PN5H2njarVVl/iDRgsBlMK1/f1gl27W2OMSsIUeMEDE8SONhFgVwqdPDZmioTv3
         8e1w==
X-Gm-Message-State: AJcUukdwSsf5FGtXq+afip2DSYrUEqZKSVfXKzILYuG+esqa+bOIuriz
        NkqoFVAheyQKSEUp3EZ1NU9q6w==
X-Google-Smtp-Source: ALg8bN4Q2/8HQNxeoL4tM/kFT66b2QnjpWeRDVwNQgcje38z4ZQlzwb77Mnkfru2+5OPUdgdnq7qtA==
X-Received: by 2002:a63:d70e:: with SMTP id d14mr19359010pgg.159.1547845518465;
        Fri, 18 Jan 2019 13:05:18 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id d21sm8259349pfo.162.2019.01.18.13.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 13:05:17 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gkbKH-0005Xf-51; Fri, 18 Jan 2019 14:05:17 -0700
Date:   Fri, 18 Jan 2019 14:05:17 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     oulijun@huawei.com, dledford@redhat.com,
        Michal.Kalderon@cavium.com, Ariel.Elior@cavium.com,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH -next] IB/hw: remove unneeded semicolon
Message-ID: <20190118210517.GA21275@ziepe.ca>
References: <20190118030900.14636-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118030900.14636-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 11:09:00AM +0800, YueHaibing wrote:
> remove unneeded semicolon
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c |  2 +-
>  drivers/infiniband/hw/qedr/qedr_iw_cm.c    |  2 +-
>  drivers/infiniband/hw/qedr/verbs.c         | 14 +++++++-------
>  3 files changed, 9 insertions(+), 9 deletions(-)

Applied to for-next

Thanks,
Jason
