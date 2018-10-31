Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 767D3ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC4D2082B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CC4D2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fromorbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729029AbeJaKId (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 06:08:33 -0400
Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:43959 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729014AbeJaKId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 06:08:33 -0400
Received: from ppp59-167-129-252.static.internode.on.net (HELO dastard) ([59.167.129.252])
  by ipmail06.adl2.internode.on.net with ESMTP; 31 Oct 2018 11:42:42 +1030
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1gHf3p-0006Zd-5K; Wed, 31 Oct 2018 12:12:41 +1100
Date:   Wed, 31 Oct 2018 12:12:41 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Fasheh <mfasheh@suse.de>
Subject: Re: linux-next: manual merge of the vfs tree with the xfs tree
Message-ID: <20181031011241.GV19305@dastard>
References: <20181031115247.6adcb659@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031115247.6adcb659@canb.auug.org.au>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2018 at 11:52:47AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> [I don't understand why all this new work turned up in the xfs tree
> during the merge window ...]
> 
> Today's linux-next merge of the vfs tree got a conflict in:
> 
>   fs/read_write.c
> 
> between commits:
> 
>   42ec3d4c0218 ("vfs: make remap_file_range functions take and return bytes completed")
>   eca3654e3cc7 ("vfs: enable remap callers that can handle short operations")
> 
> from the xfs tree and commit:
> 
>   5de4480ae7f8 ("vfs: allow dedupe of user owned read-only files")
> 
> from the vfs tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Looks ok. I didn't expect this conflict, but looks simple enough
to resolve. Thanks!

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
