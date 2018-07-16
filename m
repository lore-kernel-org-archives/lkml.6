Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD436ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68F3A2089B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ossJx0yB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68F3A2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbeGPOGC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:06:02 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55481 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbeGPOGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:06:02 -0400
Received: by mail-it0-f66.google.com with SMTP id 16-v6so20847261itl.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 06:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:organization:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=A4D5ZVDzT6hSMKEu85cZwBBAWGXTzAMHUObBDnoKDsI=;
        b=ossJx0yB3rAGG6mb21QOnb3bfQXaq33Q+NgJJ71U5LISsLM8ctUqDPs2iTKvkd2nLn
         hC1bEy9YqbcAl7tFymI65oRBBQZd/ddUlcYOLJa+lC6psNGeeTeAr3iKGhcSR8051FDg
         eT89S6zkNpnv42t6lVwQHUr8SzYjBXaxmewiGT6V3MkagYzqD3euxq6LdagET4SsNfpI
         c6TJ2If1herzzzwHbS0RdhotcdKt8goMK665CsdMNgEMIurSbM2bk2I5MJAdCyvJloZt
         brAzvzITe4VYaERW2/51jPsb7yDKA9qCEgXyspr4pai4lIb9qATNaQ3x9NTH1j1iLgR/
         NSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:organization:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=A4D5ZVDzT6hSMKEu85cZwBBAWGXTzAMHUObBDnoKDsI=;
        b=fbVLwHxY9pa0rlE2Zvd3eUdbhgF0B2y1J0U0y8Cf27uT8OGLSQY3S5OjrCBZiCZemc
         QPy+r9ORoLChIjv3dwut+4yFYqZVQW2ioMP0TJhhbHVYNZC1+h7KbLJlsTechyFYrbUx
         9cLf2Z05lP0pmmMIhHhtGNt8tgLt4aEsU2MLcEEZGd0FGzz30w6KK87nDV89mECFkHuR
         PbXR38VxIOq9GmdiS1x/muPpGXh2ubX7UGVD7ON8ks8F8ITa4cS0DQ9HBEt2htMT64eV
         iQnhlmBUl7Ghn5OwPxLeQsHvckkvC1HODmcs4WaaJ+wsyvUz0AInW92lIZV5wwEtVbnS
         r72Q==
X-Gm-Message-State: AOUpUlHykaHukPfnGmb+mZVefZjR61vIJKzEdUMoyFq+Rpltls7bJ9k6
        sVYRZnNxuvjNfAKBBHqxHNub/w==
X-Google-Smtp-Source: AAOMgpdPOqUeSNX6PWGYqy99feg7FH1ZB3WEkB7+3+ZJFGe17VgA0J/Y5+FHZrZqqXVnqIbwNpw3CA==
X-Received: by 2002:a24:4ad2:: with SMTP id k201-v6mr13620175itb.6.1531748311397;
        Mon, 16 Jul 2018 06:38:31 -0700 (PDT)
Received: from localhost (c-24-118-241-30.hsd1.mn.comcast.net. [24.118.241.30])
        by smtp.googlemail.com with ESMTPSA id x6-v6sm5489502ith.1.2018.07.16.06.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 06:38:30 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Yixun Lan <yixun.lan@amlogic.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        jian.hu@amlogic.com, Neil Armstrong <narmstrong@baylibre.com>,
        qianggui.song@amlogic.com, sboyd@kernel.org,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        bo.yang@amlogic.com, qiufang.dai@amlogic.com,
        linux-arm-kernel@lists.infradead.org, carlo@caione.org,
        linux-amlogic@lists.infradead.org, sunny.luo@amlogic.com,
        linux-clk@vger.kernel.org, xingyu.chen@amlogic.com,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/3] clk: meson-g12a: Add EE Clock controller driver
Organization: BayLibre
References: <1531134767-29927-1-git-send-email-jian.hu@amlogic.com>
        <1531134767-29927-4-git-send-email-jian.hu@amlogic.com>
        <CAFBinCBB9N_p6S_-dfiV=zDCf-RYnA3C-ir6oNLC7JAfdOqqiw@mail.gmail.com>
        <ec49c089-bccf-9aac-5d0f-43bc27770ad9@amlogic.com>
        <1531216472.2708.71.camel@baylibre.com>
Date:   Mon, 16 Jul 2018 08:38:29 -0500
In-Reply-To: <1531216472.2708.71.camel@baylibre.com> (Jerome Brunet's message
        of "Tue, 10 Jul 2018 11:54:32 +0200")
Message-ID: <7hfu0jmhbe.fsf@baylibre.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On Tue, 2018-07-10 at 09:21 +0800, Yixun Lan wrote:
>> 
>> On 07/10/18 05:53, Martin Blumenstingl wrote:
>> > On Mon, Jul 9, 2018 at 1:14 PM Jian Hu <jian.hu@amlogic.com> wrote:

[...]

>> > > +
>> > > +static const struct of_device_id clkc_match_table[] = {
>> > > +       { .compatible = "amlogic,g12a-clkc" },
>> > 
>> > I wonder if that should be "amlogic,meson-g12a-clkc" (I know that AXG
>> > and GXBB/GXL/GXM omit the "meson-" prefix, but I am not sure if that's
>> > correct - I'll CC Rob Herring on the dt-bindings patch)
>> > 
>> 
>> we're fine with either way, since the g12a is recently new added SoC.
>> 
>> but I guess those old compatibles which already exist won't be changed,
>> as it will break the DT
>
> Yes, I doubt we are going to change the compatibles. With or without the meson
> prefix, I suppose it going to stay that way.

Correct, we will not change existing compatibles.  Adding new ones for
clarity is fine though.

> It is worth thinking about it for new drivers though.
> We already have the "amlogic,", so do we really to prefix even more with "meson-
> "
>
> Also, if we were really strict about that scheme, should meson8b compatible be
>
> "amlogic,meson-meson8b-foo-bar" ... the SoC is meson8b, not just 8b after all ?
>
> For the particular case of the clock controller, I don't care very much, as long
> as the compatible is coherent with documentation.
>
> I might have a preference for the current compatible ... just for consistency
> with the other clock controllers.

In hindsight, I think using the "meson" prefix was a mistake.  It's
redunant, IMO, but it's how we've been doing things for all the drivers,
except for drivers/clk, which, honestly, I hadn't even noticed until
now.

As Jerome said, I think consistency is an important goal, so leaving off
the "meson-" for drivers/clk is fine with me.

Also for consistency, for the rest of the drivers, keeping "meson-" is
probably the right thing to do.

However, patches would be welcome to add compatibles without the "meson"
for the rest of the drivers & documentation as well, but please do not
remove any compatibles.

Kevin
