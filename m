Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D071DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:00:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E528218FF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 00:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jGrISdXx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387934AbfBNAAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 19:00:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52052 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732400AbfBNAAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 19:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b2Y8OC5a1L0hTA7a0DVJp+KO4Zptb0EV6XMOqxk1G+k=; b=jGrISdXx/anAMBh9d7rwMCvlO
        X0NtwpLdXl/IOKKTTDF7Twpcwfz0rW6tS+/zwtzcuQ3d93A0SXY8xL7hOTY4MM6FfPTtaTBNMRnqP
        ZLXdu58FC0eXBsxg6WFaQ6JlMZHKXOHvuYKVK7MZCqqlOZ3D9cP8DH5AhTYydoIHdyEMCufTgTPmW
        iWYm17Yzz+LymbTRAzQSlzPfKQvWXi0VxYr6E1a1+GHA5+r4FdDCVyklGMXKlXOEssNm7hmIfoQVK
        DUkyZa1sdJ4+TKLTgp3gxgCipDIrVfB6Ah6rhAwBomoBdQs8CzfPmYWFNxeNJO/PQfhV2iRFaryUO
        d/Tu1WQWw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gu4Rc-0005fL-5B; Thu, 14 Feb 2019 00:00:00 +0000
Date:   Wed, 13 Feb 2019 15:59:59 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Subject: Re: [LSF/MM TOPIC] (again) THP for file systems
Message-ID: <20190213235959.GX12668@bombadil.infradead.org>
References: <77A00946-D70D-469D-963D-4C4EA20AE4FA@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77A00946-D70D-469D-963D-4C4EA20AE4FA@fb.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 10:00:10PM +0000, Song Liu wrote:
> I would like to discuss remaining work to bring THP to (non-tmpfs) file systems.
> This topic has been discussed multiple times in previous LSF/MM summits [1][2].
> However, there hasn't been much progress since late 2017 (the latest work I can
> find is by Kirill A. Shutemov [3]).

... this was literally just discussed.

Feel free to review
https://lore.kernel.org/lkml/20190212183454.26062-1-willy@infradead.org/

with particular reference to the last three paragraphs of
https://lore.kernel.org/lkml/20190208042448.GB21860@bombadil.infradead.org/

> Therefore, we would like discuss (for one more time) what is needed to bring
> THP to file systems like ext4, xfs, btrfs, etc. Once we are aligned on the
> direction, we are more than happy to commit time and resource to make it happen.

I believe the direction is clear.  It needs people to do the work.
We're critically short of reviewers.  I got precious little review of
the original XArray work, which made Andrew nervous and delayed its
integration.  Now I'm getting little review of the followup patches
to lay the groundwork for filesystems to support larger page sizes.
I have very little patience for this situation.
