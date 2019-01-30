Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5D89C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:58:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83EAB2184D
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 10:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hVnbM0GT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730298AbfA3K6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:58:21 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41597 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbfA3K6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 05:58:21 -0500
Received: by mail-ot1-f67.google.com with SMTP id u16so20730106otk.8;
        Wed, 30 Jan 2019 02:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=22PfJD3VvWjZA5JzWoMtRlbmBHWVyVih0KBEdwGiUVo=;
        b=hVnbM0GTfaAd+3EMYqIyDC2C/hmAEBq0TxEVwsgu8YOtSemw6Ng1v54iS89Oe8F9nc
         CeoFYO9umZ8dMASQX6GyCbos+wRkwocUrdEKoLUkhi6yPBsY8z1xImDiSaMrSS4im6Ys
         HUk2Gi+1XXB9V3XhlwhW00Ei3HB8iN8Y5iSqefpr/z9G9oUyh8CTnRoyjuT71gNBIE1A
         tbUU8Tx8yhVnUg+kXBX2nvUAqOT/tj+6pGI1XdqBF2nar7glf/p0CAs/EyEGRcp0Gu1D
         1jzkfSt6XqEAPEDdDpikr0Nog7scE50egSKwSpmMczzMF/4mAeDGhgkAprjVUMEl10/Y
         n9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=22PfJD3VvWjZA5JzWoMtRlbmBHWVyVih0KBEdwGiUVo=;
        b=dNqV1CvV0TdlSweim3tOomJy/RQoVmu/nzXPa2ozqyrL+28IqgHyq4tfZ4HaeRANo0
         KiXTbgyRbKGvE6MHCNuSqnqDaqDfnpVRw8FhCx/32ydCILB1ARRLWeHHmlZvS/AIsLib
         bX7vApeqB0Zvs6duH+eXUNAf/tj4J4EX4D9yo1Utc1ymNRlkfvxrYF6hqZAtyM7cVLmv
         SEDviJhDL1fnn67JPsgOoD5MbC+2xKatCqkWebFSHrPk/y1GmSc7v5JSotHY5ze1qpOE
         TLxoJomQ0jM3kI6LHRxjfx9UKpaU08ZuR+0H3CXaHRvh55W6CsJ6jz3D8m6srpMGOxw1
         jaYg==
X-Gm-Message-State: AJcUukdDvxOi0rLSarc4rYNL6B+4qbE3IcXRnZx8pTkrTsgyZ3k26coX
        zK6VjtEyn+31e3+MnUm8Eg==
X-Google-Smtp-Source: ALg8bN7VboMDpcYzRcct0WWZ2eNuU/XCnIkqMKmmgmZKwKsWnKDmpNBTHmmOIT2TK9YAcpYGnDs0wQ==
X-Received: by 2002:a9d:75da:: with SMTP id c26mr23652333otl.39.1548845900313;
        Wed, 30 Jan 2019 02:58:20 -0800 (PST)
Received: from kmo-pixel ([2600:380:b941:37c4:9e42:6f9a:8369:8e52])
        by smtp.gmail.com with ESMTPSA id o8sm478974oia.53.2019.01.30.02.58.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 02:58:19 -0800 (PST)
Date:   Wed, 30 Jan 2019 05:58:17 -0500
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     colyli@suse.de, linux-kernel@vger.kernel.org,
        linux-bcache@vger.kernel.org
Subject: Re: [PATCH -next] bcache: Fix potential NULL pointer dereference
Message-ID: <20190130105817.GA12598@kmo-pixel>
References: <20190130102112.11228-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190130102112.11228-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 06:21:12PM +0800, YueHaibing wrote:
> There is a potential NULL pointer dereference in case
> kzalloc() fails and returns NULL.
> 
> Fixes: bc082a55d25c ("bcache: fix inaccurate io state for detached bcache devices")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/md/bcache/request.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
> index 1507041..a50afa4 100644
> --- a/drivers/md/bcache/request.c
> +++ b/drivers/md/bcache/request.c
> @@ -1094,6 +1094,8 @@ static void detached_dev_do_request(struct bcache_device *d, struct bio *bio)
>  	 * which would call closure_get(&dc->disk.cl)
>  	 */
>  	ddip = kzalloc(sizeof(struct detached_dev_io_private), GFP_NOIO);
> +	if (!ddip)
> +		return;
>  	ddip->d = d;
>  	ddip->start_time = jiffies;
>  	ddip->bi_end_io = bio->bi_end_io;

This should be using a mempool/bioset... just returning from a make_request
function is not correct, that's a serious bug - you're just dropping an IO on
the floor, which is going to cause whatever submitted that IO to hang.
