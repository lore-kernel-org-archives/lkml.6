Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E07EC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29A1B208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:03:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29A1B208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934057AbeGJPDH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:03:07 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:37080 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933508AbeGJPDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:03:05 -0400
Received: by mail-ed1-f67.google.com with SMTP id v22-v6so16817272edq.4;
        Tue, 10 Jul 2018 08:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=immCL8nvMsdQdvlzItwFTtPwi1KW9sPD0D5kRCxmUQ8=;
        b=O7s3YWoT4q2MnoRvRkaC1TjNXY590nFTyBP8m/PqgxFSPKgl5Nd6lBKeN/ZIcjVH4l
         L0B2Y624+mt17oobbvOpn6Jt16LqX1THa0bK+12l5TbujuYgxYq/3p23VeKs5/tEgYrD
         q5nwTXwJLOcEtE6Gx8xiIxrjDczU3eYWsP1YKf0BRKgLK/iFl/Bd9i9uRBv+L9vHpPB0
         YqtL5i4rNJI0SwBlF14QHSHqn7wj3nIk1jkRJE7RuevgqwezD9PkZNm/pXdkst5XPT63
         C0B68VIpBa5WHGcd3nMhURXWwsWXlCbxRzEvqwOBJ/YvmAnXyhl2qUeoitljrLNd1GFC
         rnlQ==
X-Gm-Message-State: APt69E2mxKw8vFjZJJ3hb9I//4DCPsb7pBYd+WYDTsrBG+7jR+N0QNg6
        PY++K99uJu362c/fUoNvb2IiFl4kSQE=
X-Google-Smtp-Source: AAOMgpc42/yilRfoZ0SNl09yfR8rwKup313D++HGvhNeT4KenoA7DI8d08NYnD7i25Ou32U6CTqXUQ==
X-Received: by 2002:a50:9226:: with SMTP id i35-v6mr26754419eda.27.1531234983490;
        Tue, 10 Jul 2018 08:03:03 -0700 (PDT)
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com. [74.125.82.46])
        by smtp.gmail.com with ESMTPSA id u2-v6sm8090628eds.43.2018.07.10.08.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:03:03 -0700 (PDT)
Received: by mail-wm0-f46.google.com with SMTP id v25-v6so25037329wmc.0;
        Tue, 10 Jul 2018 08:03:03 -0700 (PDT)
X-Received: by 2002:a1c:ee9a:: with SMTP id j26-v6mr13960025wmi.116.1531234491137;
 Tue, 10 Jul 2018 07:54:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 07:54:30
 -0700 (PDT)
In-Reply-To: <20180710080114.31469-11-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com> <20180710080114.31469-11-paul.kocialkowski@bootlin.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 10 Jul 2018 22:54:30 +0800
X-Gmail-Original-Message-ID: <CAGb2v67APUGDu=KM8opavOEKCjorXRyzshdqzZAifPkQzJHNjQ@mail.gmail.com>
Message-ID: <CAGb2v67APUGDu=KM8opavOEKCjorXRyzshdqzZAifPkQzJHNjQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH v5 10/22] ARM: dts: sun7i-a20: Use
 most-qualified system control compatibles
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

On Tue, Jul 10, 2018 at 4:01 PM, Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
> This switches the sun7i-a20 dtsi to use the most qualified compatibles
> for the system-control block (previously named SRAM controller) as well
> as the SRAM blocks. The sun4i-a10 compatibles are kept since these
> hardware blocks are backward-compatible.
>
> The phandle for system control is also updated to reflect the fact that
> the controller described is really about system control rather than SRAM
> control.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

But see discussion about the SRAM mapping compatibles.
