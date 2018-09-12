Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE222C46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A65920866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 12:26:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A65920866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727161AbeILRaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 13:30:20 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39545 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbeILRaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 13:30:19 -0400
Received: by mail-ed1-f65.google.com with SMTP id h4-v6so1599451edi.6;
        Wed, 12 Sep 2018 05:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OM4mBBaMvjpne+FWAwTOFKeUU2ofE7tQLZRDPYyIve4=;
        b=pidtKXx7CiATR6kxI/yP9VgsRrfkngz37hCJ4Pxq4H/dmAb+6icKeAMfBIB5Kyvs3C
         a+toNdKKkLZ5rwrWCBnfEYdLogzqy7Z10lEMs72oddw4l08r1mOHifPCeH6dZD8K2e4c
         DLKYo9ydJct6NSA0t5t1uk5uy5pH1c0woSUP4GOyLV2rDeLVwQ+mEcemvUNL9/7E1UBc
         KQGhhWgGV2IxpPPnvovoWOYaNJoFCVp7EBF6OLsrJyELp6ogMsPz+cLlPBT6mQBwpwF5
         lDDLy6TbhQ16GoBKDX8zoKL0E+/k2b3M2mXS02kD0f63QOaA8rBE/+XKUTNlu8ich9AT
         LDFQ==
X-Gm-Message-State: APzg51BO2uhM6KynnezpHoQqPvpUmzsCjEB66FG+eBHbIV/VNa2pVnhr
        DApSylabNwlJ+b9P89cJGVUPMtLeNS4=
X-Google-Smtp-Source: ANB0VdbdCF0fc4SjP9lRLq3D3Wb7IWdryQbGJtpd0q0bnlSdCV3GcBhV1uBFMjwYnkb4v7gRqS+BeQ==
X-Received: by 2002:aa7:d78c:: with SMTP id s12-v6mr2375113edq.69.1536755160000;
        Wed, 12 Sep 2018 05:26:00 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id c24-v6sm468416ede.53.2018.09.12.05.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 05:25:59 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id j26-v6so1842014wre.2;
        Wed, 12 Sep 2018 05:25:58 -0700 (PDT)
X-Received: by 2002:adf:d245:: with SMTP id o5-v6mr1371930wri.91.1536755158760;
 Wed, 12 Sep 2018 05:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180902072643.4917-1-jernej.skrabec@siol.net> <20180902072643.4917-16-jernej.skrabec@siol.net>
In-Reply-To: <20180902072643.4917-16-jernej.skrabec@siol.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Wed, 12 Sep 2018 20:25:44 +0800
X-Gmail-Original-Message-ID: <CAGb2v66qrZG=RH9SYs7ZeZdhfcq+4sT47Y1dDQaeS1QBcEZXvg@mail.gmail.com>
Message-ID: <CAGb2v66qrZG=RH9SYs7ZeZdhfcq+4sT47Y1dDQaeS1QBcEZXvg@mail.gmail.com>
Subject: Re: [PATCH 15/27] drm/sun4i: Not all DW HDMI controllers has
 scrambled addresses
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
> Currently supported Allwinner SoCs with DW HDMI controller have
> scrambled addresses and read lock. However, that is not true in general.
> For example, A80 and H6 have normal addresses and normal read access.
>
> Move code for unscrambling addresses and unlocking read access to it's
> own function and call it from init function.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
