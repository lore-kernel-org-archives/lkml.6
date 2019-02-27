Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A723AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 21:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70C9C20863
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 21:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j78GG+Lr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730547AbfB0Vej (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 16:34:39 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46456 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfB0Vej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 16:34:39 -0500
Received: by mail-ed1-f65.google.com with SMTP id f2so15179010edy.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 13:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=33TM7Cs9TumwVat/O6BjwK7P3AjdXMLeuWOXQzZThW8=;
        b=j78GG+Lrn1m27fhQUz5AsdhDeKRuAcUJsYc2XG5rZ4ek5f1nzqDYYDs09/lGWkxmDR
         DGWCAwlGCU1kU/oArEaeCjpCKANvohSRctwMeKX7NASMiT99ct2TZLPoBFnY78sKeVzK
         UA4X5Ummsm0DWgvmhKg29vBsDo+1uR+a3KCQY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=33TM7Cs9TumwVat/O6BjwK7P3AjdXMLeuWOXQzZThW8=;
        b=V6eX5LrBQ4omx0+1z1b3vsC+AVtVV0YDj2a9bIZbtsnpodYiu9hpJWEoZniqckAHjO
         FBsaOtUKbsJEdWor18wm03GdpdL0l9mlEE11BRZDlko0t9d3qvmpBQosFJbIBeSt7ClO
         PQDFeCUx9788DSzjJOF5gpAOPAy4PDsIjl7H/kDp4suXGKifkXm4YMQL98zcyo6QrRsD
         E603uBgLS3fWjUxlkPKl4mVwc5Sh0WaWBF/8FIQ+LrQTm3VJC4Os9BFya/onDX1poUTO
         1u29oiF/urmPoz+9lGbNZr4Nfvp5Fxa9A3lQSfxjwrqpAmpuHlY8IzN4ft8o2yiYCP5O
         PTEw==
X-Gm-Message-State: AHQUAuabIrc8Gz4/QLWYyfz7+RRhX+Lq3ddfzb6kiDS1VTLzrEvAEu+c
        udBe3mlwwG7cxeDO6Xjql72z4GVFuc4=
X-Google-Smtp-Source: AHgI3IapPs3gUbmysof3dTSj73adsBlU+bFww+4fWz/o2FDNozNPSoK4cZFmvlKIVJVJpucUPifNYA==
X-Received: by 2002:a50:fa8f:: with SMTP id w15mr3830218edr.256.1551303277313;
        Wed, 27 Feb 2019 13:34:37 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id w54sm4597113edw.82.2019.02.27.13.34.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 13:34:36 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 10so15197586eds.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 13:34:34 -0800 (PST)
X-Received: by 2002:a50:a3bc:: with SMTP id s57mr4018952edb.4.1551303274387;
 Wed, 27 Feb 2019 13:34:34 -0800 (PST)
MIME-Version: 1.0
References: <20190222225345.69084-1-briannorris@chromium.org> <C908FF06-43F1-4A5C-B80F-0982315DDB6A@holtmann.org>
In-Reply-To: <C908FF06-43F1-4A5C-B80F-0982315DDB6A@holtmann.org>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 27 Feb 2019 13:34:22 -0800
X-Gmail-Original-Message-ID: <CA+ASDXOG43dRtqzZJuA4ixVvfpt-Wd1rUVMMG3QFRnNGOmY5GA@mail.gmail.com>
Message-ID: <CA+ASDXOG43dRtqzZJuA4ixVvfpt-Wd1rUVMMG3QFRnNGOmY5GA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Bluetooth: btusb: add QCA6174A compatible properties
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Douglas Anderson <dianders@chromium.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Bluetooth mailing list 
        <linux-bluetooth@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajat Jain <rajatja@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel,

On Tue, Feb 26, 2019 at 11:53 PM Marcel Holtmann <marcel@holtmann.org> wrote:
> > We may need to specify a GPIO wake pin for this device, so add a
> > compatible property for it.
> >
> > There are at least to USB PID/VID variations of this chip: one with a
> > Lite-On ID and one with an Atheros ID.
> >
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > v2:
> > * drop leading zeroes from VID, per documented binding
> > ---
> > drivers/bluetooth/btusb.c | 2 ++
> > 1 file changed, 2 insertions(+)
>
> all 3 patches have been applied to bluetooth-next tree.

Thanks! I failed to repeat my comment from v1:

"""
This patch is also required to make this stable, but since it's not
really tied to the device tree, and it's an existing bug, I sent it
separately:

  https://lore.kernel.org/patchwork/patch/1044896/
  Subject: Bluetooth: btusb: request wake pin with NOAUTOEN
"""

Can you take this one too? Otherwise Scarlet will be less stable
(possible interrupt storm at boot).

Regards,
Brian
