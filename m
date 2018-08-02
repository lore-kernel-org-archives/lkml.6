Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B13C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5826121581
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 22:08:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G/wZC9ep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5826121581
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeHCABW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 20:01:22 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23290 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbeHCABW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 20:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1533247697; x=1564783697;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=IkEMS6307cxa1iJwY/yXxGC9EkjJJe4RM3A347gjklY=;
  b=G/wZC9epLsvRgfjrOnUVgsFVw1tJqOVdQtcsOGTHqz/9DRj3+24DSA2W
   MsaTE6Mrui6sq8V/fADrnsip4PYf7UedAkDgBH45DlTY22dCa9z4RNerI
   SHNHH4Za4D/B+ygyQZQhwwEHuHoEhXNTHoOXOZifAKAYaq/CNdO/6qY3I
   FeOpGcprxdHDHttAJZHsi1FzSHlmJGnROBZKzByNcloNt5YGfkmDlP9Mf
   kqkdEvv4nBbjh+BlSY0ex3iS85+ENq4eUayOCsgdJpg8TinnJigMiRBS3
   Bp19En0SbEhlZ6EYL8VivjFCf4ikZq49pZAfmYcVkomhMmBQXwlCqC0T2
   A==;
X-IronPort-AV: E=Sophos;i="5.51,437,1526313600"; 
   d="scan'208";a="87014537"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 03 Aug 2018 06:08:16 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP; 02 Aug 2018 14:56:02 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.148]) ([10.196.159.148])
  by uls-op-cesaip02.wdc.com with ESMTP; 02 Aug 2018 15:08:16 -0700
Subject: Re: [PATCH 03/11] dt-bindings: interrupt-controller: RISC-V PLIC
 documentation
To:     Christoph Hellwig <hch@lst.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "anup@brainfault.org" <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "shorne@gmail.com" <shorne@gmail.com>
References: <20180802115008.4031-1-hch@lst.de>
 <20180802115008.4031-4-hch@lst.de>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <0093fadc-a150-3745-e73d-e579bfdfabfb@wdc.com>
Date:   Thu, 2 Aug 2018 15:08:15 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180802115008.4031-4-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/18 4:50 AM, Christoph Hellwig wrote:
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
> [hch: various fixes and updates]
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   .../interrupt-controller/sifive,plic0.txt     | 57 +++++++++++++++++++
>   1 file changed, 57 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic0.txt
> new file mode 100644
> index 000000000000..c756cd208a93
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
> +Each interrupt can be enabled on per-context basis. Any context can claim
> +a pending enabled interrupt and then release it once it has been handled.
> +
> +Each interrupt has a configurable priority. Higher priority interrupts are
> +serviced first. Each context can specify a priority threshold. Interrupts
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
> +- compatible : "sifive,plic0"
> +- #address-cells : should be <0>
> +- #interrupt-cells : should be <1>
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- reg : Should contain 1 register range (address and length)

The one in the real device tree has two entries.
reg = <0x00000000 0x0c000000 0x00000000 0x04000000>;

Is it intentional or just incorrect entry left over from earlier days?

Regards,
Atish
> +- interrupts-extended : Specifies which contexts are connected to the PLIC,
> +  with "-1" specifying that a context is not present.  The nodes pointed
> +  to should be "riscv" HART nodes, or eventually be parented by such nodes.
> +- riscv,ndev: Specifies how many external interrupts are supported by
> +  this controller.
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
> +	};
> 

