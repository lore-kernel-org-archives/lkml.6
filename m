Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF76BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D4DC223DD
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 05:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPM7wFny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4DC223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeKOPy2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 10:54:28 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:40223 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbeKOPy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 10:54:27 -0500
Received: by mail-oi1-f194.google.com with SMTP id u130-v6so15787325oie.7;
        Wed, 14 Nov 2018 21:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gH2rjWn83IU2TGDsYQAmPrfVFRW+r+gBqCv4hek2XvQ=;
        b=OPM7wFny/6owLT30gzzubnJxMCbe1UW7ct4O6MABpirU2un0AvGbUB7h1I2NOxkwsM
         vka4vqfysQWM9y/wgWFXFSWFbP6FhhjhEIGO3ErW4Y2Hxs8TG1+gdNVp9PTY5QxQyJYl
         /jmuV0lVuioGK7s+8av1/+BE2l1Pycd2X+227aUAOmTbywel1sFmX2RdzifW8ZU2/vaI
         2zNmswPxJcN8VU7kZWC8qpq8ftLCrmaf/E83zd6tsz5GGNz1XwQ3N6PjXnJUlZuib2dw
         Um5Wt4vvDcRJmeZfTE88E/ctLDd1axOS8SsDGezFYyqDa9Ws9Y/C626sL0srEjHLpeVQ
         UcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gH2rjWn83IU2TGDsYQAmPrfVFRW+r+gBqCv4hek2XvQ=;
        b=D+YCsTYC7pLx8nKSUwU+zT2iBvs2NtoeLeeXou4GXPFJ4aKdX/2o6VYYdLwMMY+UOa
         Dr205mDDKeaZ2VbvFbLlv+6+CJd8pRwFL2F2bEd6T4IbuedjmzhvBipXd1QUz9ToGqGd
         1uY1/rw+UthKQcoIfdvZc867rAFNzc58OWh4g6sXm82174H0C37IL1JUI3U2TkOI44Gg
         7/+2usMZzBkIYFGmaUUVWHjAyTRO0dYyHhBWpped5EbeGi9ALN56o1+zmei6igfVcIrq
         ZwPNzB+++8KrXp4VdEl2oeK88t1mDf8yKRBuX0Ve+XHIW6TYqWRUVNVAz7uzyhZoWvLy
         RV/Q==
X-Gm-Message-State: AGRZ1gJVw98xUx9SBu1zI1HHFhACI1t2fO/ADOa+eTg+2n4jbeIzXTBF
        r+2/7vE5jT6vLYRkp5EtquvlVWh7Olute+5P3n4=
X-Google-Smtp-Source: AJdET5cQpUHqR9wiNDE3zzooDgX+2vgf/FOv/FyAvayGYWotvHZfg5K7Bn9I8TSTyKb20KHZzkMiCBIAUNG8UNgrYxg=
X-Received: by 2002:aca:6545:: with SMTP id j5mr2604609oiw.70.1542260882793;
 Wed, 14 Nov 2018 21:48:02 -0800 (PST)
MIME-Version: 1.0
References: <20181108063929.29720-1-anarsoul@gmail.com> <20181108063929.29720-4-anarsoul@gmail.com>
 <CAGb2v65zb4rXJJv018AfDC-YQgAAmahmQ=-Bb5CyU3kA6wBAqg@mail.gmail.com>
In-Reply-To: <CAGb2v65zb4rXJJv018AfDC-YQgAAmahmQ=-Bb5CyU3kA6wBAqg@mail.gmail.com>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Wed, 14 Nov 2018 21:47:36 -0800
Message-ID: <CA+E=qVegv61NgF4peK=Bz2RDvjCUX+M_njrpC4Ph+Jv+r2KFgg@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] arm64: dts: allwinner: a64: enable sound on Pinebook
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        arm-linux <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 11:30 PM Chen-Yu Tsai <wens@csie.org> wrote:
> > +
> > +       speaker_amp: speaker_amp {
> > +               compatible = "simple-audio-amplifier";
> > +               enable-gpios = <&pio 7 7 GPIO_ACTIVE_HIGH>; /* PH7 */
>
> You might want to add a sound-name-prefix property. See
>
>     Documentation/devicetree/bindings/sound/name-prefix.txt
>
> Also this should have a reference to its power supply regulator.

You're right, it should reference its power supply which should be a
fixed regulator controlled via GPIO from AXP803.

Unfortunately there's no AXP803 GPIO support yet and
simple-audio-amplifier doesn't have regulator property.

I have no time (and interest) to work on it in near future, so if
anyone wants to pick it up - feel free to do so.

Regards,
Vasily
