Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F7DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A964A2086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A964A2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727337AbeKHG2i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:28:38 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:42179 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbeKHG2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:28:37 -0500
Received: from p4fea46ac.dip0.t-ipconnect.de ([79.234.70.172] helo=nanos.glx-home)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gKUs9-0008T8-VQ; Wed, 07 Nov 2018 21:56:22 +0100
Date:   Wed, 7 Nov 2018 21:56:21 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Logan Gunthorpe <logang@deltatee.com>,
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
In-Reply-To: <20181107123838.1b7234c98a87dec5a2b25e67@linux-foundation.org>
Message-ID: <alpine.DEB.2.21.1811072153590.1666@nanos.tec.linutronix.de>
References: <20181107173859.24096-1-logang@deltatee.com> <20181107173859.24096-3-logang@deltatee.com> <20181107121207.62cb37cf58484b7cc80a8fd8@linux-foundation.org> <724be9bb-59b6-33f3-7b59-3ca644d59bf7@deltatee.com> <alpine.DEB.2.21.1811072125280.1666@nanos.tec.linutronix.de>
 <b1cc442e-7314-4a8e-3eec-9adc200d7582@deltatee.com> <20181107123838.1b7234c98a87dec5a2b25e67@linux-foundation.org>
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

On Wed, 7 Nov 2018, Andrew Morton wrote:
> On Wed, 7 Nov 2018 13:36:34 -0700 Logan Gunthorpe <logang@deltatee.com> wrote:
> 
> > > Actually if both names suck, then there also is the option to rename both
> > > instead of adding a comment to explain the suckage.
> > 
> > Ok, well, I wasn't expecting to take on a big rename like that as it
> > would create a patch touching a bunch of arches and mm files... But if
> > we can come to some agreement on a better name and someone is willing to
> > take that patch without significant delay then I'd be happy to create
> > the patch and add it to the start of my series.
> 
> Some other time ;)

More precise: Manjana. You live way too close to Mexico :)

