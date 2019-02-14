Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FD4C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ACF221928
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393622AbfBNQtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:49:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:60128 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726404AbfBNQtj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:49:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A5392B174;
        Thu, 14 Feb 2019 16:49:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 3BCF11E0900; Thu, 14 Feb 2019 17:49:37 +0100 (CET)
Date:   Thu, 14 Feb 2019 17:49:37 +0100
From:   Jan Kara <jack@suse.cz>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Subject: Re: linux-next: Tree for Feb 14 (fanotify)
Message-ID: <20190214164937.GC23000@quack2.suse.cz>
References: <20190214175138.3f69ec91@canb.auug.org.au>
 <b005f0f9-6db1-e9dc-a04c-bf37b37be8ce@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b005f0f9-6db1-e9dc-a04c-bf37b37be8ce@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 14-02-19 07:58:33, Randy Dunlap wrote:
> On 2/13/19 10:51 PM, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20190213:
> > 
> 
> seen on i386:
> 
> when # CONFIG_EXPORTFS_BLOCK_OPS is not set:
> 
> ld: fs/notify/fanotify/fanotify.o: in function `fanotify_alloc_event':
> fanotify.c:(.text+0x25a): undefined reference to `exportfs_encode_inode_fh'
> ld: fanotify.c:(.text+0x29e): undefined reference to `exportfs_encode_inode_fh'

Yeah, fanotify needs to select EXPORTFS now. Added patch to my tree. Thanks
for report!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
