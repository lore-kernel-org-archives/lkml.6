Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F832ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E719C2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 22:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tjoqmM6j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E719C2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbeGRWxU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 18:53:20 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34823 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbeGRWxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 18:53:20 -0400
Received: by mail-wm0-f66.google.com with SMTP id y22-v6so4367072wma.0;
        Wed, 18 Jul 2018 15:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3V4P/LgKgdeVy0WLivz6K6yPWy/b8rTPXD9U/YPFALM=;
        b=tjoqmM6jErcLyxklWPBeNSOjfPIuHCtiIMGLDDMoQG04r4JBUqBxdKxgpRqzOT2Dp3
         YaNERLBtDrNKEEF7bT2S4NW1xgIE4mZFTvmww5McV4jtxcKVqK/hAhym5Hyk0Mo/GJpC
         QU8ZEOHSxgxWWrzG2nWA6G/EyUwM1OdWkMEWNZwQmxrQ0zuLAJDBwqKhA1IwhkJAgaNm
         YUFA8hO4aP/iaSSza7ubrmRyRxq7UyKeuJs7JBCODUMaqwQ90x9EQfv/WN3W1cHQ8hCH
         +4oGT4dN47cV4EuYnYsLfRg2745cbTAZ81A6oaoA4nJ5B9w5l9dFcBm1O/ePkcu+Yr02
         jntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3V4P/LgKgdeVy0WLivz6K6yPWy/b8rTPXD9U/YPFALM=;
        b=mnKQlmG74CUmFHnOqtVTNYWc0NhxHRFOip02Yi5QPLxz7v8c1qKEldyKkgj5JGzlJ7
         IZL7/Cz0Oq60OVjK7b8VW0Q9TNVtarO14U3LX0jezhojTiPfOWqIVQLUxdlAKeNef9po
         qwMJ3KQTUUcgD7+irhZYfpaThK585H12R1p3//0URoJx4ex7GfQyhyL+F4n+AJRNfppW
         +w7Q0mqh8KSs99bKvcD1SUt4ecsGxQtKF9S1oUPEXKYxIikI6z+BkeC7MJ3NBOwxpxT3
         7Xja9BsIaQiEeYy6r5RB7u8RLGiq7uku0CkOuxQQdCJpcHQssmfUNo/fCth79QXuOHR2
         NHvw==
X-Gm-Message-State: AOUpUlGblcTl/wiQ//wWkhWWseRNjYZlMMcy+ZejxZ26xuyWQs00Agj6
        IwZA4PC40N7QB0yWr4oZocHwweDkFM2+GiOjPiG1Ww==
X-Google-Smtp-Source: AAOMgpd3IWuo8ZMF6yARYcB+Yv8GlWHU3fIqmvTRxpxiIA/H4NsgOndSH9h2A0ebBqHbdMkIwKHsYMJYalDiXqgskxM=
X-Received: by 2002:a1c:149:: with SMTP id 70-v6mr2756505wmb.2.1531952001782;
 Wed, 18 Jul 2018 15:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180711132233.42301-1-icenowy@aosc.io> <20180711132233.42301-2-icenowy@aosc.io>
In-Reply-To: <20180711132233.42301-2-icenowy@aosc.io>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Thu, 19 Jul 2018 08:13:08 +1000
Message-ID: <CAGRGNgUpLpvDcJPWXw2chcWNhvbrDkc99RwDbpzGGoNJf2ORYQ@mail.gmail.com>
Subject: Re: [linux-sunxi] [PATCH 1/2] ARM: sun8i: h3: enable HDMI output on
 Banana Pi M2 Zero
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        devicetree <devicetree@vger.kernel.org>,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Icenowy,

On Wed, Jul 11, 2018 at 11:25 PM Icenowy Zheng <icenowy@aosc.io> wrote:
>
> Banana Pi M2 Zero board has a miniHDMI port connected to the HDMI
> controller of Allwinner H3 SoC.
>
> Enable the HDMI output in Banana Pi M2 Zero device tree.
>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

This is identical to the patch I'd cooked up to do this, so this is:

Tested-by: Julian Calaby <julian.calaby@gmail.com>

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
