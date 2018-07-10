Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D784FC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B6352089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6352089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933710AbeGJOtp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:49:45 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40805 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933416AbeGJOtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:49:40 -0400
Received: by mail-ed1-f68.google.com with SMTP id e19-v6so16768615edq.7;
        Tue, 10 Jul 2018 07:49:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8ny+C4xDcf3N+n5UZMMoqOCqWAh3QOJJxL0mwmc0zFA=;
        b=HYYBKO2fBGCD3Gi/JLt8+v4X/5Y10G8AqtqHYNHjQwij3wmLykQEJnsBmQz8uS08md
         jdhqeX214r/b4XsEL+SzIkYCro/E/3MA8AnAivyDQV/vw8vkkAXYUgZlwQBha7udA51c
         fyG+jeDq7TuKHuo8QLaODa8pMKBDzGGkbJh9rkeJDreUnhoJVnj6BMtebdUts639sSzT
         B3EBRcHCi/PnG7nfftoIFZP8ItkEKRxCZAYvrHSDT/i+F2+AGB/Nh9QvHBO1ktidxYwY
         P0qDbiaHRBCgMsAUAbAgmUqy/qY2wU15H6xT518IJ2I/3gLGhq1dDbB7cr1/NGcspt56
         Qs8w==
X-Gm-Message-State: APt69E04zz7pYIk1tAye5fgM+IvBXVGdnsjeYWWeJZT1sG63y8doWua0
        mtDSdao+jzjllWFaRnOpGfDqa0WaFSw=
X-Google-Smtp-Source: AAOMgpdtNkNLrsYz0x68Vji7sM0YgOWzCpj2sPi80Qn7OZG7gCcHCSc2MONLSpBPebUeLW4KBOLuPQ==
X-Received: by 2002:a50:8141:: with SMTP id 59-v6mr27232499edc.156.1531234178681;
        Tue, 10 Jul 2018 07:49:38 -0700 (PDT)
Received: from mail-wm0-f50.google.com (mail-wm0-f50.google.com. [74.125.82.50])
        by smtp.gmail.com with ESMTPSA id i89-v6sm8212086edi.10.2018.07.10.07.49.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 07:49:38 -0700 (PDT)
Received: by mail-wm0-f50.google.com with SMTP id w16-v6so24826971wmc.2;
        Tue, 10 Jul 2018 07:49:37 -0700 (PDT)
X-Received: by 2002:a1c:8c12:: with SMTP id o18-v6mr14057572wmd.120.1531234177711;
 Tue, 10 Jul 2018 07:49:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 07:49:17
 -0700 (PDT)
In-Reply-To: <20180710080114.31469-8-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com> <20180710080114.31469-8-paul.kocialkowski@bootlin.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 10 Jul 2018 22:49:17 +0800
X-Gmail-Original-Message-ID: <CAGb2v65fgkG0hiSuX_VyD1TBCw7OQLoBBJLpun1GK4yUCnPwNg@mail.gmail.com>
Message-ID: <CAGb2v65fgkG0hiSuX_VyD1TBCw7OQLoBBJLpun1GK4yUCnPwNg@mail.gmail.com>
Subject: Re: [PATCH v5 07/22] drivers: soc: sunxi: Add support for the C1 SRAM region
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
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>
> This introduces support for the SRAM C1 section, that is controlled by
> the system controller. This SRAM area can be muxed either to the CPU
> or the Video Engine, that needs this area to store various tables (e.g.
> the Huffman VLD decoding tables).
>
> This only supports devices with the same layout as the A10 (which also
> includes the A13, A20, A33 and other SoCs).
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
