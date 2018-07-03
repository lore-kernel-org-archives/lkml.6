Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D64DC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4047921E17
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4047921E17
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753022AbeGCUK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:10:56 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:41206 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752898AbeGCUKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:10:53 -0400
Received: by mail-yb0-f195.google.com with SMTP id s8-v6so1215022ybe.8;
        Tue, 03 Jul 2018 13:10:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hUJ+nv2CU2CNAJE3+tm+gABWkwDjDbMl0OiwQfwWQN8=;
        b=WOcxDWn0wEfKktWzFkZUzQvczu45gHAHTx9gkCfZrn1M1vPh2Cb5/fDVRDGiC+BmJY
         2uSujeosVJQmdZbRl/v9ddf8NXEwFLAAwK4NXf0MQFHqY95aK1M5AgZ3gmAzJuXGm2B6
         MEuX8OSUgo0GdDeJu4eHn5jmXiFxYO08O8cfDa+B4dkigKuReeogbqXDFBLo/0ZMWflV
         6XXnpMgETrwLbQ/arcZoYR6vF1H9j+1J+o79Ro5hNwQhrG2ENWRig+6G/mbTe2E2C35x
         8iekJT1Vg5+zvg17U0Ie2NDbWX+Ek5cUUt1lhiahHOK2lClaLw9hSCB3khkrH8Xu759Q
         nHRA==
X-Gm-Message-State: APt69E0KANjISAQbJB8Bsuy2pTvN3W/29eraL4cfWAwSzVBv84t23H1D
        v93mozwaYxCIYcCouf3RCA==
X-Google-Smtp-Source: ADUXVKJGDrQjpWltU7TKmmbA2E/Ms4MQFsrfURvECdf2b3nM0+fAdcyLPJ/jmknLjVNfV8yagvCi3w==
X-Received: by 2002:a25:7141:: with SMTP id m62-v6mr16787594ybc.422.1530648652604;
        Tue, 03 Jul 2018 13:10:52 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id l14-v6sm677642ywi.35.2018.07.03.13.10.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 13:10:51 -0700 (PDT)
Date:   Tue, 3 Jul 2018 14:10:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        mark.rutland@arm.com, aou@eecs.berkeley.edu, shorne@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 2/3] dt-bindings: interrupt-controller: RISC-V local
 interrupt controller docs
Message-ID: <20180703201048.GA20288@rob-hp-laptop>
References: <20180622232006.12158-1-palmer@sifive.com>
 <20180622232006.12158-3-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622232006.12158-3-palmer@sifive.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 22, 2018 at 04:20:05PM -0700, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@dabbelt.com>
> 
> This patch adds documentation on the RISC-V local interrupt controller,
> which is a per-hart interrupt controller that manages all interrupts
> entering a RISC-V hart.  This interrupt controller is present on all
> RISC-V systems.
> 
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> ---
>  .../interrupt-controller/riscv,cpu-intc.txt        | 41 ++++++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
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

What are the PLIC to HLIC connections you need to support? 1-to-1 is 
easy. But I would imagine you'd want the PLIC irq to go to all the HLICs 
which can't really be described unless you list every CPU's HLIC in 
PLIC "interrupts" property.

We avoid this problem on ARM because a single DT interrupt controller 
node represents even per cpu interrupts and interrupt cells are used to 
indicate which CPU interrupts are routed too. That's not perfect either, 
but seems to be good enough (though maybe Marc Z or Mark R have more 
thoughts on that).

> +
> +Required properties:
> +- compatible : "riscv,cpu-intc"

Kind of vague. There's only one implementation and one set of bugs?

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
> 2.16.4
> 
