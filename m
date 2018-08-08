Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD5FEC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 799EF219C9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 14:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jArZCS/O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 799EF219C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbeHHQt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:49:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727050AbeHHQt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:49:58 -0400
Received: from mail-qk0-f170.google.com (mail-qk0-f170.google.com [209.85.220.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DEAA21A13;
        Wed,  8 Aug 2018 14:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533738603;
        bh=YWpKQhgDdf5MyiJ6gjuLONPaSMbqxMgILKse+iaXbfs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jArZCS/OailRyXEhRK0iQGXUHq5YpqZdjoQ32AqmgDLtnrjsOnwvBMUL/bVb9nBQf
         sdd7iAfO+HkFaL06uFz24F1mUHv33zbj6symCgxhh9FusqoaGnzU0T+/ZjTtCvZxeB
         DQvV+WdT86kMI7HP5Cz9ci0zvGmJWybZl/+0/9/M=
Received: by mail-qk0-f170.google.com with SMTP id u21-v6so1650628qku.2;
        Wed, 08 Aug 2018 07:30:03 -0700 (PDT)
X-Gm-Message-State: AOUpUlEiissPGWIfMv9LguEtpmnklWihjQBrXQlCtWO+30KdKSw7e9Jm
        G/gXYmGfUEzMwf2Yc9TDTiQzp64Ywo8kDX11/Q==
X-Google-Smtp-Source: AA+uWPxz8cB0/08Zhhl26rkGPXydhg6673EyJ7heyzglIKQrM3PfbMSSp40lHNok8p+l3OXSBOCwxTIdoNMIg46ZfiY=
X-Received: by 2002:a37:1a69:: with SMTP id a102-v6mr2764474qka.43.1533738602298;
 Wed, 08 Aug 2018 07:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20180804082319.5711-1-hch@lst.de> <20180804082319.5711-7-hch@lst.de>
In-Reply-To: <20180804082319.5711-7-hch@lst.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 8 Aug 2018 08:29:50 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKKCPhb1um_+68ya0ng_v2tSb5O+-8RQPqx7Od3sJ4FuA@mail.gmail.com>
Message-ID: <CAL_JsqKKCPhb1um_+68ya0ng_v2tSb5O+-8RQPqx7Od3sJ4FuA@mail.gmail.com>
Subject: Re: [PATCH 6/8] dt-bindings: interrupt-controller: RISC-V PLIC documentation
To:     Christoph Hellwig <hch@lst.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Anup Patel <anup@brainfault.org>, atish.patra@wdc.com,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Stafford Horne <shorne@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 4, 2018 at 2:23 AM Christoph Hellwig <hch@lst.de> wrote:
>
> From: Palmer Dabbelt <palmer@dabbelt.com>

Version numbers on the individual patches would be nice...

> This patch adds documentation for the platform-level interrupt
> controller (PLIC) found in all RISC-V systems.  This interrupt
> controller routes interrupts from all the devices in the system to each
> hart-local interrupt controller.
>
> Note: the DTS bindings for the PLIC aren't set in stone yet, as we might
> want to change how we're specifying holes in the hart list.
>
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> [hch: various fixes and updates]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  .../interrupt-controller/sifive,plic0.txt     | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
> new file mode 100644
> index 000000000000..bbfa61cf8d3f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
> @@ -0,0 +1,57 @@
> +SiFive Platform-Level Interrupt Controller (PLIC)
> +-------------------------------------------------
> +
> +SiFive SOCs include an implementation of the Platform-Level Interrupt Controller
> +(PLIC) high-level specification in the RISC-V Privileged Architecture
> +specification.  The PLIC connects all external interrupts in the system to all
> +hart contexts in the system, via the external interrupt source in each hart.
> +
> +A hart context is a privilege mode in a hardware execution thread.  For example,
> +in an 4 core system with 2-way SMT, you have 8 harts and probably at least two
> +privilege modes per hart; machine mode and supervisor mode.
> +
> +Each interrupt can be enabled on per-context basis.  Any context can claim
> +a pending enabled interrupt and then release it once it has been handled.
> +
> +Each interrupt has a configurable priority.  Higher priority interrupts are
> +serviced first.  Each context can specify a priority threshold. Interrupts
> +with priority below this threshold will not cause the PLIC to raise its
> +interrupt line leading to the context.
> +
> +While the PLIC supports both edge-triggered and level-triggered interrupts,
> +interrupt handlers are oblivious to this distinction and therefore it is not
> +specified in the PLIC device-tree binding.
> +
> +While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
> +"sifive,plic0" device is a concrete implementation of the PLIC that contains a
> +specific memory layout, which is documented in chapter 8 of the SiFive U5
> +Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
> +
> +Required properties:
> +- compatible : "sifive,plic0".
> +- #address-cells : should be <0>.
> +- #interrupt-cells : should be <1>.
> +- interrupt-controller : Identifies the node as an interrupt controller.
> +- reg : Should contain 1 register range (address and length).
> +- interrupts-extended : Specifies which contexts are connected to the PLIC,
> +  with "-1" specifying that a context is not present.  The nodes pointed
> +  to should be "riscv" HART nodes, or eventually be parented by such nodes.
> +- riscv,ndev: Specifies how many external interrupts are supported by
> +  this controller.
> +
> +Example:
> +
> +       plic: interrupt-controller@c000000 {
> +               #address-cells = <0>;
> +               #interrupt-cells = <1>;
> +               compatible = "riscv,plic0";
> +               interrupt-controller;
> +               interrupts-extended = <
> +                       &cpu0-intc 11
> +                       &cpu1-intc 11 &cpu1-intc 9
> +                       &cpu2-intc 11 &cpu2-intc 9
> +                       &cpu3-intc 11 &cpu3-intc 9
> +                       &cpu4-intc 11 &cpu4-intc 9>;

I'm confused why this is still here if you are dropping the cpu intc binding?

I also noticed the cpu binding refers to "riscv,cpu-intc" as well.
That needs to be fixed too if there's a change.

Rob
