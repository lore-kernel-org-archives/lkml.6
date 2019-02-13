Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED466C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3B421902
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 16:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6UyDq3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392617AbfBMQSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 11:18:20 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45121 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730572AbfBMQST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 11:18:19 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so1328545pgc.12;
        Wed, 13 Feb 2019 08:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DGeUIfUMVdr08GITqwml0mXav78h0kyx3gOzu58IgWc=;
        b=P6UyDq3fH0qRJP1yezniTvtu8Xxw5o/6S0nKmS1ELxFb+CRSAiNZz3P/ebskF3Ixaq
         JBrZCO/tMa4Z/PfpddSjGjVqe3cVo7BqC+Nwvwyc9QiosoPcxLX6+Et9nzT/hH77+d1k
         Go+PhRfiZNEg+abWUYaQzr8JHCFp2AlgN6V1ztoQxnW8S1PBGHFhRnHNrC9Vt9yV3cPU
         4U+PdRZrDxctmGGuNcD1KOEqxPv/0RnC6KrO6MRr7uL7Bm5RfZng2FmoK5zHJs94TPP8
         seNUtRi//lRYTP39n0MvXiRa+0qSzOGVg8ed2RdjlSyxCkWwQqI9S7vriXls6HEMDqbW
         SX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DGeUIfUMVdr08GITqwml0mXav78h0kyx3gOzu58IgWc=;
        b=OGC8d+D+LIyapMff/JwN6+AGRmz2fQfE29kqEYbLgpeyJ8gwSPPOSfuCHPsqNP5gxl
         lmkY7z6Tv5lRNfT2559TXUmFXHIIrlZd1OHK6u6vRFq0ZHdTJwLlmfgGLfAE68UKvnsP
         5n2IdkA/y5HJWoGPOUzLoiQ1mig3YIG0Eepg4ZYtrNZ6XXIHmgdTN8WGx1s8CLW44aXE
         HGECpk5WCM2Pje6NsQ3GAAQ14IOtSno9jQjcx1uoe/tAVU01hNSvZRsefizsi9+wcO1e
         JnIBZl7BCy6jNLf0r/28emNFEd/fAv9nQa+TUIo0wjP4CRf/c5mMEzCau4XyP2zbtAwO
         YQYA==
X-Gm-Message-State: AHQUAubuMX2axNlCupM4wX6xMjq29hmM5bkTWV1j3XISLdMnTAYS0ESQ
        MyagRUCJ+vH4DZK3dg3L7XvV1L+VXbw05l/QuxDdrgMi
X-Google-Smtp-Source: AHgI3IbFM2+cqLqhcPXbCc6s0W9UYv/XHpxMDE1jRU0OLpAQe2VpaWSgayWBx2I0x+VFA6UyfuXoasFQBSwulZ+Yigc=
X-Received: by 2002:a63:730c:: with SMTP id o12mr1175996pgc.270.1550074699045;
 Wed, 13 Feb 2019 08:18:19 -0800 (PST)
MIME-Version: 1.0
References: <5c40acf3.1c69fb81.5b02f.880c@mx.google.com> <CAFqt6zaHuWfVWS1Aa4MQm-qE9Wjj68Bq5ioEWbk+hrg32VNRCw@mail.gmail.com>
 <CAJr6mf1j+nyYDanjX7pCvSjVjdqy9Y0WG5sJHtR42_E6U9_LbA@mail.gmail.com>
In-Reply-To: <CAJr6mf1j+nyYDanjX7pCvSjVjdqy9Y0WG5sJHtR42_E6U9_LbA@mail.gmail.com>
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Date:   Wed, 13 Feb 2019 21:48:07 +0530
Message-ID: <CAJr6mf3fqC2EjxfeM5iU_uAibAj4008UfYkXVmLPoSonPD4-2A@mail.gmail.com>
Subject: Re: [PATCH] sh: Remove duplicate header
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 8:04 AM Sabyasachi Gupta
<sabyasachi.linux@gmail.com> wrote:
>
> On Thu, Jan 17, 2019 at 11:11 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
> >
> > On Thu, Jan 17, 2019 at 9:57 PM Sabyasachi Gupta
> > <sabyasachi.linux@gmail.com> wrote:
> > >
> > > Remove linux/irq.h which is included more than once.
> > >
> > > Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
> >
> > Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
> >
> If no further comment, can we get this patch in queue for 5.1 ?

If no further comment, can we get this patch in queue for 5.1 ?

> > > ---
> > >  arch/sh/boards/mach-dreamcast/irq.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/arch/sh/boards/mach-dreamcast/irq.c b/arch/sh/boards/mach-dreamcast/irq.c
> > > index 2789647..69fa91c 100644
> > > --- a/arch/sh/boards/mach-dreamcast/irq.c
> > > +++ b/arch/sh/boards/mach-dreamcast/irq.c
> > > @@ -10,7 +10,6 @@
> > >   */
> > >  #include <linux/irq.h>
> > >  #include <linux/io.h>
> > > -#include <linux/irq.h>
> > >  #include <linux/export.h>
> > >  #include <linux/err.h>
> > >  #include <mach/sysasic.h>
> > > --
> > > 2.7.4
> > >
