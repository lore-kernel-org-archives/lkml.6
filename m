Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BE7ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B022075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B022075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbeGRTIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 15:08:54 -0400
Received: from mail.bootlin.com ([62.4.15.54]:36867 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbeGRTIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 15:08:54 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E91E920766; Wed, 18 Jul 2018 20:29:43 +0200 (CEST)
Received: from bbrezillon (unknown [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id BD2B7209C7;
        Wed, 18 Jul 2018 20:28:51 +0200 (CEST)
Date:   Wed, 18 Jul 2018 20:28:51 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Richard Weinberger <richard@nod.at>
Cc:     Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        linux-mtd@lists.infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [PATCH 1/2] [RESEND] jffs2: use 64-bit intermediate timestamps
Message-ID: <20180718202851.1011fb4e@bbrezillon>
In-Reply-To: <20180717215453.04509003@bbrezillon>
References: <20180713144739.3150217-1-arnd@arndb.de>
        <2205649.NecG7tB80L@blindfold>
        <20180717215453.04509003@bbrezillon>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jul 2018 21:54:53 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> On Fri, 13 Jul 2018 22:47:13 +0200
> Richard Weinberger <richard@nod.at> wrote:
> 
> > Am Freitag, 13. Juli 2018, 16:47:16 CEST schrieb Arnd Bergmann:  
> > > The VFS now uses timespec64 timestamps consistently, but jffs2 still
> > > converts them to 32-bit numbers on the storage medium. As the helper
> > > functions for the conversion (get_seconds() and timespec_to_timespec64())
> > > are now deprecated, let's change them over to the more modern
> > > replacements.
> > > 
> > > This keeps the traditional interpretation of those values, where
> > > the on-disk 32-bit numbers are taken to be negative numbers, i.e.
> > > dates before 1970, on 32-bit machines, but future numbers past 2038
> > > on 64-bit machines.
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > ---
> > > I originally sent these two patches on Jun 19, but got no reply aside
> > > from a harmless sparse warning reported by the kbuild test robot.
> > > 
> > > Looking at the git history for jffs2, it seems that David Woodhouse
> > > hasn't applied any patches for over two years, so I suppose he's
> > > not taking these either.
> > > 
> > > Al or Andrew, could you pick these up instead?    
> > 
> > We can carry it also via the MTD tree.  
> 
> I'll queue them to mtd/next.

Applied.

Thanks,

Boris

> 
> Thanks,
> 
> Boris
> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/

