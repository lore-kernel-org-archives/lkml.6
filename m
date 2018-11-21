Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C3EC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EFB9214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 16:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQYR6M5s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EFB9214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbeKVDQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 22:16:36 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40577 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbeKVDQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 22:16:36 -0500
Received: by mail-qk1-f194.google.com with SMTP id y16so5229162qki.7;
        Wed, 21 Nov 2018 08:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3T2x6Jx/QJBN8x8W8HE3FDdSrCGpngjVcC9195XD5ZU=;
        b=VQYR6M5sU3Hx15eR7LtcpPra9dT4YoMTT5sPxaxRHp32Ux/lGQhGR2yDj/lawMj/mF
         o8FNAzV6lGIed/3HTwvQuc8AeIUBS+4Sm4HLpiheh1T0TuhJ4ExHHLzNxlMs8aTWl7xJ
         pgrrez/MI+fNi8brpSydTH9sbyDftxF0cVPxI7+SD5MkPCY6eOhVGChE4GcmgMlpcUiY
         r26iCV8pgEyGL6dpZuWD2T2qra5KpvdCMbBYxaO3nEzJYJIzVQ/bElkRum2Vm8UsnvDb
         T40y4xPSHrpQTBgYVTliOeQ0mjvmJCyz9Y7oj6BgTpDTBjpmJjadJ1ArNK1G2fR9BT2T
         YdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3T2x6Jx/QJBN8x8W8HE3FDdSrCGpngjVcC9195XD5ZU=;
        b=OPNPjgZP4qg9bMpgJAVc1rtebYhZCSHAPMdgxnLfQWiWU35IUQzGLVDcG3TjxZhGq7
         +ktiFFMBtPniL/4L5581we2nV1w+4lkqKPNqVyRtEB7gjO4NClnN7RxKyXNrpHKRRjSp
         hRRuuGiFaz0xHfk+LoaGukVOGpQB3ushdgVKqo8crfRAExpzrb1sKXHTW8G7TjPULvpZ
         698BDVcuDBcFdVnW3fnRNsQiOkCwnMdTN7OK+ec5+X/lRkphL2PX94pcR+u6w44u+noP
         Pek0B7CZmgxvzPyVkh8N0aB0IjtefSon8MSwK1npaUAt9WKr6+29twJLzIrPT9lEgMTo
         rjjg==
X-Gm-Message-State: AA+aEWZ8TOmqXZcIMfWUELz8NsnhpVyTaJ07KKHrEobIB085Um76U80y
        yCmSeCVZKmXLZbpS8eVQFgPjprG8jR7LaOUlQnE=
X-Google-Smtp-Source: AFSGD/WMQ8sw4culcf/sZBLAjWBKdPiscc/A+GN4mBa4K2KV0In40ut6o6zQIYgaFJCIAoCYwMlAJyUtTtfdiewWI4w=
X-Received: by 2002:a37:4792:: with SMTP id u140mr6486339qka.301.1542818484436;
 Wed, 21 Nov 2018 08:41:24 -0800 (PST)
MIME-Version: 1.0
References: <20181030202713.26203-1-semen.protsenko@linaro.org> <CAKaJLVu0h5woVtN5=Mh38ajACBZZQ3JHfRhkjNrwMwYXHEG-NQ@mail.gmail.com>
In-Reply-To: <CAKaJLVu0h5woVtN5=Mh38ajACBZZQ3JHfRhkjNrwMwYXHEG-NQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 21 Nov 2018 18:41:13 +0200
Message-ID: <CAHp75Vd-ydncUWQtc8ziLpCMJRFCvjV=ueKB0wRgn7W-pnV09Q@mail.gmail.com>
Subject: Re: [PATCH v2] codafs: Fix build using bare-metal toolchain
To:     Sam Protsenko <semen.protsenko@linaro.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kernel-janitors@vger.kernel.org, jaharkes@cs.cmu.edu,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        codalist@coda.cs.cmu.edu, coda@cs.cmu.edu,
        Praneeth Bajjuri <praneeth@ti.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 6:31 PM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> On Tue, Oct 30, 2018 at 10:27 PM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
> >
> > The kernel is self-contained project and can be built with bare-metal
> > toolchain. But bare-metal toolchain doesn't define __linux__. Because of
> > this u_quad_t type is not defined when using bare-metal toolchain and
> > codafs build fails. This patch fixes it by defining u_quad_t type
> > unconditionally.
> >
> > Cc: Jan Harkes <jaharkes@cs.cmu.edu>
> > Cc: Christoph Hellwig <hch@infradead.org>
> > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>

I'm not sure how you managed to miss people in this list (perhaps by
default you have suppress all Cc in your Git configuration), but I
guess we may gently ask Christoph to apply this in case Jan will not
appear.

> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  include/linux/coda.h | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/include/linux/coda.h b/include/linux/coda.h
> > index d30209b9cef8..0ca0c83fdb1c 100644
> > --- a/include/linux/coda.h
> > +++ b/include/linux/coda.h
> > @@ -58,8 +58,7 @@ Mellon the rights to redistribute these changes without encumbrance.
> >  #ifndef _CODA_HEADER_
> >  #define _CODA_HEADER_
> >
> > -#if defined(__linux__)
> >  typedef unsigned long long u_quad_t;
> > -#endif
> > +
> >  #include <uapi/linux/coda.h>
> >  #endif
> > --
> > 2.19.1
> >
>
> + Jan Harkes, + Ruslan Bilovol
>
> Hi Jan,
>
> Can you please apply this? Nobody seems to be interested in taking
> this patch, so I'm not sure how to proceed further. Please advice.
>
> Thanks!



-- 
With Best Regards,
Andy Shevchenko
