Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C5AAC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CBC22174A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 23:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fg5/raSS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CBC22174A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbeHUC1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 22:27:40 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:48631 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbeHUC1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 22:27:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1534806605; x=1566342605;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=Ivrgyt6iZz3p0aKbgihBMGKC1Rj1sa4Rh+rsBWvD38s=;
  b=fg5/raSSdC+VGE+DSNL2kZfcfC/G7PfL9S3QsQoeh8AjBK+DLRjU8cYN
   XOdHQcAKD0hhxEreOl/WjIv4zCCrJfUW11UKhKSmUNlg37X59wBTeotbu
   bc/frv5hxZ0+EOAOPMrnEqzUeE+g+grpertT77j5GMrgNuH2VimJcTdXw
   /dP2w7uiPky8WiLJVQ15azESJN+2e7BSOW3ZOfH9DnQqeoLHRdhiXYLY8
   7S5SJ6Tojjh/AUy/2s8hmD49m6BPe+BUNzGc6DPGRAtlR+e/pnaiqxdgp
   c5SDuKkLup04RZvpfdWYRBtyzqGYswrWf3fTX2vH3HB/1qXgniQ3gDFMx
   g==;
X-IronPort-AV: E=Sophos;i="5.53,267,1531756800"; 
   d="scan'208";a="192040881"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2018 07:10:05 +0800
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP; 20 Aug 2018 15:57:43 -0700
Received: from c02v91rdhtd5.sdcorp.global.sandisk.com (HELO [10.196.159.148]) ([10.196.159.148])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Aug 2018 16:10:06 -0700
Subject: Re: [PATCH] dt-bindings: riscv,cpu-intc: Cleanups from a missed
 review
To:     Palmer Dabbelt <palmer@sifive.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        Rob Herring <robh@kernel.org>,
        "marc.zyngier@arm.com" <marc.zyngier@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Karsten Merker <merker@debian.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>
References: <20180820230011.25368-1-palmer@sifive.com>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <51924de4-4a16-07a0-f499-753e0df49678@wdc.com>
Date:   Mon, 20 Aug 2018 16:10:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180820230011.25368-1-palmer@sifive.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/18 4:01 PM, Palmer Dabbelt wrote:
> I managed to miss one of Rob's code reviews on the mailing list
> <http://lists.infradead.org/pipermail/linux-riscv/2018-August/001139.html>.
> The patch has already been merged, so I'm submitting a fixup.
> 
> Sorry!
> 
> Fixes: b67bc7cb4088 ("dt-bindings: interrupt-controller: RISC-V local interrupt controller")
> Cc: Rob Herring <robh@kernel.org>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Karsten Merker <merker@debian.org>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---
>   .../bindings/interrupt-controller/riscv,cpu-intc.txt       | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
> index b0a8af51c388..265b223cd978 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
> @@ -11,7 +11,7 @@ The RISC-V supervisor ISA manual specifies three interrupt sources that are
>   attached to every HLIC: software interrupts, the timer interrupt, and external
>   interrupts.  Software interrupts are used to send IPIs between cores.  The
>   timer interrupt comes from an architecturally mandated real-time timer that is
> -controller via Supervisor Binary Interface (SBI) calls and CSR reads.  External
> +controlled via Supervisor Binary Interface (SBI) calls and CSR reads.  External
>   interrupts connect all other device interrupts to the HLIC, which are routed
>   via the platform-level interrupt controller (PLIC).
>   
> @@ -25,7 +25,15 @@ in the system.
>   
>   Required properties:
>   - compatible : "riscv,cpu-intc"

Since this is a fix up patch, we should update the compatible string 
with the sifive specific one as well. no?

Regards,
Atish
> -- #interrupt-cells : should be <1>
> +- #interrupt-cells : should be <1>.  The interrupt sources are defined by the
> +  RISC-V supervisor ISA manual, with only the following three interrupts being
> +  defined for supervisor mode:
> +    - Source 1 is the supervisor software interrupt, which can be sent by an SBI
> +      call and is reserved for use by software.
> +    - Source 5 is the supervisor timer interrupt, which can be configured by
> +      SBI calls and implements a one-shot timer.
> +    - Source 9 is the supervisor external interrupt, which chains to all other
> +      device interrupts.
>   - interrupt-controller : Identifies the node as an interrupt controller
>   
>   Furthermore, this interrupt-controller MUST be embedded inside the cpu
> @@ -38,7 +46,7 @@ An example device tree entry for a HLIC is show below.
>   		...
>   		cpu1-intc: interrupt-controller {
>   			#interrupt-cells = <1>;
> -			compatible = "riscv,cpu-intc", "sifive,fu540-c000-cpu-intc";
> +			compatible = "sifive,fu540-c000-cpu-intc", "riscv,cpu-intc";
>   			interrupt-controller;
>   		};
>   	};
> 

