Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7B79C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC428206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="K87SXdFu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC428206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390421AbeKVJgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:36:13 -0500
Received: from mail-pl1-f182.google.com ([209.85.214.182]:37615 "EHLO
        mail-pl1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390407AbeKVJgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:36:12 -0500
Received: by mail-pl1-f182.google.com with SMTP id b5so7520801plr.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 14:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bwxw0ZSso+6lFLLjX6HxKu5uCkj0Kp67nEidlavA7zQ=;
        b=K87SXdFuTviNuIwR1goUoB+aUg3klotfhc/xxY7fliKznIAG2fTa4k7mPMB1mH/S/g
         W8ZNQ/wNMO1RO3oKZQVBhY+nzlwWILkkasOsPh3mWoQP+pZVzp2zAxOyeAsnKYrqND8q
         Q7Y3Kdul2PZSA3n9Qy83M55/9xT12a12iRXw0bUG4PICFQOePJ6CDq2hEpgkeJHtp48g
         b+6yTAH9QmS4Up7jmPwTkmjF5UpoN1MzBLq/DiS/2QsWBOMW6hulY0ddEX1aX2idpUN7
         6k9PAT2TXnnUXkgHRVUdOdMPmgeJt8XTZmVVCBUReiE8dd1RVCKBnG9uekYCu/+a3m9W
         uMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bwxw0ZSso+6lFLLjX6HxKu5uCkj0Kp67nEidlavA7zQ=;
        b=BlxPbvfB/mz4xNKCvCbP0/Pd3tUBapb+3p06vEbe80iVD8Xt4Y40QpXVW43eXvln/1
         yVGoOnFaT2jLXWx4jpANDsO41p543/aaW665Apib1OXrnVxCO8aw+IlmAcPHDb9/rpU2
         jbc00Gc6UnoW06hyOJuwr27YwSS5G5tJeMmw09+xkdmq8kEv9MaoyhbKbMNzWwihLYDk
         kZR/M3t9rb94ONZRTZjO9sJPSOTldJ+go4P/l7xYB/EwNt+pYU7IL5IaCOi4+jpiFtLk
         VySJB0ZYi0lux4l4fFMt2Bx6LDvNLIIu4LXzLR7srAe0lsUi8nKBGLbULgzhqq4rtbU5
         wF2Q==
X-Gm-Message-State: AA+aEWavGkAlPLqT7p+fVD/iLvy971D4JuPs3TWRZNUkTFl1hflYRoj0
        Z6M7rMfWUizeiM0lRCLu6UJcHw==
X-Google-Smtp-Source: AFSGD/WBvPPYMREHwVJARLB9tY4/qfnSpQPN2U54HDPUpnvrJJ/ZELeJhzkXV1+dZ6Wb7I72OvqS/A==
X-Received: by 2002:a63:5f41:: with SMTP id t62mr7742693pgb.76.1542841185333;
        Wed, 21 Nov 2018 14:59:45 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id a15sm20835271pgb.1.2018.11.21.14.59.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 14:59:44 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gPbTD-0007n4-Ee; Wed, 21 Nov 2018 15:59:43 -0700
Date:   Wed, 21 Nov 2018 15:59:43 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Cc:     swise@chelsio.com, dledford@redhat.com, jrdr.linux@gmail.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        brajeswar.linux@gmail.com
Subject: Re: [PATCH] infiniband/hw/cxgb3/cxio_hal.c: Use dma_zalloc_coherent
Message-ID: <20181121225943.GA29924@ziepe.ca>
References: <5be5bad9.1c69fb81.db750.d226@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5be5bad9.1c69fb81.db750.d226@mx.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 09, 2018 at 10:20:29PM +0530, Sabyasachi Gupta wrote:
> Replaced dma_alloc_coherent + memset with dma_zalloc_coherent
> 
> Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> Acked-by: Steve Wise <swise@opengridcomputing.com>
> Acked-by: Steve Wise <swise@opengridcomputing.com>
> ---
>  drivers/infiniband/hw/cxgb3/cxio_hal.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Applied to for-next

Thanks,
Jason
