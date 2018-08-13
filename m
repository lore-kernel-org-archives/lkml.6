Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19302C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:36:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD9A21737
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:36:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCD9A21737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbeHMSTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:19:36 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:37350 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbeHMSTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:19:35 -0400
Received: by mail-it0-f67.google.com with SMTP id h20-v6so14637859itf.2;
        Mon, 13 Aug 2018 08:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zvakiuoQz5AxFREQ99AOrHQkYK++ZkftqWSZ3afxqYA=;
        b=RIx5sdkepD9gQyAjNwAKfrKJZGqWWkNx/8mCWGEjDPYNXX8ei3kebQt4GVP/hX4mAy
         yeQCEMnSROqnB/rxDkVv9ixFQoduZbRu0tpGfHxwNXdJFWSMhXgf7ZAeRSvqnJdUV8Pu
         nzVcIN9okPru0YkGquiEBcJ0hPkMqQOMeZS041Bw/mftLsbYsnR3l6Q/avGW0RkCMiDp
         YoBigxk0LMFwN8Q/GSdqt8nAEM5OITOmDODEeMyt3/k2wfjswr4ql6HAF1VUNvezC89K
         B4t7TY5vpqi6YBKamgDTDZ4isM7BTAiZISCw4lBnpbExI0m8Mw+JaclKjba2EYQP2v+N
         +/Vw==
X-Gm-Message-State: AOUpUlE7sxzuQG6Gje3/TZ9+b9jlSaYBk5elN0CfjfHjAidul3QgpcxX
        UpjyA/FnC0Um3xBGx0T55w==
X-Google-Smtp-Source: AA+uWPzraMSYBp8CULdbJKoHROeRH+lcL0/cJF09qZ6UoHIVzSFQfD+ebTNgiagfzgJAXgN2kcMUEA==
X-Received: by 2002:a24:190c:: with SMTP id b12-v6mr11320097itb.79.1534174610426;
        Mon, 13 Aug 2018 08:36:50 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id v13-v6sm6562015ita.38.2018.08.13.08.36.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 08:36:49 -0700 (PDT)
Date:   Mon, 13 Aug 2018 09:36:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com, anup@brainfault.org,
        atish.patra@wdc.com, devicetree@vger.kernel.org,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, shorne@gmail.com,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: interrupt-controller: RISC-V local
 interrupt controller
Message-ID: <20180813153648.GA29089@rob-hp-laptop>
References: <20180809075602.989-1-hch@lst.de>
 <20180809075602.989-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809075602.989-2-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 09:56:00AM +0200, Christoph Hellwig wrote:
> From: Palmer Dabbelt <palmer@dabbelt.com>
> 
> Add documentation on the RISC-V local interrupt controller, which is a
> per-hart interrupt controller that manages all interrupts entering a
> RISC-V hart.  This interrupt controller is present on all RISC-V systems.
> 
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> [hch: minor cleanups]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  .../interrupt-controller/riscv,cpu-intc.txt   | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
> new file mode 100644
> index 000000000000..b0a8af51c388
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
> @@ -0,0 +1,44 @@
> +RISC-V Hart-Level Interrupt Controller (HLIC)
> +---------------------------------------------
> +
> +RISC-V cores include Control Status Registers (CSRs) which are local to each
> +CPU core (HART in RISC-V terminology) and can be read or written by software.
> +Some of these CSRs are used to control local interrupts connected to the core.
> +Every interrupt is ultimately routed through a hart's HLIC before it
> +interrupts that hart.
> +
> +The RISC-V supervisor ISA manual specifies three interrupt sources that are
> +attached to every HLIC: software interrupts, the timer interrupt, and external
> +interrupts.  Software interrupts are used to send IPIs between cores.  The
> +timer interrupt comes from an architecturally mandated real-time timer that is
> +controller via Supervisor Binary Interface (SBI) calls and CSR reads.  External

s/controller/controlled/

> +interrupts connect all other device interrupts to the HLIC, which are routed
> +via the platform-level interrupt controller (PLIC).
> +
> +All RISC-V systems that conform to the supervisor ISA specification are
> +required to have a HLIC with these three interrupt sources present.  Since the
> +interrupt map is defined by the ISA it's not listed in the HLIC's device tree
> +entry, though external interrupt controllers (like the PLIC, for example) will
> +need to define how their interrupts map to the relevant HLICs.  This means
> +a PLIC interrupt property will typically list the HLICs for all present HARTs
> +in the system.
> +
> +Required properties:
> +- compatible : "riscv,cpu-intc"
> +- #interrupt-cells : should be <1>

Given that there's only 3 sources and they are fixed(?), you should 
define the numbering of them here.

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
> +			compatible = "riscv,cpu-intc", "sifive,fu540-c000-cpu-intc";

The order here should be reversed (most specific first) and 
"sifive,fu540-c000-cpu-intc" needs to be listed above.

> +			interrupt-controller;
> +		};
> +	};
> -- 
> 2.18.0
> 
