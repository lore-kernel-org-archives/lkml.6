Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EF9C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C87252081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C87252081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbeKHF6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 00:58:54 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:42076 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbeKHF6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 00:58:54 -0500
Received: from p5492fe24.dip0.t-ipconnect.de ([84.146.254.36] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gKUPT-0007tu-1N; Wed, 07 Nov 2018 21:26:43 +0100
Date:   Wed, 7 Nov 2018 21:26:42 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Logan Gunthorpe <logang@deltatee.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@arndb.de>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH 2/2] mm/sparse: add common helper to mark all memblocks
 present
In-Reply-To: <724be9bb-59b6-33f3-7b59-3ca644d59bf7@deltatee.com>
Message-ID: <alpine.DEB.2.21.1811072125280.1666@nanos.tec.linutronix.de>
References: <20181107173859.24096-1-logang@deltatee.com> <20181107173859.24096-3-logang@deltatee.com> <20181107121207.62cb37cf58484b7cc80a8fd8@linux-foundation.org> <724be9bb-59b6-33f3-7b59-3ca644d59bf7@deltatee.com>
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

Logan,

On Wed, 7 Nov 2018, Logan Gunthorpe wrote:
> On 2018-11-07 1:12 p.m., Andrew Morton wrote:
> >> +void __init memblocks_present(void)
> >> +{
> >> +	struct memblock_region *reg;
> >> +
> >> +	for_each_memblock(memory, reg) {
> >> +		memory_present(memblock_get_region_node(reg),
> >> +			       memblock_region_memory_base_pfn(reg),
> >> +			       memblock_region_memory_end_pfn(reg));
> >> +	}
> >> +}
> >> +
> > 
> > I don't like the name much.  To me, memblocks_present means "are
> > memblocks present" whereas this actually means "memblocks are present".
> > But whatever.  A little covering comment which describes what this
> > does and why it does it would be nice.
> 
> The same argument can be made about the existing memory_present()
> function and I think it's worth keeping the naming consistent. I'll add
> a comment and resend shortly.

Actually if both names suck, then there also is the option to rename both
instead of adding a comment to explain the suckage.

Thanks,

	tglx
