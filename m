Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5ADEC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 03:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BD2D2243E
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 03:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AR9qGICZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD2D2243E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbeKMNSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 08:18:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39493 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbeKMNSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 08:18:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id c72so621753pfc.6
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 19:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sRhoh1MRAm21UHbeLTOGu25OxGE316qTnA0+1QF8Vxc=;
        b=AR9qGICZTK7HC34EZXXqoWkinuFa9CbbK5lAezj6djlTVEipGiIu/1Yuty1dJ8LTKQ
         t0riEp92Q/i75Tyvb8v3WbBxYlfa0HAdDJz9BaEUrtiF7jZcQyqn3qXhpU+K9pqxQqYH
         ZqzALymf6T71WXxQRhYfw8rhM35Vd8CNET/VQGBwfbbhC870CDgE/R/IZAZOwH/dlPLG
         9J1io/HONconLn4SzH1/BxQHOF0mGHUpvaZP8Z180Hx+dPZCDMgP9P3asH9xnKWuHcM/
         lYtC1DTRUABTJYaRSR6+7/lO67si1sfwcxOv2dArJ72MFNXbJyA0m/9Jxn5w8XdyP6Nx
         M1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sRhoh1MRAm21UHbeLTOGu25OxGE316qTnA0+1QF8Vxc=;
        b=E62MUkCDdI9mqhkNgC6vnXCEx0UZlSA9z2TqlEH9MdvdQ8bpVLeppplH/Hsyq8laJq
         4nErBqKqv3WkhVqu9ViA0VJuGLWXuUeyXP4I2Cn89NPa0OJ39GjpimGdR+oRRzFHGFV8
         R/IZJ3sar0e712FaCYnM5Lhsc4u17JPwPb8Ijf5ZHV22nGxCk16C9QlbWHdmPJKBGXGI
         78I7Ze3vZyUdp2EO09sRpy8OSQcq4sgQbb9bjrJUbya/qiz6MkU5/0bdL6SZhyFcDfLP
         wCWbxlx6oDJW4KgfgEuQMA78wwx+mzrJZR9J50tHoBtoWxsW2FpNQPyZ3WklnxE0nTCq
         S/ww==
X-Gm-Message-State: AGRZ1gLdEL7/uPGczLM8DFKLnpbnn/XJ8BNRvSrPHkeutO3KJOpIy6h9
        ajf3Jn1FAk3iN4ztjXtqTxyj7XG4O1E=
X-Google-Smtp-Source: AJdET5fvYxGVLplT1rgI8pNyeSmavW+OhZyY3olbpsPe+faAevL0lqMDe7kt9wclHEMRy1r6G+9SYw==
X-Received: by 2002:a63:2f07:: with SMTP id v7mr3003512pgv.368.1542079346149;
        Mon, 12 Nov 2018 19:22:26 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v84-v6sm24764293pfd.182.2018.11.12.19.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 19:22:24 -0800 (PST)
Subject: Re: [PATCH V5 2/6] blk-mq: refactor the code of issue request
 directly
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1542014609-1769-1-git-send-email-jianchao.w.wang@oracle.com>
 <1542014609-1769-3-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <77b68772-4daa-cffc-079a-7ad1bfae2fec@kernel.dk>
Date:   Mon, 12 Nov 2018 20:22:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542014609-1769-3-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/18 2:23 AM, Jianchao Wang wrote:
> Merge blk_mq_try_issue_directly and __blk_mq_try_issue_directly
> into one interface to unify the interfaces to issue requests
> directly. The merged interface takes over the requests totally,
> it could insert, end or do nothing based on the return value of
> .queue_rq and 'bypass' parameter. Then caller needn't any other
> handling any more.
> 
> To make code clearer, introduce new helpers enum mq_issue_decision
> and blk_mq_make_decision to decide how to handle the non-issued
> requests.
> 
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-mq.c | 108 +++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 63 insertions(+), 45 deletions(-)
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 364a53f..48b7a7c 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -1766,77 +1766,95 @@ static blk_status_t __blk_mq_issue_directly(struct blk_mq_hw_ctx *hctx,
>  	return ret;
>  }
>  
> -static blk_status_t __blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
> +enum mq_issue_decision {
> +	MQ_ISSUE_INSERT_QUEUE,
> +	MQ_ISSUE_END_REQUEST,
> +	MQ_ISSUE_DO_NOTHING,
> +};
> +
> +static inline enum mq_issue_decision
> +	blk_mq_make_dicision(blk_status_t ret, bool bypass)
> +{
> +	enum mq_issue_decision dec;
> +
> +	switch(ret) {
> +	case BLK_STS_OK:
> +		dec = MQ_ISSUE_DO_NOTHING;
> +		break;
> +	case BLK_STS_DEV_RESOURCE:
> +	case BLK_STS_RESOURCE:
> +		dec = bypass ? MQ_ISSUE_DO_NOTHING : MQ_ISSUE_INSERT_QUEUE;
> +		break;
> +	default:
> +		dec = bypass ? MQ_ISSUE_DO_NOTHING : MQ_ISSUE_END_REQUEST;
> +		break;
> +	}
> +
> +	return dec;
> +}

You seem to mix and match decision and dicision, the former is the
right spelling.

But more importantly, not sure I like where this is going, wrapping
the return value in some other status code. That also makes it a bit
fragile in terms of adding other status codes, another spot to update.
Like the decent distinction between RESOURCE and DEV_RESOURCE.

Maybe it is cleaner to just handle this in the caller still?

-- 
Jens Axboe

