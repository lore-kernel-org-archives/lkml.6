Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED9CC46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFFA219DB
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 07:21:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FFFA219DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388814AbeHGJen (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 05:34:43 -0400
Received: from verein.lst.de ([213.95.11.211]:59658 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727360AbeHGJen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 05:34:43 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 7F0A668D62; Tue,  7 Aug 2018 09:27:02 +0200 (CEST)
Date:   Tue, 7 Aug 2018 09:27:02 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: aio poll V22 (aka 2.0)
Message-ID: <20180807072702.GB678@lst.de>
References: <20180806083058.14724-1-hch@lst.de> <CA+55aFw84zP23hrQppCBLL++4kwAtgYHnQvrvanEKVScAc3DZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFw84zP23hrQppCBLL++4kwAtgYHnQvrvanEKVScAc3DZA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 09:49:24AM -0700, Linus Torvalds wrote:
> I'm not seeing what's painful for this. Looking at the patches, this
> is *much* more straightforward than your previous patch,
> 
> It adds refcounting to aio_iocb, but that's *much* better than messing
> up every other subsystem.
> 
> Or is there some follow-up patches that are pending but you didn't
> post that are the painful part? Because the diffstat says that this
> second version is *way* less painful, at about 200 lines of code in a
> couple of files, mostly aio, vs ~700 lines of changes all over the
> place, together with a performance regression.

It requires additional lock roundtrips and very strange life time
rules.  But we've already established that our preference here are
different, so I'm not surprised by your different view.
