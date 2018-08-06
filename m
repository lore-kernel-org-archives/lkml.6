Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6740FC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AE7021A15
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 21:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ToDj4QPc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AE7021A15
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732904AbeHFXKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 19:10:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728948AbeHFXKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 19:10:52 -0400
Received: from mail-qt0-f174.google.com (mail-qt0-f174.google.com [209.85.216.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A87721A68;
        Mon,  6 Aug 2018 21:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533589200;
        bh=MwvW5WpIc/LjsJovzPH/63lF7zAHWAQQTLLHsJVVhRo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ToDj4QPcq7AR8xdFF40V+om/7kU2JuAwmOy/W2FiZMvVTYh0jcMrSXeirgWwA2jmv
         6xuIQNLQMQMI46+yQu9hm4POk/d01vNC9ZCsIPPRpqMO9VZZgP4rn6BXSM7C0pERmE
         YwqvzYD/EuejFe0v3Mk3TWHbL6hoVi6WtCWzwj1M=
Received: by mail-qt0-f174.google.com with SMTP id f18-v6so15494475qtp.10;
        Mon, 06 Aug 2018 14:00:00 -0700 (PDT)
X-Gm-Message-State: AOUpUlG/4mTivWOWKVZP5biu//WL8nSCSVIfJmKQZvr4bReqGew0GGKZ
        /sfB2+2wg1crcvm52L690JvcFbsy0InJhH3Q/Q==
X-Google-Smtp-Source: AAOMgpfeCEOVl59QYgfuW7LaHSHnJwGuyaIr+byeXG6sHQQap8kTdbRwenEfG/gC4K2IF9Lm24n1GRs/2DaS1cIIMIA=
X-Received: by 2002:ac8:29a4:: with SMTP id 33-v6mr16692594qts.354.1533589199254;
 Mon, 06 Aug 2018 13:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180802115008.4031-1-hch@lst.de> <20180802115008.4031-4-hch@lst.de>
 <0093fadc-a150-3745-e73d-e579bfdfabfb@wdc.com>
In-Reply-To: <0093fadc-a150-3745-e73d-e579bfdfabfb@wdc.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 6 Aug 2018 14:59:48 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+pVzqKUbhErRr15JX2mPUOSTp_ddGvu9KAuf=TtXfduQ@mail.gmail.com>
Message-ID: <CAL_Jsq+pVzqKUbhErRr15JX2mPUOSTp_ddGvu9KAuf=TtXfduQ@mail.gmail.com>
Subject: Re: [PATCH 03/11] dt-bindings: interrupt-controller: RISC-V PLIC documentation
To:     atish.patra@wdc.com
Cc:     Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Stafford Horne <shorne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 4:08 PM Atish Patra <atish.patra@wdc.com> wrote:
>
> On 8/2/18 4:50 AM, Christoph Hellwig wrote:
> > From: Palmer Dabbelt <palmer@dabbelt.com>
> >
> > This patch adds documentation for the platform-level interrupt
> > controller (PLIC) found in all RISC-V systems.  This interrupt
> > controller routes interrupts from all the devices in the system to each
> > hart-local interrupt controller.
> >
> > Note: the DTS bindings for the PLIC aren't set in stone yet, as we might
> > want to change how we're specifying holes in the hart list.
> >
> > Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> > [hch: various fixes and updates]
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >   .../interrupt-controller/sifive,plic0.txt     | 57 +++++++++++++++++++
> >   1 file changed, 57 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
> > new file mode 100644
> > index 000000000000..c756cd208a93
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
> > @@ -0,0 +1,57 @@
> > +SiFive Platform-Level Interrupt Controller (PLIC)
> > +-------------------------------------------------
> > +
> > +SiFive SOCs include an implementation of the Platform-Level Interrupt Controller
> > +(PLIC) high-level specification in the RISC-V Privileged Architecture
> > +specification.  The PLIC connects all external interrupts in the system to all
> > +hart contexts in the system, via the external interrupt source in each hart.
> > +
> > +A hart context is a privilege mode in a hardware execution thread.  For example,
> > +in an 4 core system with 2-way SMT, you have 8 harts and probably at least two
> > +privilege modes per hart; machine mode and supervisor mode.
> > +
> > +Each interrupt can be enabled on per-context basis. Any context can claim
> > +a pending enabled interrupt and then release it once it has been handled.
> > +
> > +Each interrupt has a configurable priority. Higher priority interrupts are
> > +serviced first. Each context can specify a priority threshold. Interrupts
> > +with priority below this threshold will not cause the PLIC to raise its
> > +interrupt line leading to the context.
> > +
> > +While the PLIC supports both edge-triggered and level-triggered interrupts,
> > +interrupt handlers are oblivious to this distinction and therefore it is not
> > +specified in the PLIC device-tree binding.
> > +
> > +While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
> > +"sifive,plic0" device is a concrete implementation of the PLIC that contains a
> > +specific memory layout, which is documented in chapter 8 of the SiFive U5
> > +Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
> > +
> > +Required properties:
> > +- compatible : "sifive,plic0"
> > +- #address-cells : should be <0>
> > +- #interrupt-cells : should be <1>
> > +- interrupt-controller : Identifies the node as an interrupt controller
> > +- reg : Should contain 1 register range (address and length)
>
> The one in the real device tree has two entries.
> reg = <0x00000000 0x0c000000 0x00000000 0x04000000>;
>
> Is it intentional or just incorrect entry left over from earlier days?

> > +             reg = <0xc000000 0x4000000>;

Looks to me like one has #size-cells and #address-cells set to 2 and
the example is using 1.

Rob
