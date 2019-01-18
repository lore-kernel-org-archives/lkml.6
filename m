Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE219C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9417120850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 07:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="PtnWG1M/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbfARHwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 02:52:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39159 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbfARHwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 02:52:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so13820442wra.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 23:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ECnQqu7jAPepk4pOFbQ7ppC99odVwGio7AcnWsIsiKw=;
        b=PtnWG1M/tMh05ToM5DNQCWQiX/NY/pU3z8b7WbD7A/QMgvlWt8gnKK9Gn0dpp9U0nw
         +x5LCLL3TTnXxv/6g5MXkYinYJVy3NgDCiRtC4yn+t6UmyeCIL12lEy/x0owvinRHBBa
         MMyCWlRarOOF2THULVPuBpGIlyUklQYDJ4vykAUhnstEq51uK5/eeHmpWr2sXbWP7H9b
         3dXcRWnRI1RloQVS2jcmAyFA4o6GOLbW4qXXhMoiTDYBltlpEHHP99qMSkYfkB2Zqpj/
         YoVdHBc6DShFWzo5mBhOTU8cfiwD1YwCXFAbLfJuhtfuAZzhN5FYaaeLZuUTSEzqIdDV
         i/bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=ECnQqu7jAPepk4pOFbQ7ppC99odVwGio7AcnWsIsiKw=;
        b=Y0JIsI0bJw4i/wBXSDvZXSkU6kJRaEHZIj2hjNW59ORjycqOhuBnNPfv9TEy81swtr
         oqXmcmRtBFi5JY9qoIBjelsXnBhw3jtbg1ELtuibcxegp2iOMZQwYnuiPerjy3kH2Np6
         oMObQUAaepiai7LGHNqUSLwZEfuBwmp8IvoSR/W/xq1rzpJ+VdOfTax3ynOajSi7Nhg5
         rqD1ija9BMOLlXMfTZv0IsRlBTE0xO4LRaaQOc8tck3sLJFZgSbsx75Ub6vVqwwPfQc8
         bjDnz5HFg96wuhPkY7913YjER3Sstwb+cs5B3yMdXspAeTgmHDDS5BoqgbFEi9W2srvC
         YvaQ==
X-Gm-Message-State: AJcUukfAZtvwHgTscejFFBhtmaO+DEWvqW9PgPdlKVFwtb5mcx50ZsC6
        +/LVgT/2nVtCK7xqkvYlH3qkPg==
X-Google-Smtp-Source: ALg8bN4/pp/+yn+KUct+chKHAu1LeXSZ3FnNIgJWVWavHdpouuzhUu9gf/PUmcv+pF+tJld2H4Nwgg==
X-Received: by 2002:a5d:6907:: with SMTP id t7mr14844244wru.226.1547797962285;
        Thu, 17 Jan 2019 23:52:42 -0800 (PST)
Received: from boomer.baylibre.com ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.gmail.com with ESMTPSA id o3sm66906272wrs.30.2019.01.17.23.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 23:52:41 -0800 (PST)
Message-ID: <8d178ecbf885e25e0eb3e30d652934722fbc5050.camel@baylibre.com>
Subject: Re: [PATCH 3/4] arm64: dts: meson: axg: add clk measure support
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        patchwork-bot+notify@kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 18 Jan 2019 08:52:39 +0100
In-Reply-To: <CAFBinCChyyWaiju6ghaCHBFktTXV6DbtuCgZFjEENrf3t3eOxg@mail.gmail.com>
References: <20190117164838.8008-1-jbrunet@baylibre.com>
         <20190117164838.8008-4-jbrunet@baylibre.com>
         <CAFBinCChyyWaiju6ghaCHBFktTXV6DbtuCgZFjEENrf3t3eOxg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-01-17 at 20:57 +0100, Martin Blumenstingl wrote:
> Hi Jerome,
> 
> On Thu, Jan 17, 2019 at 5:48 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
> > Add the clock measure device to the axg SoC family
> > 
> > Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > ---
> >  arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> > b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> > index 0e0abb1a03e2..94ea36a2417a 100644
> > --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> > +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> > @@ -1611,6 +1611,11 @@
> >                                 status = "disabled";
> >                         };
> > 
> > +                       clk_msr: clock-sensor@18000 {
> in the dt-bindings specify "clock-measure@..."

That's the exemple, not a specification, AFAIK.
I'm not sure I see the problem ?

> this also applies to patch 4/4 from this series


Anyway, The node was not placed correctly in g12, I might as well rename it. I
don't really care

> 
> 
> [0] 
> https://elixir.bootlin.com/linux/v5.0-rc1/source/Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt


