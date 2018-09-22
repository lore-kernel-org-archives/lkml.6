Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85676C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 13:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49AB8208A3
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 13:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49AB8208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731840AbeIVTYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 15:24:45 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43430 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730601AbeIVTYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 15:24:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id u23so3710246edx.10;
        Sat, 22 Sep 2018 06:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4BB406f9JhaPe1aezH8Gxqw5po2q2F0evO2F3OvZpWc=;
        b=CQhe0ODLZXxb7vspPBiQCw2U0lODSXgQlutf26KHx0RxzXboXcTTgTRf9dS5s6kf2A
         MgtqrnZ0RRQnIdssAK96TJZ5+oEN7OxvOlnHMFXj9iIQdFzWkaqkVNdgWItvY4LuGa5k
         FaU68yfJrO2NVk8byKBHrese0payyXkHBevHj8/cPGGBCYouxI0fzsS9OF13RD3yC6fj
         ngIPAGY7jUxZQhTc7qwu5Zi39ml9kmDd9XFTml+ygoHbKITCGFIKn2Hu/RvyHD1NLcxE
         EBkCYHEGvmb0bygAeT4KML9Yf0rk1fJ7l0kGtt/GuuWGm++Wve5+WEfT9T3dQI3J8lDA
         opiw==
X-Gm-Message-State: APzg51APLr+NzIB2SSd7cLNOEacsOuCzRF13ApLZPkhXAp52OrVxbTNT
        XhXwRBrN4Ig2Kx03PX5yRYmNN+dGf4w=
X-Google-Smtp-Source: ACcGV63IL84i32XJjGg0flfUVrEuXXBJlHKy1ii0FkVAqJA/NO0n5dvNAlsTnS5VmBTZAqm9ORWKjg==
X-Received: by 2002:aa7:d1d1:: with SMTP id g17-v6mr3917170edp.163.1537623066607;
        Sat, 22 Sep 2018 06:31:06 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id w41-v6sm3444304edd.92.2018.09.22.06.31.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 06:31:05 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id v16-v6so15384146wro.11;
        Sat, 22 Sep 2018 06:31:05 -0700 (PDT)
X-Received: by 2002:adf:9522:: with SMTP id 31-v6mr1992358wrs.91.1537623064923;
 Sat, 22 Sep 2018 06:31:04 -0700 (PDT)
MIME-Version: 1.0
References: <20180902072643.4917-1-jernej.skrabec@siol.net> <20180902072643.4917-18-jernej.skrabec@siol.net>
In-Reply-To: <20180902072643.4917-18-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Sat, 22 Sep 2018 21:30:52 +0800
X-Gmail-Original-Message-ID: <CAGb2v66oMoXxYCrnZpWMk_wtZMfqGonWM+fdc1BG-3NghcE7bQ@mail.gmail.com>
Message-ID: <CAGb2v66oMoXxYCrnZpWMk_wtZMfqGonWM+fdc1BG-3NghcE7bQ@mail.gmail.com>
Subject: Re: [PATCH 17/27] drm/sun4i: dw-hdmi: Add quirk for setting TMDS clock
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
> It turns out that H6 HDMI BSP kernel driver doesn't change TMDS rate at
> all. At this point it is not clear whether it is just not necessary or
> it would cause some kind of issues.
>
> Add a quirk for it.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
