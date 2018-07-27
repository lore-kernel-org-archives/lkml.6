Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B227FC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F752088E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F752088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730355AbeG0Js3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 05:48:29 -0400
Received: from verein.lst.de ([213.95.11.211]:40108 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729431AbeG0Js3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 05:48:29 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D64A868D60; Fri, 27 Jul 2018 10:31:32 +0200 (CEST)
Date:   Fri, 27 Jul 2018 10:31:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] aio: add a iocb refcount
Message-ID: <20180727083132.GA22650@lst.de>
References: <20180726082903.30273-1-hch@lst.de> <20180726082903.30273-3-hch@lst.de> <20180726112227.GB3504@bombadil.infradead.org> <20180726115705.GB2051@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726115705.GB2051@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 01:57:05PM +0200, Christoph Hellwig wrote:
> On Thu, Jul 26, 2018 at 04:22:27AM -0700, Matthew Wilcox wrote:
> > On Thu, Jul 26, 2018 at 10:29:01AM +0200, Christoph Hellwig wrote:
> > > +	atomic_t		ki_refcnt;
> > 
> > Should this be a refcount_t instead?  At first glance your usage seems
> > compatible with refcount_t.
> 
> I though the magic 0 meaning would be incompatible with a refcnt_t.
> I'll investigate and respin if it ends up being ok.

Seems like a recount_t works fine, even with CONFIG_REFCOUNT_FULL,
so I'll switch it over for the next version.
