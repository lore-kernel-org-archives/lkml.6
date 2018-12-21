Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6163CC43444
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFBA218E0
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 07:04:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rERjj/vH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731459AbeLUHEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 02:04:53 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53308 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbeLUHEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 02:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=BhjaUnK16zGKnRXNgkzTnJdVhtTx9utaISBIjymdBkg=; b=rERjj/vH4XYpJx6BWorgDV/97
        4hP1N1YiTMm+aE4NL2Vaubli693TZUl6FWewFk0sOQOAuMXaHAUepRzh3WwmVNhnwcak9DPRSOSWU
        AozAbbYB+dNolPb4e1Z95vb/U3KOl6iIUe1nIniQiQRN1UQSpV0+1LqlA3WgK+3vzAT8F+V5X4a17
        YB1zuZo6Wix5gJ3+S5M8Veokso7ZzpPXYFHOxpjgvJrfPkNsx+CE70gStDRBmHr7TYsznvwHHhltt
        A5vG/s6a7fyYYBwO201S2NB+idGiDOPovub9c1yXUWOukGZ+7IWmPYydf34HaptTRA59OyV0Zw4f4
        Ss++AdUwg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gaErX-00074U-SD; Fri, 21 Dec 2018 07:04:47 +0000
Date:   Thu, 20 Dec 2018 23:04:47 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Eric Biggers <ebiggers@kernel.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Victor Hsieh <victorhsieh@google.com>,
        Chandan Rajendra <chandan@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 01/12] fs-verity: add a documentation file
Message-ID: <20181221070447.GA21687@infradead.org>
References: <20181219071420.GC2628@infradead.org>
 <20181219021953.GD31274@dastard>
 <20181219193005.GB6889@mit.edu>
 <20181219213552.GO6311@dastard>
 <20181220220158.GC2360@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220220158.GC2360@mit.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 05:01:58PM -0500, Theodore Y. Ts'o wrote:
> That's simply not true.  Number one, fsverity is not mandatory for all
> file systems to implement.  If XFS doesn't want to implement fscrypt
> or fsverity, it doesn't have to.  Number two, we're not *making* any
> changes to the kernel code; nothing in mm/filemap.c, et. al.  So
> saying that we are making changes that are impacted by /everyone/ just
> doesn't make any sense.

Ted, I think you know yourself this isn't true.  Whenever we added
useful interface to one of the major file systems we had other pick
it up, and that is a good thing because the last thing we need is
fragmentation of interfaces.  And even if that wasn't the case I don't
think we should take short cuts, because even if an interface was just
for a file system or two it still needs to be properly desgined.

There is no reason to rush interfacs in, because everytime we have done
that it has turned out to be a very bad idea in retrospective.
