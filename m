Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7C3C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C2F216C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:28:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C2F216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbeHULrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:47:13 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:46266 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeHULrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:47:12 -0400
Received: by mail-ua1-f65.google.com with SMTP id u11-v6so11326350uan.13;
        Tue, 21 Aug 2018 01:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GvSVqNU4Ija0fkpJLdsqbSOgMFXjnuhtR8+iBh/1i5o=;
        b=iyK+3F84mInUw/kRB8Lom8rlHCDwgAq2gDBhtcWqbHO4Me7clZlD36luuTNVyyK2Zi
         5/EMwyddwbcOK8Yx471ygtgSGTgFf9/m7jvYoIV421CT9sYHkQJE0WOi+syjqAI6P0B7
         m5vIP2q+WicHTsCqi6eniVKYbPVOn0ha80LVocfTLdEyRhsTOBhQR5c/m+4n1QAVJkGM
         Hyf+Fcav7ToMi9EH8ZvsM0Msz4JHWqYOgSZtllloGbDYR++S3mjmK/8Xcc8aBFf9CgW4
         MoDd11ieWzfiAqdInGQbKULHaqWvC0s+jwZ1ZmPNa6L2C+TtfHa0+vlx58UD6Xc0KoSZ
         9eEg==
X-Gm-Message-State: AOUpUlHIPOhlGYHF6veS1IDYlS6cSQBG4Y/vuCLgB7zZdf28rDXEiDlT
        xc+Kps3wTlYv0L+0KC/t152C4GQXWEFx30FJ+y4=
X-Google-Smtp-Source: AA+uWPzraOcF53jDXeX/WmyhMWtgABsg3yEPzplGMxIsr2gSOXGcqEWUEMk9W7Iu0BRQ/SBH36CW6h2ngUhI/5HMjQs=
X-Received: by 2002:ab0:13c7:: with SMTP id n7-v6mr13284933uae.47.1534840080070;
 Tue, 21 Aug 2018 01:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180726151006.345e8397@canb.auug.org.au> <20180816121256.0435930e@canb.auug.org.au>
In-Reply-To: <20180816121256.0435930e@canb.auug.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Aug 2018 10:27:48 +0200
Message-ID: <CAMuHMdXtMer6z09GV4HM++0RjYSkLWaXO9-m==SE85RkQ2xP-g@mail.gmail.com>
Subject: Re: linux-next: manual merge of the mfd tree with the drm-intel tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        "Nikula, Jani" <jani.nikula@linux.intel.com>,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        paulo.r.zanoni@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 8:05 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> On Thu, 26 Jul 2018 15:10:06 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Today's linux-next merge of the mfd tree got a conflict in:
> >
> >   drivers/gpu/drm/i915/intel_display.h
> >
> > between commit:
> >
> >   6075546f57f8 ("drm/i915/icl: store the port type for TC ports")
> >
> > from the drm-intel tree and commit:
> >
> >   9c229127aee2 ("drm/i915: hdmi: add CEC notifier to intel_hdmi")
> >
> > from the mfd tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> >
> > --
> > Cheers,
> > Stephen Rothwell
> >
> > diff --cc drivers/gpu/drm/i915/intel_display.h
> > index 0a79a46d5805,1f176a71e081..000000000000
> > --- a/drivers/gpu/drm/i915/intel_display.h
> > +++ b/drivers/gpu/drm/i915/intel_display.h
> > @@@ -126,24 -126,30 +126,48 @@@ enum port
> >
> >   #define port_name(p) ((p) + 'A')
> >
> > + /*
> > +  * Ports identifier referenced from other drivers.
> > +  * Expected to remain stable over time
> > +  */
> > + static inline const char *port_identifier(enum port port)
> > + {
> > +     switch (port) {
> > +     case PORT_A:
> > +             return "Port A";
> > +     case PORT_B:
> > +             return "Port B";
> > +     case PORT_C:
> > +             return "Port C";
> > +     case PORT_D:
> > +             return "Port D";
> > +     case PORT_E:
> > +             return "Port E";
> > +     case PORT_F:
> > +             return "Port F";
> > +     default:
> > +             return "<invalid>";
> > +     }
> > + }
> > +
> >  +enum tc_port {
> >  +    PORT_TC_NONE = -1,
> >  +
> >  +    PORT_TC1 = 0,
> >  +    PORT_TC2,
> >  +    PORT_TC3,
> >  +    PORT_TC4,
> >  +
> >  +    I915_MAX_TC_PORTS
> >  +};
> >  +
> >  +enum tc_port_type {
> >  +    TC_PORT_UNKNOWN = 0,
> >  +    TC_PORT_TYPEC,
> >  +    TC_PORT_TBT,
> >  +    TC_PORT_LEGACY,
> >  +};
> >  +
> >   enum dpio_channel {
> >       DPIO_CH0,
> >       DPIO_CH1
>
> This is now a conflict between Linus' tree and the mfd tree.

FTR, it's not this one, but the similar one reported on Jul 19, which does not
add the tc_port_type enum.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
