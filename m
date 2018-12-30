Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84661C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 18:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51604213F2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 18:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546194865;
	bh=XpZKn3oE/sDBvKfNTpEt4GTJdArEb4qRbcjgEjNxwBw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Thv5iU2jt7oWfWczI657wFm+1Fshn8B2AUgRTKXqfeZchpCToOp6B3lxb0PqMJfC8
	 KKXiZlVsNXX8BHZNm5j4rookxvECJZi1x6/UaJBvMhgJwR7qdN51GxDde9FwUl25Lk
	 jNZrz4rUQ0n+QzCoHn/SnEFxdhM92hhInmz8x59M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbeL3SeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 13:34:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:44192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbeL3SeY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 13:34:24 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3352E213F2;
        Sun, 30 Dec 2018 18:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546194863;
        bh=XpZKn3oE/sDBvKfNTpEt4GTJdArEb4qRbcjgEjNxwBw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h8W7vf0ZvwxcrqSh1OLDWcqYIsWdLWgfUTqXBJF3HE6CGvziVBTS/+EtPW0K9nVuC
         eK1EjIZLS5xFdPvFvsw+Y/NTSs7CWaKf0Zb97WakKCQDjw0SGJ83BYT3kuqwpEx3R1
         TKqgA4lx5eBVObq1Vq4hKV40cGA4vcm3r5xntJYw=
Received: by mail-oi1-f180.google.com with SMTP id t204so20747168oie.7;
        Sun, 30 Dec 2018 10:34:23 -0800 (PST)
X-Gm-Message-State: AJcUukdHso4qx1KcEw2wj9IGGpef6rXxJEc3ZT2OfQOWnwyfXaTVAdWN
        7fANJS6Tjmt5ao/wNZyn75dB+l+xWDmlVwjI42U=
X-Google-Smtp-Source: ALg8bN6k+kmxaeSFAcfEJdYfL5P32GwdzoZtaEuQLJKprO16AW3MPMQJhzQkJnieCzxJhKI5mRtlvoUCwBglq02rMQw=
X-Received: by 2002:aca:5e09:: with SMTP id s9mr6882243oib.153.1546194862485;
 Sun, 30 Dec 2018 10:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20181228201119.11920-1-pakki001@umn.edu>
In-Reply-To: <20181228201119.11920-1-pakki001@umn.edu>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Sun, 30 Dec 2018 21:34:12 +0300
X-Gmail-Original-Message-ID: <CAK9iUCPvmoN4_0jyZ+DP+ROmmoKTpqCoRPgOCKTmjT-o73zW4A@mail.gmail.com>
Message-ID: <CAK9iUCPvmoN4_0jyZ+DP+ROmmoKTpqCoRPgOCKTmjT-o73zW4A@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: qcom_hidma: Check for driver register failure
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     kjlu@umn.edu, Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 11:11 PM Aditya Pakki <pakki001@umn.edu> wrote:
>
> While initializing the driver, the function platform_driver_register can
> fail and return an error. Consistent with other invocations, this patch
> returns the error upstream.
>
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---

Acked-by: Sinan Kaya <okaya@kernel.org>


>  drivers/dma/qcom/hidma_mgmt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
> index d64edeb6771a..681de12f4c67 100644
> --- a/drivers/dma/qcom/hidma_mgmt.c
> +++ b/drivers/dma/qcom/hidma_mgmt.c
> @@ -423,9 +423,8 @@ static int __init hidma_mgmt_init(void)
>                 hidma_mgmt_of_populate_channels(child);
>         }
>  #endif
> -       platform_driver_register(&hidma_mgmt_driver);
> +       return platform_driver_register(&hidma_mgmt_driver);
>
> -       return 0;
>  }
>  module_init(hidma_mgmt_init);
>  MODULE_LICENSE("GPL v2");
> --
> 2.17.1
>
