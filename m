Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B445C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D599C20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D599C20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbeIJOfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:35:34 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34029 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbeIJOfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:35:34 -0400
Received: by mail-ua1-f68.google.com with SMTP id r15-v6so16841464uao.1;
        Mon, 10 Sep 2018 02:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cCb0As7sGnS40v87lPjfn3VlL5KacPMw5Rb4SrWiedw=;
        b=TAF3rH9Xfqh98smot6Ali7YQenU3xNcery3rDkUArtbbPizp10rGQ4YZt+ketRPq02
         d9G1xXYe5I3uK3vxv85jUlnZnwqClBg1+mfXeG0WrUwjCME6iMa4WKFg1pTCshhwj3Fd
         uAfmvnL4d1QE7a8/5XWMf1meOsKSp7Fq+5LqvVqzTrSmiAd6xZkxwsU7SwlSwJP7Vszr
         OIQgdDaQ3ggHIPSfpNEXr3BgO/U5/8hltoGBeqfm5w6mOOry7fZGDWT/eMS0s4teHG9f
         ktslInQdRDBRRCTwy3P9JL30AFhT8o7wHcA0PILgMCQotAgJcQaNmy9J4wMapu6gyM/o
         hp8Q==
X-Gm-Message-State: APzg51DGADXNVjXWIRx+UxnDDEEFGMb1W4ZUoVczc80NUSQWGjHjr49S
        1nechYAVSCpfTbPu+r9iIhgG44mRRe6UXCPauRrydA==
X-Google-Smtp-Source: ANB0Vdajk1WF5GnjhHv3Z7oWDDarh5PxF5sQ2avuk5H2CGrstYsidoqlulCz3I+iqcXdDh2ledXEvxFSKJCV4+VY6Q8=
X-Received: by 2002:ab0:60ae:: with SMTP id f14-v6mr6614575uam.153.1536572542982;
 Mon, 10 Sep 2018 02:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <1535634775-19365-1-git-send-email-phil.edworthy@renesas.com>
 <20180903103358.GC20333@w540> <TY1PR01MB17697F04004A7C8CF1D21CC1F50C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <CAMuHMdU-CcckKueeT5r9-jCoNr0H5KhzrAMbL4LeFta_fAqWuA@mail.gmail.com>
 <TY1PR01MB17697A2D3BCA85B3BFC1FE21F5020@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <CACRpkdad=U5YACQ6k86A4BJo9-U4bC61A0kJ8kONSHu+u3BPyA@mail.gmail.com>
In-Reply-To: <CACRpkdad=U5YACQ6k86A4BJo9-U4bC61A0kJ8kONSHu+u3BPyA@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Sep 2018 11:42:10 +0200
Message-ID: <CAMuHMdUX2Bq+t0yaVYsz6VzX7ZNw_gf_EHc2BuaR9bZcZ=jV7Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Renesas R9A06G032 PINCTRL Driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 9:49 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Sep 5, 2018 at 11:59 AM Phil Edworthy <phil.edworthy@renesas.com> wrote:
> > On 05 September 2018 10:37, Geert Uytterhoeven wrote:
>
> > > Have the VxWorks DT bindings been submitted for review to the devicetree
> > > mailing list?
>
> > I'm not involved with the VxWorks port, but I am pretty sure that they have
> > not been submitted for review.
>
> We have had other cases where deployments on other OSes have been
> establishing bindings (even not very pretty ones).
>
> Examples include typically the Power MacIntosh and the original SPARC
> bindings.

Which predated FDT support in Linux by more than a decade, with the
latter predating even p1275?

While I see merit in compatibility with other existing OSes, I prefer not
to deviate from standard DT bindings, if they exist.

Over time, we've even migrated from Renesas-specific DT bindings to
standard DT bindings, in already upstreamed SoC support.

If needed, I guess a script can be written to convert DTS files from the
old to the new syntax?

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
