Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0A2C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F155208D5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F155208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967926AbeFRIxa (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:53:30 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:40802 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966364AbeFRIx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:53:27 -0400
Received: by mail-ua0-f196.google.com with SMTP id l11-v6so10186998uak.7;
        Mon, 18 Jun 2018 01:53:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TEfxwfB+qu3ElJd4Mz2XR0KZ1uRkHbuFEHSOpNUVM00=;
        b=k9rnV/QZdobo4MAFQTwgJxStDyAUY+myuIHhpEYn00sYY+1EtJxcihrlB2eogqT8p6
         Dd3NExXfSrODnP0BaFtIsqNjS0wzWBN2lx5Fj46kZ8MNgGgh3j+ndygUU/hOa+SyLKVq
         Z82ZCcVufJlNzLvjLkGipkC+aVLJOcLznI58cAexlOqp1q79mOS1QJAHi+thcr/brz1q
         tyf0tIDg7RQ0NMoz6XYWtgWp9Zw5RuaTziqQMCzKRXaPT1GGP4mcvS/5tcaU9sFDT4LR
         FtrQl9ElCMrpMfKFxmhv1jC+giKgZI+OKaQoGadpvBxDkghUhA2ZlPuCI7wwdbdC4hLt
         l/vQ==
X-Gm-Message-State: APt69E1nKzTL3X8vAoWUCHhqjUKuYhampgcwjXjLm29qucgL9ZXtatIi
        QvTQE3gKvxS0+bSC/yJ7YWKBBRsk8TG4kPoJI9s=
X-Google-Smtp-Source: ADUXVKItt6lxkwvfdpoUZekmj4VVdU8grYeqW5Ok5cWU9z+oIdBqZDuuazMqrW/JL68QCTbtE6ZH4KX4WSGp3wsyn3c=
X-Received: by 2002:ab0:48e1:: with SMTP id y30-v6mr7176447uac.180.1529312006985;
 Mon, 18 Jun 2018 01:53:26 -0700 (PDT)
MIME-Version: 1.0
References: <20180618080608.851973560@linuxfoundation.org> <20180618080609.641888971@linuxfoundation.org>
 <b00cf160-5457-1a2c-2020-4b2fffe047cc@cogentembedded.com>
In-Reply-To: <b00cf160-5457-1a2c-2020-4b2fffe047cc@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Jun 2018 10:53:15 +0200
Message-ID: <CAMuHMdUweN=HowbFBOV+8TYom42aGR3jKRNigS0DCaOBbUUhbg@mail.gmail.com>
Subject: Re: [PATCH 4.16 020/279] dt-bindings: net: ravb: Add support for
 r8a77965 SoC
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Rob Herring <robh@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergei,

On Mon, Jun 18, 2018 at 10:46 AM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 6/18/2018 11:10 AM, Greg Kroah-Hartman wrote:
>
> > 4.16-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >
> > [ Upstream commit 1a862488729a6ea9cfd285d2c90f8738949ae7d2 ]
> >
> > Add documentation for r8a77965 compatible string to renesas ravb device
> > tree bindings documentation.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> > Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >   Documentation/devicetree/bindings/net/renesas,ravb.txt |    1 +
> >   1 file changed, 1 insertion(+)
> >
> > --- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
> > +++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
> > @@ -17,6 +17,7 @@ Required properties:
> >
> >         - "renesas,etheravb-r8a7795" for the R8A7795 SoC.
> >         - "renesas,etheravb-r8a7796" for the R8A7796 SoC.
> > +      - "renesas,etheravb-r8a77965" for the R8A77965 SoC.
> >         - "renesas,etheravb-r8a77970" for the R8A77970 SoC.
> >         - "renesas,etheravb-r8a77980" for the R8A77980 SoC.
> >         - "renesas,etheravb-r8a77995" for the R8A77995 SoC.
>
>     Seeing the bindings update in -stable for the 1st time, and I highly doubt
> that it's necessary here.

They don't hurt (as long as no _separate_ driver update is needed!), hence
I don't object to backporting in-se.

But their usefulness can be doubted, as they don't change the behavior of the
kernel, unlikely adding e.g. new PCI IDs, or extending drivers with
new compatible
values. It's purely a documentation update.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
