Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B03EC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6532086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 10:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6532086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbeLNKJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 05:09:27 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34395 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLNKJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 05:09:26 -0500
Received: by mail-vs1-f68.google.com with SMTP id y27so3056726vsi.1;
        Fri, 14 Dec 2018 02:09:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J9vsoy2OM6dVLzuxk78wTlK+3eRMo+7QAyTqR/1Uyio=;
        b=Ppfhw6T3fOGiaUGishHgwTIclZ8Oo//Ew0eglvTjtX3sB09jMiDLgf9cOsjxBfJGXz
         zGJbvMNk9+Sf03Zhktc4u6PkRoWiwoDmqyGDCJIdpVqBOOqIoICc5iQUBsonGZgrr4qF
         Dh15Ikq4VRO8ixQNzPDKq/dm/3vAxI/uM22JbWgRDOL2TtL0yS5ehXz+buBN26ByH3j7
         j4gTt6Pdc0jf/BBd/L5/fRoYyIBwVUqc1XtNkoTl1WzGu91xZMEMHTheN1hhlfAVU7wK
         L6PVVJ1Kt/6LAxUV/IsOw7RLoD8ckyAv3qlIPOxFlNocUFj5MT56oyDte2EXsznIdsow
         ei/Q==
X-Gm-Message-State: AA+aEWZ+iHt4JvvgDBK+iqwVZbjnfm9Isx/ODzg2I/BtB1tUV4HldOzk
        9cAapM+yGvb6av7uICfyON4zdtE+trAu5P1o5YE=
X-Google-Smtp-Source: AFSGD/WOzVSoEu19kNohQj5yBqYxrxA9MV0ZpkZqRCRRWl3V2Ie8SRArAzDs7eQVIsOykN97zS/Se/HOfWWWbIXP3Ro=
X-Received: by 2002:a67:3885:: with SMTP id n5mr852480vsi.96.1544782165291;
 Fri, 14 Dec 2018 02:09:25 -0800 (PST)
MIME-Version: 1.0
References: <1544732378-6268-1-git-send-email-fabrizio.castro@bp.renesas.com>
In-Reply-To: <1544732378-6268-1-git-send-email-fabrizio.castro@bp.renesas.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 14 Dec 2018 11:09:13 +0100
Message-ID: <CAMuHMdXCWhA=-9zO4Z4uL3vQgy6ooDQwTEXyX844dP7TQOepsw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: can: rcar_can: Add r8a774c0 support
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org,
        netdev <netdev@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 9:19 PM Fabrizio Castro
<fabrizio.castro@bp.renesas.com> wrote:
> Document RZ/G2E (r8a774c0) SoC specific bindings.
>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
