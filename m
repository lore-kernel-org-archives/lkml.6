Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13B2C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3C12086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 11:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A3C12086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.ee
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeIKQ5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 12:57:15 -0400
Received: from smtp1.it.da.ut.ee ([193.40.5.66]:56962 "EHLO smtp1.it.da.ut.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbeIKQ5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 12:57:15 -0400
Received: from math.ut.ee (unknown [IPv6:2001:bb8:2002:2400:5054:ff:fe3b:8db9])
        by smtp1.it.da.ut.ee (Postfix) with ESMTP id 28ECC20947;
        Tue, 11 Sep 2018 14:58:13 +0300 (EEST)
Received: by math.ut.ee (Postfix, from userid 1014)
        id 13D1E220AD1; Tue, 11 Sep 2018 14:58:11 +0300 (EEST)
Received: from localhost (localhost [127.0.0.1])
        by math.ut.ee (Postfix) with ESMTP id 0B0EE220429;
        Tue, 11 Sep 2018 14:58:11 +0300 (EEST)
Date:   Tue, 11 Sep 2018 14:58:10 +0300 (EEST)
From:   Meelis Roos <mroos@linux.ee>
To:     Joerg Roedel <jroedel@suse.de>
cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 32-bit PTI with THP = userspace corruption
In-Reply-To: <20180911114927.gikd3uf3otxn2ekq@suse.de>
Message-ID: <alpine.LRH.2.21.1809111454100.29433@math.ut.ee>
References: <alpine.LRH.2.21.1808301639570.15669@math.ut.ee> <20180830205527.dmemjwxfbwvkdzk2@suse.de> <alpine.LRH.2.21.1808310711380.17865@math.ut.ee> <20180831070722.wnulbbmillxkw7ke@suse.de> <alpine.DEB.2.21.1809081223450.1402@nanos.tec.linutronix.de>
 <20180911114927.gikd3uf3otxn2ekq@suse.de>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 	4) Disable PTI support on 2-level paging by making it dependent
> 	   on CONFIG_X86_PAE. This is, imho, the least ugly option
> 	   because the machines that do not support PAE are most likely
> 	   too old to be affected my Meltdown anyway. We might also
> 	   consider switching i386_defconfig to PAE?
> 
> Any other thoughts?

The machines where I have PAE off are the ones that have less memory. 
PAE is off just for performance reasons, not lack of PAE. PAE should be 
present on all of my affected machines anyway and current distributions 
seem to mostly assume 686 and PAE anyway for 32-bit systems.

-- 
Meelis Roos (mroos@ut.ee)      http://www.cs.ut.ee/~mroos/
