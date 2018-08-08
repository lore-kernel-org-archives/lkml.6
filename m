Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F62AC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD47B20C03
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD47B20C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbeHHKwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:52:20 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43798 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbeHHKwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:52:19 -0400
Received: by mail-lf1-f66.google.com with SMTP id f135-v6so970119lfg.10;
        Wed, 08 Aug 2018 01:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9yFLRQm0ECjpsTmiXketk+4+I/6V3VcrouMdwQNQiks=;
        b=jrc+9ewFZh9Tar0/opLMk95DUkXP9HTxunrjmAjtj2qDJqcN5ZWSlvUP9Fya3friRd
         4vNEIe5Ige3R783iOxju5tew6CwZFc9RKaklyb5Iavi75JtuBmO8d5vjOA3NR6liyWOQ
         1urt0JtcXHBIa44WT4c0tNX3CizgFZFaT6UoUlkd02GtH/KrF1FToUSBKWd9Hmv4+92q
         9bWFRsdHK2ZA3lux0yf4T4PxFXVSzbIseLCF0CmI2UTCuW6tIGNLP7lbby+9R7+ncLIf
         h5kL+cUzTgsil91FlAsoDOw9JpQpqUVhxhApRW+wlY9KPmSXzWF3zmwF7VRahUQaDLXf
         XOkQ==
X-Gm-Message-State: AOUpUlGX17HD2h8PVAsulD9FpE8GNvRY/kF/ueop6q5jTsoLTBVYkqfF
        FedBtdNM3yhz4nEJVpSiJ5nf8+U3hebS6ksq0Ps=
X-Google-Smtp-Source: AA+uWPyv4yDpcw66TktN5U1c6/KnTVTcQOij/9HXFiJ5+ZipxBiizMO1mN0Yd88fabJgHZe4zA/jc/+bflbt0jDLRhA=
X-Received: by 2002:a19:ea5c:: with SMTP id i89-v6mr1263747lfh.19.1533717218794;
 Wed, 08 Aug 2018 01:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20180803030237.3366-1-songjun.wu@linux.intel.com>
 <20180803030237.3366-9-songjun.wu@linux.intel.com> <CAMuHMdXkGchPN337dXbBVOFsb1o-Tkh8S_z=uCm3Z0sDjPVMKA@mail.gmail.com>
 <734bddbc-a5aa-d50d-0e7b-d8adc4d1afb2@linux.intel.com>
In-Reply-To: <734bddbc-a5aa-d50d-0e7b-d8adc4d1afb2@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 8 Aug 2018 10:33:25 +0200
Message-ID: <CAMuHMdVgC__AJHCEKT9UhdK4Jh4bm-s0ihH8mvx7KQ7+vzh6Ag@mail.gmail.com>
Subject: Re: [PATCH v2 08/18] serial: intel: Get serial id from dts
To:     songjun.wu@linux.intel.com
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Songjun,

On Wed, Aug 8, 2018 at 6:05 AM Wu, Songjun <songjun.wu@linux.intel.com> wrote:
> On 8/7/2018 3:33 PM, Geert Uytterhoeven wrote:
> > On Fri, Aug 3, 2018 at 5:04 AM Songjun Wu <songjun.wu@linux.intel.com> wrote:
> >> Get serial id from dts.
> >>
> >> "#ifdef CONFIG_LANTIQ" preprocessor is used because LTQ_EARLY_ASC
> >> macro is defined in lantiq_soc.h.
> >> lantiq_soc.h is in arch path for legacy product support.
> >>
> >> arch/mips/include/asm/mach-lantiq/xway/lantiq_soc.h
> >>
> >> If "#ifdef preprocessor" is changed to
> >> "if (IS_ENABLED(CONFIG_LANTIQ))", when CONFIG_LANTIQ is not enabled,
> >> code using LTQ_EARLY_ASC is compiled.
> >> Compilation will fail for no LTQ_EARLY_ASC defined.
> >>
> >> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
> > Thanks for your patch!
> >
> >> @@ -699,9 +700,19 @@ lqasc_probe(struct platform_device *pdev)
> >>                  return -ENODEV;
> >>          }
> >>
> >> -       /* check if this is the console port */
> >> -       if (mmres->start != CPHYSADDR(LTQ_EARLY_ASC))
> >> -               line = 1;
> >> +       /* get serial id */
> >> +       line = of_alias_get_id(node, "serial");
> >> +       if (line < 0) {
> >> +#ifdef CONFIG_LANTIQ
> >> +               if (mmres->start == CPHYSADDR(LTQ_EARLY_ASC))
> >> +                       line = 0;
> >> +               else
> >> +                       line = 1;
> >> +#else
> >> +               dev_err(&pdev->dev, "failed to get alias id, errno %d\n", line);
> >> +               return line;
> > Please note that not providing a fallback here makes life harder when using
> > DT overlays.
> > See the description of commit 7678f4c20fa7670f ("serial: sh-sci: Add support
> > for dynamic instances") for background info.
> Thanks for your comment.
> The logic in commit 7678f4c20fa7670f is not suitable here.
> We need to know which serial instance is used for console.
> We cannot use dynamic serial instance here.

Why does the driver need to use which serial instance is used for the console?
Hardcoding that is not an option, as the board DTS may specify the console using
chosen/stdout-path.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
