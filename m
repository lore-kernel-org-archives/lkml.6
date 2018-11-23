Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9DDC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E3A820672
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 02:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E3A820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439393AbeKWMyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 07:54:12 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46225 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733249AbeKWMyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 07:54:12 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so9031078edt.13;
        Thu, 22 Nov 2018 18:11:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qGCz31pgZFlYojE1pveQ5VbetAHfVJaLcPcB8wPuU+o=;
        b=g8kJU/cEl153GzNO3nUPmiB5DwqqyO0QtqXWZar0A5Vs7OL64MuZu20v9CTz0SfWi4
         XLFedjuLwIVprTBaySMREQ+3PUnjOQ/7iXWLHTh44FGxOWPI7PrVwf/oAWoQudKlwhTT
         N33HhIqU1kjeEw9Sm6wzu+N7JT8QvI636un4ZsCkdzhUZ4vYs+TAzpdaw9oKmUnEhRTY
         aFcl5ZvWxQ+REg8NW4q2C4ZTHa6wX88BtV7oOTWeEdtr1bxWYZctMXy6a03Kb7TlYAcS
         i5UvqrZXXrkqC4JWprL38SMyYmVwE41QWUf8jgbP+eDAgdKH2wW5IubkUsQBmw7uak8m
         EqZg==
X-Gm-Message-State: AGRZ1gL1TiogZxn35S8m6LTLIJ1Hxxmpve0VOAvsMx9SZopwroA4pQXt
        AL1ysPCLxsjcOE66PWwxGPFG+x20N0E=
X-Google-Smtp-Source: AJdET5eYNSDGzQFPuGVwJ95eyS+NLQIxTFTxS8kqA3Fd8pqO+0d9bIuamUXQw2N5yGsEWpAX3bIirw==
X-Received: by 2002:a17:906:4c94:: with SMTP id q20-v6mr9902476eju.26.1542939118847;
        Thu, 22 Nov 2018 18:11:58 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id p1-v6sm7842705ejo.49.2018.11.22.18.11.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Nov 2018 18:11:58 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id p4so10862640wrt.7;
        Thu, 22 Nov 2018 18:11:58 -0800 (PST)
X-Received: by 2002:adf:a599:: with SMTP id g25-v6mr12312770wrc.188.1542939117741;
 Thu, 22 Nov 2018 18:11:57 -0800 (PST)
MIME-Version: 1.0
References: <20181122102325.29495-1-wens@csie.org> <20181122102325.29495-2-wens@csie.org>
 <20181122153241.lzrwhkewg5q4hy2c@flea> <CAGb2v64-Wszg9m8+jCPWzYYRQduwpod2P0UdrFdhTLvAe3paPA@mail.gmail.com>
 <20181122154819.powgbwwqpljqvjty@flea>
In-Reply-To: <20181122154819.powgbwwqpljqvjty@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 23 Nov 2018 10:11:45 +0800
X-Gmail-Original-Message-ID: <CAGb2v669eNKvLxrD4OXgqUa_6qXwvNR0241AkS2x_zC3NCSo1Q@mail.gmail.com>
Message-ID: <CAGb2v669eNKvLxrD4OXgqUa_6qXwvNR0241AkS2x_zC3NCSo1Q@mail.gmail.com>
Subject: Re: [PATCH v9 1/8] ASoC: dt-bindings: sun50i-codec-analog: Add
 headphone amp regulator supply
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com,
        Vasily Khoruzhick <anarsoul@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 22, 2018 at 11:48 PM Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> On Thu, Nov 22, 2018 at 11:41:57PM +0800, Chen-Yu Tsai wrote:
> > On Thu, Nov 22, 2018 at 11:33 PM Maxime Ripard
> > <maxime.ripard@bootlin.com> wrote:
> > >
> > > On Thu, Nov 22, 2018 at 06:23:18PM +0800, Chen-Yu Tsai wrote:
> > > > On the Allwinner A64 SoC, the audio codec has a built-in headphone
> > > > amplifier. This amplifier has a power supply separate from the rest of
> > > > the analog audio circuitry.
> > > >
> > > > Add a regulator supply property to handle this.
> > > >
> > > > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt b/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
> > > > index 4f8ad0e04d20..056a098495cc 100644
> > > > --- a/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
> > > > +++ b/Documentation/devicetree/bindings/sound/sun50i-codec-analog.txt
> > > > @@ -4,9 +4,11 @@ Required properties:
> > > >  - compatible: must be one of the following compatibles:
> > > >               - "allwinner,sun50i-a64-codec-analog"
> > > >  - reg: must contain the registers location and length
> > > > +- cpvdd-supply: Regulator supply for the headphone amplifier
> > >
> > > I guess we should make this optional, since even if it's missing, it's
> > > going to create a dummy regulator. and that allows to have backward
> > > compatibility.
> > >
> > > For the rest of the series,
> > > Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> >
> > This one (not sun8i-codec-analog) is new for the next release, so there's
> > no backward compatibility to consider. Plus none of the device tree changes
> > for A64 have been merged.
>
> Ok, that works for me then.

Well, I misspoke. The driver was introduced in 4.20-rc1, and these changes will
end up in 4.21. But again, since we don't have any device tree changes already
merged, we should be fine.

Implementation wise, there really isn't a "required" variant of the regulator
API. The API will use the dummy regulator if it's missing.

ChenYu
