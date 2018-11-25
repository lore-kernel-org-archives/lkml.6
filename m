Return-Path: <SRS0=bZNE=OE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT,WEIRD_PORT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06971C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 03:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16582086B
	for <linux-kernel@archiver.kernel.org>; Sun, 25 Nov 2018 03:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ikUlAk09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A16582086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbeKYNuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 25 Nov 2018 08:50:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59432 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbeKYNuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Nov 2018 08:50:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hyp8zWuu/LFjnrWWQcDlhfd6MYPkZytz4lWVSqRJz2M=; b=ikUlAk09nSeMV9p0zsiVfdCMl
        VpjlipCAzFoYC5u8KkG8CpP/6oc9eoOddxlGLlnkyzexOFJ2vfm0N7gxF6J+mz4gy2DYdVc1JTa5l
        G1TeMUH+BFeoQLUhI6IIFfW+UCyrgrpCluBieZht8nKdEaG63MQCaap8h6kIlcglAumnej8o8lI/V
        7LQQAGLqZyU292csIK08Qz5uhMBmN0BWPdONuW/PdXYc4m2NMdwxE6UQvBll75PNBU/dpBKvPn9W+
        pwnb2lw9FoDmrIR3TdLfKaACeWkBDF1SOCAgArRLw7qrWHWQu+pyc8UJPntWz9eBF/wQB8rM4YM4A
        aPt7QqYNg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gQkel-00085L-Up; Sun, 25 Nov 2018 03:00:23 +0000
Date:   Sat, 24 Nov 2018 19:00:23 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        dan.j.williams@intel.com
Subject: Re: [GIT PULL] XArray updates
Message-ID: <20181125030023.GC3065@bombadil.infradead.org>
References: <20181124173209.GZ3065@bombadil.infradead.org>
 <CAHk-=wgHTcLXY4P-EJiXd4MbwXjp9QdEfQ+udVUGRuUzT-8ZFA@mail.gmail.com>
 <20181125023814.GB3065@bombadil.infradead.org>
 <CAHk-=whU1RMvzGvCwq8HaApYZuJ4STyfAYC5b_qDPFTwcTWD=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whU1RMvzGvCwq8HaApYZuJ4STyfAYC5b_qDPFTwcTWD=Q@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 24, 2018 at 06:49:30PM -0800, Linus Torvalds wrote:
> On Sat, Nov 24, 2018 at 6:38 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > I generated a new key 5EC42E41545C1F5E and signed a new tag
> > xarray-4.20-rc4
> 
> Hmm. Did you publicize it on any keyservers? I'm not finding the key
> on pgp.mit.edu or on the sks-keyservers.net pool..

I pushed it out to hkps://hkps.pool.sks-keyservers.net ... as I recall,
pgp.mit.edu is frequently not synchronised well with the other keyservers,
but I'm surprised that one of the sks-keyservers didn't have it.

http://pgpkeys.uk:11371/pks/lookup?search=0x5EC42E41545C1F5E&fingerprint=on&op=index

sees it just fine.

> > I've signed that key with my old DSA key 2218C81E8E7C03FF which has
> > about 400 signatures on it, but I understand is not terribly trustable
> > these days.
> 
> .. but at least I can find that one.  I think a 1024-bit DSA key may
> be borderline in theory, but it's a lot better than no key at all.
> 
>                Linus
