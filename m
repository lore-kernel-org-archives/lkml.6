Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id D02FAC5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:17:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D1B20891
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idVb6POA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D1B20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965539AbeFOCRe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:17:34 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54638 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965516AbeFOCR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:17:29 -0400
Received: by mail-wm0-f65.google.com with SMTP id o13-v6so1033893wmf.4;
        Thu, 14 Jun 2018 19:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CF542w8LLdst1hs++0JEVWNvVMqX6e9wfgrfMVZmZck=;
        b=idVb6POAFCxbWJzOFLhzCqoCiLIX4LuyTDYJZDvO7F5qVV/arUdR5T7HfTT+4uMYYs
         KI+u3KJtdySnYYKTIOM8x63W6su8PDE8HPEAME3u+2vtBOqn454Q+N1NTF38rs+66Nm4
         pT/kfrbSILGeM2U6f+4z8b74LzkAC6ghil/ma6IgqJ7MERXJft5ddZ1GelBI55exeQQh
         MdWfJKsw8C49xFKIqEw/XRarROMTFGAWpzI4BBqYLtIG6dYy49wgnMuEFsM7WXIgNZ7C
         3cg1sV7pK9CmC3cj4HD21EfcodtsfHuz2scsDCgNYACYuJh23+8/zTt6k8u8ka6I/JvV
         PrVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CF542w8LLdst1hs++0JEVWNvVMqX6e9wfgrfMVZmZck=;
        b=d/yn7NqNqbzw2/YntWROJjyS+Wn6WPNp8K/xNNSUmxLoUzSew1y1rvjX/Xk6mF3uvs
         vAtrWvTNOkg3Yc9ZupHoTSu5TCzjH+1nXRmkDCigIbPvwfKfEgk5Na8bT5M5jGXFP9Th
         530coxxq4Z64igr0Ic1QzgAkUlG7Q/rTjqlhWkdlpXDZqe32fpplh/j0Zad9NJ8DrUVu
         V9KdUtNNSTVpscr1y15b1id/Dpnz1Mo0M2pYDrPx1DUZxhC/pTZcjm0Xy7+ofC2y++y4
         ojdQC8BmKZC+geiPaGZtj8RSitzxBFh07i6TKvJky7VQVkzr/7EWIO0OmAIq4vZGUsSY
         hjCA==
X-Gm-Message-State: APt69E2rMypxEl2uK6Qb4bDU8LDUZpuftg9fODSQYosdAwxldKgmd82Y
        DNT4DtKaKW25RnpaBPVZOgEt0vXIRTGnP1b4nxU=
X-Google-Smtp-Source: ADUXVKIbCdhYe27xzZZR007I940A6eJkrVueFM8sQsYMzBuXTYwLLur52xKSyapUHSpmb1RCA0s7AcbYeEf69YQkTAM=
X-Received: by 2002:a1c:aa12:: with SMTP id t18-v6mr78739wme.54.1529029048271;
 Thu, 14 Jun 2018 19:17:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:97c6:0:0:0:0:0 with HTTP; Thu, 14 Jun 2018 19:17:26
 -0700 (PDT)
In-Reply-To: <1529027847-29085-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1529027847-29085-1-git-send-email-jianchao.w.wang@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 15 Jun 2018 10:17:26 +0800
Message-ID: <CACVXFVMe4zSvfXfuSn0NFayeQqbmDwBBy1kcso=5iznT6EfpSA@mail.gmail.com>
Subject: Re: [PATCH 1/2] block: export __blk_complete_request
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 9:57 AM, Jianchao Wang
<jianchao.w.wang@oracle.com> wrote:
> After f6e7d48 (block: remove BLK_EH_HANDLED), LLDD is responsible
> to complete the timed out request, however, for blk-legacy, the
> 'complete' is still marked, blk_complete_request will do nothing,
> we export __blk_complete_request for LLDD to complete the request
> in timeout path.
>
> Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
> ---
>  block/blk-softirq.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/block/blk-softirq.c b/block/blk-softirq.c
> index 01e2b35..15c1f5e 100644
> --- a/block/blk-softirq.c
> +++ b/block/blk-softirq.c
> @@ -144,6 +144,7 @@ void __blk_complete_request(struct request *req)
>
>         local_irq_restore(flags);
>  }
> +EXPORT_SYMBOL(__blk_complete_request);
>
>  /**
>   * blk_complete_request - end I/O on a request
> --
> 2.7.4
>

Looks non-blk-mq timeout code need to convert to ref-counter
based approach too?

Thanks,
Ming Lei
