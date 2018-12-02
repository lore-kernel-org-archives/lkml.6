Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A7EC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD909206B7
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 06:11:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD909206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725730AbeLBGL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 01:11:26 -0500
Received: from gate.crashing.org ([63.228.1.57]:47746 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbeLBGL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 01:11:26 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id wB26B3sd012208;
        Sun, 2 Dec 2018 00:11:04 -0600
Message-ID: <42b1408cafe77ebac1b1ad909db237fe34e4d177.camel@kernel.crashing.org>
Subject: Re: use generic DMA mapping code in powerpc V4
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Rui Salvaterra <rsalvaterra@gmail.com>, hch@lst.de
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 02 Dec 2018 17:11:02 +1100
In-Reply-To: <CALjTZvZsk0qA+Yxu7S+8pfa5y6rpihnThrHiAKkZMWsdyC-tVg@mail.gmail.com>
References: <CALjTZvZzHSZ=s0W0Pd-MVd7OA0hYxu0LzsZ+GxYybXKoUQQR6Q@mail.gmail.com>
         <20181130103222.GA23393@lst.de>
         <CALjTZvZsk0qA+Yxu7S+8pfa5y6rpihnThrHiAKkZMWsdyC-tVg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-30 at 11:44 +0000, Rui Salvaterra wrote:
> Thanks for the quick response! I applied it on top of your
> powerpc-dma.4 branch and retested.
> I'm not seeing nouveau complaining anymore (I'm not using X11 or any
> DE, though).
> In any case and FWIW, this series is
> 
> Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>

Talking of which ... Christoph, not sure if we can do something about
this at the DMA API level or keep hacks but some adapters such as the
nVidia GPUs have a HW hack we can use to work around their limitations
in that case.

They have a register that can program a fixed value for the top bits
that they don't support.

This works fine for any linear mapping with an offset, provided they
can program the offset in that register and they have enough DMA range
to cover all memory from that offset.

I can probably get the info about this from them so we can exploit it
in nouveau.

Cheers,
Ben.

> Thanks,
> Rui

