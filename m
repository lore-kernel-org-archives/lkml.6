Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935C0C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D31420E20
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:39:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D31420E20
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbeHTWzw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 18:55:52 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34308 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeHTWzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 18:55:52 -0400
Received: by mail-oi0-f65.google.com with SMTP id 13-v6so27923628ois.1;
        Mon, 20 Aug 2018 12:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VyQsR4kjJrUJ76zcPe+WaVd1Mgc7po2bcCmaW1//X7Y=;
        b=I45UbR9X+neSKnxvNcXmAxb/TbG6a+RzTRlkdzFXr6Pd8K/D795QpmOPYLC90fuC2M
         R0/FXFFa8g7VbamqxzTgPaXMo9kP9w8vFPFSWJUXLbfjQBoKOxMHPtjj6+Dg+ADDvtI6
         TAgbdDB+UT40bteV8A6pe1BoHFUb+8aJaOxQyNF3l9sUABjZtgycjODuVAVCt4vGYolN
         qBM6JtWXVBAVc6LOZPL1JxnKFrbwZrFUi8Jsq6KHClThj9192B1GOlAqCSpeiynU7Yac
         6CGzbE7z2+A5HRKSYkCyzWzS7cpCmz0AferwRpVggVN0QFx/69atmMZOODkrdqTKgIG9
         PamQ==
X-Gm-Message-State: AOUpUlFWDC68c0aFT4fnWyUwO5Ak0cN1y0Xc2tVFrB9QNlVGqIl4fmfm
        AEQNSJ155nff5pCGvnNC3Q==
X-Google-Smtp-Source: AA+uWPytuqNuWd4XPFYSsYrL/OxR9HD4Rzyg5WbVXROBPMXwBGsSf7F7/DZdLXBedaCGpUdlgNgB5g==
X-Received: by 2002:aca:401:: with SMTP id 1-v6mr14067682oie.28.1534793938751;
        Mon, 20 Aug 2018 12:38:58 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v202-v6sm10833308oie.47.2018.08.20.12.38.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 20 Aug 2018 12:38:58 -0700 (PDT)
Date:   Mon, 20 Aug 2018 14:38:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        orsonzhai@gmail.com, zhang.lyra@gmail.com,
        lanqing.liu@spreadtrum.com, baolin.wang@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: spi: Add Spreadtrum SPI controller
 documentation
Message-ID: <20180820193826.GA20541@bogus>
References: <a77a6bb8b3abf1c127014c78f71533c24afacd93.1534423916.git.baolin.wang@linaro.org>
 <53e9467b4b16911576bcfb71c50c108ea83a803c.1534423916.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53e9467b4b16911576bcfb71c50c108ea83a803c.1534423916.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2018 20:54:50 +0800, Baolin Wang wrote:
> From: Lanqing Liu <lanqing.liu@spreadtrum.com>
> 
> This patch adds the binding documentation for Spreadtrum SPI
> controller device.
> 
> Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v1:
>  - Remove the sprd,spi-interval property.
> ---
>  Documentation/devicetree/bindings/spi/spi-sprd.txt |   26 ++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-sprd.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
