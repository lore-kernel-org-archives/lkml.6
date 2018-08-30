Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB19C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:55:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0265420661
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 20:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0265420661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeHaA7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 20:59:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:44416 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727181AbeHaA7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 20:59:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7DDA3AD81;
        Thu, 30 Aug 2018 20:55:28 +0000 (UTC)
Date:   Thu, 30 Aug 2018 22:55:27 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Meelis Roos <mroos@linux.ee>
Cc:     Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: 32-bit PTI with THP = userspace corruption
Message-ID: <20180830205527.dmemjwxfbwvkdzk2@suse.de>
References: <alpine.LRH.2.21.1808301639570.15669@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.21.1808301639570.15669@math.ut.ee>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Meelis,

On Thu, Aug 30, 2018 at 09:09:19PM +0300, Meelis Roos wrote:
> I am seeing userland corruption and application crashes on multiple 
> 32-bit machines with 4.19-rc1+git. The machines vary: PII, PIII, P4. 
> They are all Intel. AMD Duron/Athlon/AthlonMP have been fine in my tests 
> so far (may be configuration dependent).

Thanks for the report! I'll try to reproduce the problem tomorrow and
investigate it. Can you please check if any of the kernel configurations
that show the bug has CONFIG_X86_PAE set? If not, can you please test
if enabling this option still triggers the problem?

Thanks,

	Joerg

