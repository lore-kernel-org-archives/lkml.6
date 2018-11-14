Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F5FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C135206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 15:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C135206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387661AbeKOBlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 20:41:15 -0500
Received: from verein.lst.de ([213.95.11.211]:35710 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727731AbeKOBlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 20:41:15 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 48A0A68CED; Wed, 14 Nov 2018 16:37:30 +0100 (CET)
Date:   Wed, 14 Nov 2018 16:37:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] MIPS: SiByte: Enable ZONE_DMA32 for LittleSur
Message-ID: <20181114153730.GB28823@lst.de>
References: <alpine.LFD.2.21.1811131653160.9637@eddie.linux-mips.org> <alpine.LFD.2.21.1811132145480.9637@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.21.1811132145480.9637@eddie.linux-mips.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 10:42:37PM +0000, Maciej W. Rozycki wrote:
> The LittleSur board is marked for high memory support and therefore 
> clearly must provide a way to have enough memory installed for some to 
> be present outside the low 4GiB physical address range.  With the memory 
> map of the BCM1250 SOC it has been built around it means over 1GiB of 
> actual DRAM, as only the first 1GiB is mapped in the low 4GiB physical 
> address range[1].
> 
> Complement commit cce335ae47e2 ("[MIPS] 64-bit Sibyte kernels need 
> DMA32.") then and also enable ZONE_DMA32 for LittleSur.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
