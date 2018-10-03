Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBAFC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0E7213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0E7213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbeJCVQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:16:38 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49150 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbeJCVQi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:16:38 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qySAopmy_EFZ; Wed,  3 Oct 2018 16:27:59 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC64F00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:4f00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 689551EC04DE;
        Wed,  3 Oct 2018 16:27:59 +0200 (CEST)
Date:   Wed, 3 Oct 2018 16:27:59 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     linux-kernel-owner@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        eranian@google.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, x86@kernel.org
Subject: Re: [PATCH] perf/x86/intel: Add counter freezing quirk for Goldmont
Message-ID: <20181003142758.GC4227@zn.tnic>
References: <1538515812-8808-1-git-send-email-kan.liang@linux.intel.com>
 <alpine.DEB.2.21.1810030803260.1435@nanos.tec.linutronix.de>
 <b3834054-cb2c-2074-7b7d-ad9eb4961a07@linux.intel.com>
 <alpine.DEB.2.21.1810031550550.23677@nanos.tec.linutronix.de>
 <a72002d5-be3a-1f51-dc26-ac4e962586d2@linux.intel.com>
 <3d5a49d4-85c8-0d7f-254e-d9d02419e718@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3d5a49d4-85c8-0d7f-254e-d9d02419e718@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2018 at 10:25:03AM -0400, Liang, Kan wrote:
> 
> 
> On 10/3/2018 10:15 AM, linux-kernel-owner@vger.kernel.org wrote:
> > To make it more generic, I think we also need to extend the struct
> > sku_microcode to check vendor and family.
> > The "model" in struct x86_cpu_id is u16. I will also change "model" and
> > "stepping" to u16.
> > 
> > struct sku_microcode {
> >      u16 vendor;
> >      u16 family;
> >      u16 model;
> >      u16 stepping;
> >      u32 microcode;
> > };
> 
> No, should be consistent as struct cpuinfo_x86.
> The struct sku_microcode should be
> 
> struct sku_microcode {

And drop that "sku_" prefix. Call this a struct microcode_bl_entry or
so, to be clear what it is.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
