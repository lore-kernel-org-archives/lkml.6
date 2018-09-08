Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91525C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 12:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5DA20652
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 12:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bcvLR32H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F5DA20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbeIHRPA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 13:15:00 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38535 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbeIHRO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 13:14:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id t84-v6so6422012pgb.5;
        Sat, 08 Sep 2018 05:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uRh+6FT6o3DqkF+Muqt432oUQtZTIM1GyzWu56Qnldw=;
        b=bcvLR32HUAsKhHMunb7Epj7rExxzRkLHi2cEHE/Di4BK2+KQjlMlCKHKh2i6KbehWR
         hgyCAykbOMp/TfQQx5ajbVgbg5kQqMar41nxhSF6QHuq2aSg+4k9D6FXEOcCeumMVGCQ
         ArqRXFLx8VUECH+Te3fTp57o4/HG+vsJZiqhxNfNwfD5ZodRw7fIC69WgvYAxA5nJ9Ir
         xCTTIab/vzEokWLP0Fr2Q4URML7eiRFBDtGruoprpYJi5q1RkSOrPwwBLXb++g8fENg4
         JULRzjjMqQY+FROsKeVsUGMHhQAL4resgb8lhYQ3637YiZg/bcDlKnkZFexXBUk7tlxW
         dxBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uRh+6FT6o3DqkF+Muqt432oUQtZTIM1GyzWu56Qnldw=;
        b=BO9YikAWiPla3PNIqd7Fs3TeXK562GrsSZ9a74oCZR78ZHoIMlQomIHzhGdQtZI+g1
         gvulWa0cN4G8e14NRKDEbQbmqINCQa+kQWqPhAMljgTGgP4axH3qxG1G3xEALduu75nI
         SD+3RLQ30nlKWsT2YO6lpCMC0Li5QnedbIVzc33qzV/BqZ+ad13W6Cyr0EKNzdF4oV0d
         TmQE59VWKqVq5T0bqH/WT/HFfH4HL4Z08ySiY/vws1akiE4mIczoFrxlqScwnKBgkxOK
         uGc9GVlMf+UeIMAIjBTxVsu7Cgc+GE+MpO1Z8T4eAA/4+JDVyzwJWAtcHWetYuXSs8zQ
         qxvQ==
X-Gm-Message-State: APzg51CKEk8DOvXkS+bGbSA7H5umUwzk5rKs/UysAXPK4wNHb4czUKBh
        3Qj3QjJSZ+sIllEL/XGbCJc=
X-Google-Smtp-Source: ANB0VdaaATztSYtAa2jhELkYUUvgLHJg/FDMkERwgPknLCGnX47A++mCG/ZjaD1rNV96agGn2ooVbw==
X-Received: by 2002:a62:9c17:: with SMTP id f23-v6mr13609743pfe.209.1536409760967;
        Sat, 08 Sep 2018 05:29:20 -0700 (PDT)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id f67-v6sm15858886pff.29.2018.09.08.05.29.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Sep 2018 05:29:20 -0700 (PDT)
Date:   Sat, 8 Sep 2018 17:59:13 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: remove unnecessary condition judgment in
 am2315_trigger_handler
Message-ID: <20180908122913.GA4445@himanshu-Vostro-3559>
References: <1536404256-25189-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536404256-25189-1-git-send-email-zhongjiang@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 08, 2018 at 06:57:36PM +0800, zhong jiang wrote:
> The iterator in for_each_set_bit is never null, therefore, remove
> the redundant conditional judgment.
> 
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/iio/humidity/am2315.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/humidity/am2315.c b/drivers/iio/humidity/am2315.c
> index 7d8669d..dc12e37 100644
> --- a/drivers/iio/humidity/am2315.c
> +++ b/drivers/iio/humidity/am2315.c
> @@ -176,8 +176,7 @@ static irqreturn_t am2315_trigger_handler(int irq, void *p)
>  		i = 0;
>  		for_each_set_bit(bit, indio_dev->active_scan_mask,
>  				 indio_dev->masklength) {
> -			data->buffer[i] = (bit ? sensor_data.temp_data :
> -						 sensor_data.hum_data);
> +			data->buffer[i] = sensor_data.temp_data;

No, this seems wrong!

We have buffer support to either take both readings(temp & humid)
simultaneously, or only single channel using specified scan mask.

Patch title should be:

"iio: humidity: am2315: .... .. "


Thanks
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
