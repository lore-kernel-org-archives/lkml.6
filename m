Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB8EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0803620868
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 20:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="OX/yUElu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbfAQU14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 15:27:56 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:42639 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729022AbfAQU14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 15:27:56 -0500
Received: by mail-ot1-f67.google.com with SMTP id v23so12333417otk.9;
        Thu, 17 Jan 2019 12:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y/HXYh0cHPauar+ArG9l18TsCCkBugX4KAFs+CO7+MA=;
        b=OX/yUElubG+0ZNGnS/rZOB0Ag7XjykMrFyIwd07ERr/9qL1s0voYMx9KOqMF/yCKFw
         CA/XnPCWBxXOlVNCuQE2bCsM3hQjqvP3u1gYGI5q6sXEP4EWvIDe5w6i+n6bW1qp+s/m
         JcEYsOqzSB2j4/0nM3bb6VoCfa0/+XrVVvSIUjemtq6AJEEra4c0MHndaycGIzcGAWUs
         /9rD8T7cVNVVqO0NEyrJSLLYT10PiTiwRCEbaiY2T0x2In/YF/2xiTExRPN6lqbTukdF
         u7kzd+nKHFX6T3aN24tboK+PWmSlxIVcQyCWtQSpnu/ikijeIpPGVLeTToc4F1cYf7Gw
         YUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y/HXYh0cHPauar+ArG9l18TsCCkBugX4KAFs+CO7+MA=;
        b=Q+QPffEQM0EeEXiZ6pbor5fG6XAh4U0jOFAJzzE7k+q5X6lfPWr5ONzRKJYV75QrnH
         aJoYWjy1tZ+NXsVqEpbnNSXNrKgzhyEND+rVDqjPbBNIxrJpfUsalUamXOaYBAQf9ioS
         3nI542pTq/3/OIqqIHekXHoowEllrJOvYT4s3pcgaYlMGUKxodR1QxM6blfTSeyqYZ4N
         Sh/vg+S+JtZhPuYymapsK9JaR6P4p1KWZZQmD4vYj5IEsUL0ZD9xwr3KEn0fIr6bG/hO
         YGUROjso7LchayNqQYGReNfLy3ISjK1Odd2uI1jXhqCgDk6c3OwRZkcdB84EvuTU5LEI
         XxXw==
X-Gm-Message-State: AJcUukedUgH8BbgUeUwDzfCXZWGAPPNFNjqf+SNMH8iRGeUW3KUqrtI8
        Z5pdbqepnWn23TcaA3VY9sc1fdGsdeCs+J+haIM=
X-Google-Smtp-Source: ALg8bN4/VpvMgwlr85nGQ7Y4Gg1u2L9beY6r1DqQczHxOsGQfRf3WxlIAWe730rU2hx4NtG9lzxbJgcUczCzacDg1mc=
X-Received: by 2002:a9d:6a8e:: with SMTP id l14mr9462139otq.348.1547756875094;
 Thu, 17 Jan 2019 12:27:55 -0800 (PST)
MIME-Version: 1.0
References: <20190116165236.8330-1-jbrunet@baylibre.com> <CAFBinCBFge2tir-MXw+ojTxzW+7n9Uf4FzCahrw0MDzAYV2SSg@mail.gmail.com>
 <f7289814e316ad5879848fb8c379db396f615828.camel@baylibre.com>
In-Reply-To: <f7289814e316ad5879848fb8c379db396f615828.camel@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 17 Jan 2019 21:27:44 +0100
Message-ID: <CAFBinCDhryOWHmRKp7GhWp2O+NpJziEgHoUE4HKVitTPDMrrBQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: fix g12a buses
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Thu, Jan 17, 2019 at 9:12 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
>
> On Thu, 2019-01-17 at 21:03 +0100, Martin Blumenstingl wrote:
> > Hi Jerome,
> >
> > On Wed, Jan 16, 2019 at 5:52 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > [...]
> > > -               aobus: bus@ff800000 {
> > > -                       compatible = "simple-bus";
> > > -                       reg = <0x0 0xff800000 0x0 0x100000>;
> > are you sure about removing aobus?
> > in your patch "arm64: dts: meson: g12a: add pinctrl support
> > controllers" from [0] you're adding back an "rti" bus at the same
> > memory address, except that it's size is 0x1000 instead of 0x100000
>
> Yes, I'm sure. The fact that the aobus region size is completly made up, for
> all I know, is the reason
>
> >
> > I don't have any G12A datasheet so it's hard for me to ACK / NACK this
> > patch, here are some clues why I'm asking:
> > - GXM's public datasheet lists the "RTI" region at 0xC8100000 -
> > 0xC81FFFFF, we call it "aobus" in our .dtsi
>
> ... RTI region which will appear once i submit the clock controller
I assume you're speaking of G12A and not about GXM:
you already need it for your G12A pinctrl patches, which is why you
add it in: [0]

> Yes GXM (and GXBB, GXL or AXG) has the same made up region with nothing
> matching in the datasheet, but it is bit late fix that now.
looking at the datasheet: it seems that there's only a name mismatch
(aobus in our .dtsi, "rti" in the datasheet)
offset and size correspond with the datasheet

> > - buildroot_openlinux_kernel_4.9_fbdev_20180706/kernel/aml-
> > 4.9/arch/arm64/boot/dts/amlogic/mesong12a.dtsi
> > also uses an aobus node as well as an io_aobus_base sub-node for the
> > codec_io node (the latter is obviously not upstream)
>
> I know, but again, it does not map to anything in the doc, and it has been the
> case for several SoC.
OK, but we had incorrect documentation in the past. did you check this
with someone from Amlogic?

I'm curious because there seem to be two different approaches here:
1) hiubus name and offsets are being fixed within this patch
2) aobus is being dropped here and re-introduced with a different name later on

approach 1) can also be used for the "rti" region (at least in my
opinion, the patch doesn't explain why it can't be done):
rename "aobus" to "rti" and change the size to either 0x1000 or 0xb000
(both values can be found in mesong12a.dtsi from
buildroot_openlinux_kernel_4.9_fbdev_20180706)


Regards
Martin


[0] https://lore.kernel.org/patchwork/patch/1032981/
