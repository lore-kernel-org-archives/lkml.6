Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1155EC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C575F2756D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 19:21:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C575F2756D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755608AbeF2TVD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 15:21:03 -0400
Received: from mailoutvs11.siol.net ([185.57.226.202]:51711 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753865AbeF2TVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 15:21:02 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTP id DB80E5224A2;
        Fri, 29 Jun 2018 21:20:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta10.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta10.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id MJu36op5NJ-9; Fri, 29 Jun 2018 21:20:59 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Postfix) with ESMTPS id 70B89522F6C;
        Fri, 29 Jun 2018 21:20:59 +0200 (CEST)
Received: from jernej-laptop.localnet (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Postfix) with ESMTPA id CCDEB5224A2;
        Fri, 29 Jun 2018 21:20:58 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [PATCH v3 16/24] drm/sun4i: Enable DW HDMI PHY clock
Date:   Fri, 29 Jun 2018 21:19:33 +0200
Message-ID: <3131254.YlICBQirlu@jernej-laptop>
In-Reply-To: <CAGb2v65En4RbVdRu7c6MJUztVhC36dWr0kaO9bqc9PtuXAcsww@mail.gmail.com>
References: <20180625120304.7543-1-jernej.skrabec@siol.net> <20180625120304.7543-17-jernej.skrabec@siol.net> <CAGb2v65En4RbVdRu7c6MJUztVhC36dWr0kaO9bqc9PtuXAcsww@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne četrtek, 28. junij 2018 ob 04:22:36 CEST je Chen-Yu Tsai napisal(a):
> On Mon, Jun 25, 2018 at 8:02 PM, Jernej Skrabec <jernej.skrabec@siol.net> 
wrote:
> > Current DW HDMI PHY code never prepares and enables PHY clock after it is
> > created. It's just used as it is. This may work in some cases, but it's
> > clearly wrong. Fix it by adding proper calls to enable/disable PHY
> > clock.
> > 
> > Fixes: 4f86e81748fe ("drm/sun4i: Add support for H3 HDMI PHY variant")
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> 
> So why does it work on the H3? Because there's only one PLL that the whole
> display pipeline uses?
> 
> We should probably tag this for stable. So,
> 
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Same question as before, how this should be handled? Can I send separate patch 
with same content to stable ML only?

Best regards,
Jernej



