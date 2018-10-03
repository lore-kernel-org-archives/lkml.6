Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2975DC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E202F2098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:24:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E202F2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbeJCVMy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:12:54 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:33910 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbeJCVMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:12:54 -0400
Received: from tmo-096-48.customers.d1-online.com ([80.187.96.48] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g7i4S-0005A1-Lk; Wed, 03 Oct 2018 16:24:12 +0200
Date:   Wed, 3 Oct 2018 16:24:11 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
cc:     Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        eranian@google.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, x86@kernel.org
Subject: Re: [PATCH] perf/x86/intel: Add counter freezing quirk for
 Goldmont
In-Reply-To: <a72002d5-be3a-1f51-dc26-ac4e962586d2@linux.intel.com>
Message-ID: <alpine.DEB.2.21.1810031623390.23677@nanos.tec.linutronix.de>
References: <1538515812-8808-1-git-send-email-kan.liang@linux.intel.com> <alpine.DEB.2.21.1810030803260.1435@nanos.tec.linutronix.de> <b3834054-cb2c-2074-7b7d-ad9eb4961a07@linux.intel.com> <alpine.DEB.2.21.1810031550550.23677@nanos.tec.linutronix.de>
 <a72002d5-be3a-1f51-dc26-ac4e962586d2@linux.intel.com>
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

On Wed, 3 Oct 2018, Liang, Kan wrote:
> On 10/3/2018 9:55 AM, Thomas Gleixner wrote:
> > On Wed, 3 Oct 2018, Liang, Kan wrote:
> > > On 10/3/2018 2:10 AM, Thomas Gleixner wrote:
> > > > There is another variant of model/stepping micro code verification code
> > > > in
> > > > intel_snb_pebs_broken(). Can we please make this table based and use a
> > > > common function? That's certainly not the last quirk we're going to
> > > > have.
> > > > 
> > > > We already have a table based variant of ucode checking in
> > > > bad_spectre_microcode(). It's trivial enough to generalize that.
> > > > 
> > > 
> > > Sure, I will generalize the bad_spectre_microcode(), rename it to
> > > is_bad_intel_microcode(), and move it to
> > > arch\x86\kernel\cpu\microcode\intel.c.
> > 
> > I suggest: is_bad_microcode() and have it in cpu/microcode/core.c unless
> > you are claiming that bad microcode() is an intel only feature.
> > 
> 
> Yes, other platforms also have microcode issues.
> To make it more generic, I think we also need to extend the struct
> sku_microcode to check vendor and family.
> The "model" in struct x86_cpu_id is u16. I will also change "model" and
> "stepping" to u16.
> 
> struct sku_microcode {
> 	u16 vendor;
> 	u16 family;
> 	u16 model;
> 	u16 stepping;
> 	u32 microcode;
> };

Makes sense.

Thanks,

	tglx
