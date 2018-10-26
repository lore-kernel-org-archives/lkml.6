Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18596ECDE44
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D26172082D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 14:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="I2JDpYJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D26172082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbeJZXDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 19:03:17 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:50989 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbeJZXDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 19:03:16 -0400
Received: by mail-it1-f193.google.com with SMTP id k206-v6so1738576ite.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 07:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RxNeL0lPc2d1DxZeopg2s5tokZ+X47tKrxulYoOh5bc=;
        b=I2JDpYJ9qd/kVktTDOo780XDPBp93OLsesFTWNbt4O6zTQ1R8I1NOo25Z18b7zNV55
         qTadBwji0e8XVxxOD1jZxanwUlcjsClKsgo5Hfd8egMz9ghf83cKl7zEAhUE4m3Z3WiJ
         L6PtcUN91Q8lpwQ/InfbVMTQ+1AerEobsQwoX5DxD7cLRuqsByaikEwi6gz5ME02OtFw
         gGksq8zHeFkQK1cGo6ZDwudwVyLi+cZcSWK6rCTE+Z5R+1nazO4cQ2jjOJ3epJtsE3st
         4gA7ltj7jGu4MbH5fzjUHkr/Fd/rfDMc73Pe+gaeu0++EslQQzI8OsLlomDKcfZZJfsL
         owRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RxNeL0lPc2d1DxZeopg2s5tokZ+X47tKrxulYoOh5bc=;
        b=he0ZjtVpwNxuukiPpZ9DyOH6EE+lsUEUJ707IspVm6XSZE+GAT2URF+X5JIFOfnMyE
         4uPE9ut4qWztNMz2qbnCvSmGCqvIoHCAnAcam9GxfXs4JSLred384ewf6oChYjjUVB91
         jC49AOKqfbr3PlKKJsQubcEKx+jgXdH8HP1X6g5ka1D1NqLpQ7p8qtfAScsgTesR8rpJ
         tvJiDz+NPBeZ/Dsn0pfsxgpMb0PM2f0Fh7auRuR6z/GrE2nBJCNe8ZFTJrCjcGtwEox/
         AkKndLuk1HUdjk/vuQjT7RXmyaZeSmmpGpSO9crxp5xXH93Xj0tvZxKN258iaNfLFI73
         UfQQ==
X-Gm-Message-State: AGRZ1gKAAuUZ5BzxY8LLK9OjDy1FbvsOXBPwmO/XpWRlUNhfXoBTO3p+
        z+3zAnQjGG8YDXmHOgy3mlEz/eX28ag=
X-Google-Smtp-Source: AJdET5dNdoBdR32qdvkcwjhDwenWnhGlW0jOdE1N5bfCEAycaN4BrAZumvYCzeB6I9t5EPhssIzReQ==
X-Received: by 2002:a24:6c8e:: with SMTP id w136-v6mr227856itb.153.1540563959416;
        Fri, 26 Oct 2018 07:25:59 -0700 (PDT)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k15-v6sm2172065itk.8.2018.10.26.07.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 07:25:58 -0700 (PDT)
Subject: Re: [PATCH V4] block: fix the DISCARD request merge
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     martin.petersen@oracle.com, tom.leiming@gmail.com, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1540546116-1620-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4ee51782-acbb-bcc9-6692-39e9b8df477f@kernel.dk>
Date:   Fri, 26 Oct 2018 08:25:56 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1540546116-1620-1-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/18 3:28 AM, Jianchao Wang wrote:
> There are two cases when handle DISCARD merge.
> If max_discard_segments == 1, the bios/requests need to be contiguous
> to merge. If max_discard_segments > 1, it takes every bio as a range
> and different range needn't to be contiguous.
> 
> But now, attempt_merge screws this up. It always consider contiguity
> for DISCARD for the case max_discard_segments > 1 and cannot merge
> contiguous DISCARD for the case max_discard_segments == 1, because
> rq_attempt_discard_merge always returns false in this case.
> This patch fixes both of the two cases above.

Looks good to me, but:

> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 42a4674..cf817c7a 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -714,6 +714,32 @@ static void blk_account_io_merge(struct request *req)
>  		part_stat_unlock();
>  	}
>  }
> +/*
> + * Two cases of handling DISCARD merge:
> + * If max_discard_segments > 1, the driver takes every bio
> + * as a range and send them to controller together. The ranges
> + * needn't to be contiguous.
> + * Otherwise, the bios/requests will be handled as same as
> + * others which should be contiguous.
> + */
> +static inline bool blk_discard_mergable(struct request *req)
> +{
> +	if (req_op(req) == REQ_OP_DISCARD &&
> +	    queue_max_discard_segments(req->q) > 1)
> +		return true;
> +	else
> +		return false;
> +}

Please get rid of the redundant else.

-- 
Jens Axboe

