Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E1DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160F920836
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 07:20:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 160F920836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbeI0Ngt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 09:36:49 -0400
Received: from mail-vk1-f193.google.com ([209.85.221.193]:40557 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbeI0Ngt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 09:36:49 -0400
Received: by mail-vk1-f193.google.com with SMTP id q184-v6so356459vke.7;
        Thu, 27 Sep 2018 00:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fGbK97kn1V4/k5zlF4nqGbeKtif2TJRk193lLKKgwXQ=;
        b=fXqEGuEAuzfk8wDLCVKxwrNm+XQZrysru5Gb9rtPl8Jw8lVMTJqAAROZoFLAn+SQ6X
         K00boFQTTeRO+N4WsgZUJFapd66+my94IFBKcIQai+hkQstHsvf9nICqWBsSZnn32Hyb
         ktXYiJYeJ1e2BG6px+Wg5drcgZ8C7SeZSjAmqpEQ/pMwKpi2t53lJ1aOcwBXPIJoHgXZ
         X+TIN+rvRkgeTLca4g91PoH0dETw47tbtbHyCpuEjcVZa+KV00KiRbVkg75nPQ6fCNuT
         bWAqbRVvxbXqAufRKHZNs9kEmBw7QWkXVrgF8ctkxwQKIdTq4EI2Y9FhPbEICL/mkTzs
         f2iA==
X-Gm-Message-State: ABuFfohi7s1dYLI2lJGvtSD/kOVseBWFDLkNWNzxqLGaCKeNl05NNPcn
        +Vmo/uTAuQzo//RzREQD5BIFp5dIad99IQXmcoY=
X-Google-Smtp-Source: ACcGV62i50VzQiPjOctHlv0BhvypgGuWU28947nsG1fJ3Me8eUVQ7MRi879353HQkQ1UMsGTkBgn92ww3W33cS/VDfw=
X-Received: by 2002:a1f:92c4:: with SMTP id u187-v6mr2979694vkd.72.1538032798931;
 Thu, 27 Sep 2018 00:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <b1772d99d4e8b788448cde0fc5c7dccb1f63b507.1537443710.git.michal.simek@xilinx.com>
 <CAMuHMdW5zze-KJhK=diR-WKbhO_vsMV2b7WuLHmcT2FtRD4J7Q@mail.gmail.com> <d27b381e-f091-91dc-cffe-27789583f949@xilinx.com>
In-Reply-To: <d27b381e-f091-91dc-cffe-27789583f949@xilinx.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 27 Sep 2018 09:19:46 +0200
Message-ID: <CAMuHMdW4H6pjpijU2SX1Z=1Ld7CbBnTtFVwp3gac9toQc4iGpg@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 1/2] of: base: Introduce of_alias_get_alias_list()
 to check alias IDs
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greg KH <gregkh@linuxfoundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On Wed, Sep 26, 2018 at 1:01 PM Michal Simek <michal.simek@xilinx.com> wrote:
> On 24.9.2018 09:41, Geert Uytterhoeven wrote:
> > On Thu, Sep 20, 2018 at 1:42 PM Michal Simek <michal.simek@xilinx.com> wrote:
> >> The function travels the lookup table to record alias ids for the given
> >> device match structures and alias stem.
> >> This function will be used by serial drivers to check if requested alias
> >> is allocated or free to use.
> >>
> >> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > I know this has already been applied, it just drew my attention.
> >
> >> --- a/drivers/of/base.c
> >> +++ b/drivers/of/base.c
> >> @@ -16,6 +16,7 @@
> >>
> >>  #define pr_fmt(fmt)    "OF: " fmt
> >>
> >> +#include <linux/bitmap.h>
> >>  #include <linux/console.h>
> >>  #include <linux/ctype.h>
> >>  #include <linux/cpu.h>
> >> @@ -1943,6 +1944,57 @@ int of_alias_get_id(struct device_node *np, const char *stem)
> >>  EXPORT_SYMBOL_GPL(of_alias_get_id);
> >>
> >>  /**
> >> + * of_alias_get_alias_list - Get alias list for the given device driver
> >> + * @matches:   Array of OF device match structures to search in
> >> + * @stem:      Alias stem of the given device_node
> >> + * @bitmap:    Bitmap field pointer
> >> + * @nbits:     Maximum number of alias ID which can be recorded it bitmap
> >
> > IDs
> >
> >> + *
> >> + * The function travels the lookup table to record alias ids for the given
> >> + * device match structures and alias stem.
> >> + *
> >> + * Return:     0 or -ENOSYS when !CONFIG_OF
> >> + */
> >> +int of_alias_get_alias_list(const struct of_device_id *matches,
> >> +                            const char *stem, unsigned long *bitmap,
> >> +                            unsigned int nbits)
> >> +{
> >> +       struct alias_prop *app;
> >> +
> >> +       /* Zero bitmap field to make sure that all the time it is clean */
> >> +       bitmap_zero(bitmap, nbits);
> >> +
> >> +       mutex_lock(&of_mutex);
> >> +       pr_debug("%s: Looking for stem: %s\n", __func__, stem);
> >> +       list_for_each_entry(app, &aliases_lookup, link) {
> >> +               pr_debug("%s: stem: %s, id: %d\n",
> >> +                        __func__, app->stem, app->id);
> >> +
> >> +               if (strcmp(app->stem, stem) != 0) {
> >> +                       pr_debug("%s: stem comparison doesn't passed %s\n",
> >
> > didn't pass?
> >
> >> +                                __func__, app->stem);
> >> +                       continue;
> >> +               }
> >> +
> >> +               if (app->id >= nbits) {
> >> +                       pr_debug("%s: ID %d greater then bitmap field %d\n",
> >
> > than
> > %u for unsigned int
>
> I won't fix this now because this can be done together with one change
> described below.
>
> >
> >> +                               __func__, app->id, nbits);
> >> +                       continue;
> >
> > Shouldn't this return an error, if of_match_node() below would have matched?
>
> IIRC Above check is for "serial" name.
> This one is for getting XX number from alias "serialXX".
> And below is checking compatible string.
>
> You are calling this function from uartps with 32 lines limit and there
> is serial33 alias poiting to uartlite (for example) then you don't want
> to break this call for that.
>
> What can be done is that compatible string is checked first and if this
> passed then ids are check and error can be returned or bit sets.

That's what I meant: currently any serialN with N >= nbits is ignored, even
if the alias applies to the driver that called the function.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
