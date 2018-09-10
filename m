Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC94C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8464B20870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 09:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8464B20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbeIJOva (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 10:51:30 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35486 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeIJOv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 10:51:29 -0400
Received: by mail-ua1-f68.google.com with SMTP id m26-v6so16843892uap.2;
        Mon, 10 Sep 2018 02:58:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e6MuWwRnmzZgNwf5IVNAT2MW+K9GPBw+PA94qeRsaRc=;
        b=M9SnTYxQFZspqeYBLLfLP26/MDQAOsPqWuUufPYU09UODKkWFuJ5KYIHkTnYJXFFCZ
         Po/YiI8drh16c65PksGya9PS7uS8Y+1ONbXuEpyCemGGWhDGHnB0Z2nldkDPzF/fUpCU
         OpFqLQEB3ET3vFa5hTQTVYvO/UfgNKiQDRj+dLMn+Mp5l4nZRHF/oamniZW+QobFNUvM
         JNZyFDww7vw+Ayh/jX7dafC46mnxgSxZGdZY+0J6s+bN3lyIFnjrNujJGJiKo4nFbFST
         rDgGvLAKQcHbTK6StbBM+iodZeIXWq2vKcA6MoHKcvzhF+IJCR7FpFoCN0hfK7EDOFRx
         A7Mg==
X-Gm-Message-State: APzg51Ari1JXvLxms6a0pg0hQ1+Q2itLzzzm5byvu6WXajy+yIiAcSTo
        gRO6MvbWpov/TZrjvQEGSTf2zF0SjT4yQJ2mhF4=
X-Google-Smtp-Source: ANB0VdbpDLc/SpC/43CFX6yXaWLq7XUZ5e2Ap2ddU7BtXpfkjLPAVs2GDxuovTlbU93Ku5sDKeeVnb0gG/OyU9VfIyM=
X-Received: by 2002:a67:cd07:: with SMTP id u7-v6mr6180799vsl.78.1536573494102;
 Mon, 10 Sep 2018 02:58:14 -0700 (PDT)
MIME-Version: 1.0
References: <1535634775-19365-1-git-send-email-phil.edworthy@renesas.com>
 <20180903103358.GC20333@w540> <TY1PR01MB17697F04004A7C8CF1D21CC1F50C0@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <CAMuHMdU-CcckKueeT5r9-jCoNr0H5KhzrAMbL4LeFta_fAqWuA@mail.gmail.com>
 <TY1PR01MB17697A2D3BCA85B3BFC1FE21F5020@TY1PR01MB1769.jpnprd01.prod.outlook.com>
 <CACRpkdad=U5YACQ6k86A4BJo9-U4bC61A0kJ8kONSHu+u3BPyA@mail.gmail.com>
 <CAMuHMdUX2Bq+t0yaVYsz6VzX7ZNw_gf_EHc2BuaR9bZcZ=jV7Q@mail.gmail.com> <TY1PR01MB176944F61B503C4BCE7FD03CF5050@TY1PR01MB1769.jpnprd01.prod.outlook.com>
In-Reply-To: <TY1PR01MB176944F61B503C4BCE7FD03CF5050@TY1PR01MB1769.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Sep 2018 11:58:02 +0200
Message-ID: <CAMuHMdVcmZuY2Uh-U7R8sKjpLGTvio1-W+jJrWZMgMoM+tZ=Zg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Renesas R9A06G032 PINCTRL Driver
To:     Phil Edworthy <phil.edworthy@renesas.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Simon Horman <horms@verge.net.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Phil,

On Mon, Sep 10, 2018 at 11:54 AM Phil Edworthy
<phil.edworthy@renesas.com> wrote:
> On 10 September 2018 10:42 Geert Uytterhoeven wrote:
> > On Mon, Sep 10, 2018 at 9:49 AM Linus Walleij  wrote:
> > > On Wed, Sep 5, 2018 at 11:59 AM Phil Edworthy wrote:
> > > > On 05 September 2018 10:37, Geert Uytterhoeven wrote:
> > >
> > > > > Have the VxWorks DT bindings been submitted for review to the
> > > > > devicetree mailing list?
> > >
> > > > I'm not involved with the VxWorks port, but I am pretty sure that
> > > > they have not been submitted for review.
> > >
> > > We have had other cases where deployments on other OSes have been
> > > establishing bindings (even not very pretty ones).
> > >
> > > Examples include typically the Power MacIntosh and the original SPARC
> > > bindings.
> >
> > Which predated FDT support in Linux by more than a decade, with the latter
> > predating even p1275?
> >
> > While I see merit in compatibility with other existing OSes, I prefer not to
> > deviate from standard DT bindings, if they exist.
> >
> > Over time, we've even migrated from Renesas-specific DT bindings to
> > standard DT bindings, in already upstreamed SoC support.
> >
> > If needed, I guess a script can be written to convert DTS files from the old to
> > the new syntax?
>
> Thanks for your comments, that is also my preference. Since I have to juggle
> effort vs. features I thought it best to send the driver with existing out-of-tree
> bindings first just to see.
>
> I'll modify the driver for the standard bindings.

Thank you, much appreciated!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
