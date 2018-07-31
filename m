Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5022EC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5B52083E
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E5B52083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732769AbeHAA3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 20:29:05 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:42824 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731637AbeHAA3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 20:29:04 -0400
Received: by mail-io0-f194.google.com with SMTP id g11-v6so14460592ioq.9;
        Tue, 31 Jul 2018 15:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0GSyw6So1ZUz6/wjB/2yqHo+LxE26c9lLgFJOw4S2Os=;
        b=hWpozF9BGVvtB7ZJpyikylgcxbyW4cv85XKtl5Vvuv6W1wDP1X5O7H2y5ak35O2G3j
         pllmJrDdKpoE6TRRviDnC00ZeFnK1G/aJuPwys5XqdkZHQzPjRF0h0LduEaIDg5aa3lv
         UExLhEYBaDMmBgvfWg2EAgNCvNMtZrwfd2voAKsiKzWgFEM8MYKxikuhb/WgQO4ueH38
         X1pki4Z8CXsp4raA4cWcS3VoD6bTBXoraF7Ihd0gxLOOQis0BEF22MPfwvp8lQU7we0y
         VYlIdJaz2Qx+vfPsNXhWgkFPXHsXbGYEBOZKFp6PglyzFUgxmUWiTSzTq4JDFi6oA/jW
         kvEw==
X-Gm-Message-State: AOUpUlF+xBUmbJ1mQ2p3C0f8HrGngseNpHvnGR9JCGlKG+Dr897xRh4P
        /PHsXk6QLsCscDhk7MTs6g==
X-Google-Smtp-Source: AAOMgpftyI79kgyhclyd+zjfwBoB2ASrmTu8OtuOTNXhgEZy/MKkBKNkF263MBupQTQFk6mYdJ128A==
X-Received: by 2002:a5e:8b4c:: with SMTP id z12-v6mr1324624iom.230.1533077191717;
        Tue, 31 Jul 2018 15:46:31 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id y25-v6sm2151210ita.17.2018.07.31.15.46.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 15:46:31 -0700 (PDT)
Date:   Tue, 31 Jul 2018 16:46:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     tglx@linutronix.de, palmer@sifive.com, jason@lakedaemon.net,
        marc.zyngier@arm.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com, Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 6/6] dt-bindings: interrupt-controller: RISC-V PLIC
 documentation
Message-ID: <20180731224630.GB12168@rob-hp-laptop>
References: <20180725093649.32332-1-hch@lst.de>
 <20180725093649.32332-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180725093649.32332-7-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 25, 2018 at 11:36:49AM +0200, Christoph Hellwig wrote:
> From: Palmer Dabbelt <palmer@dabbelt.com>
> 
> This patch adds documentation for the platform-level interrupt
> controller (PLIC) found in all RISC-V systems.  This interrupt
> controller routes interrupts from all the devices in the system to each
> hart-local interrupt controller.
> 
> Note: the DTS bindings for the PLIC aren't set in stone yet, as we might
> want to change how we're specifying holes in the hart list.
> 
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> ---
>  .../interrupt-controller/riscv,plic0.txt      | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,plic0.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,plic0.txt b/Documentation/devicetree/bindings/interrupt-controller/riscv,plic0.txt
> new file mode 100644
> index 000000000000..99cd359dbd43
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,plic0.txt
> @@ -0,0 +1,55 @@
> +RISC-V Platform-Level Interrupt Controller (PLIC)
> +-------------------------------------------------
> +
> +The RISC-V supervisor ISA specification allows for the presence of a
> +platform-level interrupt controller (PLIC).   The PLIC connects all external
> +interrupts in the system to all hart contexts in the system, via the external
> +interrupt source in each hart's hart-local interrupt controller (HLIC).  A hart
> +context is a privilege mode in a hardware execution thread.  For example, in
> +an 4 core system with 2-way SMT, you have 8 harts and probably at least two
> +privilege modes per hart; machine mode and supervisor mode.
> +
> +Each interrupt can be enabled on per-context basis. Any context can claim
> +a pending enabled interrupt and then release it once it has been handled.
> +
> +Each interrupt has a configurable priority. Higher priority interrupts are
> +serviced firs. Each context can specify a priority threshold. Interrupts
> +with priority below this threshold will not cause the PLIC to raise its
> +interrupt line leading to the context.
> +
> +While the PLIC supports both edge-triggered and level-triggered interrupts,
> +interrupt handlers are oblivious to this distinction and therefor it is not
> +specific in the PLIC device-tree binding.
> +
> +While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
> +"riscv,plic0" device is a concrete implementation of the PLIC that contains a
> +specific memory layout.  More details about the memory layout of the
> +"riscv,plic0" device can be found as a comment in the device driver, or as part
> +of the SiFive U5 Coreplex Series Manual (page 22 of the PDF of version 1.0)
> +<https://www.sifive.com/documentation/coreplex/u5-coreplex-series-manual/>
> +
> +Required properties:
> +- compatible : "riscv,plic0"

Perhaps this should be 'sifive,plic0'

Normally this would have an SoC specific compatible too. Sometimes we 
can get away without, but it doesn't seem like the PLIC is very tightly 
specified nor has common implementations.

> +- #address-cells : should be <0>
> +- #interrupt-cells : should be <1>
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- reg : Should contain 1 register range (address and length)
> +- interrupts-extended : Specifies which contexts are connected to the PLIC,
> +  with "-1" specifying that a context is not present.
> +
> +Example:
> +
> +	plic: interrupt-controller@c000000 {
> +		#address-cells = <0>;
> +		#interrupt-cells = <1>;
> +		compatible = "riscv,plic0";
> +		interrupt-controller;
> +		interrupts-extended = <
> +			&cpu0-intc 11
> +			&cpu1-intc 11 &cpu1-intc 9
> +			&cpu2-intc 11 &cpu2-intc 9
> +			&cpu3-intc 11 &cpu3-intc 9
> +			&cpu4-intc 11 &cpu4-intc 9>;
> +		reg = <0xc000000 0x4000000>;
> +		riscv,ndev = <10>;

Not documented.

> +	};
> -- 
> 2.18.0
> 
