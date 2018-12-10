Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3118EC5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3A520821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:33:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3A520821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729351AbeLJTdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:33:20 -0500
Received: from verein.lst.de ([213.95.11.211]:50758 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727501AbeLJTdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:33:19 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 99BD268DD2; Mon, 10 Dec 2018 20:33:17 +0100 (CET)
Date:   Mon, 10 Dec 2018 20:33:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Rui Salvaterra <rsalvaterra@gmail.com>
Cc:     hch@lst.de, benh@kernel.crashing.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: use generic DMA mapping code in powerpc V4
Message-ID: <20181210193317.GA31514@lst.de>
References: <CALjTZvZzHSZ=s0W0Pd-MVd7OA0hYxu0LzsZ+GxYybXKoUQQR6Q@mail.gmail.com> <20181130103222.GA23393@lst.de> <CALjTZvZsk0qA+Yxu7S+8pfa5y6rpihnThrHiAKkZMWsdyC-tVg@mail.gmail.com> <42b1408cafe77ebac1b1ad909db237fe34e4d177.camel@kernel.crashing.org> <20181208171746.GB15228@lst.de> <CALjTZvb4+Ox5Jdm-xwQuxMDz_ub=mHAgPLA4NgrVNZTmUZwhnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALjTZvb4+Ox5Jdm-xwQuxMDz_ub=mHAgPLA4NgrVNZTmUZwhnQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 05:04:46PM +0000, Rui Salvaterra wrote:
> Hi, Christoph and Ben,
> 
> It just came to my mind (and this is most likely a stupid question,
> but still)… Is there any possibility of these changes having an
> (positive) effect on the long-standing problem of Power Mac machines
> with AGP graphics cards (which have to be limited to PCI transfers,
> otherwise they'll hang, due to coherence issues)? If so, I have a G4
> machine where I'd gladly test them.

These patches themselves are not going to affect that directly.
But IFF the problem really is that the AGP needs to be treated as not
cache coherent (I have no idea if that is true) the generic direct
mapping code has full support for a per-device coherent flag, so
support for a non-coherent AGP slot could be implemented relatively
simply.
