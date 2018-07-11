Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8935AC1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 430D020C0E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 430D020C0E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733152AbeGKU4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:56:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:59098 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726692AbeGKU4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:56:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6DBFAADEF;
        Wed, 11 Jul 2018 20:50:26 +0000 (UTC)
Date:   Wed, 11 Jul 2018 22:50:25 +0200
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mips: Fix mips_dma_map_sg by using correct dma
 mapping function
Message-Id: <20180711225025.9c8da709d9c513fbbdce020b@suse.de>
In-Reply-To: <20180711160342.ddvlqvjp3smwyido@pburton-laptop>
References: <20180711113852.2734-1-tbogendoerfer@suse.de>
        <20180711160342.ddvlqvjp3smwyido@pburton-laptop>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 09:03:42 -0700
Paul Burton <paul.burton@mips.com> wrote:

> This doesn't apply after Christoph's massive MIPS DMA cleanup which can
> be found in mips-next (or linux-next). After this work we end up using
> the generic dma_direct_map_sg() on most systems, and the code above has
> been removed.

Christoph's cleanup also fixes the issue. I thought sending it as a fix for
4.17 would be appropriate, but no problem with dropping it.

Thomas.
