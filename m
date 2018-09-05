Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B33C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:24:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB34206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="n+HB9q+c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB34206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbeIEMxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 08:53:49 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34121 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeIEMxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 08:53:49 -0400
Received: by mail-io0-f196.google.com with SMTP id c22-v6so5313373iob.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 01:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4tg9Uj6eWJ4+Timngz4NDm3Nkz9LNENHMBDYy5pLKv0=;
        b=n+HB9q+cdzD3kIOGQTXf6+NHWSfAa6R1kmysvToVww3w88aJnprqdLIUPEOjDu0KZ+
         UZeyxm/c9PUEJ0wEy61xzSVrwqKE9KBZ7iVV1FVvjqvyAindeZXbY/rgwkRJZEHaiCcG
         F0W01/zcxs5Ui2p/ghLD/5blsdFmGIlISlk/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4tg9Uj6eWJ4+Timngz4NDm3Nkz9LNENHMBDYy5pLKv0=;
        b=MAUekflb9Bo/wAINE23QzD4dISunJwTnhLPGIWyMwNVTNhfyYAV1qdxPgNssnlIdu9
         HIdAcSGq1of3yFmLgPOauZyuAHJ0clK/jsZA/akIkR9oNzheBuoHkLPnIYPtRQISnO36
         EC/tJc/OFmUzrHl0/SrL3Z9mFVB9J2JYBHdxpG33FubqtiL36RfRIkyNxGv0xeEm5x8N
         SMEjVk4RNM6SM1KzRoZuAaWiX9LH5x0Y3ivxwes1CXinQWOBx8MYlRiRP1oDZsPRKeBQ
         z0GGQp2u9eOwcpXRLhqpFqAlo5v31swoZ+ILtg9rC3Bwvs1QLTJ9FuKOiQ2s/rLmlBOg
         XCYQ==
X-Gm-Message-State: APzg51ClVMQOHLexMqgaexHArtmowNSHpMWxXgc7Y4UiJSRmpJdNvKkG
        g4ckI690oiSaP8UzTAGDhOe7n8xrQ7HHT57wEERCYg==
X-Google-Smtp-Source: ANB0VdZv1sk+YXlYHGn6wgLQd63EJ09OcNcXiKFE4YQ8Z/EC/o69sAYHb18beI2rBLlG8Cns7Bm+DdI5pW3MTp+jBqA=
X-Received: by 2002:a5e:860d:: with SMTP id z13-v6mr2873241ioj.28.1536135883377;
 Wed, 05 Sep 2018 01:24:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:978e:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 01:24:42 -0700 (PDT)
In-Reply-To: <20180905070819.gisznpkvvuqire7c@flea>
References: <20180904163609.10171-1-jagan@amarulasolutions.com>
 <20180904163609.10171-4-jagan@amarulasolutions.com> <20180905070819.gisznpkvvuqire7c@flea>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Wed, 5 Sep 2018 13:54:42 +0530
Message-ID: <CAMty3ZAzjSwq86BwB8O_7DrT0jrhn3ByzN34dY37pF3ZsAZ6uA@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] drm/sun4i: Enable DesignWare HDMI for SUN50I
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 12:38 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Tue, Sep 04, 2018 at 10:06:09PM +0530, Jagan Teki wrote:
>> Allwinner SUN50I are now using DesignWare HDMI so enable
>> them as default. This can build DRM_SUN8I_DW_HDMI as module
>> since DRM in arm64 has module.
>>
>> Making this as defult to SUN8I, may cause an issue while
>> loading since arm32 DRM built as static.
>
> Uh? Why? We should fix this instead of working around it.

I didn't dig further on this. Since ARM64 has is fine with it both
(module and static) may be we can take this.
