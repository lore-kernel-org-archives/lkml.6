Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D615C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107FB20844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 02:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V4AXN/vb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="V4AXN/vb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 107FB20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388512AbeGYDWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 23:22:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:55610 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388472AbeGYDWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 23:22:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EA05A60B62; Wed, 25 Jul 2018 02:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532484777;
        bh=dzNv+tT+RRl7deAxm/0RQ+DmYdgGN6G4D4ZgY9N+PqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V4AXN/vb3x7aHsj4CiiIjGBzZH5Wlq4FdfIgv+QTGo3rHzOHsYJtn4qWXvm7rozuA
         9O4BjuSS604E68hJqO3DP8GxGSFL0E8lJn2jnjn0io1VIgmL0aJsr2AcM+fwpCc0X6
         gAkz/lTIl/SDjcMHw7nDxRiWTPsXjPBUkYP99Esw=
Received: from codeaurora.org (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rkuo@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DBCE56021A;
        Wed, 25 Jul 2018 02:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1532484777;
        bh=dzNv+tT+RRl7deAxm/0RQ+DmYdgGN6G4D4ZgY9N+PqU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V4AXN/vb3x7aHsj4CiiIjGBzZH5Wlq4FdfIgv+QTGo3rHzOHsYJtn4qWXvm7rozuA
         9O4BjuSS604E68hJqO3DP8GxGSFL0E8lJn2jnjn0io1VIgmL0aJsr2AcM+fwpCc0X6
         gAkz/lTIl/SDjcMHw7nDxRiWTPsXjPBUkYP99Esw=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DBCE56021A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rkuo@codeaurora.org
Date:   Tue, 24 Jul 2018 21:12:55 -0500
From:   Richard Kuo <rkuo@codeaurora.org>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc:     Michal Hocko <mhocko@kernel.org>, linux-hexagon@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hexagon: switch to NO_BOOTMEM
Message-ID: <20180725021255.GF12771@codeaurora.org>
References: <1531726998-10971-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180723212339.GA12771@codeaurora.org>
 <20180724054704.GA16933@rapoport-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724054704.GA16933@rapoport-lnx>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 08:47:04AM +0300, Mike Rapoport wrote:
> On Mon, Jul 23, 2018 at 04:23:39PM -0500, Richard Kuo wrote:
> > 
> > On Mon, Jul 16, 2018 at 10:43:18AM +0300, Mike Rapoport wrote:
> > > This patch adds registration of the system memory with memblock, eliminates
> > > bootmem initialization and converts early memory reservations from bootmem
> > > to memblock.
> > > 
> > > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > 
> > Sorry for the delay, and thanks for this patch.
> > 
> > I think the first memblock_reserve should use ARCH_PFN_OFFSET instead of
> > PHYS_OFFSET.
> 
> memblock_reserve gets physical address rather than a pfn.
> 
> If I read arch/hexagon/include/asm/mem-layout.h correctly, the PHYS_OFFSET
> *is* the physical address of the RAM and ARCH_PFN_OFFSET is the first pfn:
> 
> #define PHYS_PFN_OFFSET	(PHYS_OFFSET >> PAGE_SHIFT)
> #define ARCH_PFN_OFFSET	PHYS_PFN_OFFSET
> 
> Did I miss something?

Sorry, I should have been more clear.  In the size calculation, it's
subtracting the unshifted PHYS_OFFSET from the start page number, which
I'm pretty sure is wrong.


Thanks,
Richard Kuo


-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
