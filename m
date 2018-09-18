Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D1BECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DB72214C2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 14:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="fmpERQBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DB72214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbeIRUTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 16:19:20 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39067 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbeIRUTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 16:19:20 -0400
Received: by mail-it0-f66.google.com with SMTP id h1-v6so3340694itj.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Sep 2018 07:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AK+SJRqXre6VfyJm5g10BZL2PVfKGqFxI51i5FhjIBg=;
        b=fmpERQBYo8C5NZ1F7KtWiBu3TmN4EtPPmylGGTMdV5FHUKJFD5A7J3/TSLa75KMcdw
         M7ZdEyH/TpP689QTxAwplGt/vLXMfirMW7CFFfjb2dMJotovTaSLlxWHUaQ2TwBf8Yop
         xKLtpy3uPq06tEFPiYy4IHQlmf4pv0UaxqYDfnq2tJBQriXEzZ+ktQUzcCz/EbPzUjUh
         sW68+W42iYUz36YdprGHE8zyST/ojmZudonBgfcG2ktHXiVdtFFfdin0UMuODJm0LL7u
         UbPJWdEgLp9nHYeHBWjdyUMaZmCvjrBNM/2TmRv5R2SeIcqxysXvIOqpg8QspCDLr3wi
         sdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AK+SJRqXre6VfyJm5g10BZL2PVfKGqFxI51i5FhjIBg=;
        b=k2masieTiUUDVFZoe6PrLcyWOL63eo+h+hxxGNmiTRsPZvqespWFzIRuoEOBtPUoXH
         MWvCfBZRnC5Mm9YZmg3EOzTjp9qSdKtiE1bge+SgWDuF+lIbW2PFRpjWYVHSEjagnQtC
         1sEAVGiu17ERlTenFxZwB51b5ZTHpGuED3rM5fzrg2FdC8cNFXhLvRwWEPW1/O1i88Wt
         9fZYTJ1O8mV5kD7VDQDEiQSENt2GiNYMOpMRWiQzX41pO5crc2vkg7e72pCUR0RssjpY
         nPKaGDrdHIh+TkqeANTkqaa/Eoh6Cfd0Au4Qr7e0O6izKyfZOG1SDzmC4vhtE8sVc0Do
         SGnA==
X-Gm-Message-State: APzg51AVYw8ynu5R9nx8MDES9gFrc7W3nOcwDmT1HtoRdH4XY1I4IPnr
        k/2YKpb9Ik28F4KRmJLeQFwLsw==
X-Google-Smtp-Source: ANB0VdbllpSDI62u0EI1WUSFKDls98XU3HnHSXlruPPqYVjlOaSq3CBRzpPNO9+WVsv27QdL5aK1aA==
X-Received: by 2002:a24:ca84:: with SMTP id k126-v6mr17702400itg.27.1537281984678;
        Tue, 18 Sep 2018 07:46:24 -0700 (PDT)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id k9-v6sm6327193iop.1.2018.09.18.07.46.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 18 Sep 2018 07:46:24 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1g2HGh-0003QC-8o; Tue, 18 Sep 2018 08:46:23 -0600
Date:   Tue, 18 Sep 2018 08:46:23 -0600
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jan Dakinevich <jan.dakinevich@virtuozzo.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Parav Pandit <parav@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Kees Cook <keescook@chromium.org>,
        Kamal Heib <kamalheib1@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Denis Lunev <den@virtuozzo.com>,
        Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: Re: [PATCH 0/4] IB: decrease large contigous allocation
Message-ID: <20180918144623.GI11367@ziepe.ca>
References: <1537275826-27247-1-git-send-email-jan.dakinevich@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1537275826-27247-1-git-send-email-jan.dakinevich@virtuozzo.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 04:03:42PM +0300, Jan Dakinevich wrote:
> The size of mlx4_ib_device became too large to be allocated as whole contigous 
> block of memory. Currently it takes about 55K. On architecture with 4K page it 
> means 3rd order.
> 
> This patch series makes an attempt to split mlx4_ib_device into several parts 
> and allocate them with less expensive kvzalloc

Why split it up? Any reason not to just allocate the whole thing with
kvzalloc?

Jason
