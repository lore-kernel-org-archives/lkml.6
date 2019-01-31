Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B9BC169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F2C20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 10:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbfAaKLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 05:11:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:49844 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729232AbfAaKLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 05:11:24 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2CB6DAF3C;
        Thu, 31 Jan 2019 10:11:23 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2F31E1E3FFD; Thu, 31 Jan 2019 11:11:22 +0100 (CET)
Date:   Thu, 31 Jan 2019 11:11:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jan Kara <jack@suse.cz>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the ext3 tree
Message-ID: <20190131101122.GD19222@quack2.suse.cz>
References: <20190131151411.7e8b89b3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131151411.7e8b89b3@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 31-01-19 15:14:11, Stephen Rothwell wrote:
> Hi Jan,
> 
> After merging the ext3 tree, today's linux-next build (powerpc
> ppc44x_defconfig) failed like this:
> 
> ld: fs/ext2/super.o: in function `ext2_fill_super':
> super.c:(.text+0x1494): undefined reference to `__divdi3'
> ld: super.c:(.text+0x14bc): undefined reference to `__divdi3'
> 
> Caused by commit
> 
>   455d38a0e62f ("ext2: Fix underflow in ext2_max_size()")
> 
> I have reverted that commit for today.

Yeah, I've fixed that already in my tree. Thanks for letting me know and
sorry for the breakage.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
