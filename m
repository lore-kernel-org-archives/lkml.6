Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FF0C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 17:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C765D206BB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 17:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbfAARg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 12:36:28 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:35689 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbfAARg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 12:36:27 -0500
Received: by mail-vk1-f195.google.com with SMTP id b18so6184125vke.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jan 2019 09:36:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HHbve5bzvHOo4uY6yXwLFm0GG7yFkTwTmFXguVT9CEk=;
        b=hjORvq6aPjs7iof4qdSC5jR9Wlj9onDXTxR/2VSLAosKNIaAXbf1ft1dkKCPyv0Mnn
         0hj+k+Hi7dlZ+kXob2i20Z5D1mlgr9tPDfZgO/VCfAVP+kcnfnKKIKFWIS5eoFYazPnR
         5FgxNC7dJ0Ok0gt0Yv5XT7JT2FUMVZuXpPEwoXI3Ub8qVniXo9Own4cQsoU5Dminkmil
         VKXgiP6VEvr/FyMjXLGlFqrGTIx8AIHI5mCDXsW1AEpFEsRYTAVIPQoHesgbHaLY9Hu3
         XboRturFiHkCUDtM0plyp1XWvsQxMyI97kl1pAfxGDAO+mQNcYX508lBdQGt7LuFu925
         ZaRA==
X-Gm-Message-State: AJcUukfjv6qkrqmra/CN58Bley7JHuPb0CDR06WPb0hpIaU/RwoOKuid
        kJb5lDquHZGqwXM9shvCNM1zHa2Zz2vGvHD0t+0=
X-Google-Smtp-Source: ALg8bN5k20a4iQBOVnU2gey0aRAh8Hf7q+D1JACPBsFD3fsYhkEo9P+r5iXC1ougBPkC6vbW2SsWdMHg0VXWun8/5E0=
X-Received: by 2002:a1f:2145:: with SMTP id h66mr15173592vkh.65.1546364185671;
 Tue, 01 Jan 2019 09:36:25 -0800 (PST)
MIME-Version: 1.0
References: <20181227084443.GA23991@localhost.localdomain> <CAMuHMdUg=C+pNrbauM-f7LchXRnwu1ufYyUSp=jO+8hs_SrgXQ@mail.gmail.com>
 <20181231191428.GM1846@sirena.org.uk>
In-Reply-To: <20181231191428.GM1846@sirena.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 1 Jan 2019 18:36:13 +0100
Message-ID: <CAMuHMdXi60ZnVMgAxTnBr2ydvhcFzVbooosc+O+gC4q0-0_sEA@mail.gmail.com>
Subject: Re: [PATCH] regmap: regmap-irq: silently ignore unsupported type settings
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, Dec 31, 2018 at 8:14 PM Mark Brown <broonie@kernel.org> wrote:
> On Sat, Dec 29, 2018 at 12:13:32PM +0100, Geert Uytterhoeven wrote:
> > > Geert, do you know if anyone vould to test this?
>
> > Thanks, that seems to fix the issue with da9063-rtc.
>
> > I don't know how to trigger an actual interrupt, though.
>
> If it's a RTC does it have an alarm you can set?

That's what I had expected, too, but there is no alarm file under
/sys/class/rtc/.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
