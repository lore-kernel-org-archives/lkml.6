Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C855C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FFD12089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 14:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FFD12089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934007AbeGJOtL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 10:49:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36643 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933416AbeGJOtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 10:49:08 -0400
Received: by mail-ed1-f68.google.com with SMTP id t3-v6so16775821eds.3;
        Tue, 10 Jul 2018 07:49:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8QuJX/qlpHUGBmz1x2NBpgBRn5q/WrQEjbsVcYafv0s=;
        b=hgLmjJftW0VgppuvUPNlXM/3QrBtJ5NlQi2weG7K7JgkloCc/m6JINW+NXSK/KwYlf
         2H2rEMBReKqeS77vHZ+tFTZ3RyMtLluFRjq0gh/xPUxgSLpTcI9gCdR17zhDRs6axtpZ
         3puJgA9FAU/PtmNDZumzqc8HzTizaFc2O438XuQs3UgqWss5mwKX7j2L63XKImaABL0o
         NNecIICSswJqRJ2o63IdJZlvqH+e1slEpeGeE39y/PvwlXoMKDU0mwatH2tLG/4dpbe5
         /wOVtfDdkFQpnEITryxRkPfkW0O3pBAJITSOYwq/MfMOX2Rq6G4PkIYoFjuUymuttfvo
         sgOw==
X-Gm-Message-State: APt69E3o2M1ZsiHE5BRbSuBlKJI0vRvGDvb11r4oPP+PLJujuOyA9wcN
        01LxnYa3RChRQcACvVmfUllKIIs40P4=
X-Google-Smtp-Source: AAOMgpdd724ydcQ6s/xuNmsWvZPxSNg/QuGJ3al6FphIlwCr+jnxCMRtMnBA6LSNH2XXIfEyn9wq0Q==
X-Received: by 2002:a50:8b8c:: with SMTP id m12-v6mr26946754edm.165.1531234146441;
        Tue, 10 Jul 2018 07:49:06 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id p59-v6sm8628464edp.54.2018.07.10.07.49.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jul 2018 07:49:05 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id b15-v6so14942468wrv.10;
        Tue, 10 Jul 2018 07:49:04 -0700 (PDT)
X-Received: by 2002:adf:b202:: with SMTP id u2-v6mr17471864wra.19.1531234144388;
 Tue, 10 Jul 2018 07:49:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:a15a:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 07:48:43
 -0700 (PDT)
In-Reply-To: <20180710080114.31469-7-paul.kocialkowski@bootlin.com>
References: <20180710080114.31469-1-paul.kocialkowski@bootlin.com> <20180710080114.31469-7-paul.kocialkowski@bootlin.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 10 Jul 2018 22:48:43 +0800
X-Gmail-Original-Message-ID: <CAGb2v67=TizoRQ9uKMPyXPu5fjYFG9bg3DtJ4mBQT2Zm_eZh9w@mail.gmail.com>
Message-ID: <CAGb2v67=TizoRQ9uKMPyXPu5fjYFG9bg3DtJ4mBQT2Zm_eZh9w@mail.gmail.com>
Subject: Re: [PATCH v5 06/22] soc: sunxi: sram: Add dt match for the A10
 system-control compatible
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
> This binds the new A10 system-control compatible to the associated
> driver, with the same driver data as the previous compatible.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
