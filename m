Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E9D7C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7306820817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 09:41:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7306820817
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbeK0Uio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 15:38:44 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41870 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729869AbeK0Uio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 15:38:44 -0500
Received: by mail-ed1-f66.google.com with SMTP id z28so18393920edi.8;
        Tue, 27 Nov 2018 01:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XyQhOfhYtYgSTTHruK4HtukCUh54ZCERjV99mj5Xcz4=;
        b=oRIMcXCiNjwwtrscqFsiWAUA8pSGPYjSNN94OT2zF+bSbRBYmWP1UtsvOr39t//YDF
         n2ZmHuWWjQ/h5woFzAR5lF3zzayN2UwzPOV2mYA60zGWoyiTkjLR65bJ+yd7/bg3tf+s
         kfAUXhn2ovkAaAhEsR0U1aYxtVB8KntdI+jMyRDXUeJlILQ+ffLXiGOEs3kHCClHjwcG
         o9/WKSGpz2oxG1qtiWlTqxPW17iBYhWydW2jCVjyOPVE2AnMXxMkMQWuv8krV7w+U1G3
         lO9ltpUo4wgsVyapLfHwtDV71lj2OFDYLA68uq6izqYyGnvzh1w/S2SxNteCe7K82gK6
         E4tw==
X-Gm-Message-State: AA+aEWZm7fFDvZGn4+qtFW8zrBUuchsUeGh2YX0B7C+NWE2ftrx4EI0a
        CGDGGj2EBr8JbosFOvsJmthHMou2
X-Google-Smtp-Source: AFSGD/Xby1F7nftl/ztgHYd4XTr4aODLMsRYDx0bhLv6/qqdHWBapkrfnjNcu08cvMTsZ5z0ON7OWw==
X-Received: by 2002:a17:906:655:: with SMTP id t21-v6mr10492780ejb.81.1543311683240;
        Tue, 27 Nov 2018 01:41:23 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id d8-v6sm485541ejy.34.2018.11.27.01.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 01:41:23 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id t27so13963448wra.6;
        Tue, 27 Nov 2018 01:41:22 -0800 (PST)
X-Received: by 2002:a5d:4f10:: with SMTP id c16mr27580448wru.177.1543311682374;
 Tue, 27 Nov 2018 01:41:22 -0800 (PST)
MIME-Version: 1.0
References: <cover.156212c9c5df493e098556cad9793a07dcab5e32.1543245984.git-series.plaes@plaes.org>
 <b27515a1cfe3512253a3fbcda04a3367818520b9.1543245984.git-series.plaes@plaes.org>
 <20181127093735.amfqfcsxzreajte4@flea>
In-Reply-To: <20181127093735.amfqfcsxzreajte4@flea>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 27 Nov 2018 17:41:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v66odUU9OOwon4URR-+P_jFw2rV+8PLVzrnLmFpKtqT8gA@mail.gmail.com>
Message-ID: <CAGb2v66odUU9OOwon4URR-+P_jFw2rV+8PLVzrnLmFpKtqT8gA@mail.gmail.com>
Subject: Re: [PATCH 10/14] regulator: dts: set proper lradc vref on OLinuXino Lime2
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Priit Laes <plaes@plaes.org>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        Oliver Schinagl <oliver@schinagl.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 5:37 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Mon, Nov 26, 2018 at 05:27:51PM +0200, Priit Laes wrote:
> > From: Olliver Schinagl <oliver@schinagl.nl>
> >
> > The lradc's analog reference voltage is set to 3.0 volt in the
> > hardware. This is more or less set in copper for at least lradc0. Set the
> > property in the dts to ensure the lradc is referenced properly.
> >
> > Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
> > Signed-off-by: Priit Laes <plaes@plaes.org>
>
> I'm not sure why that patch is part of this series, but I applied
> it. Thanks!

Please help fix up the subject. Should read

"ARM: dts: sun7i: set proper lradc vref on OLinuXino Lime2"

or

"ARM: dts: sun7i: olinoxino-lime2: set proper lradc vref"

ChenYu
