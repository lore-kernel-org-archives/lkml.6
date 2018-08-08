Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223D5C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:24:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA23A21700
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 09:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMrp3SC6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA23A21700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbeHHLnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 07:43:04 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33116 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727187AbeHHLnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 07:43:04 -0400
Received: by mail-wr1-f68.google.com with SMTP id g6-v6so1393547wrp.0;
        Wed, 08 Aug 2018 02:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=yw0cAodkWdzlnA1FL47Y3dJhIfqpFOqMSaa5iy2NohE=;
        b=AMrp3SC6WTYoIt8WT1DrMN0CQ7TkUTh5ZsBb3E4cNTILWCqZNYoNSE0OMGPllsPWr8
         g4AmSzXmaMHxgbPi6OpGKkENSNeFykDVhowYNmJgbqullwIjS1+UiAzRs+zr1kCEGvih
         RslWPQQz6etxQ3qKL4RYmFNxKLQQaLW2UzzYnlFpofO6ao9jw+toUMwapN5+lSLoxa8L
         iC7x5btuIRk0pldA+4NzZiNAll72GhrqRA/10qeIfrJzxgPaMSaW6RzZRylaxrSWPek7
         bq3NvzhjCazV5Yxg27kPissIv9PTX4AN2sNVpggQ8V6hhLNY4bC6utWS1TF3Sb1MtquQ
         u82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=yw0cAodkWdzlnA1FL47Y3dJhIfqpFOqMSaa5iy2NohE=;
        b=oLOpkwu6V0/tvB9Ff3p7iyx+ARvgq5th30DwiroPuwxnCYOTvpO46GCLzP2RE8Xf+h
         x/QTqrImlPRBN9YoFZdGireqTkOvJrigd11wRGNod6lNakc+7P3XSX5bqFO7I3ed5MOJ
         Z4kixiEQXwF8L9aN8urwfNwXlgOiYR3N+3hty9MqqdTk2igVqjG5n+7mBa2Gq7fCcBT0
         aqELLDddGO6+PwTaLhnk3N084DzZ+um2xk04I6cKHw83zS8mQUA2fIhx5EWCjlerFtYF
         PguH2lWGdDuu1+/4/YNfqZyqUyBdREgNLrm996J5n3+yn6Sh5YY/hriejfRymZv/pxqh
         avAQ==
X-Gm-Message-State: AOUpUlFQJ1GislBn15hPNcsgreawMMnGMyoWS1BSoaRz7oY6Xj6knWvl
        q8OKg1PP+EDtCabAeNq6yB8vxRyYk94rcBfgXhyPhZke
X-Google-Smtp-Source: AA+uWPzqXkD84+/Zzvu9udso4AT/C8QzKp8vVJEyaSpdUDjUl569vAaJUt637nCaalaiynr9PPuSCgUKlpoj3rPfcTw=
X-Received: by 2002:adf:e50f:: with SMTP id j15-v6mr1364998wrm.111.1533720253982;
 Wed, 08 Aug 2018 02:24:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:9c8:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 02:24:12 -0700 (PDT)
In-Reply-To: <1533716548-1645-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1533716548-1645-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Wed, 8 Aug 2018 17:24:12 +0800
Message-ID: <CACVXFVMKQRT5_gyikVAPMKY_KPmQ2_w+VnZhKKCK9Sm4WphqQw@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: count the hctx as active before allocate tag
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 8, 2018 at 4:22 PM, Jianchao Wang
<jianchao.w.wang@oracle.com> wrote:
> Currently, we count the hctx as active after allocate tag
> successfully. The other shared-tags users could exhaust the tags
> and starve a non-active and waiting-tag hctx. Count the hctx as
> active before try to allocate tag to fix this.

This patch looks fine.

>
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-mq.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index ae44e85..acd40eb 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -369,6 +369,8 @@ static struct request *blk_mq_get_request(struct request_queue *q,
>                         e->type->ops.mq.limit_depth(op, data);
>         }
>
> +       blk_mq_tag_busy(data.hctx);
> +

blk_mq_tag_busy is only required for driver tag.

Thanks,
Ming Lei
