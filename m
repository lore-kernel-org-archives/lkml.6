Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00C6C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB77F222B7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QuHAGxx0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfBKOGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:06:55 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39337 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbfBKOGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:06:55 -0500
Received: by mail-ed1-f66.google.com with SMTP id b14so8971375edt.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 06:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=6up0/2CWLW2mHT8pB2BYsiR1F95jgx3Z8tSp/xeu/rY=;
        b=QuHAGxx0C8NpYb7B2IIFj8pXvOVbJUU98LmlerVAlK4SEzDyUf+EzsLKZwZDPHb0j7
         u52euAa/Nl5Azxyzib9EowUim8sdwTS3dHT9Qi35e2+hujzYuCfN45HTaU5cvqCrfShP
         nEA1cc8F2yKoLAolMcHjSJHuuDQlP7nZDqmAFLJg3G0wX6u629jXNaL8pQiGJ93kMo9q
         w+BIOlj3ditkPr+cJEgFP6/+z68UfHcZGoz+hITYVwuCgblRY50qqeIgLeubmAJOZ6ku
         NWDZRdnLdpumiiy3/nGuZ8+jafiQf6rLvwCZCTM4V3/PWL9UF+PvS1iTvL9A7CfgEQot
         Y/hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=6up0/2CWLW2mHT8pB2BYsiR1F95jgx3Z8tSp/xeu/rY=;
        b=hOoRr8P1LN6pUl16xna13rnRBsa07UgQ/kK5kiVutdh1rhyqoQhOKD0yPxiJ/UwtzX
         JsNO0575iJ+68iXh3MRvQijfDnGIjPD+C6nr83CbuXfzTli5SkppxcjlmAbp8gwMf0Fv
         QxTKn0F/vCYKqbyu6crdK3Do5TKPF1JdjdnfZQIScjvrQx+8ahkM2+TrwOeNPpHa2ruu
         7QcRTG838HNBK7m6rTorE9NhiP6BnTEXgh3xPozAQnTrnGvjYGI0CPbc5N2z3Gv4havO
         UTo9/kKpZ7vcVRiqV/oaeCBtUJiRwATNMa93FFnSGBmFJR0yb3pC2UvrvHXGq+u7jbz6
         jSEw==
X-Gm-Message-State: AHQUAub1PGSPn3zlJ9hEFB3RhF/xx3sGJjIg6RRF28GfJpigmZLXmuul
        PgV5QETvazUoJAxrQ1fNf3cGQg==
X-Google-Smtp-Source: AHgI3IYdy6zkKwBeQYluvpgQrFC7/eqeirtldBfC4BSiFgEh4fIN7hyHUbaDgMl8civGo2+qRCRIhA==
X-Received: by 2002:aa7:d487:: with SMTP id b7mr28130054edr.256.1549894013672;
        Mon, 11 Feb 2019 06:06:53 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:7e84])
        by smtp.gmail.com with ESMTPSA id t12sm856202ejk.37.2019.02.11.06.06.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 06:06:52 -0800 (PST)
References: <1548693481-1162-1-git-send-email-lollivier@baylibre.com> <1548693481-1162-3-git-send-email-lollivier@baylibre.com> <20190130155016.GA26536@bogus> <20190211092251.GV4686@localhost>
User-agent: mu4e 1.0; emacs 25.3.2
From:   Loys Ollivier <lollivier@baylibre.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Loys Ollivier <lollivier@baylibre.com>,
        devicetree@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: gnss: add mediatek binding
In-reply-to: <20190211092251.GV4686@localhost>
Date:   Mon, 11 Feb 2019 15:06:50 +0100
Message-ID: <86o97iv2px.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon 11 Feb 2019 at 09:22, Johan Hovold <johan@kernel.org> wrote:

> On Wed, Jan 30, 2019 at 09:50:16AM -0600, Rob Herring wrote:
>> On Mon, Jan 28, 2019 at 05:37:59PM +0100, Loys Ollivier wrote:
>> > Add binding for Mediatek-based GNSS receivers.
>> > 
>> > Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
>> > ---
>> > 
>> > v3:
>> > Removed the I2C and SPI interfaces references.
>> > Removed the "mediatek,mt3339" compatible line.
>> > Added the optional propertied (reset, fix)
>> > Added the pin names for the optional properties.
>> > 
>> > v2:
>> > Renamed bindings from Globaltop/gtop to Mediatek/mtk.
>> > Moved current-speed as an optional propertie.
>> > Removed the status line in the example.
>> > Added "mediatek,mt3339" compatible.
>> > 
>> >  .../devicetree/bindings/gnss/mediatek.txt          | 37 ++++++++++++++++++++++
>> >  1 file changed, 37 insertions(+)
>> >  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
>> > 
>> > diff --git a/Documentation/devicetree/bindings/gnss/mediatek.txt b/Documentation/devicetree/bindings/gnss/mediatek.txt
>> > new file mode 100644
>> > index 000000000000..00650d81c5c8
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/gnss/mediatek.txt
>> > @@ -0,0 +1,37 @@
>> > +Mediatek-based GNSS Receiver DT binding
>> > +
>> > +Mediatek chipsets are used in GNSS-receiver modules produced by several
>> > +vendors and can use an UART interface.
>
> s/an/a/
>
ok

>> > +
>> > +Please see Documentation/devicetree/bindings/gnss/gnss.txt for generic
>> > +properties.
>> > +
>> > +Required properties:
>> > +
>> > +- compatible	: Must be
>> > +
>> > +			"globaltop,pa6h"
>> > +
>> > +- vcc-supply	: Main voltage regulator (pin name: VCC)
>> > +
>> > +Optional properties:
>> > +
>> > +- gtop,reset-gpios	: GPIO used to reset the device
>> > +  			  (pin name: RESET, NRESET)
>> 
>> reset-gpios is the standard name.
>> 
>> > +- gtop,fix-gpios	: GPIO used to determine device position fix state
>> > +			  (pin name: FIX, 3D_FIX)
>
> I'm thinking we might need a standard name for fix-gpios as well. This
> isn't a feature that is globaltop (or mediatek) specific, and other
> manufacturers provide similar functionality through pins named UI_FIX,
> or even LCKIND (lock indicator).
>
> The pin is typically used to drive an indicator LED AFAIU, but the
> characteristics of the signal varies from device to device (fw to fw),
> for example, pulse when no lock and low otherwise, or pulse when a 2d or
> 3d-fix is acquired, etc.
>

Yes most GNSS recevivers provide a similar feature even if behavior of
the line differs.

> I'm not sure how useful the pulsing would be for software, but someone
> might find a use for it in some form.
>

Well it is useful to know when you start acquiring "valid" positionning
data. I'm using this as a trigger to start recording position.

> Rob, is this something we want to keep in the binding, and if so, how
> about using a generic name such as "gnss-fix-gpios"?
>

Name "gnss-fix-gpios" sounds good to me.

Loys

> Johan


-- 
-L
