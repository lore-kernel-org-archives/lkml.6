Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D896C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1917C2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 18:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A3m9zISQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1917C2077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbeIEXQL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 19:16:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42514 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727254AbeIEXQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 19:16:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QaGo6IhJWfAgL8g3xsRuKSsUrYPQvRXIcnPsa6a0jZs=; b=A3m9zISQMGcx/MeYr1gWHDb2S
        Q9lDxZThPjylDCqY+Y6WYUeraj7h3DBfOBKWJa0j+CpsnFSfhwvOWrKi4071zzeAR/eOcAcFOwVHu
        ILiqgnDuzDDW0n64VgnubS9jw/jDME9EXvOSSYcjQEjJgw43AOmTrYnqpC5LCEcyxuKMMghB/aYEg
        lpWnO8EjuR1CYMTiR1v43j+2s/GM2q838F62hbQiCCv7QT4bHaSnsK5nEWgryoGSHC/NH9nxtpI7c
        qZcu8Z+6AKZYQ+5d7ih7dyUXyl/mlBiM9pD2TWjx3zjLOphctGUNo9rFjV315c0QCgmU3LgWPuflW
        U8JkvnPJg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxcn4-0008Nd-0F; Wed, 05 Sep 2018 18:44:34 +0000
Date:   Wed, 5 Sep 2018 11:44:33 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Jan Kara <jack@suse.cz>,
        syzbot+87a05ae4accd500f5242@syzkaller.appspotmail.com,
        ak@linux.intel.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        mawilcox@microsoft.com, mgorman@techsingularity.net,
        syzkaller-bugs@googlegroups.com, tim.c.chen@linux.intel.com,
        zwisler@kernel.org, willy@infradead.org
Subject: Re: linux-next test error
Message-ID: <20180905184433.GA31174@infradead.org>
References: <0000000000004f6b5805751a8189@google.com>
 <20180905085545.GD24902@quack2.suse.cz>
 <CAFqt6zZtjPFdfAGxp43oqN3=z9+vAGzdOvDcgFaU+05ffCGu7A@mail.gmail.com>
 <20180905133459.GF23909@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180905133459.GF23909@thunk.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2018 at 09:34:59AM -0400, Theodore Y. Ts'o wrote:
> It's at: 83c0adddcc6ed128168e7b87eaed0c21eac908e4 in the Linux Next
> branch.
> 
> Dmitry, can you try reverting this commit and see if it makes the
> problem go away?
> 
> Souptick, can we just NACK this patch and completely drop it from all
> trees?
> 
> I think we need to be a *lot* more careful about this vm_fault_t patch
> thing.  If you can't be bothered to run xfstests, we need to introduce
> a new function which replaces block_page_mkwrite() --- and then let
> each file system try to convert over to it at their own pace, after
> they've done regression testing.

block_page_mkwrite is only called by ext4 and nilfs2 anyway, so
converting both callers over should not be a problem, as long as
it actually is done properly.

Which is my main beef with this mess of a conversation - it should
have been posted as a single series that actually does a mostly
scriped conversion after fixing up the initial harder issues, and
be properly tested.  It has been pretty much an example of how not
do things, and been dragging on forever while wasting everyones time.
