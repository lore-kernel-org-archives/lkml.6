Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60454C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C778216C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C778216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbeHUL2O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:28:14 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:39025 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeHUL2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:28:14 -0400
Received: by mail-ua1-f65.google.com with SMTP id g18-v6so11328918uam.6;
        Tue, 21 Aug 2018 01:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yA9EWXQu7OZOXo27w2iTI5Wsjhg817l85K2xW8CSwMM=;
        b=Qy6Qxy0AVjOxVENdE7MIWCOzR8141LFj3/NTx+C1eUQQZZAc/gUrdSW9sDIDE0JBhP
         JEu5n4JFVZrbhI8cKaTflpRzbdF09JyoCSEPuK9sWUkL2LhJ9y6s4Uq1//AgWGVoLbBC
         MRfk0JnBnUgntwokzNbzMT4q22N45NPHLfb2FeHwYF448EWnjINVLzDHBUnaNsFWL6hg
         kpOgcAIHERtN9SZLxPBxYlSQAv9hrTVBgIVyQMo8pViD1xdCoZ4R7pxxDNERNt+44JPo
         fne3my3S2pKEB3FfS/pgaop9Rq+abrqCA0YsqCJX08xGFgOzrPvxd40Mw1whecrR/Bq7
         1pjw==
X-Gm-Message-State: AOUpUlGCY6P3ZWSCg2s9ju7mBauYu/NjtLnlrF45bkjt4UTMZ/7dRFKb
        pJQPFrAI8ef6qVQgTJKpcXeCShBOBmcHEYZ47xQ=
X-Google-Smtp-Source: AA+uWPzKtElkTmOJpAiGBIEFPDxsbbbdK2qSSRtUm3re02EA+8pJmJe8Xp/tW8MS3kpbsUcxC03quL6EmDY5OGn9yjs=
X-Received: by 2002:ab0:240b:: with SMTP id f11-v6mr31956590uan.137.1534838946183;
 Tue, 21 Aug 2018 01:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180817103913.52544928@canb.auug.org.au>
In-Reply-To: <20180817103913.52544928@canb.auug.org.au>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 21 Aug 2018 10:08:54 +0200
Message-ID: <CAMuHMdUQcoMxb=0_i1PYyymUpQ1VBOub+EgDbRJWmrq8_xJ-uQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the mfd tree with Linus' tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux-Next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        rf@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 2:40 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Today's linux-next merge of the mfd tree got a conflict in:
>
>   MAINTAINERS
>
> between commit:
>
>   16b7db4c8150 ("MAINTAINERS: Add .clang-format entry")
>
> from Linus' tree and commit:
>
>   97c2b5cba204 ("mfd: madera: Add register definitions for Cirrus Logic Madera codecs")
>
> from the mfd tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> --
> Cheers,
> Stephen Rothwell
>
> diff --cc MAINTAINERS
> index 041b111596bc,2c1c6aef7d74..000000000000
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@@ -3557,11 -3513,23 +3557,27 @@@ M:   Christian Benvenuti <benve@cisco.com
>   S:    Supported
>   F:    drivers/infiniband/hw/usnic/
>
>  +CLANG-FORMAT FILE
>  +M:    Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>  +S:    Maintained
>  +F:    .clang-format
>  +
> + CIRRUS LOGIC MADERA CODEC DRIVERS

To obey sorting rules, the CIRRUS LOGIC entry should be before the CLANG
entry.
Upon closer look, it should be inserted before the CISCO entries, too (in
the mfd tree).

> + M:    Charles Keepax <ckeepax@opensource.cirrus.com>
> + M:    Richard Fitzgerald <rf@opensource.cirrus.com>
> + L:    alsa-devel@alsa-project.org (moderated for non-subscribers)
> + L:    patches@opensource.cirrus.com
> + T:    git https://github.com/CirrusLogic/linux-drivers.git
> + W:    https://github.com/CirrusLogic/linux-drivers/wiki
> + S:    Supported
> + F:    Documentation/devicetree/bindings/mfd/madera.txt
> + F:    Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
> + F:    include/linux/mfd/madera/*
> + F:    drivers/gpio/gpio-madera*
> + F:    drivers/mfd/madera*
> + F:    drivers/mfd/cs47l*
> + F:    drivers/pinctrl/cirrus/*
> +
>   CLEANCACHE API
>   M:    Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>   L:    linux-kernel@vger.kernel.org


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
