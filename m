Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17789C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6B8420661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 04:12:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B8420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727325AbeHaISS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 04:18:18 -0400
Received: from smtp2.it.da.ut.ee ([193.40.5.67]:48413 "EHLO smtp2.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbeHaISS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 04:18:18 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp2.it.da.ut.ee (Postfix) with ESMTP id 60FD89003E;
        Fri, 31 Aug 2018 07:12:46 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id 529BD220A01; Fri, 31 Aug 2018 07:12:44 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id 6244222044B;
        Fri, 31 Aug 2018 07:12:44 +0300 (EEST)
Date:   Fri, 31 Aug 2018 07:12:44 +0300 (EEST)
From:   Meelis Roos <mroos@linux.ee>
To:     Joerg Roedel <jroedel@suse.de>
cc:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 32-bit PTI with THP = userspace corruption
In-Reply-To: <20180830205527.dmemjwxfbwvkdzk2@suse.de>
Message-ID: <alpine.LRH.2.21.1808310711380.17865@math.ut.ee>
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

Will check, but out of my memery there were 2 G3 HP Proliants that did 
not fit into the pattern (problem did not appear). I have more than 4G 
RAM in those and HIGHMEM_4G there, maybe that's it?

-- 
Meelis Roos (mroos@linux.ee)
