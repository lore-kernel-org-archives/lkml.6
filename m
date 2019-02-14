Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B4CC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1953B2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Y8n3YjHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfBNAhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:37:54 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42080 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbfBNAhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 19:37:52 -0500
Received: by mail-pf1-f193.google.com with SMTP id n74so2057189pfi.9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 16:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=uT75a19FaF87yjESbhIfkIe22b6AasUHkjMarqW5BsM=;
        b=Y8n3YjHTl49N3znm/rfydQpsP+i4dhNF+yLiTVb68qUi+tqEh7qNfIYu7j3s+Z54Qb
         ls3lh+BDhGxtxQzFHmJVUg6AOUbdqabyo/U9DYx3GzmmZYBHfFOAQ8XK07xT+Re2ZeLY
         G38Cns+n7+uqmC2jq4mvH/4ogqmf+9pC/jqygUHJHlHfOcUe1SoRQpw8FCsQrTOZYx93
         ru/Rnm//RTemMMNmDJxMn3ft8mA28ENLQLxu47aBQ3yWZZJmP3DFP+deQ/+e3kbTAdZo
         3E895dFSabqwv9tKzC/laTzC9nya64c/ZI3Lo/1/vVJF24jkvMiHuDseopRKHqZNxq7s
         r35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=uT75a19FaF87yjESbhIfkIe22b6AasUHkjMarqW5BsM=;
        b=Ps3IuN6mM4Nc3VtWAQcqfo4ByKhtzTMNJ73ZClCAvB94LhXEe4RyJSb/xEYSKa4A63
         WlNI3mQg0Wvj43ecAS6WK4kTfAP9/Up4mj8ft/Xhj33T6l5fcKEL3Fw6TTnjO5TUz0ph
         mshr4Ve6P18Q9h5BZwMSEhgnktMuG792Ce6/dpzE1qEwL9CafAb9iB65Aq8GJ4UcCFvH
         1IDjiX8sBfRiz881wEhM6M+fjhMEIwH9wsZZlGFj7S7TftYiDhlP0oKMcOLKyayS4Rt/
         Y6Lz7VHJxmqhh0+vnEr9WrecZ9nZdAhCgEWx3/FWuXWwpR122lHJYDbN1sPvY8vCGpkL
         NWSg==
X-Gm-Message-State: AHQUAuYbfHpBBU30XUyK+ev2WsN6mgRsdPGBZqo+HRwuWda7EIOLi13B
        Ag5KFavaVaq5RP/ht7etVTNVhA==
X-Google-Smtp-Source: AHgI3IYuAK6VrAw16TgxnA4ZfOcmKNYt9kIIDRM0Kb+5DQxV80IYsIXJey6nuMq7RejD1KAW2EQYsA==
X-Received: by 2002:a65:424c:: with SMTP id d12mr1000124pgq.126.1550104671315;
        Wed, 13 Feb 2019 16:37:51 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id e128sm643789pfe.67.2019.02.13.16.37.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 16:37:50 -0800 (PST)
Date:   Wed, 13 Feb 2019 16:37:50 -0800 (PST)
X-Google-Original-Date: Wed, 13 Feb 2019 16:30:21 PST (-0800)
Subject:     Re: [v4 PATCH 8/8] RISC-V: Assign hwcap as per comman capabilities.
In-Reply-To: <20190213084442.GD28278@localhost>
CC:     atish.patra@wdc.com, johan@kernel.org, robh@kernel.org,
        aou@eecs.berkeley.edu, jason@lakedaemon.net, alankao@andestech.com,
        dmitriy@oss-tech.org, schwab@suse.de, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com,
        Paul Walmsley <paul.walmsley@sifive.com>, anup@brainfault.org,
        linux-riscv@lists.infradead.org, tglx@linutronix.de
