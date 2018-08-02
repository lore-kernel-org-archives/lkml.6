Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991B2C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47EB121566
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Sq9JwmXl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47EB121566
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731564AbeHBWWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 18:22:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46735 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeHBWWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 18:22:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id f14-v6so1216712pgv.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 13:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=QDXv2wdMXuedg3f01o9H9KBXqjb+Eo7PJH2Wl4l7d+Y=;
        b=Sq9JwmXlIGVLFLD+hdsbIj/r5dpx1qG5z4CCmm9LyPFAkI1Qzp49sC3ORVpREInWYo
         jilooB8mtVuFmq5biJDOb6ImQogZD/XmQ4jc6Iz/G+WWFsyzPaSLxt0FvbIQotY5F3aN
         IueMkMJgi9RTy8g4VG5zV6mTKuEOkyH2B+WwTAIzaUZLr2gKPo/cX85OWOZx+0FpflXL
         nLUyBsiNO1UsL21nE2827Oa2SyJWJ0szKdq1Zlo541jRu82MPZBtLW1Nyda3CneZHTBb
         gYMVgBMCLZe7F6kV8Tpv7kdxwsAjGB+z6zpmy7jquBNi3PEI4/cA/jLKisugZHWgwdyi
         k7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=QDXv2wdMXuedg3f01o9H9KBXqjb+Eo7PJH2Wl4l7d+Y=;
        b=q+uAIKqutfrL+Efy1REMACKHIPrIU3IyRZqNS23ZP+kz8cRcVug4vpfzkzWU/iuNn0
         LCsezkriOTN2JifxoJ/S5UpRENSDFdrs+kTJf69B+yDMDwM57kIApUHDgwoHLwbJX61l
         R+5RNpC7gl3CsGbDwnu14JxXSVqEpWrnRYYvngDrO7Ou64Gv8siL8EBlvw8WfF2VqpM0
         plSFU7g+t4dcXo8biJkzSDO3xeTHX1SttdUiePPsrvk+xp7Rh7QFiSbRNTn8cLkPEqCI
         UnVwHSMCK5BmLVdC3kYU3tNUPBfmWlmphaO5yToLvwBj6UxoxO8JY4PyqVblmhgp4JAH
         OHvw==
X-Gm-Message-State: AOUpUlGlxmhV5zih8NNe6LCNtGZhzq1NymZhChNuo/ZSRrj9uqYR6aDF
        bZAZgKrB03iFvaa+FU0JAjQCjQ==
X-Google-Smtp-Source: AAOMgpc5w4Ic8kG416mdFzjNsGWaOvgwUgh9xvuZxpyedIi/yrL+1w217uK0bRoCedDbzVC5M2c6jg==
X-Received: by 2002:a65:6104:: with SMTP id z4-v6mr863801pgu.361.1533241803893;
        Thu, 02 Aug 2018 13:30:03 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id p3-v6sm3791704pfo.130.2018.08.02.13.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 13:30:01 -0700 (PDT)
Date:   Thu, 02 Aug 2018 13:30:01 -0700 (PDT)
X-Google-Original-Date: Thu, 02 Aug 2018 13:15:39 PDT (-0700)
Subject:     Re: [PATCH 2/3] dt-bindings: interrupt-controller: RISC-V local interrupt controller docs
In-Reply-To: <20180625200448.26fvdv2tj3etmtlp@localhost>
CC:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, aou@eecs.berkeley.edu,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        shorne@gmail.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     christoph@boehmwalder.at, Christoph Hellwig <hch@infradead.org>
Message-ID: <mhng-a548b882-7f89-4ff4-a46b-f9cee7da724f@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jun 2018 13:04:48 PDT (-0700), christoph@boehmwalder.at wrote:
> On Fri, Jun 22, 2018 at 04:20:05PM -0700, Palmer Dabbelt wrote:
>> From: Palmer Dabbelt <palmer@dabbelt.com>
>>
>> This patch adds documentation on the RISC-V local interrupt controller,
>> which is a per-hart interrupt controller that manages all interrupts
>> entering a RISC-V hart.  This interrupt controller is present on all
>> RISC-V systems.
>>
>> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
>> ---
>>  .../interrupt-controller/riscv,cpu-intc.txt        | 41 ++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
>> new file mode 100644
>> index 000000000000..61900e2e3868
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
>> @@ -0,0 +1,41 @@
>> +RISC-V Hart-Level Interrupt Controller (HLIC)
>> +---------------------------------------------
>> +
>> +RISC-V cores include Control Status Registers (CSRs) which are local to each
>> +hart and can be read or written by software. Some of these CSRs are used to
>> +control local interrupts connected to the core.  Every interrupt is ultimately
>> +routed through a hart's HLIC before it interrupts that hart.
>> +
>> +The RISC-V supervisor ISA manual specifies three interrupt sources that are
>> +attached to every HLIC: software interrupts, the timer interrupt, and external
>> +interrupts.  Software interrupts are used to send IPIs between cores.  The
>> +timer interrupt comes from an architecturally mandated real-time timer that is
>> +controller via SBI calls and CSR reads.  External interrupts connect all other
>> +device interrupts to the HLIC, which are routed via the platform-level
>> +interrupt controller (PLIC).
>> +
>> +All RISC-V systems that conform to the supervisor ISA specification are
>> +required to have a HLIC with these three interrupt sources present.  Since the
>> +interrupt map is defined by the ISA it's not listed in the HLIC's device tree
>> +entry, though external interrupt controllers (like the PLIC, for example) will
>> +need to define how their interrupts map to the relevant HLICs.
>> +
>> +Required properties:
>> +- compatible : "riscv,cpu-intc"
>> +- #interrupt-cells : should be <1>
>> +- interrupt-controller : Identifies the node as an interrupt controller
>> +
>> +Furthermore, this interrupt-controller MUST be embedded inside the cpu
>> +definition of the hart whose CSRs control these local interrupts.
>> +
>> +An example device tree entry for a HLIC is show below.
>
> Spotted a typo here, "show" -> "shown".

Thanks.  It looks like we're actually dropping this binding and integrating 
this first-level interrupt controller into the core RISC-V arch code as keeping 
it split out results in too many inefficiencies.

>> +
>> +	cpu1: cpu@1 {
>> +		compatible = "riscv";
>> +		...
>> +		cpu1-intc: interrupt-controller {
>> +			#interrupt-cells = <1>;
>> +			compatible = "riscv,cpu-intc";
>> +			interrupt-controller;
>> +		};
>> +	};
>> --
>> 2.16.4
>
> Also, I've noticed that double spaces after punctuation are used pretty
> inconsistently throughout the document. Is that intended?

No.  I noticed this in the PLIC document as well, I'll fix that one up.

Thanks!
