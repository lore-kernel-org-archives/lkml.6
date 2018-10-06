Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305E7C67871
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 18:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5AA20875
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 18:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE5AA20875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbeJGBn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 21:43:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:33938 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbeJGBn4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 21:43:56 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VGry3GgWBVoO; Sat,  6 Oct 2018 20:39:33 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCA7500329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:7500:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A81011EC02B2;
        Sat,  6 Oct 2018 20:39:33 +0200 (CEST)
Date:   Sat, 6 Oct 2018 20:39:28 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Andi Kleen <andi@firstfloor.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
        kan.liang@intel.com, isaku.yamahata@intel.com, kvm@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v1 1/2] x86/cpufeature: Add facility to match microcode
 revisions
Message-ID: <20181006183928.GA703@zn.tnic>
References: <20181006001928.28097-1-andi@firstfloor.org>
 <alpine.DEB.2.21.1810061555270.5454@nanos.tec.linutronix.de>
 <20181006181506.7cycnsg5gtoavtmx@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181006181506.7cycnsg5gtoavtmx@two.firstfloor.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 06, 2018 at 11:15:07AM -0700, Andi Kleen wrote:
> The matcher can be used to match specific hardware steppings by setting
> the min/max_ucode to 0 or specific microcode revisions 
> (which are associated with steppings)

This better be explained unambiguously.

> We still support the old microcode interface that allows updates
> per CPU, and also it could happen during CPU hotplug.

There are no per CPU microcode updates anymore - it is all or none.

It is actually your microcoders who came up with a bunch of restrictions
like quiescing the cores from doing *anything*, blocking hotplug,
prohibiting updates if a subset of the cores is not online and still not
guaranteeing it'll work all the time because <reasons>.

The actually very simple reason being it is just too late for microcode
update when the machine is up. Where all I wanna do is rip the damn
thing out completely.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
