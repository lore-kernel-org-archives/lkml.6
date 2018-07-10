Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB350C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641372089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:43:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641372089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933840AbeGJOnT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:43:19 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38476 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933353AbeGJOnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:43:17 -0400
Received: by mail-ed1-f68.google.com with SMTP id t2-v6so2164479edr.5;
        Tue, 10 Jul 2018 07:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0oQ+Ev2wwbYIKIy5D8rbZN/PmDh1tYW7eK5mubi1swo=;
        b=GvH2KAGuNnqfRklIkyJOiSnAXxRTAc+55t8w24qxILuTxXNk7yq0FrVP5+tkh/uQHO
         axtZpCbpeD/TrTQXPBeKM9zookueDEJRD2MUv6Qd8TW7kPIhVjNwJD/wxNzVc/XXN8kM
         2E6FzQ9sdNpi4uwtL/Zv8XK1FR3ptFxa2Kxs6C77kMF3r9KOp7GyNbyBR3/KorfDX7Rk
         6xlxSN7xMG+o7Fhryutpwr2Feimi80ILmL+5vgXV+AvJ9pO/feo83igCKXTLcleQ/Ex3
         uK4Fwf2yM5A2WhQRGbDPlHJ5mSGlxD8zJjC7AC8zFVXRDcE2hkH0vMUyP+XREo1o+9hn
         /nLQ==
X-Gm-Message-State: APt69E0+2MpSxxiL624tHn101+Rc44SGHuVcGoUfS34iWHv+aW5wru6s
        13svG9G7Ugl3ycOXuZm93l0V+FhNzJ0=
X-Google-Smtp-Source: AAOMgpehut0Mv8QLMX4H89M7AZRcRSlmlJPsrIqTNK2B81bY7ppvZLLMqRXjMINDxTRiR+UCBiSW/w==
X-Received: by 2002:a50:f609:: with SMTP id c9-v6mr27192826edn.103.1531233795665;
        Tue, 10 Jul 2018 07:43:15 -0700 (PDT)
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com. [74.125.82.48])
        by smtp.gmail.com with ESMTPSA id j34-v6sm7460139edb.50.2018.07.10.07.43.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 07:43:15 -0700 (PDT)
Received: by mail-wm0-f48.google.com with SMTP id s12-v6so24970957wmc.1;
        Tue, 10 Jul 2018 07:43:15 -0700 (PDT)
X-Received: by 2002:a1c:3b54:: with SMTP id i81-v6mr15652160wma.143.1531233399913;
 Tue, 10 Jul 2018 07:36:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 07:36:19
 -0700 (PDT)
In-Reply-To: <20180710080114.31469-5-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com> <20180710080114.31469-5-paul.kocialkowski@bootlin.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 10 Jul 2018 22:36:19 +0800
X-Gmail-Original-Message-ID: <CAGb2v65MO9xmKQz5LuydwqwvVB-_bbM=FeqbsRwJbh-5km9XCQ@mail.gmail.com>
Message-ID: <CAGb2v65MO9xmKQz5LuydwqwvVB-_bbM=FeqbsRwJbh-5km9XCQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/22] dt-bindings: sram: sunxi: Add A13, A20, A23 and
 H3 dedicated bindings
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
> This introduces dedicated bindings for the system control blocks found
> on the A13, A20, A23 and H3 sunxi platforms.
>
> Since the controllers on the A33 are the very same as those on the A23,
> no specific compatible is introduced for it.
>
> These bindings are introduced to allow reflecting the differences that
> exist between these controllers, that may become significant to driver
> implementations.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Not sure if there's a difference between A10 and A20, if you don't count
the NMI that we have a separate node for. But anyway,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
