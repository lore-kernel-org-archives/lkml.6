Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B456EC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 838502083D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 17:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 838502083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbeLHRRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 12:17:48 -0500
Received: from verein.lst.de ([213.95.11.211]:40861 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbeLHRRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 12:17:48 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 42CC268AA6; Sat,  8 Dec 2018 18:17:46 +0100 (CET)
Date:   Sat, 8 Dec 2018 18:17:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Rui Salvaterra <rsalvaterra@gmail.com>, hch@lst.de,
        linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20181208171746.GB15228@lst.de>
References: <CALjTZvZzHSZ=s0W0Pd-MVd7OA0hYxu0LzsZ+GxYybXKoUQQR6Q@mail.gmail.com> <20181130103222.GA23393@lst.de> <CALjTZvZsk0qA+Yxu7S+8pfa5y6rpihnThrHiAKkZMWsdyC-tVg@mail.gmail.com> <42b1408cafe77ebac1b1ad909db237fe34e4d177.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42b1408cafe77ebac1b1ad909db237fe34e4d177.camel@kernel.crashing.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 05:11:02PM +1100, Benjamin Herrenschmidt wrote:
> Talking of which ... Christoph, not sure if we can do something about
> this at the DMA API level or keep hacks but some adapters such as the
> nVidia GPUs have a HW hack we can use to work around their limitations
> in that case.
> 
> They have a register that can program a fixed value for the top bits
> that they don't support.
> 
> This works fine for any linear mapping with an offset, provided they
> can program the offset in that register and they have enough DMA range
> to cover all memory from that offset.
> 
> I can probably get the info about this from them so we can exploit it
> in nouveau.

I think we can expose the direct mapping offset if people care enough,
we just have to be very careful designing the API.  I'll happily leave
that to those that actually want to use it, but I'll gladly help
reviewing it.
