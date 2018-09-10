Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA18C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8ABD2086A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 19:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8ABD2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeIKAvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 20:51:33 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37245 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbeIKAvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 20:51:33 -0400
Received: by mail-oi0-f65.google.com with SMTP id p84-v6so42638744oic.4;
        Mon, 10 Sep 2018 12:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jJe3i+MwIwG2gD986bstmAM6fMtJvBG7bzJYMKhgxHo=;
        b=dFRqWHsfxIWuSkgxTbLeBVUVmIb2oRimSwPhOUg/xzvjZcHJCWu5VjHmjdYZsDb2pb
         e6Zp9HuKblEJI8F3M0oom1n4FAC3FVvBlUZMiS+CZy+ykK8RIuXX4UHQU0gYic6rn+DS
         F9rq/a+g0Tf1l6Qz3OOGiLUMt5fcBb1cuCK0i03pDExlcgp2NVBnPbi6vBf3qfmBl8po
         hyKbQFknzvumlctke+SlTxMpbYT1NN9VLgPHBk+1U9GUP7ofp8vZRrHkdpfBDFPAADBL
         q3qcTJ1BKMvT3BCEmZAvLiDP1mUGycr7zle7pnLUkXOZ5QBuN84mdN7k1yL+3iYNJ8Vc
         htrQ==
X-Gm-Message-State: APzg51DegTRAwEEVApJcd0xkquNU52nD/pNxQzDCfXHG9UXmMILzwKU+
        h2RsgmIK6BxwRE5coTyb1vSvjEM=
X-Google-Smtp-Source: ANB0VdarLEZjNpg/+CTCPG+g0D4EiLpTLd7/YSrQi7KyN0T+BhDJEoduS2QmD9/mezE6CZmQxIVdtg==
X-Received: by 2002:aca:efd7:: with SMTP id n206-v6mr24375353oih.70.1536609351372;
        Mon, 10 Sep 2018 12:55:51 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id i132-v6sm25093622oif.20.2018.09.10.12.55.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 10 Sep 2018 12:55:50 -0700 (PDT)
Date:   Mon, 10 Sep 2018 14:55:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, Kukjin Kim <kgene@kernel.org>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v3] dt-bindings: arm: Explicitly mark Samsung Exynos SoC
 as unstable
Message-ID: <20180910195550.GA29719@bogus>
References: <20180830180205.18121-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180830180205.18121-1-krzk@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 08:02:05PM +0200, Krzysztof Kozlowski wrote:
> Samsung Exynos SoCs and boards related bindings evolved since the initial
> introduction, but initially the bindings were minimal and a bit incomplete
> (they never described all the hardware modules available in the SoCs).
> Since then some significant (not fully compatible) changes have been
> already committed a few times (like gpio replaced by pinctrl, display ddc,
> mfc reserved memory, some core clocks added to various hardware modules,
> added more required nodes).
> 
> On the other side there are no boards which have device tree embedded in
> the bootloader. Device tree blob is always compiled from the kernel tree
> and updated together with the kernel image.
> 
> Thus to avoid further adding a bunch of workarounds for old/missing
> bindings, make development of new platforms easier and allow to make
> cleanup of the existing code and device tree files, lets mark some
> Samsung Exynos SoC platform bindings as unstable. This means that
> bindings can may change at any time and users should use the dtb file
> compiled from the same kernel source tree as the kernel image.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> [krzk: Explicitly list unstable bindings instead of marking entire
> Exynos]
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> 
> ---
> 
> Changes since v2:
> 1. Add tags.
> 
> Changes since v1:
> 1. Rebase
> 2. Add specific compatibles to mark unstable.
> 
> v1 is here:
> https://patchwork.kernel.org/patch/9477963/
> 
> Previous tags (not applying due to change in contents):
> Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  .../devicetree/bindings/arm/samsung/exynos.txt     | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos.txt

Feel free to take this thru the Samsung tree, but don't expect an ack 
from me.

Rob
