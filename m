Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 082E0C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE28420684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 12:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE28420684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeJBTlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 15:41:51 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33096 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727739AbeJBTlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 15:41:51 -0400
Received: by mail-qk1-f195.google.com with SMTP id 84-v6so1030527qkf.0;
        Tue, 02 Oct 2018 05:58:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BfHPq4uwznvhsxeo9Nr8Uug8WVsmwzyPotert9gMGC8=;
        b=dRFFSLAhXDGZ7w9UxwNd+aZ1bt04nsLGjI14V3J3iuwZLB2MoI7Jti8OxFuqWbdVeX
         rpy1OxIIYEwS5LPhrjQALM8bVM+mFsS7tFMYsgybiipw9SThVfm4P3XSZ9w4l0H9hICj
         giqqk26JQbnwbHgxQSCIcIlsIwzuRptc4WimBs2Qsvw3fK336Udw9LQesG48lWwIvg/h
         IqscXm8Zn3QiheI5zcw+jaJtl0GfUTwFdnvYpStXcUSCJx/Db7Atar3mryPx0qCwb/hw
         rMCS8kKswgiENcud08U35o+EFqe5qJ5f4MWoLaqyaiVX6GTR2GNZCW/B3fnqBcNUb6Ka
         vjTw==
X-Gm-Message-State: ABuFfoih7Yys5AYUUcJE4gjkxwUVUy51LXN1vXzp4gdkfQ9OnHx6BXPj
        cvlcBHFMCg9+OVq8dKdAGmC1XAukzV/EyMAIuIA=
X-Google-Smtp-Source: ACcGV61zjfFypuvwOJGESFzv3dAX7k88uvbTMzydAojR/mLULqVTxMHMMVOB4CuiGVsNneQOyahs1AHd/Eq1SNtdZPc=
X-Received: by 2002:a37:e21a:: with SMTP id g26-v6mr1488386qki.330.1538485117203;
 Tue, 02 Oct 2018 05:58:37 -0700 (PDT)
MIME-Version: 1.0
References: <20180915063645.31295-1-natechancellor@gmail.com>
In-Reply-To: <20180915063645.31295-1-natechancellor@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 2 Oct 2018 14:58:21 +0200
Message-ID: <CAK8P3a3PaWgieA0_HBJJ-FVeBO+iAdN8_kv5YUbpKURJ3gsoaQ@mail.gmail.com>
Subject: Re: [PATCH] scsi: mptfusion: Remove unnecessary parentheses and
 simplify null checks
To:     natechancellor@gmail.com
Cc:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com,
        linux-scsi <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 15, 2018 at 8:38 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:

> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/message/fusion/mptbase.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
> index dc1e43a02599..ba551d8dfba4 100644
> --- a/drivers/message/fusion/mptbase.c
> +++ b/drivers/message/fusion/mptbase.c
> @@ -335,11 +335,11 @@ static int mpt_remove_dead_ioc_func(void *arg)
>         MPT_ADAPTER *ioc = (MPT_ADAPTER *)arg;
>         struct pci_dev *pdev;
>
> -       if ((ioc == NULL))
> +       if (!ioc)
>                 return -1;
>
>         pdev = ioc->pcidev;
> -       if ((pdev == NULL))
> +       if (!pdev)
>                 return -1;
>
>         pci_stop_and_remove_bus_device_locked(pdev);
> --


The exact same code also exists in drivers/scsi/mpt3sas/. I had a similar
patch for both drivers, but saw that yours now got merged for fusion.

If you don't mind, could you fix mpt3sas_base.c the same way?

     Arnd
