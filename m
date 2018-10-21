Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7444ECDE3D
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 09:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C4212083E
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 09:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20150623.gappssmtp.com header.i=@philpotter-co-uk.20150623.gappssmtp.com header.b="1+nxgMXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C4212083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbeJUSLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 14:11:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37549 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbeJUSK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 14:10:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id g9-v6so432421wrq.4
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 02:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c+BLAiFIYW5qzYAcYGu25/ascoY7iKfu070ZTpSyk6I=;
        b=1+nxgMXovpSHSXBXaQ5Vio3+MHt5bsOeL8dnkkKpj/mBfx6isvb9VtBK7e8DFziV94
         koa45raUZxNtKGLDSVQtZQ5AbUNQaJzVUFfMILP39DMA/+gJRyrrtRjvdUPwJgRfcHBz
         1QghhDfzWU9D+vVAZ1fc4NjzLI8sAwAbl5rV+mrXUlhxb7/ext8azBddcDojySUtt3gt
         y/45Wkqp6g6Ifj3t/iGt7w6H/LVwMXyXdSad8M1oXDekQjGiCr8YCyK+ImvU2BhyWLwE
         J7uuOSJX+/9MLGlKuLFIWvh+y9xXnlU5tm+sJZRw27iO+XfN3XcRvcSl1ENRQ6mILCOs
         tYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c+BLAiFIYW5qzYAcYGu25/ascoY7iKfu070ZTpSyk6I=;
        b=CFxss7aHY3ilD83R/kmDFYZ8K2TrTpCj55mvt7RhXsUP2++kGcXT9EMm6HbGdJoGpL
         2IE2qyMVJqseeysdfzFm8XSvG0n4Vm+6OPUPi51plp1ljk58Odocmj0EMPZN31S9rtzV
         D9Rzw2byuOKuvDqgMkT2q9V/l7qTMZpd+JhdfFxKvdjuQUNyX3nXyf5fFm+jn9+RdXuL
         MBTbQLSalgKfJ3MV2So4x1qZZ28IojrXyqNx0X45GFOdytDTJJ+BRN+SLzEMlEYrwiCB
         zrkhByOQSZruyzo7uA29fHTLGcGiF2WkdP4cPMr91dV2NuWL23QrZf+dthEaHTo+5cCb
         48hQ==
X-Gm-Message-State: ABuFfohG+dh9QZe4jJfY9XZLE/S7RMCAMLs9Ay2VEoJS6lgImzgD7sKb
        XvGONvL6mxXZqMvqAT0DVCDTMw==
X-Google-Smtp-Source: ACcGV63bjiSl4NXJpUddu+jRvlh/VOh18cr4Y9+DCdJSJaZnuyxynJfF5c1g2BnDa5O4gnenlk0/6w==
X-Received: by 2002:adf:ecc9:: with SMTP id s9-v6mr38805787wro.142.1540115833159;
        Sun, 21 Oct 2018 02:57:13 -0700 (PDT)
Received: from pathfinder (62-64-249-96.dynamic.dsl.as9105.com. [62.64.249.96])
        by smtp.gmail.com with ESMTPSA id g15-v6sm21040217wrp.56.2018.10.21.02.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 02:57:12 -0700 (PDT)
Date:   Sun, 21 Oct 2018 10:57:10 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     willy@infradead.org, dushistov@mail.ru, viro@zeniv.linux.org.uk,
        David.Laight@aculab.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: ufs: Remove switch statement from ufs_set_de_type
 function
Message-ID: <20181021095710.GA3482@pathfinder>
References: <20181020220957.GA7267@pathfinder>
 <20181020222637.GA3477@bombadil.infradead.org>
 <CAOQ4uxhO_-B12280jT5RHX3oMjoSTHG73=PyDDVfURs-ey-EkA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhO_-B12280jT5RHX3oMjoSTHG73=PyDDVfURs-ey-EkA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2018 at 08:30:35AM +0300, Amir Goldstein wrote:
> On Sun, Oct 21, 2018 at 1:27 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Sat, Oct 20, 2018 at 11:09:57PM +0100, Phillip Potter wrote:
> > > Remove switch statement from ufs_set_de_type function in fs/ufs/util.h
> > > header and replace with simple assignment. For each case, S_IFx >> 12
> > > is equal to DT_x, so in valid cases (mode & S_IFMT) >> 12 should give
> > > us the correct file type. It is expected that for *nix compatibility
> > > reasons, the relation between S_IFx and DT_x will not change. For
> > > cases where the mode is invalid, upper layer validation catches this
> > > anyway, so this improves readability and arguably performance by
> > > assigning (mode & S_IFMT) >> 12 directly without any jump table
> > > or conditional logic.
> >
> > Shouldn't we also do this for other filesystems?  A quick scan suggests
> > someone should at least look at xfs, ubifs, squashfs, romfs, ocfs2,
> > nilfs2, hfsplus, f2fs, ext4, ext2, exofs, coda, cifs & btrfs.
> >
> 
> I've tried to do that 2 years ago, not even for readability, but to
> fix a lurking
> bug in conversion table implementation that was copy&pasted from ext2 to
> many other fs:
> https://marc.info/?l=linux-fsdevel&m=148217829301701&w=2
> https://marc.info/?l=linux-fsdevel&w=2&r=1&s=amir73il+file+type+conversion&q=b
> 
> The push back from ext4/xfs maintainers was that while all fs use common
> values to encode d_type in on disk format, those on-disk format values
> are private to the fs.
> 
> Eventually, the fix that got merged (only to xfs) did the opposite, it converted
> the conversion table lookup to a switch statement:
> https://marc.info/?l=linux-fsdevel&m=148243866204444&w=2
> 
> Some fs maintainers were happy about the initial version, but I did not
> pursue pushing that cleanup:
> https://marc.info/?l=linux-fsdevel&m=148243866204444&w=2
> 
> Phillip, you are welcome to re-spin those patches if you like.
> Note that the generic conversion helpers do not rely on upper layer
> to catch invalid mode values.
> 
> Cheers,
> Amir.

I only changed this code in the first place because of the comment in the code -
I was looking for things to do basically, and this caught my eye because I play
with FreeBSD now and then which of course uses UFS. I didn't consider any use
to the other filesystems - by re-spin do you just mean fix up and make sure
the kernel still builds etc?

Regards,
Phil
