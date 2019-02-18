Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF7FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B7DE21738
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 16:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550507631;
	bh=0q/kfWNKqGdkpY+YX5rZDiPKXLbEOK7j9UPuGWBuO3Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JqLFINFDuePpzh/rlUN3W4/liG/wbEBhfL0lyOVjt7RXkibQ92VxeMoXl6372J3K9
	 7bT2KmYWqOe5eAl32ImjXw47jKlYKDtF1UL3+/sUnv4X8lB90zb+UNylzbqkM6mn20
	 oZPl7Cu8PM7OXb+iWNDH6eL9qJ7iCJ91O09q2fdE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389686AbfBRQdu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 11:33:50 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38288 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732534AbfBRQdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 11:33:44 -0500
Received: by mail-ot1-f68.google.com with SMTP id m1so29272600otf.5;
        Mon, 18 Feb 2019 08:33:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/3OTtw+XimbN3zuGxZJlMD8HX9wbXSnJdqnMGNSEaO0=;
        b=XcO3FhMRzXSMMQ1Mv8N9XWGSJTiHNlx77PEQAL5H5S5FJx0/JIpqpJ6tMF66pCtaS8
         M0rUDYtGS2tWTHn0ttBdtwGpv4jFfQcUCV1n/D6XtQC2xCudLZil+OxP53bHJGCkoaME
         8TCZq2Mgpux5ptY/yFVaGrHQLtsXfCsmDwiK5URt0w9HjAVjSjrJgn6bbz7C7r0tlx0h
         pYTaP4L4PQ3VkUgrhRXbEAq8SwQxfKvrRgHLcf3zq0+KAAqqVttEad1kGhkVPxDDvgLJ
         TGBcxUAd6OGE2EwlVxwcpjY7SX0iIgRbbRJfYU30RTmKhvt4jd4giCbJHN4Lh9MaXkPv
         Luqw==
X-Gm-Message-State: AHQUAuYJvBV3jeXH06XnEoHwzEBNtvcR9sCquOrjRHXltqE9FhS/mevw
        v8OA2G7NZkOMCoFnb/tc0AXF9Ss=
X-Google-Smtp-Source: AHgI3Ia77PdVDQPtBsuUkPNc0UKt1rxr5mMlVLuVXmIc0fOQ927DI6NDVQ/XIZyfkht6kBngYUUVsw==
X-Received: by 2002:a9d:22a4:: with SMTP id y33mr3595921ota.218.1550507623523;
        Mon, 18 Feb 2019 08:33:43 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m84sm867636oig.49.2019.02.18.08.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Feb 2019 08:33:42 -0800 (PST)
Date:   Mon, 18 Feb 2019 10:33:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Erin Lo <erin.lo@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        devicetree@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, yingjoe.chen@mediatek.com,
        mars.cheng@mediatek.com, eddie.huang@mediatek.com,
        linux-clk@vger.kernel.org, Zhiyong Tao <zhiyong.tao@mediatek.com>
Subject: Re: [PATCH v7 5/6] arm64: dts: mt8183: add pintcrl file
Message-ID: <20190218163342.GA12014@bogus>
References: <1550210558-30516-1-git-send-email-erin.lo@mediatek.com>
 <1550210558-30516-6-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550210558-30516-6-git-send-email-erin.lo@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 02:02:37PM +0800, Erin Lo wrote:
> This patch adds pinctrl file for mt8183.
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h | 1120 +++++++++++++++++++++++++
>  1 file changed, 1120 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h b/arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h
> new file mode 100644
> index 0000000..768e41e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-pinfunc.h
> @@ -0,0 +1,1120 @@
> +// SPDX-License-Identifier: GPL-2.0

Run checkpatch. It will tell you that this should be /* */ comments.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
