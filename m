Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C81C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800BB214F1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 16:50:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="srJS9Ujw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800BB214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731845AbeHBSmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 14:42:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35461 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbeHBSmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 14:42:52 -0400
Received: by mail-wr1-f67.google.com with SMTP id a3-v6so2828033wrt.2;
        Thu, 02 Aug 2018 09:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9t/K0/W7nVK+HXimozMBZb3agmVO7lUKTOd8PoKBYZw=;
        b=srJS9Ujw1raIBbpzLxb6XTFOnEvWyjY7B5bXFw3bN62p5z87mr1xZDvzJd269COT6+
         rDHvmtdJjmcRJxD3/oaxE86XFhCkEJ7a6Y1qJPh7YEO1VNcSlUzXV9sKf8LdQ2QLnGS3
         2OUz4tr4Lvrmv/PEyk5NBIp3E18Wvy7lJqYa7BBhaP2s7nFK5fC0hr1ft1Tsku0y8XK/
         qFLrNLZn7OWUXQn+lDd3+zWTxN9r4IYYf1kpXZehJYarF2KzhVfpkbDPlHq1sKaRPN/+
         kpUz8xq+g/6hp/G9DaapZ8YV/HC/ka91y86oL/0lNy2UWwz7+02qn/Xx5US6G5hfCv8H
         Z6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9t/K0/W7nVK+HXimozMBZb3agmVO7lUKTOd8PoKBYZw=;
        b=JJcT7kNuUKgZIKL7YbYIMHblRqFfQQIpO/tBL4B5t+LSpqazP1+bWYrWXLbWhUIzfx
         eDGqK7IOjAQyH+3zsqZbQO7+N2Rql6GngHDUohjG3eBuU4OTlGDdW90+NQHG6Khq3+RI
         3AnWl1K8C/46XisYCZq02kAy9MDTLZutEAdOBIKqetWcldWhDWZfmt3Eqd6Rxt6mNCGi
         odFXK0MzlvWT0WEQPkcTgB4wACEdpguV5XKLsLmjUjRhP6MoUZ7y7ve10szlOJfwZ+NE
         9os+wVMJJY2O8njxlOa3H4CTkNg9141UXGTKymvJLX1lkgnbMLJVmgEffeqtspkPQz5J
         iYHA==
X-Gm-Message-State: AOUpUlFdBheI8LEp+7Ge/Zv0g2M4SfjUCF/LSOGFRFxzZm9grh5bZQK/
        k/Tx4onfHWv9A2M72DVoQawqqH4f0KlAxzkMGgUj7wM1
X-Google-Smtp-Source: AAOMgpcbgHQkz+omgT2Hm/aFXlPihfg4WddRHVGeSmPfTzp5xrdHW7nJIyu0gcBWbOEr5KnxnCRYfunfzqTT5lK6W7g=
X-Received: by 2002:a5d:5201:: with SMTP id j1-v6mr178996wrv.198.1533228654239;
 Thu, 02 Aug 2018 09:50:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:9c8:0:0:0:0:0 with HTTP; Thu, 2 Aug 2018 09:50:53 -0700 (PDT)
In-Reply-To: <9329f50c734eec5fa994ea652890f017a88625c2.camel@wdc.com>
References: <20180801175852.36549130@canb.auug.org.au> <20180801224813.GA13074@roeck-us.net>
 <1533163965.3158.1.camel@HansenPartnership.com> <20180801234727.GA3762@roeck-us.net>
 <CACVXFVMrzLRP5Q=cwZGnqeUeyODL3Pq9jMkT7czZouK9510fUA@mail.gmail.com>
 <1533168205.3158.12.camel@HansenPartnership.com> <171b2cdc-2e74-2b3c-e5f5-c656a196601a@roeck-us.net>
 <CACVXFVMT7UwWHPQ6K-eNWZJOoZ77==Ki7zmX5UtDz4ZQFFB0Jw@mail.gmail.com>
 <a10a509a-7e5c-1706-52ee-79849cad4224@roeck-us.net> <20180802162654.GA8928@ming.t460p>
 <9329f50c734eec5fa994ea652890f017a88625c2.camel@wdc.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Fri, 3 Aug 2018 00:50:53 +0800
Message-ID: <CACVXFVNi_R3Xecwm7weqEv5Lqy+F-Nxmbq4-i3089Ge2qHFD_g@mail.gmail.com>
Subject: Re: linux-next: Tree for Aug 1
To:     Bart Van Assche <Bart.VanAssche@wdc.com>
Cc:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "tj@kernel.org" <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 12:40 AM, Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
> On Fri, 2018-08-03 at 00:27 +0800, Ming Lei wrote:
>> This issue can be fixed by reverting d250bf4e776ff09d5 ("blk-mq: only iterate over
>> inflight requests in blk_mq_tagset_busy_iter").
>>
>> This patch looks wrong, because 'blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT'
>> isn't completely same with 'blk_mq_request_started(req)'.
>
> Please test the following change instead of reverting the commit mentioned
> above:
>
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 09b2ee6694fb..25a0583d8b4c 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -271,7 +271,7 @@ static bool bt_tags_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>          * test and set the bit before assining ->rqs[].
>          */
>         rq = tags->rqs[bitnr];
> -       if (rq && blk_mq_rq_state(rq) == MQ_RQ_IN_FLIGHT)
> +       if (rq && blk_mq_rq_state(rq) != MQ_RQ_IDLE)
>                 iter_data->fn(rq, iter_data->data, reserved);
>
>         return true;
>

I just sent out a similar patch on list, but use blk_mq_request_started()
instead.

https://marc.info/?l=linux-scsi&m=153322823307754&w=2

Thanks,
Ming Lei
