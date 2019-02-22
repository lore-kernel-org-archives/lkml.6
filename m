Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D929C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD4D2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 22:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bltQQJBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfBVWLP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:11:15 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40357 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBVWLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 17:11:14 -0500
Received: by mail-ed1-f65.google.com with SMTP id 10so3064279eds.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 14:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yuHwDkyo+FE+kx/nk3ypUawi0rYD4PuoS1hwu59DHRQ=;
        b=bltQQJBq77iVWZX8IQbvi4zj/TVzxkPp4uD+6beKh9il3NgC922hIXmrNvJ5nJKX+R
         xux+2kSNS3JZM/F762m4oOQhE6QbqSF7CJMR8o2Vra8pC207nD+20jVqx5KocXNGKAg6
         qrpKUWtRWWVJPdDCI1voshOEkZ2Pje8Qo+Yq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yuHwDkyo+FE+kx/nk3ypUawi0rYD4PuoS1hwu59DHRQ=;
        b=WMiqXzoJxKD4/Fr95HejO4opeJQ4N3Nux5YWjcA9qzVmeNAnM9B8pAxMBgm8a1yRKY
         Mpr4ITWy6tjNnJ152nv5aestLGH8ExAFyZ4q0tjjQ/1ZbbyIOk/qxwaTgOkFENXU4bp8
         /9Sth8A8Ag32GPO7FYk/c3pGfmMZL6dgV3jR2t23bENQmW5ubYU7F6aRWE4PSJ1gN6Bi
         jgJn/GDH3FnE/a8Epzu28SpYiT48c/nVTaLLiEBzj7eO+Aebauo1UfmxI8SVtja4QEhc
         DAhDpfLHeU3H8KIhC+pjVET9oKt4Ar9ge9U+I8OQyuSHICeaTarvUqCJS8KrJD0m4hO9
         YSHg==
X-Gm-Message-State: AHQUAuaNq3SYX3S68DZGR2PjA4wCfvahrSHIOP27FLAAWW3I26Me95Mk
        K6xVzpD6TqPKZ0E4tgTve9RJacPsXUc=
X-Google-Smtp-Source: AHgI3IZUDP5LNk+I1OI4a6XbyHvlG7LzrSrpstf8oL9sii6bDmEXEIGLwxDYUPAJHYSLbYuH4G+R+Q==
X-Received: by 2002:a17:906:4893:: with SMTP id v19mr4337017ejq.196.1550873471893;
        Fri, 22 Feb 2019 14:11:11 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id me7sm467010ejb.46.2019.02.22.14.11.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 14:11:10 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id a16so3100141edn.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Feb 2019 14:11:10 -0800 (PST)
X-Received: by 2002:a05:6402:164a:: with SMTP id s10mr4911135edx.6.1550873469625;
 Fri, 22 Feb 2019 14:11:09 -0800 (PST)
MIME-Version: 1.0
References: <20190222003403.128243-1-briannorris@chromium.org>
 <20190222003403.128243-2-briannorris@chromium.org> <5efc9f02-eeb8-78cc-0f11-13e0010efd46@arm.com>
In-Reply-To: <5efc9f02-eeb8-78cc-0f11-13e0010efd46@arm.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Fri, 22 Feb 2019 14:10:57 -0800
X-Gmail-Original-Message-ID: <CA+ASDXOFTYmXHw6DD6f3P-0DfyKGZUt9MANEYZXfBBkiXqikYQ@mail.gmail.com>
Message-ID: <CA+ASDXOFTYmXHw6DD6f3P-0DfyKGZUt9MANEYZXfBBkiXqikYQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: net: btusb: add QCA6174A IDs
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        devicetree@vger.kernel.org,
        Linux Bluetooth mailing list 
        <linux-bluetooth@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Rajat Jain <rajatja@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 1:57 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 2019-02-22 12:34 am, Brian Norris wrote:
> > +               "usb0cf3,e300" (Qualcomm QCA6174A)
> > +               "usb04ca,301a" (Qualcomm QCA6174A (Lite-On))
>
> Nit: the USB device binding states that those leading zeroes in the VIDs
> should be suppressed.

Ah, thanks. Didn't notice that part. I'll remove the zeroes and resend.

Brian
