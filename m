Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0176DC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0A62147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690563;
	bh=zb+nISiRI73A+qDN+B8FR5Vq4TOtoLMt5EaVYuqlw3k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=S8Ir0JzpBPJ2ai7iwrO3xgaz/oCJqpKk+Iz6wYbc0LcII6Nj/a0MemNkg7dHoNEi1
	 P3osz5YF4bjsQJP0GqzpQK+UdINRmIuVU/eHohZKTq+jWHRiRqABOKGzQjCNUdQw6y
	 HSnM36PLuereU/DAi0nIpaQpwdNkf1r3Y+XPqskc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfA1PtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:49:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbfA1PtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:49:18 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8DE6217F5;
        Mon, 28 Jan 2019 15:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690557;
        bh=zb+nISiRI73A+qDN+B8FR5Vq4TOtoLMt5EaVYuqlw3k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wzh4I8U3m/doHXMuJs+U+XcvJZn5zi1aPkPRWnb6CY8m95I8YmDIc6Uw7YnK81NYm
         Mfbr3fYfkAfw4k61uN3DmjPVgzP4Tri3fAkSCon1PPU5/oB2DRqsiSnF/2umkD+A4r
         s45+o7+CeYhBM3T85YQBs94xOMyjKEb3UIlybgHo=
Received: by mail-qt1-f178.google.com with SMTP id t13so18723174qtn.3;
        Mon, 28 Jan 2019 07:49:16 -0800 (PST)
X-Gm-Message-State: AJcUukdHZxljYiMFSgctbx81OIZM2A69nN0gJG+HNxKaX0uOZTyZ82uz
        89YQPkywrs3r78djkUGoR1FfNeuEGSQKrfCyqQ==
X-Google-Smtp-Source: ALg8bN6aAd3dUU8SPZKh3Ue5xmkf45/Ph2BX3YSHn6GYh7OyqXrJ80LErM0PgHIMouF7sP1yus5diSXLSD4ZYYMcubc=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr21234047qtd.257.1548690556001;
 Mon, 28 Jan 2019 07:49:16 -0800 (PST)
MIME-Version: 1.0
References: <20181211202406.27721-1-robh@kernel.org> <CAMuHMdUZHi87Dv=m4USocfQ60s6_uHmny5DvCVm+hZ98+ROvdA@mail.gmail.com>
 <CAL_JsqJKhOmp+UKS=B-_8txHhRbqheG3GuogcZpXJ+aYcO5Oqg@mail.gmail.com> <CAMuHMdU3Om44R3wB69jeyHFER8syGDeJQsYd-pXqEKHBMZW2ow@mail.gmail.com>
In-Reply-To: <CAMuHMdU3Om44R3wB69jeyHFER8syGDeJQsYd-pXqEKHBMZW2ow@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 28 Jan 2019 09:49:04 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+5RpZ2WmxnFz-wa=NTGQ2=6MqjdysmXH8PTrRfke8-=A@mail.gmail.com>
Message-ID: <CAL_Jsq+5RpZ2WmxnFz-wa=NTGQ2=6MqjdysmXH8PTrRfke8-=A@mail.gmail.com>
Subject: Re: [PATCH v4] kbuild: Add support for DT binding schema checks
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm-soc <arm@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Marek <michal.lkml@markovi.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 2:59 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Sun, Jan 27, 2019 at 4:00 AM Rob Herring <robh@kernel.org> wrote:
> > On Wed, Jan 23, 2019 at 9:33 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Tue, Dec 11, 2018 at 9:24 PM Rob Herring <robh@kernel.org> wrote:
> > > > This adds the build infrastructure for checking DT binding schema
> > > > documents and validating dts files using the binding schema.
> > > >
> > > > Check DT binding schema documents:
> > > > make dt_binding_check
> > > >
> > > > Build dts files and check using DT binding schema:
> > > > make dtbs_check
> > > >
> > > > Optionally, DT_SCHEMA_FILES can be passed in with a schema file(s) to
> > > > use for validation. This makes it easier to find and fix errors
> > > > generated by a specific schema.
> > > >
> > > > Currently, the validation targets are separate from a normal build to
> > > > avoid a hard dependency on the external DT schema project and because
> > > > there are lots of warnings generated.
> > >
> > > Thanks, I'm giving this a try, and get errors like:
> > >
> > >       DTC     arch/arm/boot/dts/emev2-kzm9d.dt.yaml
> > >     FATAL ERROR: No markers present in property 'cpu0' value
> > >
> > > and
> > >
> > >       DTC     arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dt.yaml
> > >     FATAL ERROR: No markers present in property 'audio_clk_a' value
> > >
> > > Do you have a clue?
> >
> > That's really strange because those aren't even properties. Are other
> > dts files okay? This is the in tree dtc?
> >
> > The only time you should be missing markers is if you did a dts -> dts
> > -> dt.yaml.
>
> Found it: make dtbs_check doesn't play well with my local change to
> add symbols for DT overlays:

Now that makes sense.

>     --- a/scripts/Makefile.lib
>     +++ b/scripts/Makefile.lib
>     @@ -285,6 +285,10 @@ cmd_dt_S_dtb=
>              \
>      $(obj)/%.dtb.S: $(obj)/%.dtb FORCE
>             $(call if_changed,dt_S_dtb)
>
>     +ifeq ($(CONFIG_OF_OVERLAY),y)
>     +DTC_FLAGS += -@
>     +endif
>     +
>      quiet_cmd_dtc = DTC     $@
>      cmd_dtc = mkdir -p $(dir ${dtc-tmp}) ; \
>             $(HOSTCC) -E $(dtc_cpp_flags) -x assembler-with-cpp -o
> $(dtc-tmp) $< ; \
>
> Do you see a way to handle that better?

We need to have the code that generates these properties to also add
markers. Or we could drop the __symbols__ nodes on YAML output. Or
ignore the option when doing YAML output.

> Apart from a few expected issues, I'm seeing one other strange message:
>
>     arch/arm/boot/dts/sh73a0-kzm9g.dt.yaml: interrupts: [[2, 4], [3,
> 4]] is too long
>
> This is the interrupts property in the adi,adxl345 node in
> arch/arm/boot/dts/sh73a0-kzm9g.dts.
> Apparently the check complains if more than one interrupt is listed here.
> Is this a known issue?

There are lots of warnings... I've gone thru and checked some to make
sure they are valid, but certainly not all. There's probably some
cases that are too strict too.

This one is because this device is listed in trivial-devices.yaml and
you can't have 2 interrupts for a trivial device (because you need to
define the interrupt order). Looks like we have a binding doc for it
too, so we should just remove it from trivial-devices.yaml.

There are lots of '... is too (long|short)' messages because of how
the dts file property values are bracketed. This used to not matter,
but is significant in the YAML output. I have a dtc patch to give
warnings on all these (and dtc will give source location).

Rob
