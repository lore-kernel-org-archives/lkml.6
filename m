Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 589A4C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29CB7223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 21:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CB7223DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728248AbeKOH4Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 02:56:24 -0500
Received: from foss.arm.com ([217.140.101.70]:51584 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726015AbeKOH4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 02:56:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBF4F1596;
        Wed, 14 Nov 2018 13:51:24 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A48543F5A0;
        Wed, 14 Nov 2018 13:51:23 -0800 (PST)
Date:   Wed, 14 Nov 2018 21:51:13 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Hogan <jhogan@kernel.org>, linux-hexagon@vger.kernel.org,
        x86@kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-snps-arc@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Huang Ying <ying.huang@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rich Felker <dalias@libc.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 1/4] kgdb: Remove irq flags from roundup
Message-ID: <20181114215112.GA4044@brain-police>
References: <20181112182659.245726-1-dianders@chromium.org>
 <20181112182659.245726-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112182659.245726-2-dianders@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2018 at 10:26:55AM -0800, Douglas Anderson wrote:
> The function kgdb_roundup_cpus() was passed a parameter that was
> documented as:
> 
> > the flags that will be used when restoring the interrupts. There is
> > local_irq_save() call before kgdb_roundup_cpus().
> 
> Nobody used those flags.  Anyone who wanted to temporarily turn on
> interrupts just did local_irq_enable() and local_irq_disable() without
> looking at them.  So we can definitely remove the flags.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Acked-by: Will Deacon <will.deacon@arm.com>

I'm hopeful that you'll keep hacking on kgdb, because it definitely needs
some love in its current state.

Will