From:   Palmer Dabbelt <palmer@sifive.com>
To:     johan@kernel.org
Message-ID: <mhng-d7d9894c-d6f6-485b-95e8-962c4ab0f3f1@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 00:44:42 PST (-0800), johan@kernel.org wrote:
> On Tue, Feb 12, 2019 at 11:58:10AM -0800, Atish Patra wrote:
>> On 2/12/19 3:25 AM, Johan Hovold wrote:
>> > On Tue, Feb 12, 2019 at 03:10:12AM -0800, Atish Patra wrote:
>> >> Currently, we set hwcap based on first valid hart from DT. This may not
>> >> be correct always as that hart might not be current booting cpu or may
>> >> have a different capability.
>> >>
>> >> Set hwcap as the capabilities supported by all possible harts with "okay"
>> >> status.
>> >>
>> >> Signed-off-by: Atish Patra <atish.patra@wdc.com>
>> >> ---
>> >>   arch/riscv/kernel/cpufeature.c | 41 ++++++++++++++++++++++-------------------
>> >>   1 file changed, 22 insertions(+), 19 deletions(-)
>> >>
>> >> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
>> >> index e7a4701f..a1e4fb34 100644
>> >> --- a/arch/riscv/kernel/cpufeature.c
>> >> +++ b/arch/riscv/kernel/cpufeature.c
>> >> @@ -20,6 +20,7 @@
>> >>   #include <linux/of.h>
>> >>   #include <asm/processor.h>
>> >>   #include <asm/hwcap.h>
>> >> +#include <asm/smp.h>
>> >>
>> >>   unsigned long elf_hwcap __read_mostly;
>> >>   #ifdef CONFIG_FPU
>> >> @@ -42,28 +43,30 @@ void riscv_fill_hwcap(void)
>> >>
>> >>   	elf_hwcap = 0;
>> >>
>> >> -	/*
>> >> -	 * We don't support running Linux on hertergenous ISA systems.  For
>> >> -	 * now, we just check the ISA of the first "okay" processor.
>> >> -	 */
>> >>   	for_each_of_cpu_node(node) {
>> >> -		if (riscv_of_processor_hartid(node) >= 0)
>> >> -			break;
>> >> -	}
>> >> -	if (!node) {
>> >> -		pr_warn("Unable to find \"cpu\" devicetree entry\n");
>> >> -		return;
>> >> -	}
>> >> +		unsigned long this_hwcap = 0;
>> >>
>> >> -	if (of_property_read_string(node, "riscv,isa", &isa)) {
>> >> -		pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
>> >> -		of_node_put(node);
>> >> -		return;
>> >> -	}
>> >> -	of_node_put(node);
>> >> +		if (riscv_of_processor_hartid(node) < 0)
>> >> +			continue;
>> >>
>>
>> >> -	for (i = 0; i < strlen(isa); ++i)
>> >> -		elf_hwcap |= isa2hwcap[(unsigned char)(isa[i])];
>> >> +		if (of_property_read_string(node, "riscv,isa", &isa)) {
>> >> +			pr_warn("Unable to find \"riscv,isa\" devicetree entry\n");
>> >> +			return;
>> >
>> > Did you want "continue" here to continue processing the other harts?
>>
>> Hmm. If a cpu node doesn't have isa in DT, that means DT is wrong. A
>> "continue" here will let user space use other harts just with a warning
>> message?
>>
>> Returning here will not set elf_hwcap which forces the user to fix the
>> DT. I am not sure what should be the defined behavior in this case.
>>
>> Any thoughts ?
>
> The problem is that the proposed code might still set elf_hwcap -- it
> all depends on the order of the hart nodes in dt (i.e. it will only be
> left unset if the first node is malformed).
>
> For that reason, I'd say it's better to either bail out (hard or at
> least with elf_hwcap unset) or to continue processing the other nodes.
>
> The former might break current systems with malformed dt, though.
>
> And since the harts are expected to have the same ISA, continuing the
> processing while warning and ignoring the malformed node might be
> acceptable.

Handling malformed device trees by providing a warning and an empty HWCAP seems 
like the right way to go to me.

>
> Johan
