Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974D3C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18FE4204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uHL3BqSx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FE4204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeJBSm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 14:42:27 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46719 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727557AbeJBSm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 14:42:26 -0400
Received: by mail-ot1-f66.google.com with SMTP id o21so1277693otb.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 04:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HanyxJjqmJFAhbQAJCmaMd1FuxthfmtTJx5SYhZGOIU=;
        b=uHL3BqSx5n8RUgV+ZJf7c+KQ8/DgHJgiwS+fMypwwFCVRW8qdav8WcHQyCkRQHL5BR
         kKxcchnVp0w2K5fFI2Vp7dyeKTYkL5U/kbYj3Be1ejrXXn6+JfSM3fZox8ui9EUhi6Jt
         jBwVMX11DNoRLDckqlsmKLWUL6t8gadsgY6G8j2eOMc9w8Z34OMJoj5mCU7MLfUYC1A0
         x3fb+2tYaTp/UVLoh8byTdx83A+8KIdFGSur8vy/2w7TzYVLWoVqUcPNOqjxt1ZBckzl
         FPrMpxeOhX10GcjiMPm2tvtFvRN23gzhAlwXRkKBHZd0M++OoxEDMBBP2npuC77ksTGP
         1bOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HanyxJjqmJFAhbQAJCmaMd1FuxthfmtTJx5SYhZGOIU=;
        b=Gx6Ci5OgBpvc0rFQVhQbDZJGhzK3PbDgxXERvj3sMi8U8XQGyng7EDCx6CiJWbG6h0
         lOzOsaIgk6Y7DFHbYaYw3qTgUUWjAMknAgyisY3ESRfrgwch/2VwPALY7ygh0gh/tvBa
         oAGljbLBhwm0L7T/qqghuhKwHwoYLucDNuvP5tCbx8/u9jH/oLT5kgCLnXuwnJiPB3xJ
         iQJyGnqRm4sf8kqFn4qD31h6tD5z4xd1W/XqoZIAWEKaun4i4GW0XjPDoGK+jtY+rk+Z
         V67etW6v7zW0Ofr/1IBmJWKnz9uXWRRRkIQgi84SjR7WJX1Mz9d6remckusEJuJOHDcD
         l7Xw==
X-Gm-Message-State: ABuFfoiOHfVFcsczG8cN2nwXqy7FaWACkOyGv0uuObuQeSisiUfU+vkb
        KTeEsyYtFBDf+rho4MMJZCq6DiOkTwmeJc3xO3a+HA==
X-Google-Smtp-Source: ACcGV60FQI38Rg/JDEneSQCCzE+K+/V5ch+bHbeD+HI7s5GlYyFKkfr8mNKUoGoPnrYwIIe6p3iFigUwBTHsrJMsLrw=
X-Received: by 2002:a9d:1707:: with SMTP id i7mr852993ota.236.1538481569056;
 Tue, 02 Oct 2018 04:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20181002110246.3175-1-brgl@bgdev.pl> <13b4b871-8f81-d007-ef37-eb697f984f01@linaro.org>
In-Reply-To: <13b4b871-8f81-d007-ef37-eb697f984f01@linaro.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 2 Oct 2018 13:59:18 +0200
Message-ID: <CAMpxmJUf8NdCHXVMxZVfO20ddKFdFSxzo6xkcL=6Ve0TC_GY-A@mail.gmail.com>
Subject: Re: [PATCH] nvmem: only build nvmem_find_cell_by_index() if OF is enabled
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>, Arnd Bergmann <arnd@arndb.de>,
        GregKH <greg@kroah.com>, sfr@canb.auug.org.au,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wt., 2 pa=C5=BA 2018 o 13:49 Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> napisa=C5=82(a):
>
>
>
> On 02/10/18 12:02, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > The following warning is produced when building nvmem core if
> > CONFIG_OF is disabled:
> >
> > drivers/nvmem/core.c:496:1: warning: 'nvmem_find_cell_by_index' defined=
 but not used [-Wunused-function]
> >   nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
> >   ^~~~~~~~~~~~~~~~~~~~~~~~
> >
> > This is caused by the fact that the only caller of this routine is
> > under an ifdef depending on this option. Fix it by adding a relevant
> > ifdef to the function in question as well.
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >   drivers/nvmem/core.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
> > index cc815bb2eebd..65f61cd0a687 100644
> > --- a/drivers/nvmem/core.c
> > +++ b/drivers/nvmem/core.c
> > @@ -492,6 +492,7 @@ static int nvmem_add_cells_from_table(struct nvmem_=
device *nvmem)
> >       return rval;
> >   }
> >
> > +#if IS_ENABLED(CONFIG_OF)
>
> You should probably attribute the function with "__maybe_unused"
> Instead of adding this condition.
>

Sounds better indeed. I'll resend tomorrow to avoid spamming.

Bart

> --srini
>
>
> >   static struct nvmem_cell *
> >   nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
> >   {
> > @@ -507,6 +508,7 @@ nvmem_find_cell_by_index(struct nvmem_device *nvmem=
, int index)
> >
> >       return cell;
> >   }
> > +#endif
> >
> >   static struct nvmem_cell *
> >   nvmem_find_cell_by_name(struct nvmem_device *nvmem, const char *cell_=
id)
> >
