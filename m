Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2209C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:02:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760F620851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:02:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIszrXm4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760F620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbeLCGCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 01:02:18 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38274 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeLCGCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 01:02:18 -0500
Received: by mail-pl1-f196.google.com with SMTP id e5so5895876plb.5
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 22:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KvOLLYtosfl9evOE75aR4QwQpjj3V6YvB33Oi+VUiiE=;
        b=TIszrXm4p0cDEemFF1HIeB39YpvhTy+qNr7Q0H29c/zChAaPH+MhSXYqpoLsA76NRt
         Cm0nsqrwFfC/F/zTUbCKmN1r+658s8/nYO6SHeJo+0Y8FpZaiMirSP/bMWZ3izn8YhYX
         HymASgWQqZ2vb7k05tJSqT4cQQM/8TN+efmjAchGPHro7F4xE5DMeW9NUAy/uY/WUyFC
         aShqMjXBGTJo1FEjNpfBkkmeev+uMwkAc+B2GpIs2dmdaAcnw0bDSx8rS57wR9QC2IoB
         I0MkHpsmVWoxlAX5KGoZcDwVoKygj1i0ZG3qyNu+B9jnKxIUSWh+7A5H+bEd2QrGrnAu
         8mZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KvOLLYtosfl9evOE75aR4QwQpjj3V6YvB33Oi+VUiiE=;
        b=S1poKxBTwdFxPrp+SRkoCtzY+so2o78fq6W4xwR8ntJqNV9SJRg4068gNFgUrUl9NJ
         CYsKSApi8+7WpeA1ryyGd05zm2eMy86C4G5CaBYOsh6G8LOep5K992lzKCVoriPNwXFi
         tx7qP2Ri1CEAypt2aNB24bx/bkgMH90kWzABbnyZPFjiCtQ7MKJ18dHO3+hasmnhEVVV
         ueEqzxTLGGNPvg4Jt8/z6DYe1Vrbili08JzwePFf/s1qcWnJDV7O9eJBkeDjo8NryVGK
         48a+dePGBLesa0CvgO2iPu0OSmT0eSyADMuJsvS1wN8fevF4eXqrewCsGux1bNqbBcJ5
         Y0Jw==
X-Gm-Message-State: AA+aEWbOlKPTJEl3LtDW6k5ouYBICNTEZhr7pijX97p2oKFhgwdwnLsS
        qvgIpaVQFXRgUXIputnjpBM=
X-Google-Smtp-Source: AFSGD/WQnHTJolfZQYzOazcHovGKPzinhhsC+U3F7w5qudLEfald0BVMQawx39KVuVdfHKxqg1JQ4Q==
X-Received: by 2002:a17:902:b118:: with SMTP id q24mr14881114plr.209.1543816932333;
        Sun, 02 Dec 2018 22:02:12 -0800 (PST)
Received: from localhost ([175.223.22.143])
        by smtp.gmail.com with ESMTPSA id j14sm16502452pfn.175.2018.12.02.22.02.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 22:02:11 -0800 (PST)
Date:   Mon, 3 Dec 2018 15:02:08 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH v4 7/7] zram: writeback throttle
Message-ID: <20181203060208.GE427@jagdpanzerIV>
References: <20181203024045.153534-1-minchan@kernel.org>
 <20181203024045.153534-8-minchan@kernel.org>
 <20181203055026.GD427@jagdpanzerIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203055026.GD427@jagdpanzerIV>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (12/03/18 14:50), Sergey Senozhatsky wrote:
> On (12/03/18 11:40), Minchan Kim wrote:
> [..]
> > +	down_read(&zram->init_lock);
> > +	atomic64_set(&zram->stats.bd_wb_limit, val);
> > +	if (val == 0)
> > +		zram->stop_writeback = false;
> > +	up_read(&zram->init_lock);
> 
> [..]
> 
> > +		if (zram->stop_writeback) {
> > +			ret = -EIO;
> > +			break;
> > +		}
> > +
> >  		if (!blk_idx) {
> >  			blk_idx = alloc_block_bdev(zram);
> >  			if (!blk_idx) {
> > @@ -694,6 +732,11 @@ static ssize_t writeback_store(struct device *dev,
> >  		zram_set_element(zram, index, blk_idx);
> >  		blk_idx = 0;
> >  		atomic64_inc(&zram->stats.pages_stored);
> > +		if (atomic64_add_unless(&zram->stats.bd_wb_limit,
> > +					-1 << (PAGE_SHIFT - 12), 0)) {
> > +			if (atomic64_read(&zram->stats.bd_wb_limit) == 0)
> > +				zram->stop_writeback = true;
> > +		}
> 
> Do we need ->stop_writeback? It should be identical to
> 
> 	atomic64_read(&zram->stats.bd_wb_limit) == 0

Seems like I misread writeback_limit_store() a bit.

So, if I want to, say, let only 10M of writteback pages, I need to
do

	echo 0 > writeback_limit
	echo 10M > writeback_limit_store	// memparse format is for
						// simplicity only; I know
						// it should be in 4K units.

every day. How about dropping the "echo 0" and ->stop_writeback?
So then we can just do

	echo 10M > writeback_limit_store

every day: if we have ->bd_wb_limit budget then we writeback,
           otherwise we don't.

	-ss
