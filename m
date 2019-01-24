Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 483F3C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D3192184C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfAXJNI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:13:08 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44766 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfAXJNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:13:08 -0500
Received: by mail-vs1-f66.google.com with SMTP id u11so3069846vsp.11;
        Thu, 24 Jan 2019 01:13:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1ehrP1RXAhBOaf7/Ggy42Orq06tEZtqtdfxRf3rgExY=;
        b=L17YZ7NIbmFLfHUhEBcYu652W3McnI1TO0VsaTeTBcUFmS/fg4orefpOoTx08ykp+T
         EwZhROFOkZGnoRpPxxvokGGBZGbgEhY5uJxASYrL1afGGx5m+1tnvPZRCM1po5oeuAPZ
         rYUJeuTXVDT8Vgla7p2cBt1i5GV5Iy2clERGqaxxpZai/xT9gvvEWXjUI8sOmvBNZdho
         lZo+9OgGCjTyNybQZUoRHDOWmNOnLrQeMvskl1BBoMhIKSGSSghdPwhWgFAwWOQRZ3Rm
         Z1mfDQCjgK9z28E1vGMO89IhGzznWMn410l9L/1YT9ROdm4Y9OiP80AFLTAJrbABravc
         Xavw==
X-Gm-Message-State: AJcUukfenqm6oXs2gb8xH/Jm5XKVTUZm/4Hc5/Ha1YCrS2SdRG30KxnB
        eeEOQpn0gvmtHQ7B9wpAY9MdCgApC4SjDQ1Bnwo=
X-Google-Smtp-Source: ALg8bN6fu95l/gMOq/DT5BcGg41b9+nExgnUVqyIngkzZhzELrIsY8AajxN2tv6YwIUNtxf8WJqPTjHBmnt4wMrdc3M=
X-Received: by 2002:a67:c202:: with SMTP id i2mr2307162vsj.11.1548321186908;
 Thu, 24 Jan 2019 01:13:06 -0800 (PST)
MIME-Version: 1.0
References: <1548227352-14910-1-git-send-email-masonccyang@mxic.com.tw>
 <1548227352-14910-2-git-send-email-masonccyang@mxic.com.tw>
 <12af2632-491d-0e01-66c9-0ead4f9d985a@cogentembedded.com> <OFC86383C3.5347178A-ON4825838C.00093E95-4825838C.000B9D6F@mxic.com.tw>
In-Reply-To: <OFC86383C3.5347178A-ON4825838C.00093E95-4825838C.000B9D6F@mxic.com.tw>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 24 Jan 2019 10:12:54 +0100
Message-ID: <CAMuHMdU7wOzG4T5DZoNOhmcspTsGQ7Rd6T6fQjB6o0CeZ5yxhg@mail.gmail.com>
Subject: Re: [PATCH v7 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
To:     Mason Yang <masonccyang@mxic.com.tw>
Cc:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>, zhengxunli@mxic.com.tw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

On Thu, Jan 24, 2019 at 3:07 AM <masonccyang@mxic.com.tw> wrote:
> > "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>
> > 2019/01/24 上午 02:04

> > > +static const struct of_device_id rpc_spi_of_ids[] = {
> > > +   { .compatible = "renesas,r8a77995-rpc", },
> >
> >    Why (if it has no differences with the generic gen3 value below)?
> > Please remove.
>
> By Geert's comments in dts,
>
>          rpc: rpc@ee200000 {
>                 compatible = "renesas,r8a7795-rpc", "renesas,rcar-gen3-rpc";
>                 reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>,
>                       <0 0xee208000 0 0x100>;
>
> I modified it to "renesas,r8a77995-rpc" because this is Soc I developed and validated.

There's a difference between compatible values in DT and in drivers:
  - DT should list all compatible values that are applicable, from
    most-specific to least-specific,
  - Drivers should match against the least-specific compatible value that
    is sufficient to get the job done.
    In this case, that's "renesas,rcar-gen3-rpc".

The driver will probably have to be extended to match against
"renesas,r8a77970-rpc" when R-Car V3M support is added, as RPC on V3M
has an extra register that must be set, and thus cannot be declared
compatible with "renesas,rcar-gen3-rpc".

I hope this explanation makes it clearer.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
