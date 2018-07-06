Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7C0C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A70216FC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 17:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="CBAeFTST";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="RIbboCWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A70216FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933989AbeGFRCj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 13:02:39 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48010 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933561AbeGFRCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 13:02:37 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id AE5CE60BDD; Fri,  6 Jul 2018 17:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530896556;
        bh=jYvs2pN30ASArQIna37Yzw2SQAMa95+fhtWlW4HZXg0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CBAeFTST16Gae/XtBgMjVUoPNkgaDul9IKKV9ILYuFjLYzd0smYdyIBaZcFavPZrF
         iE1NBjgowfJDVuzuMpa2IUxZyr4yNhHcFs3BHCwjHboRVfKywlNwkW/L+2zeKrJfT/
         KzmJL89ZdlmQ48nOLDb3tIEeEMSPWfd1158+dSTM=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 32C9060BF7;
        Fri,  6 Jul 2018 17:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1530896555;
        bh=jYvs2pN30ASArQIna37Yzw2SQAMa95+fhtWlW4HZXg0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RIbboCWgiPsc60bnGKurNS/c5C2fF+Gr/CFGl4lktigqU0YOLf5ESrHWRDClP9b3S
         E7fHl97WRquIQZea+o0x1WCHizwd7Y162fJiSYG9DC9YUziEMATbu66DeO5w2BC4JD
         TGgTTzIoHIGBuNPOzjQYOzkz99y6quPdAtBAsefw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 06 Jul 2018 10:02:35 -0700
From:   pheragu@codeaurora.org
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Joe Perches <joe@perches.com>, apw@canonical.com,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, ckadabi@codeaurora.org,
        tsoni@codeaurora.org, bryanh@codeaurora.org
Subject: Re: [PATCH] checkpatch: Add exceptions for dsb keyword usage
In-Reply-To: <20180706054510.puli24y6i6ylghxt@salmiak>
References: <1530814776-16988-1-git-send-email-pheragu@codeaurora.org>
 <f3ce3ca8741f774b63e8a67a278384747b1de522.camel@perches.com>
 <20180706054510.puli24y6i6ylghxt@salmiak>
Message-ID: <ad36216c3347abecbeed6f0d18b6e797@codeaurora.org>
X-Sender: pheragu@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-05 22:45, Mark Rutland wrote:
> On Thu, Jul 05, 2018 at 02:14:28PM -0700, Joe Perches wrote:
>> On Thu, 2018-07-05 at 11:19 -0700, Prakruthi Deepak Heragu wrote:
>> > mb() API can relpace the dsb() API in the kernel code. So, dsb() usage
>> > is discouraged. However, there are exceptions when dsb is used in a
>> > variable or a function name. Exceptions are when 'dsb' is prefixed with
>> > class [-_>*\.] and/or suffixed with class [-_\.;].
> 
> This is a really confusing way of describing the match behaviour, and 
> doesn't
> explain why this is a big problem.
> 
> In C it's either:
> 
> 	dsb()
> 	dsb(scope)	// e.g. dsb(ish)
> 
> ... where scope is [a-z]*.
> 
> ... which can be matched as something like 'dsb([a-z]*)' if necessary.
> 
>> []
>> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> []
>> > @@ -5372,6 +5372,12 @@ sub process {
>> >  			     "Avoid line continuations in quoted strings\n" . $herecurr);
>> >  		}
>> >
>> > +# dsb is too ARMish, and should usually be mb.
>> > +        if ($line =~ /[^-_>*\.]\bdsb\b[^-_\.;]/) {
>> > +            WARN("ARM_BARRIER",
>> > +                 "Use of dsb is discouranged: prefer mb.\n" .
>> > +                 $herecurr);
>> > +		}
>> 
>> This patch is whitespace damaged with a spelling error.
>> 
>> Also, if this is reasonable test, and I don't know
>> that it is, it should be cc'd to the linux-arm list
>> linux-arm-kernel@lists.infradead.org
>> 
>> Also, I suggest 2 tests, one for .S files and
>> another for .[ch] files, and this be made specific
>> to arch/arm... files
>> 
>> Something like:
>> 
>> 	if ($realfile =~ @^arch/arm@ &&
>> 	    ($realfile =~ /\.S$/ && $line =~ /\bdsb\b/) ||
>> 	    ($realfile =~ /\.[ch]$/ && $line =~ /\bdsb\s*\(/)) {
>> 		WARN("ARM_DSB",
>> 		     "Prefer mb over dsb as an ARM memory barrier\n" . $herecurr);
>> 	}
>> 
>> ARM people, is this reasonable?
> 
> I don't think this is a big deal today.
> 
> For code under arch/{arm,arm64}, it's perfectly reasonable to use dsb.
> 
> For code *ouside* of arch/{arm,arm64}, there are a number of cases 
> where we
> want to use dsb(), e.g. when dealing with architectural drivers that 
> require
> special barriers, or for common code shared across arm and arm64.
> 
> It doesn't look like this is a big problem today, anyhow:
> 
> [mark@salmiak:~/src/linux]% git grep -w 'dsb(.*)' -- ^arch
> drivers/irqchip/irq-armada-370-xp.c:    dsb();
> drivers/irqchip/irq-gic-v3-its.c:               dsb(ishst);
> drivers/irqchip/irq-gic-v3-its.c:               dsb(ishst);
> drivers/irqchip/irq-gic-v3-its.c:       dsb(sy);
> drivers/irqchip/irq-gic-v3-its.c:               dsb(sy);
> drivers/irqchip/irq-gic-v3-its.c:       dsb(sy);
> drivers/mtd/nand/raw/cmx270_nand.c:     dsb();
> drivers/mtd/nand/raw/cmx270_nand.c:     dsb();
> drivers/mtd/nand/raw/cmx270_nand.c:     dsb();
> drivers/mtd/nand/raw/cmx270_nand.c:     dsb();
> drivers/mtd/nand/raw/cmx270_nand.c:     dsb();
> drivers/perf/arm_spe_pmu.c:     dsb(nsh);
> drivers/perf/arm_spe_pmu.c:     dsb(nsh);
> drivers/power/reset/arm-versatile-reboot.c:     dsb();
> drivers/soc/rockchip/pm_domains.c:      dsb(sy);
> drivers/soc/rockchip/pm_domains.c:      dsb(sy);
> drivers/staging/mt7621-mmc/sd.c:        //dsb(); /* --- by chhung */
> drivers/staging/mt7621-mmc/sd.c:        //dsb(); /* --- by chhung */
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq.h:#define 
> dsb(a)
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c:
>  dsb(sy);         /* data barrier operation */
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.c:         
> dsb(sy);
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h: do {
> debug_ptr[DEBUG_ ## d] = __LINE__; dsb(sy); } while (0)
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h: do {
> debug_ptr[DEBUG_ ## d] = (v); dsb(sy); } while (0)
> drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h: do {
> debug_ptr[DEBUG_ ## d]++; dsb(sy); } while (0)
> virt/kvm/arm/hyp/vgic-v3-sr.c:                  dsb(sy);
> virt/kvm/arm/hyp/vgic-v3-sr.c:                  dsb(sy);
> virt/kvm/arm/hyp/vgic-v3-sr.c:                  dsb(sy);
> 
> Thanks,
> Mark.
Thanks Mark.  I appreciate your feedback.
