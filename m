Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6A9C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E194620817
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 15:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E194620817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeKRCJp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:09:45 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:33689 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeKRCJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:09:45 -0500
Received: by mail-ot1-f67.google.com with SMTP id i20so17628980otl.0;
        Sat, 17 Nov 2018 07:52:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=T9Vo9y+vFveuqlyEMuD8/dGhN9iOrwwiPFbZloSn65E=;
        b=br0vM056rSiytDp3fpG7mcgYQ42efzLB9ZTGMZnZXW15wCw0t/AfqRIpA7Jp3bSXAd
         PGeboRiMOS+Wy1S/qAqeOsujDJuJfhBTM71TT0UlKerPCOYQtAGPSOzOp/6T5qtwdpTT
         9i92LrgXlvJKOgb1oYH1h+1MiaAh60si4y6SgY62G7UNzk4otFHR94alNapiwAxp21Lc
         Txr5vViyIBQgX8bW70SS9WkGAO/TJzBQRHyiimvWtrdFQzbFnag/bjOOFtuqAESAdg+x
         BPMa3hYvM7lYoUri+It+F1CmBihvwPxStjJVWkTtoSAyyn3V9fxZ2rpjylp10P4Px2Wz
         A8fQ==
X-Gm-Message-State: AGRZ1gLEiSWyhgbi3fFhtF2iX5eMl13ZLAGnYovtB+EQp1Un4HRrO+Sa
        /Rwa9/bgEfVGknyQzWMxCRKSQp4=
X-Google-Smtp-Source: AJdET5dfZDyzC1qa7wzWxQ0IZ2cHohWyBFY4idrbwWPNTHY6Og2y8FCKDWe7bsJmEoOcIREBMlh66A==
X-Received: by 2002:a9d:5263:: with SMTP id q35mr8360348otg.129.1542469960007;
        Sat, 17 Nov 2018 07:52:40 -0800 (PST)
Received: from localhost ([166.137.105.180])
        by smtp.gmail.com with ESMTPSA id k132-v6sm11555408oia.46.2018.11.17.07.52.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Nov 2018 07:52:39 -0800 (PST)
Date:   Sat, 17 Nov 2018 09:52:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     khilman@baylibre.com, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: amlogic: Add Internal Clock Measurer
  bindings
Message-ID: <20181117155237.GA17417@bogus>
References: <20181114131627.17766-1-narmstrong@baylibre.com>
 <20181114131627.17766-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181114131627.17766-2-narmstrong@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Nov 2018 14:16:25 +0100, Neil Armstrong wrote:
> The Amlogic Meson GX SoCs embeds a clock measurer IP to measure the internal
> clock paths frequencies.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/soc/amlogic/clk-measure.txt          | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/amlogic/clk-measure.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
