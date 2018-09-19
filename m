Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9766C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87884214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 09:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87884214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbeISPA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 11:00:56 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:33408 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbeISPA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 11:00:56 -0400
Received: by mail-vs1-f65.google.com with SMTP id y12-v6so1570495vsm.0;
        Wed, 19 Sep 2018 02:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OwtBkSjC3sjstRDgposZDV9ZXl8oqc/6YlA3pVSWJMw=;
        b=aZug+ryExPkgnL2Rolw9mzRjQp7ooNp+ONJ8HeDL59PboP32i8OzLwt3JGmWCSHaTK
         ZNBTJH1tKeSgszISgFSyKjPRkHPwUwGtj85iZgKuyIvyYCipTtS+/dmfxFjErXYVLYxK
         tTRnCOu+jZJ8J/3cKTFG3vdC30g2bnGjacy92+DDzaTIWfaKhJnL0sCBDtfOqDx6Pfw7
         rpG7vsPyDnBWwWPSvfjYlO/F9V3XfNZjM6/pby9Vygv5uhAx7H8GUSCqEmMF/EpvTmeu
         akl0Tf2SJx+CDU8IfvEuF5/FwyEEDMol/3ZirzDxyWv6WtBE6XeXr7lyIt1khfL5w4S4
         +ZTA==
X-Gm-Message-State: APzg51CxvPC3dUNdd+p9OULnSbcBkcWk385H5fL9M04LzzKob/J85J4J
        At/fUvv7eGzycMm+26FHv5bobscP+BR/7hOszvo=
X-Google-Smtp-Source: ANB0VdbRDOe1rElLPucnilcC2TSQgo8GxWU+LlOl31U6J1a0ZHnyrKtiYR+HV0Z457JeOsTsmtgAoGGottjTVwArlak=
X-Received: by 2002:a67:3481:: with SMTP id m1-v6mr9482563vsi.52.1537349034768;
 Wed, 19 Sep 2018 02:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180917163609.30457-1-phil.edworthy@renesas.com>
 <20180917163609.30457-4-phil.edworthy@renesas.com> <20180919091524.rgbk4m6ht34idkpd@verge.net.au>
 <TY1PR01MB17690D4C023EB9B4A5164A2AF51C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB17690D4C023EB9B4A5164A2AF51C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 19 Sep 2018 11:23:42 +0200
Message-ID: <CAMuHMdXhDcfXe7ohuO2s4MKHFPc-Z4TRjaTJv-MG0MHga=2viQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] ARM: dts: r9a06g032: Add pinctrl node
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Simon Horman <horms@verge.net.au>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On Wed, Sep 19, 2018 at 11:18 AM Phil Edworthy
<phil.edworthy@renesas.com> wrote:
> On 19 September 2018 10:15 Simon Horman wrote:
> > On Mon, Sep 17, 2018 at 05:36:09PM +0100, Phil Edworthy wrote:
> > > This provides a pinctrl driver for the Renesas R9A06G032 SoC
> > >
> > > Based on a patch originally written by Michel Pollet at Renesas.
> > >
> > > Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
> >
> > Thanks Phil, I will defer this patch pending acceptance of the bindings.
> > Please continue to repost this patch with updates to the bindings or
> > otherwise ping me once they have been accepted.
> Thanks, however I will send a new version of this patch to remove the
> clock-names prop as it is not needed.

I haven't reviewed the bindings patch yet, but it's a good idea to have
clock-names, even for a single clock.
It makes life easier if the same module is reused or enhanced in a later SoC,
with more clock inputs.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
