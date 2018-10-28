Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A5D8C6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 18:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 432E22054F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 18:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="S/czunjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 432E22054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbeJ2DX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 23:23:56 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37551 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeJ2DXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 23:23:55 -0400
Received: by mail-lf1-f66.google.com with SMTP id a82-v6so4377645lfa.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 11:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JawUiS6yl5PWFfA1n7wCgqH2PS+44iYpdZ2SRlWC0B8=;
        b=S/czunjCL4Mw44i59SyQNzVjZlUeftMEDzkt+TdvSP7QrYK0ikBfnk3Xxy6FGTJIAa
         J53DveY9sXTPSdkkFFo9LWrr3KZXZD3y4qWoYbN69Uz7/kjiJ1XutDS0IsG8DEEGf+81
         cQiWHPMmhyDEMGLYREgsPQVpddWtbZEjV6oVBO1+ZsLBYnB99OxQy6LL5yNM8ky2ltVc
         rLqgFIA3k4bEnFmrLB4ktBdaVlxjwNjlS2HfCUrV4FzZvP6L1h3nK6UM+OcKyW2AIV8a
         htx9fxtzt8ZeyYSEQvLojOpFZhJGyhT1zvwNbJ2WmCUyrzazwcgPnBJoK63Sz4B13NF7
         BgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JawUiS6yl5PWFfA1n7wCgqH2PS+44iYpdZ2SRlWC0B8=;
        b=VaS4ftUyfBOFDIA0MpXXh422oYY96hKSU+fyo9t7uBxSXXBH6+SyayzSEp+fvI1CgG
         YvfTphBNsd8waVIQxkGwa+8hxfyCTDLecOy2HlZOPtmsl9WbqjX2NOeyB020nXgh1JKP
         hZB0Ovhr0v3J3wDMRG0Dt6Sr0yyX7/hv72NcSFJLNnGD06GOehpU9c9hInvEd+aZh8AH
         Et7bmZi4j1kjVCxQ76nb45VikeDNajhqrrim4sAECSk7AjUs/dEpVym+tyXI25X4YkWx
         ehIEWy6PLBJW5OOeTd6kompVYux7TiSWV5Zlkk0mTZDSlUUj8fejt/K4ltQuyDHAuZKV
         RWZA==
X-Gm-Message-State: AGRZ1gI+R5T69PSilwypkNHVlhPIv74qBtTkLYh20pkwZAaqGLRdc2ag
        SB5PBsBJ79KZhiR/LqgS2+7aa+1ybKw=
X-Google-Smtp-Source: AJdET5fQYjC4aIIaZJwD8zAdtOuV8PRSqLVgXvkkIue/m4scmdabuigHYv1kNveK17jv/9a+85YShg==
X-Received: by 2002:a19:4e59:: with SMTP id c86mr6761660lfb.132.1540751906039;
        Sun, 28 Oct 2018 11:38:26 -0700 (PDT)
Received: from [192.168.0.36] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id u65sm380454lff.54.2018.10.28.11.38.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 11:38:24 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: Fix uninitialized return value in
 nvm_get_chunk_meta()
To:     geert@linux-m68k.org, keith.busch@intel.com, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me
Cc:     arnd@arndb.de, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20181028160726.24450-1-geert@linux-m68k.org>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <a0fa4599-f6c1-1f45-43f4-4cf30b8de509@lightnvm.io>
Date:   Sun, 28 Oct 2018 19:38:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181028160726.24450-1-geert@linux-m68k.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/2018 05:07 PM, Geert Uytterhoeven wrote:
> With gcc 4.1:
> 
>      drivers/lightnvm/core.c: In function ‘nvm_get_bb_meta’:
>      drivers/lightnvm/core.c:977: warning: ‘ret’ may be used uninitialized in this function
> 
> and
> 
>      drivers/nvme/host/lightnvm.c: In function ‘nvme_nvm_get_chk_meta’:
>      drivers/nvme/host/lightnvm.c:580: warning: ‘ret’ may be used uninitialized in this function
> 
> Indeed, if (for the former) the number of channels or LUNs is zero, or
> (for both) the passed number of chunks is zero, ret will be returned
> uninitialized.
> 
> Fix this by preinitializing ret to zero.
> 
> Fixes: aff3fb18f957de93 ("lightnvm: move bad block and chunk state logic to core")
> Fixes: a294c199455187d1 ("lightnvm: implement get log report chunk helpers")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> I don't know if this can happen in practice, but given this is core
> functionality that can be called from other files, or even from other
> modules, I think it's better to be safe than sorry.
> 
> The latter seems to be a pre-existing issue since v4.17.
> I didn't notice it before, due to the dependency of NVM on PCI (my gcc
> 4.1 targets m68k, i.e. no PCI).
> ---
>   drivers/lightnvm/core.c      | 2 +-
>   drivers/nvme/host/lightnvm.c | 3 ++-
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
> index efb976a863d2295a..73ab3cf2686804ba 100644
> --- a/drivers/lightnvm/core.c
> +++ b/drivers/lightnvm/core.c
> @@ -974,7 +974,7 @@ static int nvm_get_bb_meta(struct nvm_dev *dev, sector_t slba,
>   	struct ppa_addr ppa;
>   	u8 *blks;
>   	int ch, lun, nr_blks;
> -	int ret;
> +	int ret = 0;
>   
>   	ppa.ppa = slba;
>   	ppa = dev_to_generic_addr(dev, ppa);
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index a4f3b263cd6c60ee..d64805dc8efbaa02 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -577,7 +577,8 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
>   	struct ppa_addr ppa;
>   	size_t left = nchks * sizeof(struct nvme_nvm_chk_meta);
>   	size_t log_pos, offset, len;
> -	int ret, i, max_len;
> +	int i, max_len;
> +	int ret = 0;
>   
>   	/*
>   	 * limit requests to maximum 256K to avoid issuing arbitrary large
> 

Thanks Geert. Applied for 4.21/5.1.
