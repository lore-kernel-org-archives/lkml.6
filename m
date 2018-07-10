Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5019C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2E0A2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:03:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2E0A2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933710AbeGJODF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:03:05 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46404 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933336AbeGJODC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:03:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id r17-v6so16662526edo.13;
        Tue, 10 Jul 2018 07:03:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b3vV+TUVrE1ilt0oMPUwI6CukcaygokUbmukKN4xWD0=;
        b=bfIhuM/+Rw3znN9OIC0Utuwhk8mLVqCiPw8OeG1OjrX85WTjeHxp0ytxX5zVRhGA6W
         AqLxeonOlJgOd7xLENefNSojuzIxTy4b0fUs4sViF04Ph1Ch7L4d4qHkgvtrSWaO9mRR
         d+Faiw5RDxhuxpFZeW8jNzQpMdFqzRnOSWt/QiDWhyXu0jbZyJZVENB5twqRPIxyk6Gq
         6uB5uCkYGGWxeLmAVQ65jLeNZPfBgKpVMBqEy6oJYprUJ+Q+Xs88L6BdxGHZlwoX2Bmk
         /qvphpW/jLECxGNwsgrk/ssrjbOfLg1vTk1daqlwVqPodQuP0Iv/I0JU5g/jLDf09p/H
         padg==
X-Gm-Message-State: APt69E36SYCvL6KfNr6ah/fDRoxtcTVpJHFQ26iOHkce5xlSZdNeXaRp
        GSNTfbdOixAzef2chBGXTtd4AJOdpnw=
X-Google-Smtp-Source: AAOMgpfy3p212SoC/yKwv6yaXfmRQNHBTBjOxkuHJWjJ8TrlfujB7yC4RhIiO0fF7rXHMJQQ0Ed+9w==
X-Received: by 2002:aa7:d9d7:: with SMTP id v23-v6mr26796871eds.300.1531231380745;
        Tue, 10 Jul 2018 07:03:00 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id r25-v6sm1519454edb.45.2018.07.10.07.02.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 07:03:00 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id a3-v6so5521207wrt.2;
        Tue, 10 Jul 2018 07:02:59 -0700 (PDT)
X-Received: by 2002:adf:a541:: with SMTP id j1-v6mr20102434wrb.155.1531231379696;
 Tue, 10 Jul 2018 07:02:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 07:02:39
 -0700 (PDT)
In-Reply-To: <20180710080114.31469-4-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com> <20180710080114.31469-4-paul.kocialkowski@bootlin.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 10 Jul 2018 22:02:39 +0800
X-Gmail-Original-Message-ID: <CAGb2v661JHS7r=6LE1em18owSUwk8VXbAGCAVez7=2u5P2R4Jg@mail.gmail.com>
Message-ID: <CAGb2v661JHS7r=6LE1em18owSUwk8VXbAGCAVez7=2u5P2R4Jg@mail.gmail.com>
Subject: Re: [PATCH v5 03/22] dt-bindings: sram: sunxi: Introduce new A10
 binding for system-control
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Marco Franchi <marco.franchi@nxp.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Keiichi Watanabe <keiichiw@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Smitha T Murthy <smitha.t@samsung.com>,
        Tom Saeger <tom.saeger@oracle.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Benoit Parrot <bparrot@ti.com>,
        Todor Tomov <todor.tomov@linaro.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pawel Osciak <posciak@chromium.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Randy Li <ayaka@soulik.info>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 4:00 PM, Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
> Following-up on the introduction of a new binding for the A64, this
> introduces a system-control binding for the A10 as a replacement of
> the sram-controller binding.
>
> This change is motivated by consistency with the Allwinner literature,
> that mentions system control over SRAM controller. Moreover, the system
> control block is sometimes used for more than SRAM (e.g. for muxing
> related to the ethernet PHY).
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
