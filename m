Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FDBEC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0951C2089B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 12:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0951C2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lio96.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbeH1Q0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 12:26:50 -0400
Received: from er-systems.de ([148.251.68.21]:32992 "EHLO er-systems.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbeH1Q0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 12:26:50 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
        by er-systems.de (Postfix) with ESMTP id 2F738D60115;
        Tue, 28 Aug 2018 14:35:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by er-systems.de (Postfix) with ESMTPS id E9836D60106;
        Tue, 28 Aug 2018 14:35:18 +0200 (CEST)
Date:   Tue, 28 Aug 2018 14:35:18 +0200 (CEST)
From:   Thomas Voegtle <tv@lio96.de>
X-X-Sender: thomas@er-systems.de
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: Apollo Lake with newer microcode: not affected by meltdown
 anymore?
In-Reply-To: <alpine.DEB.2.21.1808281234260.2816@nanos.tec.linutronix.de>
Message-ID: <alpine.LSU.2.21.1808281435050.31480@er-systems.de>
References: <alpine.LSU.2.21.1808281225550.27853@er-systems.de> <alpine.DEB.2.21.1808281234260.2816@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Virus-Status: No
X-Virus-Checker-Version: clamassassin 1.2.4 with clamdscan / ClamAV 0.100.1/24880/Tue Aug 28 06:46:22 2018 signatures 58.
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018, Thomas Gleixner wrote:

> On Tue, 28 Aug 2018, Thomas Voegtle wrote:
>> Kernel 4.18.5 with old microcode:
>>
>> [    0.000000] microcode: microcode updated early to revision 0x2c, date =
>> 2017-03-25
>> cat /sys/devices/system/cpu/vulnerabilities/meltdown
>> Mitigation: PTI
>>
>>
>> Kernel 4.18.5 with new microcode (microcode-20180807.tgz), same config:
>>
>> [    0.000000] microcode: microcode updated early to revision 0x32, date =
>> 2018-05-11
>> cat /sys/devices/system/cpu/vulnerabilities/meltdown
>> Not affected
>>
>>
>> This happens with 4.14.y and 4.9.y as well.
>>
>> The same with ssb:
>> old microcode: spec_store_bypass:Vulnerable
>> new microcode: spec_store_bypass:Not affected
>>
>> Is this intentional behavior? I have never seen this on other CPUs, such
>> as Gemini Lake or Baytrail, Haswell etc.
>
> Looks like the micro code update has the relevant bits set in the
> IA32_ARCH_CAPABILITIES MSR, which tell the kernel that the CPU is not
> vulnerable. So it seems Intel was able to mitigate the mess in micro code
> for this particular CPU model.

Ah, ok.
Didn't think of the most obvious.
But yes RDCL_NO is set to 1 with the new microcode. Wow.

Thanks and sorry for the noise,

   Thomas

