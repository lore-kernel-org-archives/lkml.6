Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 633DBC282D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3278320989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 06:00:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sS7aNf51"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbfA3GAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 01:00:31 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:39253 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbfA3GAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 01:00:31 -0500
Received: by mail-lj1-f195.google.com with SMTP id t9-v6so19626080ljh.6;
        Tue, 29 Jan 2019 22:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZbbuPOyYWoYzUMDSQIZUlEIAOQeW3QT0SpIPcdLMkEw=;
        b=sS7aNf51WECmPlAMT0ufK6LKnnfj0Pc6W8uetZJrXsKet7jXPFN/wYtWgciVTTIgT8
         lGoUWWSec6oYxHAG8hFVbAztnRVB/4tjKarv1yPYivt/sH5TudXacvWgnxFsw7VBaDbZ
         mHmIrMZfLTt/CDv+Hx3yoTbiv3RnqVyhA+TT2FmqwSeAXWUs+eV/hs3fRPdJFvfqsx04
         nxsFQFxbkjIMYjQRpHWalGT+B1i5RFEaKIHDe+8J5WqdQcA0YqhB9tvO/8r+LHQMfTjs
         uYk6wc3uQYZ6Cjbhy5+o2IjS0DjWEj9C/36FpD9a0NGvB+u0Se1cJhKaPncYKb/jDfJh
         I/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZbbuPOyYWoYzUMDSQIZUlEIAOQeW3QT0SpIPcdLMkEw=;
        b=gTGF/vMtzUoDveYlxSg3i06XBWk1hWx36+ymANso9Wutc+5vL2jWmXPr8bXPdIrxUW
         zk+jiz0DD3bpqMo3Zg0MfkN5t/CxmRPcaWZ+JS3YU4t1W3JXEOe3W//qkai2lb7CZFoQ
         D3q6Tu02XhN/RsKXKwOcAp1Sqa1z+YVkV0G8N//FHqhRlRv0GR6a4QuN7Fl8m39s+fjv
         REzmvaexDIoQAb1l4Bh2myovbijIM5E24s5f58qp5qosHvVKD81S+F1WGvXUBNAy45SV
         OHvG4V/tvSPf7hs5DSapk1s/ieEV3AEOOUiVz1p22cQX6oL1LzG7vLEREzYmk3ere5s5
         dHgA==
X-Gm-Message-State: AJcUukfHqQYJkzgQvlu1VKLbHh+fQZ21ozqixKwEufwExf9yo2xrTEKV
        6JqYLVEmwJmUzQ5Fp9TyN0/wk+/obBOTxONIRi0=
X-Google-Smtp-Source: ALg8bN6OclMqIGJu/ivhcmkSwwd8PYB1hwo1RxBbf8K7TccRwIq6njYcK1+kXlrDQsuWZF1OnnNLdpRtAw9tLQ5xRE4=
X-Received: by 2002:a2e:9356:: with SMTP id m22-v6mr23013163ljh.135.1548828028406;
 Tue, 29 Jan 2019 22:00:28 -0800 (PST)
MIME-Version: 1.0
References: <20190129200858.19773-1-goldsimon@gmx.de> <0711a2e0-b4fb-fa12-7c5c-0b5da73c8b02@kernel.org>
In-Reply-To: <0711a2e0-b4fb-fa12-7c5c-0b5da73c8b02@kernel.org>
From:   Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Date:   Wed, 30 Jan 2019 07:00:17 +0100
Message-ID: <CAAh8qszCQROUZVOyX9GCNF_09DebDDUWf_2cfW3M13yG1aJ_Xg@mail.gmail.com>
Subject: Re: [PATCH] ARM: socfpga: fix base address of SDR controller
To:     Dinh Nguyen <dinguyen@kernel.org>, Marek Vasut <marex@denx.de>
Cc:     devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Alan Tull <atull@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Marek (as I really want to keep the dts in Linux and U-Boot in sync)
On Wed, Jan 30, 2019 at 1:16 AM Dinh Nguyen <dinguyen@kernel.org> wrote:
>
>
>
> On 1/29/19 2:08 PM, Simon Goldschmidt wrote:
> > From: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> >
> > The documentation for socfpga gen5 says the base address of the sdram
> > controller is 0xffc20000, while the current devicetree says it is at
> > 0xffc25000.
> >
> > While this is not a problem for Linux, as it only accesses the registers
> > above 0xffc25000, it *is* a problem for U-Boot because the lower registers
> > are used during DDR calibration (up to now, the U-Boot driver does not use
> > the dts address, but that should change).
> >
> > To keep Linux and U-Boot devicetrees in sync, this patch changes the base
> > address to 0xffc20000 and adapts the 2 files where it is currently used.
> >
> > This patch changes the dts and 2 drivers with one commit to prevent
> > breaking the code if dts change and driver change would be split.
> >
> > Signed-off-by: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
> > ---
> >
> >  arch/arm/boot/dts/socfpga.dtsi       | 4 ++--
> >  arch/arm/mach-socfpga/self-refresh.S | 4 ++--
> >  drivers/fpga/altera-fpga2sdram.c     | 2 +-
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
> > index f365003f0..8f6c1a5d6 100644
> > --- a/arch/arm/boot/dts/socfpga.dtsi
> > +++ b/arch/arm/boot/dts/socfpga.dtsi
> > @@ -788,9 +788,9 @@
> >                       reg = <0xfffec000 0x100>;
> >               };
> >
> > -             sdr: sdr@ffc25000 {
> > +             sdr: sdr@ffc20000 {
> >                       compatible = "altr,sdr-ctl", "syscon";
> > -                     reg = <0xffc25000 0x1000>;
> > +                     reg = <0xffc20000 0x6000>;
>
> I don't see the U-Boot device tree having this change. Yes, the
> documentation does state that the SDR address starts at 0xffc20000, but
> all of the pertinent registers start at 0x5000 offset. Thus, the
> starting address should be 0xffc25000.[1]

You don't see it in U-Boot as I'm working on a patch for that.
As I wrote in the commit message, U-Boot currently does not use the
devicetree for the SDR driver, but I want to convert it to do that.

But before converting, I need to find a clean way to provide the
register addresses to the driver. That doesn't work with the current dts.

>
> [1]
> https://www.intel.com/content/www/us/en/programmable/documentation/sfo1410143707420.html#sfo1411577366917

Well, in [2], you see that the peripheral's address range actually starts
at 0xffc20000. It's only the public documented registers that start at
0xffc25000. I don't know why the lower address range is undocumented.
Maybe you can help me here?

But U-Boot needs to use the undocumented registers to bring up the DDR-RAM.
Even if the registers for that are not (clearly?) documented, I think the
devicetree should still reflect the correct address range.

The U-Boot driver is made up of 2 files (in drivers/ddr/altera):
- sdram_gen5.c [3]: using the documented registers from 0xffc25000
- sequencer.c [4]: using the (undocumented?) registers from 0xffc20000

In both files, you can see the register addresses they use by checking the
static variables at the top of the file. And for convenience, use [5] to
search for the values of defines.

[2]
https://www.intel.com/content/www/us/en/programmable/hps/cyclone-v/hps.html
[3]
https://github.com/u-boot/u-boot/blob/master/drivers/ddr/altera/sdram_gen5.c
[4]
https://github.com/u-boot/u-boot/blob/master/drivers/ddr/altera/sequencer.c
[5]
https://elixir.bootlin.com/u-boot/latest/source

Regards,
Simon
