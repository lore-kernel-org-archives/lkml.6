Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 448AAC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 025E821A35
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 025E821A35
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbeHHTIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 15:08:16 -0400
Received: from foss.arm.com ([217.140.101.70]:42828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbeHHTIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 15:08:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D389218A;
        Wed,  8 Aug 2018 09:47:44 -0700 (PDT)
Received: from [10.4.13.119] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30FCA3F5D4;
        Wed,  8 Aug 2018 09:47:42 -0700 (PDT)
Subject: Re: [PATCH 03/11] dt-bindings: interrupt-controller: RISC-V PLIC
 documentation
To:     Christoph Hellwig <hch@lst.de>, Rob Herring <robh+dt@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>, atish.patra@wdc.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org, Stafford Horne <shorne@gmail.com>
References: <CAL_Jsq+pVzqKUbhErRr15JX2mPUOSTp_ddGvu9KAuf=TtXfduQ@mail.gmail.com>
 <mhng-4bc89d00-bc90-440f-996f-861dde382aaa@palmer-si-x1c4>
 <CAL_JsqKPFSQYH3p6a0VoCr-VAzf_98H7N3fNJ+4+DquS8WcjUQ@mail.gmail.com>
 <20180808150938.GA32274@lst.de>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <bb671fe1-6c43-3218-0096-7c5280ffb6b5@arm.com>
Date:   Wed, 8 Aug 2018 17:47:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180808150938.GA32274@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/18 16:09, Christoph Hellwig wrote:
> On Wed, Aug 08, 2018 at 08:16:14AM -0600, Rob Herring wrote:
>> Is 1.0 an actual version number corresponding to an exact, revision
>> controlled version of the IP or just something you made up? Looks like
>> the latter to me and I'm not a fan of s/w folks making up version
>> numbers for h/w. Standard naming convention is <vendor>,<soc>-<block>
>> unless you have good reason to deviate (IP for FPGAs where version
>> numbers are exposed to customers is one example).
>>
>> And defining a version 2 when you find a quirk doesn't work. You've
>> already shipped the DT. You need to be able to fix issues with just an
>> OS update. This is why you are supposed to define a compatible string
>> for each and every SoC (and use a fallback when they are "the
>> same"TM).
> 
> Can you point to some existing examples of the multiple offered
> compatible strings and what is actually matched for something that
> largely hasn't changed?
> 
> For example the documentation for the arm GICv3 binding seems to just
> match for arm,gic-v3.  On the other hand the GIC driver seems to match
> for a lot of different strings.

The original GIC driver deals with 2.5 revisions of the architecture
(yes, there was something pre-GICv1...), and implementers have been
creative to the extreme. Still, we could have done without most of these
compat strings. Hindsight and all that jazz.

GICv3 is a much more controlled architecture, and although people have
come up with a number of turds masquerading as implementations, it has
never been bad enough to mandate a different set of compat strings.
Also, you cannot describe that kind of stuff in ACPI, and we need to
support both, so we've come up with different ways of handling this.

	M.
-- 
Jazz is not dead. It just smells funny...
