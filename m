Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D94ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 10:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D095220881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 10:29:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D095220881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbeIOPs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 11:48:26 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51619 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeIOPsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 11:48:25 -0400
Received: from p4fea45ac.dip0.t-ipconnect.de ([79.234.69.172] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g17pm-00062n-Q1; Sat, 15 Sep 2018 12:29:50 +0200
Date:   Sat, 15 Sep 2018 12:29:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Feng Tang <feng.tang@intel.com>
cc:     Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Ingo Molnar <mingo@elte.hu>,
        "H . Peter Anvin" <hpa@linux.intel.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH] x86, mm: Reserver some memory for bootmem allocator for
 NO_BOOTMEM
In-Reply-To: <20180911061413.redy4oxia3hqifkh@shbuild888>
Message-ID: <alpine.DEB.2.21.1809151226130.1650@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1808301504300.1210@nanos.tec.linutronix.de> <20180830131920.w2jqjvlkpfb4ejb2@shbuild888> <alpine.DEB.2.21.1808301523510.1210@nanos.tec.linutronix.de> <20180831061519.3zbxsjs4rd6mmsuo@shbuild888> <alpine.DEB.2.21.1808311328260.2208@nanos.tec.linutronix.de>
 <20180831133659.pkmscqpudjnkujbg@shbuild888> <20180907081716.bxw3hmcl6w7gqvax@shbuild888> <alpine.DEB.2.21.1809071250240.1402@nanos.tec.linutronix.de> <20180910093938.ka732apzy3d3a5ip@shbuild888> <alpine.DEB.2.21.1809101147500.1402@nanos.tec.linutronix.de>
 <20180911061413.redy4oxia3hqifkh@shbuild888>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018, Feng Tang wrote:
> Thanks for the suggestion, and I have 2 patches: one adds a build warning,   
> the other prepares fixmap page table on demand and doesn't need warning.

The latter please.

> But I met a problem, that the "__end_of_permanent_fixed_addresses" is
> defined in fixmap.h, which is protected by #ifndef __ASSEMBLY__, also
> fixmap.h reference many other header file, which makes it harder to
> extract the definition out. Any suggestion on this? thanks!

What prevents you from moving the enum out of the __ASSEMBLY__ protected
section aside of a bit of careful work?

Thanks,

	tglx
