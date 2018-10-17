Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB1EECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:50:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 842592150D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 17:50:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ms386Wo4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842592150D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbeJRBqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 21:46:48 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39994 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727186AbeJRBqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 21:46:47 -0400
Received: by mail-qk1-f194.google.com with SMTP id a13-v6so17027851qkc.7;
        Wed, 17 Oct 2018 10:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+hu8ak6EOKrIE+qLO2Xw7TDff8ieVTc7xucZ6FUntxI=;
        b=Ms386Wo4b6wau563jwlBR0KMZOR5MBZM9QwwegW2+SGnaokY/ffppwOyDmaADN1zmP
         clGaYZtAMona+nhIxc/JR4858l5b2bZmwiFmzAmrIKKt9czppVxqyB8LcTOa/hAp0jT+
         N2kstxtGYmcrLa8ske6IxAHMHG3QwQcRwIBZY9CV8DfYzSjLhE4Bc1bbqSqCX6az8fD2
         ujLEJUUHqYGej7eV/SnBREcTqAwJnJqy591qoDApqcmn60BwS4SS9GpkSXqK03WdcZOo
         BxQuBEBMiSqyd8uOI8wVC9TmjiZz/stAesbqhtaGaLb0SrLNjrSfha2M8avQhNPSP4f+
         VIbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+hu8ak6EOKrIE+qLO2Xw7TDff8ieVTc7xucZ6FUntxI=;
        b=DrRHfgVRE6DFQj2zgkmt6yiCEXcuD3nZkXU/A3Og+BPiNA1TsyOQQToswPhCXRE+L0
         yEwIgmsqfsfQfdlTEjrZuIDqYtzFAcbHpCPs7AWZny6GSzCjrpt/MNhHhazFtG8mVpEm
         JsZK2RdNO72j6M+10eUjVLjJTxoebNIK63bMnu/HMFhPz3Dj/wmCIEBcYTwk9FDPJuZT
         HUTJzxzh/CARjvAfHi6R/HdS+a6SLihK9gdm4PDGX3ljHr+zqAofV09ixIGT0UghlLcP
         6miArOiV41FAFeckIErtJvnjpuj4hibt062foe0YkHtGB4kmN7RXfdMsMNSLFiMS6oME
         pHyg==
X-Gm-Message-State: ABuFfohomrqa6uoEzDZ7NpghHLh/0kOniCoZ+QzywJri/xr825ymOT6x
        f+r0rFsDu59xC8aVZ5sV8ZE=
X-Google-Smtp-Source: ACcGV606m+FngNsNnf85NeXsZ/fNt3ez40eZspJ958Bqv9jSL7N8l7hbN6ZWOlqqsSeHconuTeM6yQ==
X-Received: by 2002:a37:8305:: with SMTP id f5-v6mr25728874qkd.230.1539798600440;
        Wed, 17 Oct 2018 10:50:00 -0700 (PDT)
Received: from eaf ([181.47.179.0])
        by smtp.gmail.com with ESMTPSA id e195-v6sm13271361qka.2.2018.10.17.10.49.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 10:49:59 -0700 (PDT)
Date:   Wed, 17 Oct 2018 14:49:54 -0300
From:   Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     linux-fsdevel@vger.kernel.org, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] hfs: fix array out of bounds read of array extent
Message-ID: <20181017174954.6rd3tpcwqv42koh5@eaf>
References: <20180831140538.31566-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180831140538.31566-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 31, 2018 at 03:05:38PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently extent and index i are both being incremented causing
> an array out of bounds read on extent[i]. Fix this by removing
> the extraneous increment of extent.
> 
> Detected by CoverityScan, CID#711541 ("Out of bounds read")
> 
> Fixes: d1081202f1d0 ("HFS rewrite")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

I don't think this got picked up yet; let's see if I can help.

Reviewed-by: Ernesto A. Fernández <ernesto.mnd.fernandez@gmail.com>

> ---
>  fs/hfs/extent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/hfs/extent.c b/fs/hfs/extent.c
> index 5d0182654580..636cdfcecb26 100644
> --- a/fs/hfs/extent.c
> +++ b/fs/hfs/extent.c
> @@ -300,7 +300,7 @@ int hfs_free_fork(struct super_block *sb, struct hfs_cat_file *file, int type)
>  		return 0;
>  
>  	blocks = 0;
> -	for (i = 0; i < 3; extent++, i++)
> +	for (i = 0; i < 3; i++)
>  		blocks += be16_to_cpu(extent[i].count);
>  
>  	res = hfs_free_extents(sb, extent, blocks, blocks);
> -- 
> 2.17.1
> 
