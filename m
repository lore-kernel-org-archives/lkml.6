Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE54C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384762152A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 02:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="M1rbox3Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384762152A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbeHHEfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 00:35:00 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36080 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeHHEfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 00:35:00 -0400
Received: by mail-pl0-f68.google.com with SMTP id e11-v6so313930plb.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 19:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=2SmQluMEIEhsv+ZLBH+CPifmOHdRc/ctLn1bhtB5sNY=;
        b=M1rbox3YqQtnLu3RssZtFovo4WcaWsLIdO3RxRKKe0E8gIYbPmBZ+VacOiOLvEYUlb
         dwbQIhoirErsxmbvgpzH0OTpQWmbmQIpoRgMPCwsl7b2UsAfBdpaaGHC9lmv6lEHd6Fo
         WXG0xw3Utb5187hFD2H61f2fIUuM1iakMx81XSEbHOCJlbr9Qz7+taOL35hD/n8AIzjh
         GLXHJHpFm6585zw4TAlqicCTd/xMYxDHPmpF1ULpSzMZLxWW+GOXQaNFq8kFDWDqNQpH
         m7l2zADLLxXBpLQoRasZ6EubBV9ISeywPOw2VgHTUAAymGuBiLlb+nRzkdRMBv1bDXWG
         PLBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=2SmQluMEIEhsv+ZLBH+CPifmOHdRc/ctLn1bhtB5sNY=;
        b=fnJDict2x3SNAVD8NgJEmkNaGuLKQ1IVEDsoDy8oZvddKti9v4BSsal3TK1bzCBbpp
         ej2n9b7hGMLCXgdOMvOQhc+d2udLSN1hvJoDwpjWtRxGusr/YjFLiBMzShuuAuCXZK1G
         e/x/f1WH456csT6xlPOonx4GvYlIg4hQ7jptKhmRg9Dprn3J+M/58AcNIGznxIquUgBc
         keZlxOClsseb+0R3l8Mafa0/OctW+4JgD1qpn5P3s6f00xmA5VFizt4zQ5/3+iAYUwau
         BQ3501FJHmqzAYyqGqOc8k5euwX05rDrvFmWoio0ayOP8zEz3KgeRwz6ixqpaIWG/hyP
         q3bQ==
X-Gm-Message-State: AOUpUlGtjvd0LkD8kCzxOTYg9zx5GyuzpoNpWV0UQKbWk2zQJfFIb6BD
        rOMY0C1aWyWUTmP+mvz8d1abVQ==
X-Google-Smtp-Source: AA+uWPz5jQMvMJTmLe/dR4J0MRFGRaSEv1BchltsfbBpqJ+JWPi69zyzyDatN3n0Jr28eScnQS4v9w==
X-Received: by 2002:a17:902:2d24:: with SMTP id o33-v6mr751086plb.38.1533694661697;
        Tue, 07 Aug 2018 19:17:41 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id r23-v6sm9209773pfd.144.2018.08.07.19.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Aug 2018 19:17:40 -0700 (PDT)
Date:   Tue, 07 Aug 2018 19:17:40 -0700 (PDT)
X-Google-Original-Date: Tue, 07 Aug 2018 18:45:51 PDT (-0700)
Subject:     Re: [PATCH 03/11] dt-bindings: interrupt-controller: RISC-V PLIC documentation
In-Reply-To: <CAL_Jsq+pVzqKUbhErRr15JX2mPUOSTp_ddGvu9KAuf=TtXfduQ@mail.gmail.com>
CC:     atish.patra@wdc.com, Christoph Hellwig <hch@lst.de>,
        tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        aou@eecs.berkeley.edu, anup@brainfault.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     robh+dt@kernel.org
