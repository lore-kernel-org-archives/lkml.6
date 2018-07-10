Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1703AC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFE2208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:03:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFE2208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934087AbeGJPDK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:03:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33966 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933688AbeGJPDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:03:05 -0400
Received: by mail-ed1-f65.google.com with SMTP id d3-v6so16839838edi.1;
        Tue, 10 Jul 2018 08:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VcUhopMecYC03kbrSoHQSrIeEm004aiaORnsSiPQ1J0=;
        b=dZ7GtFbJAPeadMMahJYnUaPKMVO+kmTa1WUoCaAc18ZtUW3jWtOgl0Gmo1tCsPeuAc
         lj8EiDfozbn0FSCsEk4F1daX6B/upUeM9qM3AN9h+YS+WCI6sWT4ZvZdyrqvbyzMkFKX
         MzKPFO6Uy+RuZ2etP7yY9VpCJkg0tb0EJCN2NtHq5TNvvOuu7SuIUEEltES5wbB8Ki0u
         y4i96/GN+2DuWQY4QHap9SChJ/2g9io/dy9AE7FqfuaQHc+Ohwh73iMuxsfrh5G+xLTX
         f+3/ZEBGH852lqZ92Cw2+spj338Eh8VnrTspMF3l+Mgm+Kkww82xpYqzU6aLK8DZCVHW
         hWQQ==
X-Gm-Message-State: APt69E3KOlqnYiRp9kBzNraF9VshTyPg6xEbw10U4PL4eE9tK/NWo639
        ier2V+33Wa9j9ZAXQtbt2oVdgzKEHPU=
X-Google-Smtp-Source: AAOMgpdAp1lomBjJAsQSLzQV/4FhKZpA+T1EQ2h1CHLn6RjPWY77rCu7pKmahL52kGq9lEV8oSOWUQ==
X-Received: by 2002:a50:955e:: with SMTP id v30-v6mr27751224eda.268.1531234983944;
        Tue, 10 Jul 2018 08:03:03 -0700 (PDT)
Received: from mail-wm0-f44.google.com (mail-wm0-f44.google.com. [74.125.82.44])
        by smtp.gmail.com with ESMTPSA id d11-v6sm9199751edo.63.2018.07.10.08.03.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 08:03:03 -0700 (PDT)
Received: by mail-wm0-f44.google.com with SMTP id n17-v6so24730012wmh.2;
        Tue, 10 Jul 2018 08:03:03 -0700 (PDT)
X-Received: by 2002:a1c:3b54:: with SMTP id i81-v6mr15695798wma.143.1531234603634;
 Tue, 10 Jul 2018 07:56:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 07:56:23
 -0700 (PDT)
In-Reply-To: <20180710080114.31469-12-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com> <20180710080114.31469-12-paul.kocialkowski@bootlin.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 10 Jul 2018 22:56:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v65swXpLwAo3M9X=MJeVmUrjT=FPFZxp=eCzMrfopqHKjA@mail.gmail.com>
Message-ID: <CAGb2v65swXpLwAo3M9X=MJeVmUrjT=FPFZxp=eCzMrfopqHKjA@mail.gmail.com>
Subject: Re: [PATCH v5 11/22] ARM: sun5i: Add support for the C1 SRAM region
 with the SRAM controller
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
> From: Maxime Ripard <maxime.ripard@bootlin.com>
>
> This adds support for the C1 SRAM region (to be used with the SRAM
> controller driver) for sun5i-based platforms. The region is shared
> between the Video Engine and the CPU.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

But again, see discussion about SRAM compatibles.
