Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2A5C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4FF222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UaB76odx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732097AbfBLSrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:47:19 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37266 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730928AbfBLSrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:47:19 -0500
Received: by mail-qt1-f195.google.com with SMTP id a48so4218411qtb.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 10:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YEZTaXzB2jQwXmKBx141OR/JC3wWPlZNPkwghBTeOZc=;
        b=UaB76odxpK6Al/PuOMWcjl+FHZUy1Mps1LNRXNeBXyEVWVSURZbCSkOSy6hI4BCJjg
         K1vu0nhrVmQ+H4kab0DG5RZGdPpO5IvQYk2ungLfUKPGDdtfW3/2XlEhOaRdds44fCmc
         xb8FSXX1AyaE/lpNObyhbkvOI1RYeYBhFeNEwflqiCOJF5/CFadCifEwgybTEwebmU5p
         lcRgpz29r6HGHlR9QkD9PbGE9rIG+PdpKmpWxtv4I+HJW0pIjAbJTgsMIcBRFtwxTd/e
         pV/KjXH8fGVSyUlHzeq/wXhf9LEt/qEPuihoVi5qvVLGh2Ap0MNmPimKQO4FILsxK09Z
         us9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YEZTaXzB2jQwXmKBx141OR/JC3wWPlZNPkwghBTeOZc=;
        b=LZC9BS5KPPE+InTukork4mM4i5v+f4QYysdG3w9mgWxwS3CldO7GXlwdQ7kZCegiIx
         b3GxZUADDsCBjpEPgoKGz1xcf8o3BszB1HZrT2JdYO7k2MzgwHqu/qm60lZ3dv7oRs5l
         yGTo93TEWxnhbyDy+XpgJHSB/F2boHL4IlKoSACHLt+DCxc1RCIEW36/GiTGV9JHyDlA
         Xa1tLYSAaUDlTCG3o8wdfuAHmSSuqwq53io8bu1Z6U1cbSrfB4fB8XFeVj3JT4D/tjJD
         t/WxgurIdyZPsciyLcPXt+Ymzg+j+46TiCHqUWKl+MjlSxkDF4E+llS5AYQqtTWHPL9q
         Be+g==
X-Gm-Message-State: AHQUAubYyDTKyn97cLT15o4dPnJPJKJrKmrpfWn1Y6j1a2jE49vD/7X4
        sHT6l7L/mKnsT+P/A+MfxZk=
X-Google-Smtp-Source: AHgI3IZGb5OOnExhSoh6kQibAzaN0ImRPSRL7TTZocOULG6N8J2C9JiPjXkNLizSbJN7Am6oYMcGEA==
X-Received: by 2002:aed:2a2f:: with SMTP id c44mr4079995qtd.144.1549997237651;
        Tue, 12 Feb 2019 10:47:17 -0800 (PST)
Received: from localhost.localdomain (209-6-36-129.s6527.c3-0.smr-cbr2.sbo-smr.ma.cable.rcncustomer.com. [209.6.36.129])
        by smtp.gmail.com with ESMTPSA id 46sm9229229qty.59.2019.02.12.10.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 10:47:16 -0800 (PST)
Date:   Tue, 12 Feb 2019 13:47:13 -0500
From:   Konrad Rzeszutek Wilk <konrad@darnok.org>
To:     Dongli Zhang <dongli.zhang@oracle.com>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        konrad.wilk@oracle.com, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, joe.jin@oracle.com
Subject: Re: [PATCH v3 1/3] swiotlb: fix comment on swiotlb_bounce()
Message-ID: <20190212184708.GA19497@localhost.localdomain>
References: <1547795428-10595-1-git-send-email-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547795428-10595-1-git-send-email-dongli.zhang@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 03:10:26PM +0800, Dongli Zhang wrote:
> Fix the comment as swiotlb_bounce() is used to copy from original dma
> location to swiotlb buffer during swiotlb_tbl_map_single(), while to
> copy from swiotlb buffer to original dma location during
> swiotlb_tbl_unmap_single().

I queued up your patches in https://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  kernel/dma/swiotlb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index 1fb6fd6..1d8b377 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -385,7 +385,7 @@ void __init swiotlb_exit(void)
>  }
>  
>  /*
> - * Bounce: copy the swiotlb buffer back to the original dma location
> + * Bounce: copy the swiotlb buffer from or back to the original dma location
>   */
>  static void swiotlb_bounce(phys_addr_t orig_addr, phys_addr_t tlb_addr,
>  			   size_t size, enum dma_data_direction dir)
> -- 
> 2.7.4
> 
