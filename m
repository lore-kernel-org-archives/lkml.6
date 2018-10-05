Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FA6C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C02972084D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 04:02:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02972084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbeJEK6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 06:58:52 -0400
Received: from gate.crashing.org ([63.228.1.57]:44435 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726286AbeJEK6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 06:58:51 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w953PcSt004864;
        Thu, 4 Oct 2018 22:25:40 -0500
Message-ID: <8891277c7de92e93d3bfc409df95810ee6f103cd.camel@kernel.crashing.org>
Subject: Re: [PATCH] memblock: stop using implicit alignement to
 SMP_CACHE_BYTES
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-mm@kvack.org
Cc:     linux-mips@linux-mips.org, Michal Hocko <mhocko@suse.com>,
        linux-ia64@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Matt Turner <mattst88@gmail.com>, linux-um@lists.infradead.org,
        linux-m68k@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Guan Xuetao <gxt@pku.edu.cn>,
        linux-arm-kernel@lists.infradead.org,
        Chris Zankel <chris@zankel.net>,
        Michal Simek <monstr@monstr.eu>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>,
        linux-alpha@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org
Date:   Fri, 05 Oct 2018 13:25:38 +1000
In-Reply-To: <1538687224-17535-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1538687224-17535-1-git-send-email-rppt@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-10-05 at 00:07 +0300, Mike Rapoport wrote:
> When a memblock allocation APIs are called with align = 0, the alignment is
> implicitly set to SMP_CACHE_BYTES.
> 
> Replace all such uses of memblock APIs with the 'align' parameter explicitly
> set to SMP_CACHE_BYTES and stop implicit alignment assignment in the
> memblock internal allocation functions.
> 
> For the case when memblock APIs are used via helper functions, e.g. like
> iommu_arena_new_node() in Alpha, the helper functions were detected with
> Coccinelle's help and then manually examined and updated where appropriate.
> 
> The direct memblock APIs users were updated using the semantic patch below:

What is the purpose of this ? It sounds rather counter-intuitive...

Ben.


