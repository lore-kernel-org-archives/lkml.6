Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871E4C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 365502084A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 09:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwfEDNpT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 365502084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729608AbeJ2SdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 14:33:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54905 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeJ2SdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 14:33:06 -0400
Received: by mail-wm1-f67.google.com with SMTP id r63-v6so7477303wma.4;
        Mon, 29 Oct 2018 02:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dh40iVT1fuUDMmaQP9Dog+0ksth3tv/gdXKRBh/ARfA=;
        b=HwfEDNpTIsRB07hNH3+x2w1/KuqsLMHzCuqZsyysBYeb4WQY/paUmFAuJKtUmTMdQx
         cjUcH/TWGNkjngxwKilu/NJo75vUiZScx7IkKeUWxuhlx6M/kPHE3JMKYd09BUpwhUPw
         sEvFoOeVOT/eMBK7sUYExf1EqrMqclA5l7qIikWrg3bPTmJ/UY38LzyddQTiBJjn9lgh
         YWMgcYIz7Kv5XRJKxww8EzmxA8oRGIqsTPECqtOhRFkoU616DYNOIwm/sRFaFi3zJv8a
         s6GrklC0cwFmGFhwmlQDUMg00c9AwMRFJBvmWqNNruhVL6/a4MUA/jocGjcPq/FIWASJ
         LPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dh40iVT1fuUDMmaQP9Dog+0ksth3tv/gdXKRBh/ARfA=;
        b=igqU9/09YSdMDIVT2pwO1j+qpP+KgOWGVVPRgVsTna5cc5Sp4C3Gl51HPlrnizNeHS
         11xoBw+1tuSz0T3YxfnShjkq0VatV0j6pYfBHqodBcRMq83Lr5If3N8CH9h5lm4MgPlc
         YfnbOLrGbnypPgXE+s6TRtNQwCYUWD2J2O6YOaZhR7PWn8AZqfmoLgjC9qL1pYM1/qB8
         si0KjOZnlqJ3nJRpoMf3iQwgZaFPWnwDnMLNCZbaPG1xrYY/p4lSV8WNiEsNLES+hgDR
         8DSqT5E8C2JI55Y7qT4pZT+4dMdkdLGgzPSAFpWo6Mn12aLQSWwoEzVulxS93nbfHugq
         Q2Gg==
X-Gm-Message-State: AGRZ1gIny4CHX2e0hEiaei7ZGxXCDXI/u2QAAfSDQYsF8haejoe8Wo5e
        C+vLvbTf5vYB6YvdBReNs0BXPJBDhYglXawA+fA=
X-Google-Smtp-Source: AJdET5cAW1jhuyze1xIT+5crftUuWy1p/g1t8VrynF5uUIVuPEnqCOThqTlHNEyUuG8Hrz73qTAHAmq6Jmvi6RGJLhk=
X-Received: by 2002:a1c:8601:: with SMTP id i1-v6mr12852784wmd.148.1540806310827;
 Mon, 29 Oct 2018 02:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <1540641134-21485-1-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1540641134-21485-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 29 Oct 2018 17:44:58 +0800
Message-ID: <CACVXFVNNbqHVtP3Zx8Y5Ta-OFbnsFjJhKFzAc0ewt5q6B-6w=Q@mail.gmail.com>
Subject: Re: [PATCH V5] block: fix the DISCARD request merge
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 7:50 PM Jianchao Wang
<jianchao.w.wang@oracle.com> wrote:
>
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
>
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>
> V5:
>  - get rid of the redundant 'else' in blk_discard_mergable
>
> V4:
>  - introduce blk_try_req_merge as suggestion of Christoph.
>
> V3:
>  - Introduce blk_discard_mergable into attempt_merge and
>    blk_try_merge.
>  - Some comment changes.
>
> V2:
>  - Add max_discard_segments > 1 checking in attempt_merge.
>  - Change patch title and comment.
>  - Add more comment in attempt_merge
>
>  block/blk-merge.c | 46 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 36 insertions(+), 10 deletions(-)
>
> diff --git a/block/blk-merge.c b/block/blk-merge.c
> index 42a4674..6b5ad27 100644
> --- a/block/blk-merge.c
> +++ b/block/blk-merge.c
> @@ -714,6 +714,31 @@ static void blk_account_io_merge(struct request *req)
>                 part_stat_unlock();
>         }
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
> +       if (req_op(req) == REQ_OP_DISCARD &&
> +           queue_max_discard_segments(req->q) > 1)
> +               return true;
> +       return false;
> +}
> +
> +enum elv_merge blk_try_req_merge(struct request *req, struct request *next)
> +{
> +       if (blk_discard_mergable(req))
> +               return ELEVATOR_DISCARD_MERGE;
> +       else if (blk_rq_pos(req) + blk_rq_sectors(req) == blk_rq_pos(next))
> +               return ELEVATOR_BACK_MERGE;
> +
> +       return ELEVATOR_NO_MERGE;
> +}
>
>  /*
>   * For non-mq, this has to be called with the request spinlock acquired.
> @@ -731,12 +756,6 @@ static struct request *attempt_merge(struct request_queue *q,
>         if (req_op(req) != req_op(next))
>                 return NULL;
>
> -       /*
> -        * not contiguous
> -        */
> -       if (blk_rq_pos(req) + blk_rq_sectors(req) != blk_rq_pos(next))
> -               return NULL;
> -
>         if (rq_data_dir(req) != rq_data_dir(next)
>             || req->rq_disk != next->rq_disk
>             || req_no_special_merge(next))
> @@ -760,11 +779,19 @@ static struct request *attempt_merge(struct request_queue *q,
>          * counts here. Handle DISCARDs separately, as they
>          * have separate settings.
>          */
> -       if (req_op(req) == REQ_OP_DISCARD) {
> +
> +       switch (blk_try_req_merge(req, next)) {
> +       case ELEVATOR_DISCARD_MERGE:
>                 if (!req_attempt_discard_merge(q, req, next))
>                         return NULL;
> -       } else if (!ll_merge_requests_fn(q, req, next))
> +               break;
> +       case ELEVATOR_BACK_MERGE:
> +               if (!ll_merge_requests_fn(q, req, next))
> +                       return NULL;
> +               break;
> +       default:
>                 return NULL;
> +       }
>
>         /*
>          * If failfast settings disagree or any of the two is already
> @@ -888,8 +915,7 @@ bool blk_rq_merge_ok(struct request *rq, struct bio *bio)
>
>  enum elv_merge blk_try_merge(struct request *rq, struct bio *bio)
>  {
> -       if (req_op(rq) == REQ_OP_DISCARD &&
> -           queue_max_discard_segments(rq->q) > 1)
> +       if (blk_discard_mergable(rq))
>                 return ELEVATOR_DISCARD_MERGE;
>         else if (blk_rq_pos(rq) + blk_rq_sectors(rq) == bio->bi_iter.bi_sector)
>                 return ELEVATOR_BACK_MERGE;
> --
> 2.7.4
>

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming Lei
