Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39DAC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34772190B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Byp4Uzxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732044AbfBLSqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:46:21 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34669 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbfBLSqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:46:21 -0500
Received: by mail-qk1-f195.google.com with SMTP id a15so9383700qkc.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 10:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/zEkETC7KTf/oaYW9/CrgxKShnAHd5Db/rb8Pd+laSM=;
        b=Byp4Uzxf+O3IFxisdDtcqhpBCHWzD/ZYkrFGRiZ2VEbgE2LqtqQMfQWWs55P21WlVN
         rVUziq7GbqHQIj+jMIu0BFiQ+3FRS11pj/sWMoRibzTSeetecpnZAxVqQmA4sCvu+3Kk
         rTK8KIziJ3aE/oBPg14OT24hs78kiPISzhMqLmXndSHlG9BVQth05Pnx13Mv3FZAya5q
         QfggfVpm8GxJJCOaqGMUfopvixyS5l2DvxsSKuL7ZKgmBZKWR7zDtncGhm05gn8VM0xf
         4ga+JLTmBt5p3jY7/2+QQGkhUUSnGJhbzwAuYqbOTSUlKMUo6sSQ3xIqIvosh0ux8Vbc
         vlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/zEkETC7KTf/oaYW9/CrgxKShnAHd5Db/rb8Pd+laSM=;
        b=NhogLTQ2/hsxcqP2wyaEwRpqUt6O+5RcmmOwK4ajM1+bg3QiGlf59wM4iw5DPYXsGf
         nz2zGNafs91QTPtvUCo71WKuc36AxTuJwyfnzC5uJqKIkU3JnSNxTuGvUQY7511zwKH3
         2TAf1grKXo1e8vd++9re2qA/AqW71IsGJJmtiW/32ilyq+0F1pqhHDNYJ/FjeODYQLeO
         C5hf6KL7s6F1pt6Go3p/RQPZwDqB8PKPd56yW/3Q5ttx4cbHZ4ajP6MTNPgpUkGdluIV
         BrCh8Ox2kc9rlgxhmr5XznmU4lZXOHtaKXr5e1W5uXS1pNz5nDI/g4znpNjXuTHu0uoT
         XKLQ==
X-Gm-Message-State: AHQUAuYXmI8r9/FJn5Ozf27aLT49qRn72alvRiMzEezhlgfTtt8h6KlB
        vW7EPw4IQH37b1SGePxX7IY=
X-Google-Smtp-Source: AHgI3IaR5O74vSzc8Tl0G6HmJy3rDsgMokAud14XTkaPLsBZzz7cOmzVOWXGgaDgcTgUj4BwoWhrbg==
X-Received: by 2002:a37:884:: with SMTP id 126mr3840869qki.56.1549997180240;
        Tue, 12 Feb 2019 10:46:20 -0800 (PST)
Received: from localhost.localdomain (209-6-36-129.s6527.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.36.129])
        by smtp.gmail.com with ESMTPSA id c10sm5418315qtm.64.2019.02.12.10.46.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 10:46:19 -0800 (PST)
Date:   Tue, 12 Feb 2019 13:46:16 -0500
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     pjones@redhat.com, konrad@kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iscsi_ibft: use virt_to_phys instead of isa_virt_to_bus
Message-ID: <20190212184611.GA19464@localhost.localdomain>
References: <20190211134642.31149-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211134642.31149-1-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 02:46:42PM +0100, Christoph Hellwig wrote:
> As far as I can tell IBFT is a firmware table and has nothing to do with
> the good old ISA bus.  And even if it the two would be the same on x86
> anyway.  So remove the isa_virt_to_bus call in preparation of eventually
> removing that API entirely.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Queued it up in https://git.kernel.org/pub/scm/linux/kernel/git/konrad/ibft.git

> ---
>  drivers/firmware/iscsi_ibft_find.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/iscsi_ibft_find.c b/drivers/firmware/iscsi_ibft_find.c
> index 72d9ea18270b..85c656d04bb0 100644
> --- a/drivers/firmware/iscsi_ibft_find.c
> +++ b/drivers/firmware/iscsi_ibft_find.c
> @@ -104,7 +104,7 @@ unsigned long __init find_ibft_region(unsigned long *sizep)
>  
>  	if (ibft_addr) {
>  		*sizep = PAGE_ALIGN(ibft_addr->header.length);
> -		return (u64)isa_virt_to_bus(ibft_addr);
> +		return (u64)virt_to_phys(ibft_addr);
>  	}
>  
>  	*sizep = 0;
> -- 
> 2.20.1
> 
