Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EDBC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0687520846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0687520846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754541AbeFTSMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:12:50 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:41436 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754361AbeFTSMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:12:48 -0400
Received: by mail-yb0-f194.google.com with SMTP id e16-v6so183801ybh.8;
        Wed, 20 Jun 2018 11:12:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PAWSGIPNJkeWX3wTHDc8nGwBWj9Ur8/2QU8n+oz9kQs=;
        b=GZeKOiK1dARiJyUJsk+6zctiGO9IOcTKHuCL7BLpbMWLLgzCDSuUv0KFsyOxAtftPm
         ttx7kiFk+HmzN59+kSD5oNukJzjow0vasQGQXnpQYW1q6Lq8sWuyDpnlvTANy/rtR2UP
         p9kvzeT2Q1cGu8Fjf0NP1/DSLD7IItrwOuLDQLvOXCdRyNgbFiYEef1VVMOXlsUPjHkK
         +6oIXQQ068dVSPDncLB0ytIKJd3DG3n0E7FNRJftvZ3yYeDGExt2a9PP5+6E39Fkhkrk
         zNC/NjE8Le9NL+Gbxr5SnN7EEobMxSb41mpMCPGr3ikhnqCjeXZgUgCh+iJG+J08OCa2
         +brQ==
X-Gm-Message-State: APt69E2sC/Xc21fKfqu9mXqHOvCj93gWP8NoqFY6b+uIuU2Yd9TmFubN
        0MU7Jb9Om1WujwAtv3A3w45pKbA=
X-Google-Smtp-Source: ADUXVKKPM8xOzmgtGFBOLRN1FGakxfO+eI6sy5Mv372JNx+vORKwq83BrzZ5Ge0Zdw3n1mN5G6bvwQ==
X-Received: by 2002:a25:9392:: with SMTP id a18-v6mr10981122ybm.327.1529518367228;
        Wed, 20 Jun 2018 11:12:47 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id r9-v6sm1015262ywl.59.2018.06.20.11.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 11:12:46 -0700 (PDT)
Date:   Wed, 20 Jun 2018 12:12:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-mtd@lists.infradead.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        linux-kbuild@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        "linux-stable #4 . 14+" <stable@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marek.vasut@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 1/3] mtd: rawnand: denali_dt: add more clocks based on
 IP datasheet
Message-ID: <20180620181245.GA30779@rob-hp-laptop>
References: <1529025532-22087-1-git-send-email-yamada.masahiro@socionext.com>
 <1529025532-22087-2-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529025532-22087-2-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 10:18:50AM +0900, Masahiro Yamada wrote:
> According to the Denali User's Guide, this IP needs three clocks:
> 
>  - clk: controller core clock
> 
>  - clk_x: bus interface clock
> 
>  - ecc_clk: clock at which ECC circuitry is run
> 
> Currently, denali_dt.c requires a single anonymous clock and its
> frequency.  However, the driver needs to get the frequency of "clk_x"
> not "clk".  This is confusing because people tend to assume the
> anonymous clock means the core clock.  In fact, I got a report of
> SOCFPGA breakage because the timing parameters are calculated based
> on a wrong frequency.
> 
> Instead of the cheesy implementation, the clocks in the real hardware
> should be represented in the driver and the DT-binding.
> 
> However, adding new clocks would break the existing platforms.  For the
> backward compatibility, the driver still accepts a single clock just as
> before.  If clk_x is missing, clk_x_rate is set to a hardcoded value.
> This is fine for existing DT of Socionext UniPhier, and also fixes the
> issue of Altera (Intel) SOCFPGA because both platforms use 200 MHz for
> the bus interface clock.
> 
> Fixes: 1bb88666775e ("mtd: nand: denali: handle timing parameters by setup_data_interface()")
> Cc: linux-stable <stable@vger.kernel.org> #4.14+
> Reported-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v3:
>   - Change the patch order so that the bug-fix one comes the first
> 
> Changes in v2:
>   - Split patches into sensible chunks
> 
>  .../devicetree/bindings/mtd/denali-nand.txt        |  5 +++
>  drivers/mtd/nand/raw/denali_dt.c                   | 49 ++++++++++++++++++++--
>  2 files changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/denali-nand.txt b/Documentation/devicetree/bindings/mtd/denali-nand.txt
> index 0ee8edb..f33da87 100644
> --- a/Documentation/devicetree/bindings/mtd/denali-nand.txt
> +++ b/Documentation/devicetree/bindings/mtd/denali-nand.txt
> @@ -8,6 +8,9 @@ Required properties:
>    - reg : should contain registers location and length for data and reg.
>    - reg-names: Should contain the reg names "nand_data" and "denali_reg"
>    - interrupts : The interrupt number.
> +  - clocks: should contain phandle of the controller core clock, the bus
> +    interface clock, and the ECC circuit clock.
> +  - clock-names: should contain "nand", "nand_x", "ecc"

The subject says "add more clocks", but it doesn't look like any clocks 
were supported before. Or documentation was missing?

Please split bindings to a separate patch.

Rob
