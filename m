Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60394C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F6020685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 11:53:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F6020685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbeGZNJv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:09:51 -0400
Received: from verein.lst.de ([213.95.11.211]:36069 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729107AbeGZNJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:09:51 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id E5E7168D64; Thu, 26 Jul 2018 13:57:05 +0200 (CEST)
Date:   Thu, 26 Jul 2018 13:57:05 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, viro@zeniv.linux.org.uk,
        Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] aio: add a iocb refcount
Message-ID: <20180726115705.GB2051@lst.de>
References: <20180726082903.30273-1-hch@lst.de> <20180726082903.30273-3-hch@lst.de> <20180726112227.GB3504@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180726112227.GB3504@bombadil.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 04:22:27AM -0700, Matthew Wilcox wrote:
> On Thu, Jul 26, 2018 at 10:29:01AM +0200, Christoph Hellwig wrote:
> > +	atomic_t		ki_refcnt;
> 
> Should this be a refcount_t instead?  At first glance your usage seems
> compatible with refcount_t.

I though the magic 0 meaning would be incompatible with a refcnt_t.
I'll investigate and respin if it ends up being ok.
