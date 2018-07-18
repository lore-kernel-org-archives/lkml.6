Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CFEECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 491DD2075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 09:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491DD2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731884AbeGRKVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 06:21:41 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:47213 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbeGRKVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 06:21:40 -0400
Received: from 89-70-153-66.dynamic.chello.pl (89.70.153.66) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 58330be86bcf8a4b; Wed, 18 Jul 2018 11:44:34 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Calvin Walton <calvin.walton@kepstin.ca>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 0/2] turbostat: Improve support for AMD Zen CPUs (RAPL, CPUID)
Date:   Wed, 18 Jul 2018 11:42:55 +0200
Message-ID: <3796314.T8TZf5QxF9@aspire.rjw.lan>
In-Reply-To: <20180718013642.10344-1-calvin.walton@kepstin.ca>
References: <20180718013642.10344-1-calvin.walton@kepstin.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 18, 2018 3:36:40 AM CEST Calvin Walton wrote:
> Based on the documentation provided in AMD's Open-Source
> Register Reference For AMD Family 17h Processors:
> https://support.amd.com/TechDocs/56255_OSRR.pdf
> 
> I've added support for reading Cores and Package energy usage from AMD's
> "RAPL" MSRs. In order to correctly detect the AMD processor generation,
> I've also had to update the CPUID code to handle AMD's extended family
> field.
> 
> Here's some example output from my (idle) Ryzen 3 2200G test system:
> 
> turbostat version 17.06.23 - Len Brown <lenb@kernel.org>
> CPUID(0): AuthenticAMD 13 CPUID levels; family:model:stepping 0x17:11:0 (23:17:0)
> CPUID(1): SSE3 MONITOR - - - TSC MSR - -
> CPUID(6): APERF, No-TURBO, No-DTS, No-PTM, No-HWP, No-HWPnotify, No-HWPwindow, No-HWPepp, No-HWPpkg, No-EPB
> CPUID(7): No-SGX
> RAPL: 364 sec. Joule Counter Range, at 180 Watts
> cpu2: POLL: CPUIDLE CORE POLL IDLE
> cpu2: C1: ACPI FFH INTEL MWAIT 0x0
> cpu2: C2: ACPI IOPORT 0x414
> cpu2: cpufreq driver: acpi-cpufreq
> cpu2: cpufreq governor: schedutil
> cpu0: MSR_RAPL_PWR_UNIT: 0x000a1003 (0.125000 Watts, 0.000015 Joules, 0.000977 sec.)
> Core	CPU	Avg_MHz	Busy%	Bzy_MHz	TSC_MHz	IRQ	C1	C2	C1%	C2%	CorWatt	PkgWatt
> -	-	33	2.20	1485	3500	5073	1263	3694	2.75	95.12	0.03	3.29
> 0	0	33	2.20	1483	3500	1213	354	886	2.96	94.89	0.01	3.29
> 1	1	25	1.67	1474	3500	907	197	682	1.55	96.80	0.01
> 2	2	33	2.24	1478	3500	1674	450	1175	4.16	93.70	0.01
> 3	3	40	2.67	1501	3500	1279	262	951	2.33	95.07	0.01
> 
> 
> Calvin Walton (2):
>   turbostat: Read extended processor family from CPUID
>   turbostat: Add support for AMD Fam 17h (Zen) RAPL
> 
>  tools/power/x86/turbostat/turbostat.c | 184 ++++++++++++++++++++++----
>  1 file changed, 156 insertions(+), 28 deletions(-)
> 
> 

CC to linux-pm@vger.kernel.org pretty please!


