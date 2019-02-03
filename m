Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B476C282D7
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 01:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A7B420856
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 01:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+Vx9QI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbfBCBdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 20:33:09 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43387 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727056AbfBCBdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 20:33:09 -0500
Received: by mail-oi1-f193.google.com with SMTP id u18so8887030oie.10;
        Sat, 02 Feb 2019 17:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b2rZqsmXUinV92RCK3JMrvsiT5FW5NXrFzy/UPpdOXo=;
        b=K+Vx9QI8Yw9w+iEQ5djyBvPEhx5d4CLj5jJcTCXob7BtVU+j3KmN8G3efmB2Zz7UbU
         in8J521sJraDLba4BTXARR8lhqRLHLAve4oLMVmK+QhWVoO0YhWQaJDFmTQaT6ILQfLK
         T2oykvaQTouXEzplootYu5h//m9GyJZQ/jkkl4v6dIsFl+dbI0AGjecsbz7IoZG8HylY
         3RzxXUCPOILS3EfdKkev2uOVEhoqGk6Hh+T8NuJIa/00Rxts4GnZ89vg6+dDjV6rxYfy
         Cc3A7YjBm/gipveIDdJd0GG3zuAk6MZel6C/TXL3mNTmhXtj0oP4MXgmdnAco1JXcVO7
         /1bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b2rZqsmXUinV92RCK3JMrvsiT5FW5NXrFzy/UPpdOXo=;
        b=sW+fOD+uc7whbGTc4z6rw8IR4OsFWAjSWou7SyUjQ+IxRYDaLma/XL0iBvQW6n9cYm
         faDPe9d4cly5arNMVXfRbB09FvwmJyrqNfZaOSJ3akqksPkHNfDwLU2G+F6J6dTYruiO
         M2MY81kEsB/AYMXq/FEM5lgIPxBxzKJs02MNjGkWsBrYAI4YE6Mta3iMAoiHykgfZZ2W
         CZIGp78I2/dBQt7Tl5Nk9beAUAQlI+stkB141SxVr8aN3QA99hiHaNJ9+zzSl28qItGH
         Y2r01jr+FfOA7XihoEUJLpw62RuxBq49udZ5s22DXW4buLo0wpgPcMNKj6X/l34QQAWZ
         Cc0g==
X-Gm-Message-State: AHQUAuY5G98MFSF111wICPKqHBxQnXvqX8PJGMDc8arb3w+VhOit2BnE
        UHQQIzK53N7ZfBKrjmOtoSsfkg3gOZIIM2l2HCo=
X-Google-Smtp-Source: AHgI3IadzqU3/VlJYXkrAWtXpdIzg8LS8tCNdb6IXKAaHs5txitejuJQHv4vPtq0bjKHOD1uo5EY/i363+DG2/ddeh8=
X-Received: by 2002:aca:3904:: with SMTP id g4mr14282408oia.24.1549157587966;
 Sat, 02 Feb 2019 17:33:07 -0800 (PST)
MIME-Version: 1.0
References: <20181018073327.64942-1-icenowy@aosc.io> <CAKMK7uFp2c=wqzPi096MTRB6Cdfacerkp6dM=fEqCAr99PQG9w@mail.gmail.com>
 <20181018094258.oahlopafvm2udvoe@flea> <1585874.9P5eR8PMbl@avalon>
In-Reply-To: <1585874.9P5eR8PMbl@avalon>
From:   Vasily Khoruzhick <anarsoul@gmail.com>
Date:   Sat, 2 Feb 2019 17:32:42 -0800
Message-ID: <CA+E=qVew_TFXQzz+7V6njG4w-Ay4YZND0FZ+8F2TRnhhOBb2Mg@mail.gmail.com>
Subject: Re: [PATCH 9/9] [DO NOT MERGE] drm/sun4i: rgb: Add 5% tolerance to
 dot clock frequency check
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        devicetree <devicetree@vger.kernel.org>,
        Dave Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 4:31 AM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:

> Given that the tolerance is a property of the panel or bridge, I agree with
> Daniel that it should be implemented there, or at least in cooperation with
> drm_panel and drm_bridge.

Clock tolerance is not specified in ANX6345 datasheet.

> Semi-related information, I think the CEA and VESA standards allow a 0.5%
> clock tolerance. What is the maximum clock frequency deviation required for
> this platform ?

This particular platform requires ~1% deviation.

E.g. on Pinebook with 768p panel: requested clock: 73.0 MHz, real
clock: 72.296296 MHz (0.96%)
on Pinebook with 1080p panel: requested clock: 138.5 MHz, real clock:
138.461538 MHz (0.03%)

So unfortunately 0.5% is not enough.

Regards,
Vasily
