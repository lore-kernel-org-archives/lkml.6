Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0C6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895B32073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KLL988/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895B32073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbeH3SNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:13:44 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45194 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbeH3SNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:13:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zqRnMD7NZlRZkmXYIC+sDRCHE5M4pgkQwJVwlO2acZ0=; b=KLL988/ueL+I/DhUiMDhkURPQ
        CGkr2AZbNpaI65gKdpDvia4nW5+NdxXu89n9lz7u6lLI1fmUMAENNzZgsHqWETfEqShD/m4T45f1M
        AFw/86+UkyaYZQ9mcROv8s+x5RaXUBrXbgm22HZyvN4TA0F6UwNFnuJBIajNE4K/CIFCaadwna7Uh
        CI8JctUPSNotE2HEeH0Uuny9NvwAlwsEPPpthrHQR7axiGG8ik5Bp8sLWg3qnLcl4IK8uHLnD8XqF
        gt9dYiD4dFMNpFJr32o1p0RVsy1SqJFekFzwdSdNMU6BkMknRh+EBB3m7+JEBwRdaw/jYFrZ/cAkh
        0Tv2ZCWBA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fvNfN-0001qV-19; Thu, 30 Aug 2018 14:11:21 +0000
Date:   Thu, 30 Aug 2018 07:11:20 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Anup Patel <anup@brainfault.org>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Mark Rutland <mark.rutland@arm.com>, palmer@sifive.com,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 0/3] RISC-V: Add new smp features
Message-ID: <20180830141120.GA1724@infradead.org>
References: <1535445370-19004-1-git-send-email-atish.patra@wdc.com>
 <CAAhSdy0=ROMqkbgqcKLSdM11TBOeD65GR42s0j_HOYd+y-=jmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhSdy0=ROMqkbgqcKLSdM11TBOeD65GR42s0j_HOYd+y-=jmg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:53:50AM -0400, Anup Patel wrote:
> > Atish Patra (3):
> >   RISC-V: Add logical CPU indexing for RISC-V
> >   RISC-V: Use Linux logical cpu number instead of hartid
> >   RISC-V: Support cpu hotplug.
> >
> 
> This series looks good to me.

Hmm, that series didn't make it to my inbox, neither directly, nor
through the linux-riscv list.  Where did you see it?