Message-ID: <mhng-4bc89d00-bc90-440f-996f-861dde382aaa@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Aug 2018 13:59:48 PDT (-0700), robh+dt@kernel.org wrote:
> On Thu, Aug 2, 2018 at 4:08 PM Atish Patra <atish.patra@wdc.com> wrote:
>>
>> On 8/2/18 4:50 AM, Christoph Hellwig wrote:
>> > From: Palmer Dabbelt <palmer@dabbelt.com>
>> >
>> > This patch adds documentation for the platform-level interrupt
>> > controller (PLIC) found in all RISC-V systems.  This interrupt
>> > controller routes interrupts from all the devices in the system to each
>> > hart-local interrupt controller.
>> >
>> > Note: the DTS bindings for the PLIC aren't set in stone yet, as we might
>> > want to change how we're specifying holes in the hart list.
>> >
>> > Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>> > [hch: various fixes and updates]
>> > Signed-off-by: Christoph Hellwig <hch@lst.de>
>> > ---
>> >   .../interrupt-controller/sifive,plic0.txt     | 57 +++++++++++++++++++
>> >   1 file changed, 57 insertions(+)
>> >   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
>> >
>> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
>> > new file mode 100644
>> > index 000000000000..c756cd208a93
>> > --- /dev/null
>> > +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
>> > @@ -0,0 +1,57 @@
>> > +SiFive Platform-Level Interrupt Controller (PLIC)
>> > +-------------------------------------------------
>> > +
>> > +SiFive SOCs include an implementation of the Platform-Level Interrupt Controller
>> > +(PLIC) high-level specification in the RISC-V Privileged Architecture
>> > +specification.  The PLIC connects all external interrupts in the system to all
>> > +hart contexts in the system, via the external interrupt source in each hart.
>> > +
>> > +A hart context is a privilege mode in a hardware execution thread.  For example,
>> > +in an 4 core system with 2-way SMT, you have 8 harts and probably at least two
>> > +privilege modes per hart; machine mode and supervisor mode.
>> > +
>> > +Each interrupt can be enabled on per-context basis. Any context can claim
>> > +a pending enabled interrupt and then release it once it has been handled.
>> > +
>> > +Each interrupt has a configurable priority. Higher priority interrupts are
>> > +serviced first. Each context can specify a priority threshold. Interrupts
>> > +with priority below this threshold will not cause the PLIC to raise its
>> > +interrupt line leading to the context.
>> > +
>> > +While the PLIC supports both edge-triggered and level-triggered interrupts,
>> > +interrupt handlers are oblivious to this distinction and therefore it is not
>> > +specified in the PLIC device-tree binding.
>> > +
>> > +While the RISC-V ISA doesn't specify a memory layout for the PLIC, the
>> > +"sifive,plic0" device is a concrete implementation of the PLIC that contains a
>> > +specific memory layout, which is documented in chapter 8 of the SiFive U5
>> > +Coreplex Series Manual <https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf>.
>> > +
>> > +Required properties:
>> > +- compatible : "sifive,plic0"

I think there was a thread bouncing around somewhere where decided to pick the 
official name of the compatible string to be "sifive,plic-1.0".  The idea here 
is that the PLIC is compatible across all of SiFive's current implementations, 
but there's some limitations in the memory map that will probably cause us to 
spin a version 2 at some point so we want major version number.  The minor 
number is just in case we find some errata in the PLIC.

>> > +- #address-cells : should be <0>
>> > +- #interrupt-cells : should be <1>
>> > +- interrupt-controller : Identifies the node as an interrupt controller
>> > +- reg : Should contain 1 register range (address and length)
>>
>> The one in the real device tree has two entries.
>> reg = <0x00000000 0x0c000000 0x00000000 0x04000000>;
>>
>> Is it intentional or just incorrect entry left over from earlier days?
>
>> > +             reg = <0xc000000 0x4000000>;
>
> Looks to me like one has #size-cells and #address-cells set to 2 and
> the example is using 1.

Yes.  For some background on how this works: we have a hardware generator that 
has a tree-of-busses abstraction, and each device is attached to some point on 
that tree.  When a device gets attached to the bus, we also generate a device 
tree entry.  For whatever system I generated the example PLIC device tree entry 
from, it must have been attached to a bus with addresses of 32 bits or less, 
which resulted in #address-cells and #size-cells being 1.

Christoph has a HiFive Unleashed, which has a fu540-c000 on it, which is 
probably not what I generated as an example -- the fu540-c000 is a complicated 
configuration, when I mess around with the hardware I tend to use simple ones 
as I'm not really a hardware guy.  I suppose the bus that the PLIC is hanging 
off on the fu540-c000 has addresses wider than 32 bits.  This makes sense, as 
the machine has 8GiB of memory and the PLIC is on a bus that's closer to the 
core than the DRAM is, so it'd need at least enough address bits to fit 8GiB.

Is the inconsistency a problem?  I generally write device tree handling code to 
just respect whatever #*-fields says and don't consider that part of the 
specification of the binding.  I don't mind changing the example to have 
#size-fields and #address-fields to be 2, but since it's not wrong I also don't 
see any reason to change it.  We do have 32-bit devices with PLICs, and while 
they're not Linux-capable devices we're trying to adopt the Linux device tree 
bindings through the rest of the RISC-V software ecosystem as they tend to be 
pretty well thought out.
