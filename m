Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE3AC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815A420862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+ISeTxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 815A420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389935AbeHARTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:19:34 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:46134 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389815AbeHARTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:19:34 -0400
Received: by mail-ua0-f194.google.com with SMTP id u11-v6so8243250uan.13;
        Wed, 01 Aug 2018 08:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UZtZ2qGqyehFyxakQCwWXdAxCe1/DN+of3r9oqj7guE=;
        b=U+ISeTxSf7M7Xh/8TqFQDxDZES5Q0UVhQnXbbckDO0kCbiRE9DKjH4Na66h4iozST9
         rPTWD7SiLZZvKcRb5mBF/gKlPyF/JUivUgNQvSjbmGOph93//rV/niLAbrkW6sl+8s5P
         mRsB3scsYF8P5MjFPOt/ZMfNwLIUroYmhJiHyUP8KLHhFwQIN90NeN+dESin9W/XGmOJ
         EOzk4r7QQ6PDg+Ir/DfPSnTGBhXGxgwmtFczsC3TJBYQcJ7eQvhDKUaW5BCVMr4vgrhf
         GjJiWkXeOAA5fcQSPVl1f/+0FqrrSebX3Xpib4f/+kkXNRpK8WvA9I5WeoEWnun65DnT
         fA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UZtZ2qGqyehFyxakQCwWXdAxCe1/DN+of3r9oqj7guE=;
        b=d99BlYcXoXGr8Qjb9J8DEg4J9GPoBzEhAzmnnlsa5kMYzIx4DzRYpE/J5bO11rkodK
         H0UObqSOJcZXnB66BgZ0+TWpxjM5X3351nbujRxIfuVm1TRZadzAZ5p8p57I9bJKzymh
         K8lWNHnFWEzCN4aHvfTmYD1CEr9dXI5J3U6ZSYbvEZyudrfnI394Jpnsy+FT/5GAl2ld
         i3PnMluBLfMZEK/x2RL3Gyt9oJ+wrI8G7NocJXcaP1RzAKY50KMExd9iqo7N36oyugGH
         zOxO89mdaejVe3b4tyQkumsNMfvnItRNOPH73tSyZ5OxvjzozYxqu/To9TnUPQCNRvF8
         PCog==
X-Gm-Message-State: AOUpUlE4je/alkeANV7GBsDFyqR6gbz0304e3iFnTYE91aG4UVG3hPH5
        zrFUU9hf1ixY/YUy4UZyDWNWd4gGtyvmyGG9vIQ=
X-Google-Smtp-Source: AAOMgpcKPAhDsDQKt19+392Nw1wx09BotfMMvX6/xLrFe0PQlQfScZCTQ5wCz4XbHenTUpgskqfCXcni6ur8SWCOfUA=
X-Received: by 2002:ab0:1b93:: with SMTP id k19-v6mr18942840uai.122.1533137597783;
 Wed, 01 Aug 2018 08:33:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 1 Aug 2018 08:33:17 -0700 (PDT)
In-Reply-To: <1533129976-51930-4-git-send-email-zhongjiang@huawei.com>
References: <1533129976-51930-1-git-send-email-zhongjiang@huawei.com> <1533129976-51930-4-git-send-email-zhongjiang@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Aug 2018 18:33:17 +0300
Message-ID: <CAHp75Vd1=Tw+=JMSe3XTGx0jsXCW7qi+dMCo1i6RTWc-kMYH2A@mail.gmail.com>
Subject: Re: [PATCH 3/4] drivers/scsi/snic/snic_trc: Use vzalloc instead of vmalloc+memset
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     John Garry <john.garry@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        aacraid@microsemi.com, linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 1, 2018 at 4:26 PM, zhong jiang <zhongjiang@huawei.com> wrote:
> The vzmalloc is better than vmalloc+memset, so replace them.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  drivers/scsi/snic/snic_trc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/scsi/snic/snic_trc.c b/drivers/scsi/snic/snic_trc.c
> index fc60c93..876c490 100644
> --- a/drivers/scsi/snic/snic_trc.c
> +++ b/drivers/scsi/snic/snic_trc.c
> @@ -126,7 +126,7 @@ struct snic_trc_data *
>         int tbuf_sz = 0, ret;
>
>         tbuf_sz = (snic_trace_max_pages * PAGE_SIZE);
> -       tbuf = vmalloc(tbuf_sz);
> +       tbuf = vzmalloc(tbuf_sz);
>         if (!tbuf) {
>                 SNIC_ERR("Failed to Allocate Trace Buffer Size. %d\n", tbuf_sz);
>                 SNIC_ERR("Trace Facility not enabled.\n");
> @@ -135,7 +135,6 @@ struct snic_trc_data *
>                 return ret;
>         }
>
> -       memset(tbuf, 0, tbuf_sz);
>         trc->buf = (struct snic_trc_data *) tbuf;
>         spin_lock_init(&trc->lock);
>
> --
> 1.7.12.4
>



-- 
With Best Regards,
Andy Shevchenko
