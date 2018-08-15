Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE26C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD5C821557
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 21:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="g4oN13l6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5C821557
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeHPAEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 20:04:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39537 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbeHPAEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 20:04:47 -0400
Received: by mail-pf1-f195.google.com with SMTP id j8-v6so1009865pff.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 14:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6NbjBDHVAyQzSFQyCd/J+T/NDtFTl35hHqo5OC9Ix70=;
        b=g4oN13l6jrl51D3895IggeEzD6qAA3DGl6dKy/XRbQk2Vp88xGGwI2UZkqO75ClGdY
         5aWpwhZ7uomhklB0tsacidkrYGuYrbEVKCjHahcIn4Uxy7w9bgPjCAEBI7yWi2ukz4H2
         yx8IiKGlnky+9s6O9diHpTIQ5YHo1HuOeEk1LKYudEbrgLBaKtpVlEZNXVcbxwvjCu9c
         K5Q9lwRorLb8bVuLUgG4hEDDTatP0f4SgHu7WKTVoPYaO/wSXu4zdsZjCMErWeoQ4+nv
         PnUYlRzqF7iPWPmzlgZwQVFJys4laoMCm4J0jssMEB4Qt6zk8CWhwCoRehTIqJXjMhHB
         KpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6NbjBDHVAyQzSFQyCd/J+T/NDtFTl35hHqo5OC9Ix70=;
        b=YSCXbfXaDTl2rD6baD7t+xn3boMXtkPA1u9zCJAcZy28dyPIbKU21bUh0ioHxvqsow
         JuGn+CuV1WgX3r/FyOZtT2PtEObVqj0wr2IQwOe6YYXYKte0B4QnKr9ct7kZBRo05DB4
         pUQtTkoKe9qUoJ12AZl+MbcJ9VrySOj/DdJqfdekAmWrWu0KvoM62WNjSEhT72Hr//z/
         nM3kCJaw5jBrxIYjm7ydS7BoNZm0njgm07Wca8k1J/LRPiV0x+LfZI+DXHV+x93iZWwE
         rwKCwy2t0SvVI51BJPukzpdZpOaP2R0A0mTfUDFYRTyBQALm63Gr+jF+QtaIFXzjXe2J
         CbPg==
X-Gm-Message-State: AOUpUlFHj7FTefOFSLovUTO3pSfXY9nUqU45wpRTfCqpXucEo/PPIEIO
        hMwDRMBHwzstKtWYebqfZxY8Eg==
X-Google-Smtp-Source: AA+uWPwVOhYLMA+Ec2tsZDZFMuOu+QVIEsy6en2t/MPFWf5/kcKKtFCRC47ky8cFZn5O/VWnzRNuvQ==
X-Received: by 2002:a62:87ce:: with SMTP id i197-v6mr29420185pfe.62.1534367455770;
        Wed, 15 Aug 2018 14:10:55 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id a20-v6sm44018794pfc.14.2018.08.15.14.10.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Aug 2018 14:10:55 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1fq34A-0000fO-5u; Wed, 15 Aug 2018 15:10:54 -0600
Date:   Wed, 15 Aug 2018 15:10:54 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Joe Perches <joe@perches.com>
Cc:     Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/bnxt_re: QPLIB: Add and use #define dev_fmt(fmt)
 "QPLIB: " fmt
Message-ID: <20180815211054.GA2538@ziepe.ca>
References: <fe07a1dbe1f6699b4a64444505ae2dbacc2155cc.1533926549.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe07a1dbe1f6699b4a64444505ae2dbacc2155cc.1533926549.git.joe@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2018 at 11:42:46AM -0700, Joe Perches wrote:
> Consistently use the "QPLIB: " prefix for dev_<level> logging.
> 
> Miscellanea:
> 
> o Add missing newlines to avoid possible message interleaving
> o Coalesce consecutive dev_<level> uses that emit a message header to
>   avoid < 80 column lengths and mistakenly output on multiple lines
> o Reflow modified lines to use 80 columns where appropriate
> o Consistently use "%s: " where __func__ is output
> o QPLIB: is now always output immediately after the dev_<level> header
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 130 +++++++++++------------------
>  drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  51 ++++++-----
>  drivers/infiniband/hw/bnxt_re/qplib_res.c  |  29 ++++---
>  drivers/infiniband/hw/bnxt_re/qplib_sp.c   |  57 ++++++-------
>  4 files changed, 116 insertions(+), 151 deletions(-)

Broadcom: This is a big patch, will you ack it please?

https://patchwork.kernel.org/patch/10563083/

Thanks,
Jason
