Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC84BC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 02:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F6D217B4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 02:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="anaR1EwH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F6D217B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbeHVGN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 02:13:29 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:37570 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbeHVGN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 02:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LnpUi0P8aw9/8Z4iKcTA9INx6QFkqvT1G9oa2dDTsFE=; b=anaR1EwHBKP6r2YIxUxQG10Qm
        lga5y850v57SKMxfeQlf2NR8hxwAOQRyK5gcQEemvQLcUQ+++sealp43Ia4Mmxg6+r2JE4AXaHVdV
        phv94IszEO+elw8lUQ2X/6Rt5P8PkyN94flFhYsMTu8m904KaS//NYo443nufAhQ3N7S/PGabz3g9
        F2gCuMaMEEE8qy3HrKFcFUGL69CizRezJ55OwS8V4b0tS6nSUqLFWP5K2BeWcoQ4nNYw2yNXSrGkP
        4/qf2qjOQC3u4kf2NHsl/ozZbERQKFf5ROBRXdwIe/6Vd7XWxRI4KoIRjOrKzgNh9Vp6F8xLPpy4u
        GPUhHXsLg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fsJEG-0006nB-LY; Wed, 22 Aug 2018 02:50:40 +0000
Date:   Tue, 21 Aug 2018 19:50:40 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] XArray for 4.19
Message-ID: <20180822025040.GA12244@bombadil.infradead.org>
References: <20180813161357.GB1199@bombadil.infradead.org>
 <CA+55aFxFjAmrFpwQmEHCthHOzgidCKnod+cNDEE+3Spu9o1s3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxFjAmrFpwQmEHCthHOzgidCKnod+cNDEE+3Spu9o1s3w@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 07:09:31PM -0700, Linus Torvalds wrote:
> On Mon, Aug 13, 2018 at 9:14 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Please consider pulling the XArray patch set.
> 
> So this merge window has been horrible, but I was just about to start
> looking at it.
> 
> And no. I'm not going to pull this.
> 
> For some unfathomable reason, you have based it on the libnvdimm tree.
> I don't understand at all wjhy you did that.

I said in the pull request ...

  There are two conflicts I wanted to flag; the first is against the
  linux-nvdimm tree.  I rebased on top of one of the branches that went
  into that tree, so if you pull my tree before linux-nvdimm, you'll get
  fifteen commits I've had no involvement with.

Dan asked me to do that so that his commit (which I had no involvement
with) would be easier to backport.  At the time I thought this was a
reasonable request; I know this API change is disruptive and I wanted
to accommodate that.  I didn't know his patch was "complete garbage";
I didn't review it.

So, should I have based just on your tree and sent you a description of
what a resolved conflict should look like?

> And since I won't be merging this, I clearly won't be merging your
> other pull request that depended on this either.

I can yank most of the patches (all but the last two, iirc) out of the
IDA patchset and submit those as a separate pull request.  Would that
be acceptable?  I'm really struggling to juggle all the pieces here to
get them merged.
