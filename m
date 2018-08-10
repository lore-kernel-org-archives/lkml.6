Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96B4C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 06:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921C8223E6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 06:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 921C8223E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbeHJJEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 05:04:30 -0400
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:39042 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725746AbeHJJE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 05:04:29 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170])
        by mwinf5d27 with ME
        id MJbz1y0043hB8W903JbzB5; Fri, 10 Aug 2018 08:36:00 +0200
X-ME-Helo: mail-qk0-f170.google.com
X-ME-Auth: bWF4aS5qb3VyZGFuQHdhbmFkb28uZnI=
X-ME-Date: Fri, 10 Aug 2018 08:36:00 +0200
X-ME-IP: 209.85.220.170
Received: by mail-qk0-f170.google.com with SMTP id n85-v6so5723365qke.8;
        Thu, 09 Aug 2018 23:35:59 -0700 (PDT)
X-Gm-Message-State: AOUpUlEMz4E+BRFHDxq3Z+dKZ2LW/6UWEberGq+IpoePqti5/eT+00WH
        R10mmfkwHB7Dmt2N43c8u4XsDNQXOWV0758lu4s=
X-Google-Smtp-Source: AA+uWPw2QH5EKrAZb9Jl+ghHl9p5i04YXmMPzb1phrhnDt/5DFjOC2SCq6G4A7pjCm2KrqEqwjuJQZ0qS75fogNuuv0=
X-Received: by 2002:a37:5b47:: with SMTP id p68-v6mr4608243qkb.202.1533882958836;
 Thu, 09 Aug 2018 23:35:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:278a:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 23:35:58 -0700 (PDT)
In-Reply-To: <5b6cc316.1c69fb81.682d3.1216@mx.google.com>
References: <20180801185128.23440-1-maxi.jourdan@wanadoo.fr>
 <20180801185128.23440-5-maxi.jourdan@wanadoo.fr> <5b6cc316.1c69fb81.682d3.1216@mx.google.com>
From:   Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Date:   Fri, 10 Aug 2018 08:35:58 +0200
X-Gmail-Original-Message-ID: <CAHStOZ6oemCwYWb7dW6SS_ZaWEiVWSfrF=dB_G6CkVb6KS96nA@mail.gmail.com>
Message-ID: <CAHStOZ6oemCwYWb7dW6SS_ZaWEiVWSfrF=dB_G6CkVb6KS96nA@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/meson: convert to the new canvas module
To:     Rob Herring <robh@kernel.org>
Cc:     Maxime Jourdan <maxi.jourdan@wanadoo.fr>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-08-10 0:41 GMT+02:00 Rob Herring <robh@kernel.org>:
> Hi, this is an automated email from Rob's (experimental) review bot. I
> found a couple of common problems with your patch. Please see below.
>
> On Wed,  1 Aug 2018 20:51:28 +0200, Maxime Jourdan wrote:
>> This removes the meson_canvas files within the meson/drm layer
>> and makes use of the new canvas module that is referenced in the dts.
>>
>> Canvases can be used by different IPs and modules, and it is as such
>> preferable to rely on a module that can safely dispatch canvases on
>> demand.
>>
>> Signed-off-by: Maxime Jourdan <maxi.jourdan@wanadoo.fr>
>
> The preferred subject prefix is "dt-bindings: <binding dir>: ...".
>
>> ---
>>  .../bindings/display/amlogic,meson-vpu.txt    |  9 +--
>>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi     |  7 +-
>>  drivers/gpu/drm/meson/Kconfig                 |  1 +
>>  drivers/gpu/drm/meson/Makefile                |  2 +-
>>  drivers/gpu/drm/meson/meson_canvas.c          | 70 -------------------
>>  drivers/gpu/drm/meson/meson_canvas.h          | 42 -----------
>>  drivers/gpu/drm/meson/meson_crtc.c            |  5 +-
>>  drivers/gpu/drm/meson/meson_drv.c             | 35 ++++++----
>>  drivers/gpu/drm/meson/meson_drv.h             |  5 +-
>>  drivers/gpu/drm/meson/meson_plane.c           |  3 +-
>>  drivers/gpu/drm/meson/meson_viu.c             |  1 -
>>  11 files changed, 39 insertions(+), 141 deletions(-)
>>  delete mode 100644 drivers/gpu/drm/meson/meson_canvas.c
>>  delete mode 100644 drivers/gpu/drm/meson/meson_canvas.h
>>
>
> DT bindings (including binding headers) should be a separate patch. See
> Documentation/devicetree/bindings/submitting-patches.txt.
>

Hi, What's the standard procedure here ? The reason I kept
devicetree+drm changes together is because I didn't want to have
floating commits that would break the drm module.

Should I split the changes anyway ?

Maxime
