Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BAAC6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 02:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF8982082D
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 02:30:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8982082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbeJaL0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 07:26:14 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46524 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728645AbeJaL0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 07:26:14 -0400
Received: by mail-ed1-f68.google.com with SMTP id v18-v6so12287632edq.13;
        Tue, 30 Oct 2018 19:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K+adRQaV3KCQxO4dq+piahttjAH3CxrcrHPxip7u2FE=;
        b=XCOI7wVeOnWxVbbUA1FHGGwer8bKY8tfULp+3UsvixTBqf3DmF4qjENQFUGhpI9H16
         3F/d9/H7P+0L7CnZLsI9eMHOpt7+HOLiaD2dakdKvZKesO/4MGJMGiEKs9auBKpf5/So
         jE+rwN8FQp+jhiLgzlWrYRGxxIAreGdMD50b0p6G386VQtBfpdIF487lVyBcjU98ARuk
         OWxxUG4QUE500ujd6DTevO3O4zxr90Dm34IiuT0DUFkjm6RaN0YfQ6LTtY2Nhblk+rrN
         Z1q8rm080bMNZdH4OUo7qyj3xJg+7AvfHif7+7WMYWG6f2cDIRNxv0fkdrPZLNRlWGQg
         jJKA==
X-Gm-Message-State: AGRZ1gJuV9J08DX+NY8tUfYwyKrYci5kA+ZfiqyaRHOPQF0VSMcNgl/q
        KEFm0VhYYFKjwy0qHM/I582UQvrXoHM=
X-Google-Smtp-Source: AJdET5dJBu3vR5uvrJ+37q+4VYDUEyYLxHBiH4oyE50QL+GAnisDVpOG7IBEXmxaKEWgTj01YXw8Hw==
X-Received: by 2002:aa7:d48c:: with SMTP id b12-v6mr560097edr.256.1540953012976;
        Tue, 30 Oct 2018 19:30:12 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id v18-v6sm7680842eds.21.2018.10.30.19.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Oct 2018 19:30:12 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id l2-v6so7614219wmh.3;
        Tue, 30 Oct 2018 19:30:12 -0700 (PDT)
X-Received: by 2002:a1c:f010:: with SMTP id a16-v6mr747040wmb.5.1540953012462;
 Tue, 30 Oct 2018 19:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181023185330.10472-1-oskari@lemmela.net> <20181023185330.10472-5-oskari@lemmela.net>
 <20181024135633.GA342@bogus> <20181028154011.04efdecf@archlinux> <20181029130757.m5okrfvusjl5fu5m@qschulz>
In-Reply-To: <20181029130757.m5okrfvusjl5fu5m@qschulz>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 31 Oct 2018 10:29:59 +0800
X-Gmail-Original-Message-ID: <CAGb2v65JKj_7VcEr1KuZVop85hn-3h73NrExprpmLbKZiosD5Q@mail.gmail.com>
Message-ID: <CAGb2v65JKj_7VcEr1KuZVop85hn-3h73NrExprpmLbKZiosD5Q@mail.gmail.com>
Subject: Re: [PATCH v5 04/11] dt-bindings: iio: adc: add AXP803 ADC bindings
To:     jic23@jic23.retrosnub.co.uk
Cc:     Rob Herring <robh@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        devicetree <devicetree@vger.kernel.org>, oskari@lemmela.net,
        linux-gpio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Quentin Schulz <quentin.schulz@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 9:10 PM Quentin Schulz
<quentin.schulz@bootlin.com> wrote:
>
> Hi Jonathan,
>
> On Sun, Oct 28, 2018 at 03:40:11PM +0000, Jonathan Cameron wrote:
> > On Wed, 24 Oct 2018 08:56:33 -0500
> > Rob Herring <robh@kernel.org> wrote:
> >
> > > On Tue, 23 Oct 2018 21:53:23 +0300, Oskari Lemmela wrote:
> > > > The AXP803 ADC is compatible with AXP813 ADC, but add
> > > > specific compatible for it.
> > > >
> > > > Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> > > > ---
> > > >  Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > >
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> >
> > This doesn't seem to have any dependencies with the other patches
> > so applied to the togreg branch of iio.git and pushed out as testing
> > for the autobuilders to ignore.  However I am a little curious to know
> > why we would add the ID and then not use it (that I can see)?
> >
>
> Sometimes with Allwinner (and X-Powers), two IPs seem identical until we
> discover something that is slightly different. When this happens, we
> have to add a compatible to differentiate both. However, we would also
> need to change the Device Tree to change the compatible. We would need
> to handle the driver behaviour for both Device Trees.
>
> So better anticipate a possible difference so that we don't have to do
> some hacks in the driver to handle the device correctly.
>
> As always, Chen-Yu or Maxime may know better so I'm just stating what I
> seem to recall.

With Allwinner stuff (X-Powers included), sometimes the documents are
incomplete or have errors. We tend to add a model-specific compatible
just in case things turn out not to be so compatible, unless someone
has triple-checked everything, documents and actual hardware included.

However we don't actually document these, so this patch isn't strictly
needed. (I suppose this might annoy the device tree binding maintainers.)

ChenYu
