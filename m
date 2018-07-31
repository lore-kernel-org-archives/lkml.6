Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3503AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D5820894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:37:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2D5820894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732690AbeHAATq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 20:19:46 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:40230 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732649AbeHAATq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 20:19:46 -0400
Received: by mail-it0-f68.google.com with SMTP id h23-v6so6658969ita.5;
        Tue, 31 Jul 2018 15:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8A9IFqvUJjVsChVBVOp0LAMbEStsABcXzU9z+UMOfkY=;
        b=RzwZaKCfJnaiwGZMbX/tG9gZccjpbpZ8I2nzAY6Zf2ng/69GX/DEMtsoRw1u6EFlTg
         lFybG0/hAdb77IbYGftZ5ANhIcLgyFRHwC/V5DtBIx30Ymg22z+iHL85ZDpyNXtE4nJZ
         BDgRNhjOIihDrmQw+gtOywiEVl239u5K1C/UJfB3XDE4CQ6kd/jb0TF9Lq0/Sn6hxBAG
         MREhvY2lCT4R0iipewqqag+6O31EIe4hY4+kdcwkU4M9ljwHq1qF69VOSswvaN/AZlGI
         WQX9KkKmOTkLv4hnX+1P+Slo9bYJRJFOBVjoEUxwRevr1sNDm2bCSP4qCHxFHTAIbTqc
         1gFw==
X-Gm-Message-State: AOUpUlFK0ACVtp+95S7YIm+qmHT+cBkvDq2mCJxvdbOzRmTAP3/4S9NI
        Ke0SYKcUKR8hC8M1UOphwA==
X-Google-Smtp-Source: AAOMgpfzBZT0WgIy+JEOaPRiByBmw7bmIYAPWo6oJLVGdFLWfdUPKeoLc5YCvfdgnEDpumoV5fQNBA==
X-Received: by 2002:a24:118f:: with SMTP id 137-v6mr1462555itf.30.1533076636012;
        Tue, 31 Jul 2018 15:37:16 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id 125-v6sm2249210itm.29.2018.07.31.15.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 15:37:15 -0700 (PDT)
Date:   Tue, 31 Jul 2018 16:37:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 4/6] dt-bindings: interrupt-controller: RISC-V local
 interrupt controller docs
Message-ID: <20180731223714.GA12168@rob-hp-laptop>
References: <20180725093649.32332-1-hch@lst.de>
 <20180725093649.32332-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725093649.32332-5-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 11:36:47AM +0200, Christoph Hellwig wrote:
> From: Palmer Dabbelt <palmer@dabbelt.com>
> 
> This patch adds documentation on the RISC-V local interrupt controller,
> which is a per-hart interrupt controller that manages all interrupts
> entering a RISC-V hart.  This interrupt controller is present on all
> RISC-V systems.
> 
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> ---
>  .../interrupt-controller/riscv,cpu-intc.txt   | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt

My questions and comments on the prior version from Palmer remain.

> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
> new file mode 100644
> index 000000000000..61900e2e3868
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
> @@ -0,0 +1,41 @@
> +RISC-V Hart-Level Interrupt Controller (HLIC)
> +---------------------------------------------
> +
> +RISC-V cores include Control Status Registers (CSRs) which are local to each
> +hart and can be read or written by software. Some of these CSRs are used to
> +control local interrupts connected to the core.  Every interrupt is ultimately
> +routed through a hart's HLIC before it interrupts that hart.
> +
> +The RISC-V supervisor ISA manual specifies three interrupt sources that are
> +attached to every HLIC: software interrupts, the timer interrupt, and external
> +interrupts.  Software interrupts are used to send IPIs between cores.  The
> +timer interrupt comes from an architecturally mandated real-time timer that is
> +controller via SBI calls and CSR reads.  External interrupts connect all other
> +device interrupts to the HLIC, which are routed via the platform-level
> +interrupt controller (PLIC).
> +
> +All RISC-V systems that conform to the supervisor ISA specification are
> +required to have a HLIC with these three interrupt sources present.  Since the
> +interrupt map is defined by the ISA it's not listed in the HLIC's device tree
> +entry, though external interrupt controllers (like the PLIC, for example) will
> +need to define how their interrupts map to the relevant HLICs.
> +
> +Required properties:
> +- compatible : "riscv,cpu-intc"
> +- #interrupt-cells : should be <1>
> +- interrupt-controller : Identifies the node as an interrupt controller
> +
> +Furthermore, this interrupt-controller MUST be embedded inside the cpu
> +definition of the hart whose CSRs control these local interrupts.
> +
> +An example device tree entry for a HLIC is show below.
> +
> +	cpu1: cpu@1 {
> +		compatible = "riscv";
> +		...
> +		cpu1-intc: interrupt-controller {
> +			#interrupt-cells = <1>;
> +			compatible = "riscv,cpu-intc";
> +			interrupt-controller;
> +		};
> +	};
> -- 
> 2.18.0
> 
