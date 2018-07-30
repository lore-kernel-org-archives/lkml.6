Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80619FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D4A20870
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 12:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMJ9NAQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D4A20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbeG3NlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 09:41:20 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51343 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbeG3NlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 09:41:20 -0400
Received: by mail-wm0-f68.google.com with SMTP id y2-v6so12881475wma.1;
        Mon, 30 Jul 2018 05:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RHuDbjJWcaaQUxeraKVOOqfVgkYIlAQvbBUkO3SrBDE=;
        b=DMJ9NAQB6HgZx48lXP7/U1G1exHGIW0q5bRx/lUx0eIr3oLPH7sQfTBO7+viZDLpDO
         AX1Yi0smkhY7zQhM4D75E6TFCVimFWSMvc08n9qcyA9GHJzqkcOE48ONYWjPm1B3ysJQ
         0O7EAO+MQUa3BqrQctvYTKeRESOO+3trBKE8DaiHLbRrMPzqAxXW+wBnO1+pDqX+Q/98
         N+9BLWCD75YmdXO+D/ncSquSnGvk9KvXc+rCDipHCJUMs1KxBCvihjH9SGkcPROvziRh
         aXvyg2DKa5SjX5ScNTrnGdyDBHtR3bGRstWKoKEhG4vLfnDUehbLGG9wK6Nd0Hmbw8p+
         n96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RHuDbjJWcaaQUxeraKVOOqfVgkYIlAQvbBUkO3SrBDE=;
        b=ltgkTcjrSxMNfWWhwJqrGqZy4k0GGyqOXuBWsThy79ncOv7A0ZnJbJOqgjoLb+8WMB
         wOrzkUmXtvuEaNCNidW8+vJcM7GkHqvlgU6R5D5XvJMHFUvben+vfSGhNck/r5KTsmvl
         1I3jz5ZF3LJXfrO7RKCEO54jpPfWGwutKe/X3crRiTcn52evjeoxTQXzGIF198FKfNUW
         uTGYvYTbIFtBSZM7601QfmNysq25sl/khaIfb/xRcnu6R+B8hhBZpmlLszZZFb4cuDnv
         zFD5h196299oRnXHwgfgLHYMM0C57tym6wQMMofK9soOPRvW2d6XciIRTPcBhglMBxop
         W81Q==
X-Gm-Message-State: AOUpUlFZydK96vldPDfK2gV2ir5580rLJRWqMlzEe2QACcxY0MeTP8Pa
        krMgdeTEqLGFHYJmWsvlb4A2df9ZcQK6XSnI/K8=
X-Google-Smtp-Source: AAOMgpf6tsXBJrv0X7tDd7nt/6fXb9hwNMKoZInEqpcu3hIEIwzz9YcYoWRcwMiinOhuyBG2d94PJyoT6mIDJkm4rdM=
X-Received: by 2002:a1c:ce0b:: with SMTP id e11-v6mr14517541wmg.47.1532952397951;
 Mon, 30 Jul 2018 05:06:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:9c8:0:0:0:0:0 with HTTP; Mon, 30 Jul 2018 05:06:36 -0700 (PDT)
In-Reply-To: <1532931072-5190-1-git-send-email-jin.xiao@intel.com>
References: <1532931072-5190-1-git-send-email-jin.xiao@intel.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 30 Jul 2018 20:06:36 +0800
Message-ID: <CACVXFVOECZjvDjya1q91me5JnTh=80asDnnDs7re3xi5+OPdJw@mail.gmail.com>
Subject: Re: [PATCH] block: blk_init_allocated_queue() set q->fq as NULL in
 the fail case
To:     xiao jin <jin.xiao@intel.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        stable <stable@vger.kernel.org>,
        "Zhang, Yanmin" <yanmin.zhang@intel.com>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 2:11 PM, xiao jin <jin.xiao@intel.com> wrote:
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
> Fixes: commit 7c94e1c157a2 ("block: introduce blk_flush_queue to drive flush machinery")
> Signed-off-by: xiao jin <jin.xiao@intel.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Bart Van Assche <bart.vanassche@wdc.com>
> Cc: <stable@vger.kernel.org>
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
