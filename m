Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF528C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2CFA20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CFA20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754264AbeFTQAr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:00:47 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33992 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754303AbeFTQAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:00:43 -0400
Received: by mail-yb0-f193.google.com with SMTP id n23-v6so34651ybg.1;
        Wed, 20 Jun 2018 09:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FS/FV3/4tP7PaKbqz1ws3T9yuj5AFHtxj8thEurhfLU=;
        b=nTCchjtiiKcPYMgJ8r/ZZWthfq9x3/TrKSHeiG+C/AchqHBP7nVtNBP6Pih192nIcq
         NhAgbdnDbRoiALW3FmJWmSbXPS+WfvXnZIlq3o+8+s0214y2sdiMPAxENY0wUNijvbbF
         RGVu7sC57ZixxpFnFTo2+tq/dlZc44vkdL1VZti0Z69f9PhK3YoKFW1M7B4h+cwa+KQt
         YCzSHdggJw/TMK5vRzjVkkcs/Oxt09NOZMi2z1rbrhE7Ga+MH+hAj/iSCoaeTeyhAI1Z
         Xp+3eTnJh17UuCYQTraRwXxVHLFV5HIncqLQcaqITVBANuf5hJjwYbWCE6FEYMQJMweW
         Da/A==
X-Gm-Message-State: APt69E24MlfzIZMTv1WugQKTUB2Y8bzyv3FRkNvde6tDtFJ2AEzmrFow
        n/d//RwqPMsSxqylWohDVQ==
X-Google-Smtp-Source: ADUXVKLTkE/ihIQc9LnzHGBTlNZBcud1MzwqcxduVeYk6zCdPGbl3Elwyxii0x2WqbNbhYhqBGZTjw==
X-Received: by 2002:a25:cc94:: with SMTP id l142-v6mr6915623ybf.121.1529510442832;
        Wed, 20 Jun 2018 09:00:42 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id e142-v6sm1059160ywe.21.2018.06.20.09.00.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 09:00:42 -0700 (PDT)
Date:   Wed, 20 Jun 2018 10:00:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marco Franchi <marco.franchi@nxp.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tom Saeger <tom.saeger@oracle.com>,
        Smitha T Murthy <smitha.t@samsung.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "David S . Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Todor Tomov <todor.tomov@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-sunxi@googlegroups.com,
        Hugues Fruchet <hugues.fruchet@st.com>,
        Randy Li <ayaka@soulik.info>
Subject: Re: [PATCH v4 05/19] dt-bindings: sram: sunxi: Add A33 binding for
 the C1 SRAM region
Message-ID: <20180620160041.GA20371@rob-hp-laptop>
References: <20180618145843.14631-1-paul.kocialkowski@bootlin.com>
 <20180618145843.14631-6-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618145843.14631-6-paul.kocialkowski@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 04:58:29PM +0200, Paul Kocialkowski wrote:
> This introduces a dedicated binding for the C1 SRAM region for the A33
> sunxi platform.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Acked-by: Rob Herring <robh@kernel.org>
