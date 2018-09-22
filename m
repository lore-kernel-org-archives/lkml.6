Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001D4C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 13:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A3D2154C
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 13:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A3D2154C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731368AbeIVTW6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 15:22:58 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35770 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeIVTW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 15:22:57 -0400
Received: by mail-ed1-f67.google.com with SMTP id y21-v6so575728edr.2;
        Sat, 22 Sep 2018 06:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Id5sXHC0cO2g3GP3u48g2CReDonkqHxwDmEANExerWU=;
        b=Dj/m5kCycaiaNcqcDtN65QQxB4sTll11F+1s6fpNGmGuOZ3j1JwcnKZmem55GIFJ/E
         BwOJpMYJ1DezQFvgFEIsu/YX+rxqcAv4ULRbBoA+MMYF8guUhIJ9C2gKACHuLvAY72G+
         RLiaBdkD359yq15WzLvUxEa4fQl/9UdYJZj/vdKT8sAcLam3hLwz+KeN6SVGRC9MB8+U
         iFhtoOAYW6OINwxz0TYlfX8tKU9krMQ6CS8uFKxhTGj9vZymAVQqtcpA6+aLlNsmncNA
         v74hYrkh20p1Zx7DVzSCz2JS1KYParzFZ4nZ2rn2zEP1fmge/5yqvotWScTNaAWFQ1KE
         FetQ==
X-Gm-Message-State: ABuFfoi67U99cXRhJD7vUZnROU/VvXBy1NFxfruXBeVpAAXi67gBpurn
        oivYKualdgPJaF1GzTcdymJjPM9YQvU=
X-Google-Smtp-Source: ANB0VdZRtl2JF9kLJKq4F4C5QzzJz5UrSURb0Dl/mMhceiiiiD4EuAEqyCjYwNU/V/ngfK01fSAvog==
X-Received: by 2002:a50:9e85:: with SMTP id a5-v6mr3997255edf.92.1537622959755;
        Sat, 22 Sep 2018 06:29:19 -0700 (PDT)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id v14-v6sm3624698edm.97.2018.09.22.06.29.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 06:29:19 -0700 (PDT)
Received: by mail-wm1-f45.google.com with SMTP id l7-v6so774694wme.2;
        Sat, 22 Sep 2018 06:29:18 -0700 (PDT)
X-Received: by 2002:a1c:e289:: with SMTP id z131-v6mr1648614wmg.32.1537622958125;
 Sat, 22 Sep 2018 06:29:18 -0700 (PDT)
MIME-Version: 1.0
References: <20180902072643.4917-1-jernej.skrabec@siol.net> <20180902072643.4917-17-jernej.skrabec@siol.net>
In-Reply-To: <20180902072643.4917-17-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 22 Sep 2018 21:29:06 +0800
X-Gmail-Original-Message-ID: <CAGb2v64J7N+z1v2mXvB2hZuDEMZ2Zty-AG3L12r37NZvkk_n5g@mail.gmail.com>
Message-ID: <CAGb2v64J7N+z1v2mXvB2hZuDEMZ2Zty-AG3L12r37NZvkk_n5g@mail.gmail.com>
Subject: Re: [PATCH 16/27] drm/sun4i: dw-hdmi: Make mode_valid function configurable
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 2, 2018 at 3:27 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> Since it is not possible to access sun8i-dw-hdmi driver private data
> inside mode_valid function, make it configurable. That way different
> versions of HDMI controllers can set different function, depending on
> it's limitations.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
