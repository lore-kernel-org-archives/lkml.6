Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81EC8C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2820520842
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 07:10:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2820520842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeHaLQ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 07:16:58 -0400
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:40696 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbeHaLQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 07:16:58 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp2.it.da.ut.ee (Postfix) with ESMTP id 705E2902FF;
        Fri, 31 Aug 2018 10:10:54 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id 5F812220A38; Fri, 31 Aug 2018 10:10:52 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id 729E422043A;
        Fri, 31 Aug 2018 10:10:52 +0300 (EEST)
Date:   Fri, 31 Aug 2018 10:10:52 +0300 (EEST)
From:   Meelis Roos <mroos@linux.ee>
To:     Joerg Roedel <jroedel@suse.de>
cc:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 32-bit PTI with THP = userspace corruption
In-Reply-To: <20180830205527.dmemjwxfbwvkdzk2@suse.de>
Message-ID: <alpine.LRH.2.21.1808311005080.31140@math.ut.ee>
References: <alpine.LRH.2.21.1808301639570.15669@math.ut.ee> <20180830205527.dmemjwxfbwvkdzk2@suse.de>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I am seeing userland corruption and application crashes on multiple 
> > 32-bit machines with 4.19-rc1+git. The machines vary: PII, PIII, P4. 
> > They are all Intel. AMD Duron/Athlon/AthlonMP have been fine in my tests 
> > so far (may be configuration dependent).
> 
> Thanks for the report! I'll try to reproduce the problem tomorrow and
> investigate it. Can you please check if any of the kernel configurations
> that show the bug has CONFIG_X86_PAE set? If not, can you please test
> if enabling this option still triggers the problem?

PAE was not visible itself, but when I changed HIGHMEM_4G to 
HIGHMEM_64G, X86_PAE was also selected and the resutling kernel works.

Also, I verified that the olid proliants with 6G RAM already have 
HIGHMEM_64G set and they do not exhibit the problem either.

-- 
Meelis Roos (mroos@linux.ee)
