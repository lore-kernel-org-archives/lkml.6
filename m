Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD24FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 03:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C88E20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 03:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1pPlQD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C88E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbeG3Fau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 01:30:50 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56303 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbeG3Fau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 01:30:50 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so11485683wmc.5;
        Sun, 29 Jul 2018 20:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3RGDLhHL6FO3NWMuetUeLEFUXim5SAj3qrzWtqMdzu8=;
        b=i1pPlQD3LAbaEn9IW48ACde0HyxkHnMg/ES8RatxN0YBpWiWrzdbigDh0YLDFSdXfk
         53dVXgVcg+OeVXVpftxCcaA/RG3B3aTcIblFVWJkyiCIqwRC/0Hq405pnhSOzYh227N4
         vbYl2AGyKpO9peqjW6vg9pYcuEWzD4TZx0a3uFILHokk85sGe/BgZnCCgrCbm4lcOk/5
         EKusKqGh96OCXMuBDmsnPb2Iqwaubn4gZeZhWbKwFNUDUL1vL+smmnDZzu/s6avd00q4
         LA0tcHIvnXP/57qot6m5HN0Oers3WLwl/igXkVpm2CTXfwGzucCTu1b4vNreUGbHyLuZ
         bjNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3RGDLhHL6FO3NWMuetUeLEFUXim5SAj3qrzWtqMdzu8=;
        b=Orz/Pgct9J/uwIPtBd1hdFlk+zzvf8n9NViUAyRuTjI0geFKi13qs48jBcz/Hq4oBA
         4f4jpYHHmOhRzHBEe1g4HMEef0CKVGlc3S5ASO59cyHnxffp9RWcwfvwQGap9zq+cEKM
         zpWYiEJVu5rqpOvva1FUBiX6tFIlak0UAqQfOfcyp/L6RjTjIFcOPRPFDhnmjiTkgnir
         YCMeKWyKBUrnxrXi6MtZ4c73rkPVOpfSorAUxCeucWBswL5ut6JAZNyMsROJsfyXpX/3
         lIs/iZHX9Npz3RTCYRJWr6y0IFOcTsiTB1TvtvjdqS/myqKhcPXkI8S1NlVBzqHu5Mgv
         Sn+A==
X-Gm-Message-State: AOUpUlHA+2wdNcBQ8Rt0z6FZU9/CG+58KjUom9jxwZW1kx3aur1+D5vJ
        frJL59vWGTi98xiZEk8crXgUZBZnEzFWAUA3VQw=
X-Google-Smtp-Source: AAOMgpdyPeJxoDsFHGIDKeiDH4Gbe0Nl1Fv4dDccCxyc+S2wdBZ1ktttdoW4LtJeYsM9ilQJTX0l3Cstx4cZ3oVmgcE=
X-Received: by 2002:a1c:a103:: with SMTP id k3-v6mr13807250wme.161.1532923070497;
 Sun, 29 Jul 2018 20:57:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:9c8:0:0:0:0:0 with HTTP; Sun, 29 Jul 2018 20:57:49 -0700 (PDT)
In-Reply-To: <1532916197-14950-1-git-send-email-jin.xiao@intel.com>
References: <1532916197-14950-1-git-send-email-jin.xiao@intel.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 30 Jul 2018 11:57:49 +0800
Message-ID: <CACVXFVNt=TpVmKmQ8KUF-08pO0f_wCxyHhrGCJhicdgoK6hAGg@mail.gmail.com>
Subject: Re: [PATCH] blk_init_allocated_queue() set q->fq as NULL in the fail case
To:     xiao jin <jin.xiao@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Zhang, Yanmin" <yanmin.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 10:03 AM, xiao jin <jin.xiao@intel.com> wrote:
> We find the memory use-after-free issue in __blk_drain_queue()
> on the kernel 4.14. After read the latest kernel 4.18-rc6 we
> think it has the same problem.
>
> Memory is allocated for q->fq in the blk_init_allocated_queue().
> If the elevator init function called with error return, it will
> run into the fail case to free the q->fq.
>
> Then the __blk_drain_queue() uses the same memory after the free
> of the q->fq, it will lead to the unpredictable event.
>
> The patch is to set q->fq as NULL in the fail case of
> blk_init_allocated_queue().
>
> Signed-off-by: xiao jin <jin.xiao@intel.com>
> ---
>  block/blk-core.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index b888175..52635e2 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1072,6 +1072,7 @@ int blk_init_allocated_queue(struct request_queue *q)
>                 q->exit_rq_fn(q, q->fq->flush_rq);
>  out_free_flush_queue:
>         blk_free_flush_queue(q->fq);
> +       q->fq = NULL;
>         return -ENOMEM;
>  }
>  EXPORT_SYMBOL(blk_init_allocated_queue);
> --
> 1.7.9.5
>

Reviewed-by: Ming Lei <ming.lei@redhat.com>


Thanks,
Ming Lei
