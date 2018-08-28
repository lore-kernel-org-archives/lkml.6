Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 621EAC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CBC320878
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 10:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CBC320878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727479AbeH1O2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 10:28:08 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:44328 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbeH1O2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 10:28:08 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fubMt-0008AZ-5B; Tue, 28 Aug 2018 12:37:03 +0200
Date:   Tue, 28 Aug 2018 12:37:02 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Thomas Voegtle <tv@lio96.de>
cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: Apollo Lake with newer microcode: not affected by meltdown
 anymore?
In-Reply-To: <alpine.LSU.2.21.1808281225550.27853@er-systems.de>
Message-ID: <alpine.DEB.2.21.1808281234260.2816@nanos.tec.linutronix.de>
References: <alpine.LSU.2.21.1808281225550.27853@er-systems.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018, Thomas Voegtle wrote:
> Kernel 4.18.5 with old microcode:
> 
> [    0.000000] microcode: microcode updated early to revision 0x2c, date =
> 2017-03-25
> cat /sys/devices/system/cpu/vulnerabilities/meltdown
> Mitigation: PTI
> 
> 
> Kernel 4.18.5 with new microcode (microcode-20180807.tgz), same config:
> 
> [    0.000000] microcode: microcode updated early to revision 0x32, date =
> 2018-05-11
> cat /sys/devices/system/cpu/vulnerabilities/meltdown
> Not affected
> 
> 
> This happens with 4.14.y and 4.9.y as well.
> 
> The same with ssb:
> old microcode: spec_store_bypass:Vulnerable
> new microcode: spec_store_bypass:Not affected
> 
> Is this intentional behavior? I have never seen this on other CPUs, such
> as Gemini Lake or Baytrail, Haswell etc.

Looks like the micro code update has the relevant bits set in the
IA32_ARCH_CAPABILITIES MSR, which tell the kernel that the CPU is not
vulnerable. So it seems Intel was able to mitigate the mess in micro code
for this particular CPU model.

Thanks,

	tglx
