Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932C6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BEF1208A4
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BEF1208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732258AbeGaVGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 17:06:14 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:44538 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728800AbeGaVGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 17:06:14 -0400
Received: by mail-io0-f193.google.com with SMTP id q19-v6so13984649ioh.11;
        Tue, 31 Jul 2018 12:24:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qmb/UXecqZylxNC8peIgoBMvM4L1Zn+exLAMN4c+Kwo=;
        b=GamYojeSIgZjE2H6lKwlwMdy4f60djz8++V0oxAVOR2gS6qUQELHN1x8CNe4KDR2Kg
         rHX0gbm410OL7c6TppuIeLvQQZP38wP0OgG8hmEFvfRbvpYUixo/XpGnrU+c4h5vX2oW
         oTUQQf1Kt8y1bqs/g/oeKHAl356ywZffwoA13uZqPnLF1izfHcvD8uHKHymJ4JZNv4c6
         rqi2f2PCDkbCJJ6e8M0TWuRgDlhBzqoXXBPV3qWNY6HkQv2tFmX4pN2mZBXir0hfBpp/
         7ygyTf1RTjlQjqfZ47dsqE3/MDyCgWmFu0hTveOXrRbNigq3EA4MYS9ZP5uDxNA1EEzA
         LD+Q==
X-Gm-Message-State: AOUpUlHl7Wfd1jguroCTspGFw5PimFeLqbS85Yeiw1Q+oAZpTaORVuf3
        +EeGtZVfnPGeJnpSCEDB7w==
X-Google-Smtp-Source: AAOMgpcyXm6taM1zE9DvBv5+NOAtfjDCfR418MmlfBwL7RfJ6zKRaJ2iLxyaXOZjyL+PGA6peESyqg==
X-Received: by 2002:a6b:8d0b:: with SMTP id p11-v6mr852354iod.233.1533065067782;
        Tue, 31 Jul 2018 12:24:27 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id v5-v6sm1648601ite.20.2018.07.31.12.24.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 12:24:27 -0700 (PDT)
Date:   Tue, 31 Jul 2018 13:24:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Erin Lo <erin.lo@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
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
        linux-clk@vger.kernel.org, Weiyi Lu <weiyi.lu@mediatek.com>
Subject: Re: [PATCH v4 05/10] clk: mediatek: Add dt-bindings for MT8183 clocks
Message-ID: <20180731192426.GA8792@rob-hp-laptop>
References: <1533015487-60189-1-git-send-email-erin.lo@mediatek.com>
 <1533015487-60189-6-git-send-email-erin.lo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533015487-60189-6-git-send-email-erin.lo@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 01:38:02PM +0800, Erin Lo wrote:
> From: Weiyi Lu <weiyi.lu@mediatek.com>
> 
> Add MT8183 clock dt-bindings, include topckgen, apmixedsys,
> infracfg and subsystem clocks.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> ---
>  include/dt-bindings/clock/mt8183-clk.h | 413 +++++++++++++++++++++++++++++++++
>  1 file changed, 413 insertions(+)
>  create mode 100644 include/dt-bindings/clock/mt8183-clk.h
> 
> diff --git a/include/dt-bindings/clock/mt8183-clk.h b/include/dt-bindings/clock/mt8183-clk.h
> new file mode 100644
> index 0000000..bacad53
> --- /dev/null
> +++ b/include/dt-bindings/clock/mt8183-clk.h
> @@ -0,0 +1,413 @@
> +/* SPDX-License-Identifier: GPL-2.0

This should be a separate comment from the copyright. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> + *
> + * Copyright (c) 2018 MediaTek Inc.
> + * Author: Weiyi Lu <weiyi.lu@mediatek.com>
> + */
