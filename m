Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56FBC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9715D2075C
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:13:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9715D2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbeJHWZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:25:22 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:42359 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbeJHWZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:25:22 -0400
Received: by mail-vs1-f65.google.com with SMTP id e126so5609119vsc.9;
        Mon, 08 Oct 2018 08:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HmOabBNqDMjWcmsiNHkPzhwfgz/jRpqNu7y2U3BkQoI=;
        b=KLqPGwJVESKjzRuOMvxFnQPpY6p1slhgJP/AffetrZ8BclKD1rp5liBTfOfoALl6jh
         dZNcb9Dek7Kj6hX0OIFnrAt2q44sQrGL4828z4zXufhDZDMe8dJ0V7g15Br11Vqwi7z+
         JriyJhHTXQavWx1gYuTDkm/dbfjTGfolZnJszKkqx8zeCKpFMewC0mjV+aEJEeC8z4Ok
         wjMvgnymdKtbpIqAaZOXzKadPwIVNshI7QTxpSvJxWDlZNDupBR1iBPUTy17GendQ2tV
         T5biShzLfqd6DC3i+Uvljcx+0It9FaIJ4xEqidDgnTb8gnEgObXBR6uakPMOtRKFGRzO
         FSNw==
X-Gm-Message-State: ABuFfoj30t46b7NNjVKLCwmb6UMbotpfFBRFi0r9UhZx8WES6PpwGLNs
        H/Mj9uwnVDyOolPjadDiWACLidiGvxgenOQ0kgc=
X-Google-Smtp-Source: ACcGV620Zl5vJ9xzKDLqnc0NRHrBMVjmgYMWqKpLGCo7ur7fwyTF1afoq6FT5oEuvVO7TU4mEoqbidKdD6XcFxLkQ5Y=
X-Received: by 2002:a67:d69e:: with SMTP id o30mr6235265vsj.11.1539011589275;
 Mon, 08 Oct 2018 08:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181005165848.3474-1-robh@kernel.org> <20181005165848.3474-30-robh@kernel.org>
 <CAMuHMdU=rBV4b3EcenvtMPevx14pvTDcnQ7VDg02VZFiFuU-uw@mail.gmail.com> <CAL_JsqLbh-UhYTWN_nMDVwGSh0amh6OsOK8H-+xiTdVynL3XiA@mail.gmail.com>
In-Reply-To: <CAL_JsqLbh-UhYTWN_nMDVwGSh0amh6OsOK8H-+xiTdVynL3XiA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Oct 2018 17:12:56 +0200
Message-ID: <CAMuHMdVtuKkytpHxJfWHw=-R09_AMZ8Tn=ixjPSSRydQL6qK2g@mail.gmail.com>
Subject: Re: [PATCH 29/36] dt-bindings: arm: Convert Renesas board/soc
 bindings to json-schema
To:     Rob Herring <robh@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Grant Likely <glikely@secretlab.ca>,
        Kumar Gala <kumar.gala@linaro.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Mark Brown <broonie@kernel.org>, Tom Rini <trini@konsulko.com>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Jonathan Cameron <jic23@kernel.org>,
        =?UTF-8?Q?Bj=C3=B6rn_Andersson?= <bjorn.andersson@linaro.org>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Oct 8, 2018 at 4:57 PM Rob Herring <robh@kernel.org> wrote:
> On Mon, Oct 8, 2018 at 2:47 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Oct 5, 2018 at 6:59 PM Rob Herring <robh@kernel.org> wrote:
> > > Convert Renesas SoC bindings to DT schema format using json-schema.

> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/arm/shmobile.yaml
> > > @@ -0,0 +1,205 @@

> > > +      - description: Kingfisher (SBEV-RCAR-KF-M03)
> > > +        items:
> > > +          - const: shimafuji,kingfisher
> > > +          - enum:
> > > +              - renesas,h3ulcb
> > > +              - renesas,m3ulcb
> > > +          - enum:
> > > +              - renesas,r8a7795
> > > +              - renesas,r8a7796
> >
> > This looks a bit funny: all other entries have the "const" last, and
> > use it for the
> > SoC number. May be correct, though.
> > To clarify, this is an extension board that can fit both the [HM]3ULCB
> > boards (actually also the new M3NULCB, I think).
>
> This being Kingfisher?

Correct.

> I wrote this based on dts files in the tree. There's 2 combinations that I see:
>
> "shimafuji,kingfisher", "renesas,h3ulcb", "renesas,r8a7795"
> "shimafuji,kingfisher", "renesas,m3ulcb", "renesas,r8a7796"
>
> The schema allows 4 combinations (1 * 2 * 2). I have no idea if the
> other combinations are possible. If not, then we could rewrite this as
> 2 entries with 3 const values each.

I expect there will soon be a third one:

    "shimafuji,kingfisher", "renesas,m3nulcb", "renesas,r8a77965"

Technically, {h3,m3,m3n}ulcb are the same board (although there may be
minor revision differences), with a different SiP mounted.
But they are called/marketed depending on which SiP is mounted.

And on top of that, you can plug in a Kingfisher daughterboard. Could be an
overlay ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
