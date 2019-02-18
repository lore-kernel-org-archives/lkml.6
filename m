Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BC8C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4942184E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 09:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729488AbfBRJTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 04:19:55 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35145 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729437AbfBRJTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 04:19:54 -0500
Received: by mail-ed1-f68.google.com with SMTP id g19so4217385edp.2;
        Mon, 18 Feb 2019 01:19:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/XrklYpNWnYcNWVDYLyQUagxKF+mFK8VoH185hzGYac=;
        b=I9LWJ3wIx6K7VH6pWH7bQazf/gE59uApOQg1PlMjzuWziFJFD/Zv47YpHNSix4qQRs
         AI0MiC1/kX8dnynayn/jOFIHkfVmutG8gIS4il6L4G7IrIcuX/Z2ikr7KJSuMaUipEzG
         BZezpM5U1aHiJMU5OZpUgPgjWdUmr14H6fMATS0FkLGMAN7tRqEot4FCjwmkRlo3zQqu
         u9ishCS4GoWm+cO32Ef2FIlXq0dldRoaVzK+qu0Q/h/dBojNLrDgAdcexBxluC8kMWN3
         ZwHbYJ6SedJUvU9CvtpAUyvEaR6r7ztpbX2HiA5F041Iyow/OiBxJFNao6dTv4iCjt8W
         zBgQ==
X-Gm-Message-State: AHQUAubYjtFd2XO3WvQEaHymYV+YuaA4Wt6xss5h/xYQR1UZjQuRV0XA
        RgkTJjf3yZV0wt4vU7TwnObkn8lmTYc=
X-Google-Smtp-Source: AHgI3IYZs1EuA+sWf0jYxe+c8i38RFCc9eeJ7+iH9YzIpiBeoM7BfC/ZPtAcIjvj2IQsJZRnG16V3g==
X-Received: by 2002:a50:b527:: with SMTP id y36mr18692013edd.83.1550481592705;
        Mon, 18 Feb 2019 01:19:52 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id s46sm3953605edd.9.2019.02.18.01.19.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 01:19:51 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id t15so8149247wmi.5;
        Mon, 18 Feb 2019 01:19:50 -0800 (PST)
X-Received: by 2002:a7b:c00f:: with SMTP id c15mr14993134wmb.14.1550481590283;
 Mon, 18 Feb 2019 01:19:50 -0800 (PST)
MIME-Version: 1.0
References: <20190217162316.14111-1-tiny.windzz@gmail.com> <20190217162316.14111-3-tiny.windzz@gmail.com>
 <20190218084931.fdut6d4cgwkwvihx@flea>
In-Reply-To: <20190218084931.fdut6d4cgwkwvihx@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Mon, 18 Feb 2019 17:19:40 +0800
X-Gmail-Original-Message-ID: <CAGb2v65Frw+=DjcuqNUPd-UG6qsiVDBH0bd5btx+5=ns7VAQrQ@mail.gmail.com>
Message-ID: <CAGb2v65Frw+=DjcuqNUPd-UG6qsiVDBH0bd5btx+5=ns7VAQrQ@mail.gmail.com>
Subject: Re: [PATCH 2/5] nvmem: sunxi-sid: add support for H5's SID controller
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Yangtao Li <tiny.windzz@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 4:49 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Sun, Feb 17, 2019 at 11:23:13AM -0500, Yangtao Li wrote:
> > Add support for H5's SID controller.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
> >  drivers/nvmem/sunxi_sid.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
> > index 570a2e354f30..036029e90921 100644
> > --- a/drivers/nvmem/sunxi_sid.c
> > +++ b/drivers/nvmem/sunxi_sid.c
> > @@ -219,11 +219,17 @@ static const struct sunxi_sid_cfg sun50i_a64_cfg = {
> >       .size = 0x100,
> >  };
> >
> > +static const struct sunxi_sid_cfg sun50i_h5_cfg = {
> > +     .value_offset = 0x200,
> > +     .size = 0x100,
> > +};
>
> IIRC, there was an endianness issue on the newer SoCs, with the driver
> converting the data from big endian to little endian, while it's
> actually stored little endian in the SID.

About that, it seems the internals are either little endian or native (same
as the bus). Either way the nvmem the driver currently exposes is wrong.

My idea is to keep the current one with the current name, but have it not
associate itself with the DT node. We then register an extra one, called
"sunxi-sid-native" which uses the native endian. This one will be associated
with the DT node, so the THS driver can consume nvmem cells.

What do you think?

> Have you checked the SID content?

On the A64 and H5, directly dumping the SID registers (not using the H3
read method) shows the contents are little or native endian.

ChenYu
