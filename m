Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4490C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F53D260BD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 20:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F53D260BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=boehmwalder.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755708AbeFYUMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 16:12:51 -0400
Received: from zimbra.linuxprofi.at ([93.83.54.199]:51222 "EHLO
        zimbra.linuxprofi.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751745AbeFYUMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 16:12:49 -0400
X-Greylist: delayed 468 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jun 2018 16:12:48 EDT
Received: from localhost (localhost [127.0.0.1])
        by zimbra.linuxprofi.at (Postfix) with ESMTP id 7840B2A4848;
        Mon, 25 Jun 2018 22:05:00 +0200 (CEST)
Received: from zimbra.linuxprofi.at ([127.0.0.1])
        by localhost (zimbra.linuxprofi.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id u0F3Di_bc1DH; Mon, 25 Jun 2018 22:04:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.linuxprofi.at (Postfix) with ESMTP id CBE822A4849;
        Mon, 25 Jun 2018 22:04:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at zimbra.linuxprofi.at
Received: from zimbra.linuxprofi.at ([127.0.0.1])
        by localhost (zimbra.linuxprofi.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FWIv6RV-JS1A; Mon, 25 Jun 2018 22:04:59 +0200 (CEST)
Received: from localhost (unknown [193.170.135.207])
        by zimbra.linuxprofi.at (Postfix) with ESMTPSA id 894232A4848;
        Mon, 25 Jun 2018 22:04:59 +0200 (CEST)
Date:   Mon, 25 Jun 2018 22:04:48 +0200
From:   Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph@boehmwalder.at>
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, shorne@gmail.com
Subject: Re: [PATCH 2/3] dt-bindings: interrupt-controller: RISC-V local
 interrupt controller docs
Message-ID: <20180625200448.26fvdv2tj3etmtlp@localhost>
Mail-Followup-To: Palmer Dabbelt <palmer@sifive.com>, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, shorne@gmail.com
References: <20180622232006.12158-1-palmer@sifive.com>
 <20180622232006.12158-3-palmer@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180622232006.12158-3-palmer@sifive.com>
User-Agent: NeoMutt/20180622-44-69ffa4
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

Spotted a typo here, "show" -> "shown".

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

Also, I've noticed that double spaces after punctuation are used pretty
inconsistently throughout the document. Is that intended?

--
Regards,
Christoph
