Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AC1C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 02:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF13620C0A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 02:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpWBav7n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF13620C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbeHTFiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 01:38:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33180 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbeHTFiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 01:38:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id v90-v6so8489355wrc.0;
        Sun, 19 Aug 2018 19:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZGqanjG3aTyMTIfD6X7vcnRSVBqfnILXJxrQHpr+m6A=;
        b=SpWBav7noyK+eQIASNwEKY6Yxe0fAOqdbOvB0QfLwDqzYDFR2cuQZ3OIkyGdOKrAuN
         EFwTAr54bEO5a9kmcqhXBZv0ft5+QgTlJdS/2QMVbGzbPN63ptySwwvmzsvXWgQR+CEb
         HmxDk4BTfgB6Z/YvD/TZyJ0Vk/cu1UQb6GOMJABxKcDw1DWHeqwSQn+JaS9IETkcj6mx
         ndAq+HhR0I7ZBtcwqLF/ppY93zZ0N6696eYa/0BT8e5ZAdyFmtBuSjL2crpkAPiPmEh5
         N9/867lfqN9Q6I1HywTfnIWDG8+RdlHIUqKDLwF9Nf7cP3DJ3+AjLfugR4JxG7+X6V0i
         n66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZGqanjG3aTyMTIfD6X7vcnRSVBqfnILXJxrQHpr+m6A=;
        b=OI2eOZvBxHBt5wAVEH97WJlTVnpn7GxveJZqCukt4rKihxILBszQaDpoUlG1XeRcPj
         PP3wduDbcC+5QIgM9eTSc4IiZSLXV8+lAJGeE/8N+tk4EiduFd+wAAwWpNuzu7x3BoJN
         /4vD10CO3eaA8/xS30Js7XvPvIvZLDVt+jAM5kqwGMROFfxzmtuYQx9OSmWbBN43z64l
         inIhjjNKS2hk8MO1zN/JZ95AWHZnf3yY5t8INOmBGukndu3Eft75tB472w7gj6782Y89
         FU1Xq24R+Ga7kwBOJ/fcDNlyHmPkTN8tJxameqx+lPRhb2l3ZYhgQ3ngC9LZ7uGHj7QC
         mXIg==
X-Gm-Message-State: AOUpUlGoP1hjIsTXyVVK7WfEUaxWHpKszVGg4NnNZtEoLG/eKyYyR4d1
        UaIFbn2mmMGTHkNezlQlHsbZVnGe40OFOh5VrLs=
X-Google-Smtp-Source: AA+uWPyN9pMFR50yPxL/ZX4rj5uk32IuzRcTCdXBjsegNyiz0SjFz/lhJpZ9YC/Q0uAqmIXNHfnPJbaBZolmaUHOCzE=
X-Received: by 2002:adf:97d3:: with SMTP id t19-v6mr9877700wrb.283.1534731867574;
 Sun, 19 Aug 2018 19:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <1534478043-7170-1-git-send-email-jianchao.w.wang@oracle.com>
 <1534478043-7170-2-git-send-email-jianchao.w.wang@oracle.com>
 <CACVXFVPZF7ohzUib4Nr1qdHLwjpEWP4+be6h6GmZh1y9-qsVqg@mail.gmail.com> <96657784-dd95-6ea9-3ffd-25737c534075@oracle.com>
In-Reply-To: <96657784-dd95-6ea9-3ffd-25737c534075@oracle.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 20 Aug 2018 10:24:14 +0800
Message-ID: <CACVXFVMqjiSmzL2JeLUV2Q4bXqy2WRNHahg-fusFYjHeCX3gng@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] blk-mq: init hctx sched after update ctx and hctx mapping
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Keith Busch <keith.busch@linux.intel.com>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 9:29 AM jianchao.wang
<jianchao.w.wang@oracle.com> wrote:
>
> Hi Ming
>
> On 08/17/2018 05:33 PM, Ming Lei wrote:
> >> +               /*
> >> +                * elevator_release will put it.
> >> +                */
> >> +               __module_get(q->elv_type->elevator_owner);
> > I understand what elevator_release() frees is the 'ref-counter' got in
> > elevator_get(), but who will be the counter-pair of the above  __module_get()?
>
>
> Sorry for my bad description.
>
> The code path is:
>
> elevator_release
>   -> elevator_put(e->type)
>     -> module_put(e->elevator_owner)
>
> In normal elevator switch path, elevator_get will hold a reference counter of the
> elevator_owner.
> In this patch set, the elevator_type is saved directly. To prevent the io scheduler module
> is removed, we need to hold a reference of the module.

Yeah, I agree that the module reference need to be held, but it need to be
released too.

My concern is that this introduced getting module reference in your patch
isn't released. The module reference is a counter too, so the get and
put operation should be matched.


thanks,
Ming Lei
