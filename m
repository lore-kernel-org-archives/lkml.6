Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810F1C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3250B214C3
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 02:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VuqOe47X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3250B214C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbeJQK3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 06:29:54 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37584 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbeJQK3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 06:29:54 -0400
Received: by mail-lf1-f66.google.com with SMTP id a82-v6so18583076lfa.4;
        Tue, 16 Oct 2018 19:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DpVyLpaYpKxn3MkItBlXIeWEUn9Iur/iIXy1OBbwJuI=;
        b=VuqOe47XJ8hw+8sS00TOj9l0/nbkwzw/TpLjXXFl03KEUNJvHkVxUm6juWhW7mownu
         VXU6Jmo2bfd7sPSoJ6iHmuJxK2tg/XuoR1QKxKFMBuoq4Bhr4JFqTgVrBMere8km3XHM
         Gz/1pTAPYujAh06z9Zsw175xDZyWgYgbP90f0ta8bGUmIux/ewQCaJ0WzCz2Z1hQW3E7
         j54aZtuuYizuNoPcdC4CAO0by3teYgxNsvNY1b0RN4hFVGHswEPZlOrbhKzvNQfaZi7U
         aYWMtq4PE+h96RoT6OoTFd6uVeSSWrSMprytJ+5jbbSS3VmbVb/sPNFulVUdrlrT+eIL
         3ahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DpVyLpaYpKxn3MkItBlXIeWEUn9Iur/iIXy1OBbwJuI=;
        b=kuIFSeFJc+fOo/mdm8R5BFvyRaKgbusmvGRnRU51lSe82HOhP4KF8lkPU4DGVIt2iM
         QJZC9VUb8hVmeOzFCmWxWMIj3BElU7t0XZl82hrtzLtvZQzKAe2n2HiKa1IQyFVkbC7e
         3g+qK6ph4z2COxSb8w4NbkFWwa5cK1QgyMXfNkvF4dj6WTTubE2PyFE6+k6QtwpnW6Ba
         6yKjoI+0JHXq9a1CxeQ9+ZKclLU19+80SCGh7CMOax6CraDi69KZOPVSxCcOcAHCoelz
         Xj9ldR5BC5imRdhvs4jxObjXkAWrNLIdsrhiPJMX7KPyxiYdl9zprAaY7z9ug1exESwi
         2vSQ==
X-Gm-Message-State: ABuFfohFC8J8aIrxcEkcH3MtJCV5iEW2ydE5TcbaaXpdbL1uUIMRUxha
        95qK5jx8YK+5PhEyf6EimXapFb2CXfbusPuPEn4=
X-Google-Smtp-Source: ACcGV62p9F7PDbhxIirgsie65RcZcJnsYfAfS0wqZ7iQB/vAzgGjQHIJZpeI0vJPTy4xayKlv93T/+BplMWcNNi9HeM=
X-Received: by 2002:a19:d212:: with SMTP id j18-v6mr13918193lfg.44.1539743787960;
 Tue, 16 Oct 2018 19:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <1539677982-13762-1-git-send-email-zhang.chunyan@linaro.org> <88801a36-44cf-237f-a762-985bb215c104@intel.com>
In-Reply-To: <88801a36-44cf-237f-a762-985bb215c104@intel.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 17 Oct 2018 10:35:51 +0800
Message-ID: <CAAfSe-sX3yx4K5WP_yT3TP7aiL-EOJinvkgL63TdUKZh3Emv1g@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci: use goto rather than return directly
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Chunyan Zhang <zhang.chunyan@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linus.walleij@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Oct 2018 at 16:30, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 16/10/18 11:19 AM, Chunyan Zhang wrote:
> > The driver should clean resources requested in the function before
> > unnormal return.
> >
> > CC: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
> > Fixes: bd9b902798ab ("mmc: sdhci: Implement an SDHCI-specific bounce buffer")
> > ---
> >  drivers/mmc/host/sdhci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> > index 1b3fbd9..f6b57e1 100644
> > --- a/drivers/mmc/host/sdhci.c
> > +++ b/drivers/mmc/host/sdhci.c
> > @@ -3991,7 +3991,7 @@ int sdhci_setup_host(struct sdhci_host *host)
> >               /* This may alter mmc->*_blk_* parameters */
> >               ret = sdhci_allocate_bounce_buffer(host);
>
> Do we need the error return?  It seems to be zero always.

Or we don't need to check 'ret' for now, right?

>
> >               if (ret)
> > -                     return ret;
> > +                     goto unreg;
> >       }
> >
> >       return 0;
> >
>
