Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47001C1B0E3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8F6520C0B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 20:52:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F6520C0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388035AbeGKU6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 16:58:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:59264 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726692AbeGKU6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 16:58:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C5F73ADEF;
        Wed, 11 Jul 2018 20:52:21 +0000 (UTC)
Date:   Wed, 11 Jul 2018 22:52:21 +0200
From:   Thomas Bogendoerfer <tbogendoerfer@suse.de>
To:     Paul Burton <paul.burton@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mips/jazz: provide dma_mask/coherent_dma_mask for
 platform devices
Message-Id: <20180711225221.f25a7ce2eda3c1a1ffad6464@suse.de>
In-Reply-To: <20180711161556.gmxgfo7y46xbdw7z@pburton-laptop>
References: <20180711113852.2734-1-tbogendoerfer@suse.de>
        <20180711113852.2734-2-tbogendoerfer@suse.de>
        <20180711161556.gmxgfo7y46xbdw7z@pburton-laptop>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-suse-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jul 2018 09:15:56 -0700
Paul Burton <paul.burton@mips.com> wrote:

> On Wed, Jul 11, 2018 at 01:38:52PM +0200, Thomas Bogendoerfer wrote:
> > platform devices for sonic and esp didn't have dma_masks.
> 
> That's a very brief commit message :)

I thought it's obvious, that now every dma mapping operation triggers a WARN_ON, if
dma masks are missing. But no problem to respin with a more information added.

Thomas.
