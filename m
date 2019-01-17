Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECA3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF7520859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 19:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="u1f7OpyJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbfAQTbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 14:31:36 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33679 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbfAQTbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 14:31:35 -0500
Received: by mail-oi1-f194.google.com with SMTP id c206so7138074oib.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 11:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WPiKxAsqViOka5al7bPffF5qlXbjgAKnpAeml+B0w3g=;
        b=u1f7OpyJbnr59QVGAIwHouOJwBtVaKjRp+hk+Wv5Ec54epZnUL+R54In3pDJMGaiMn
         QAsiPdxBm8WAoPLkmmqa3UlVLaprI/f0n2tEfUVKiTANV2T7RpLCOeDGDk8eIb9XuUP2
         3HnE2GWPiDfZwNx9JFT9tDd3MBzz/mi6iSLZZOIO+agyl1rtUINw9MClO37OazgD2p9L
         hj7GXE/b52/q5MuOzJpnBK+DCpPIWzapnrFQhRoBo/spTOKCDED/XhaNg721K2DGqJN9
         DSAjGQmaTiGZ/ujaKNs8EghnCzDM0N9P0jM+s55/fgJotCiyG1VnW8nOFdMbOiTuR/Ka
         8JoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WPiKxAsqViOka5al7bPffF5qlXbjgAKnpAeml+B0w3g=;
        b=CarFkEwHpIquc+HaQB0puzebUw4AqziOPJsxAOfY+hL6zZezRT9YhqjM5Vt/UUg0Ci
         PPOZPNQ015qAeyIQ9PbFOGyFs3OCtSMmnHDIzCht3KViX6JXF6e//RcD1sI3TdqHl4in
         4keigZxh1uESFgeIrdKZh1XApuE1J4a53oXy6t4AEEszfoGP6raengXOjmkxOHbg6ybq
         0ohnkUBt8zt7z4DoT2EO5bxdvnaQE6gY9hYIxFhd24gSMZy3lWyi68lK1wWr+wlPxnUZ
         YdnD2fdnxMFffBBNu6LC/Eo6l/qTRGeUxEmt6hsFaY2s1hLJrq4XyCXqKwP3gXyQ3RD0
         melQ==
X-Gm-Message-State: AJcUukcsaB9I7Kcp6eyauWob2cKiV3z6gFAkwjrP9FpupvRCmjp2JjEL
        PHhorxfmEqxlnVQZl8qmK70D9HofW4mhkSH/korq4g==
X-Google-Smtp-Source: ALg8bN4WKVDYuQlVLhDdco5RGZUyqNHyxIJjjpcj5lidO0QT8N4meb9MB8KM1KPf365dhI3dGr9sabL+/+yGhj1UZiY=
X-Received: by 2002:aca:720a:: with SMTP id p10mr645392oic.169.1547753494203;
 Thu, 17 Jan 2019 11:31:34 -0800 (PST)
MIME-Version: 1.0
References: <20171110084650.31325-1-yixun.lan@amlogic.com> <alpine.DEB.2.21.1811121115520.14703@nanos.tec.linutronix.de>
 <alpine.DEB.2.21.1901161112090.1655@nanos.tec.linutronix.de> <7hbm4fccb1.fsf@baylibre.com>
In-Reply-To: <7hbm4fccb1.fsf@baylibre.com>
From:   Kevin Hilman <khilman@baylibre.com>
Date:   Thu, 17 Jan 2019 11:31:23 -0800
Message-ID: <CAOi56cV2j-ZKuJHLO3+1MArSJjXKLJm4c4zFE4xLzMq3UR_iYQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: reset: Add bindings for the Meson-AXG
 SoC Reset Controller
To:     Jianxin Pan <jianxin.pan@amlogic.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Carlo Caione <carlo@caione.org>,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 11:29 AM Kevin Hilman <khilman@baylibre.com> wrote:
>
> [ + Jianxin since Yixun is no longer at Amlogic ]
>
> Thomas Gleixner <tglx@linutronix.de> writes:
>
> > On Mon, 12 Nov 2018, Thomas Gleixner wrote:
> >
> > Gentle ping.
> >
> >> Yixun,
> >>
> >> On Fri, 10 Nov 2017, Yixun Lan wrote:
> >>
> >> > +/*
> >> > + *
> >> > + * Copyright (c) 2016 BayLibre, SAS.
> >> > + * Author: Neil Armstrong <narmstrong@baylibre.com>
> >> > + *
> >> > + * Copyright (c) 2017 Amlogic, inc.
> >> > + * Author: Yixun Lan <yixun.lan@amlogic.com>
> >> > + *
> >> > + * SPDX-License-Identifier: (GPL-2.0+ OR BSD)
> >>
> >> There are two things wrong:
> >>
> >>   1) The placement. See Documentation/process/license-rules.rst
> >>
> >>   2) BSD is not a valid license id. You really have to decide which BSD
> >>      variant to use.
> >>
> >> Please get that fixed as especially #2 is broken. The goal of using SPDX is
> >> to provide reliable license information for compliance tools.
> >
> > This still is broken:
> >
> > # scripts/spdxcheck.py include/dt-bindings/
> > include/dt-bindings/reset/amlogic,meson-axg-reset.h: 9:41 Invalid License ID: BSD
>
> Jianxin, can you fix this and clarify which BSD license was intended by
> Amlogic?
>
> If this isn't fixed soon, I will cleanup and remove the BSD part and
> Amlogic can clarify with a subsequent patch.

Oops, nevermind.  Looks like Jerome already did the cleanup.

Kevin
