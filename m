Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4169591-1526659003-2-11922234950625239576
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526659003; b=Jo1VYz0kbT9wC2rfVfAQZobGXEQDDnHVY4KUhlywqag/GioNli
    mKtIxCzsmLXHCh7mnPPEyMxXEQoM5LQKuwzIvYTP0HXLiwfQ8IVwbf7qjSXotyE/
    r7iiRQvssO4r+ZKOXCTffj45z3Lf92zvKUL6o8M8z2gaxT6FtBIKg3yj/L2fdAUc
    SXcUIRDuX7rgYvgumZ58AH+qFMKvY66j8sv0O4vsQiVOvKkcZ1tWGP/sW1DOxv8M
    ASj6yd8Ki+x+hHRaB1uvHUKiOvnGif+NnBt1Q6Yt+FkjHub1bGtknxyzTo8L0DJI
    n2No2N4X7xLw8NNHNncOFhGD/xOHcPepNSHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526659003; bh=jshB91DgEvtONrGKXY6XUVbEidGbK4
    wreeWBNezqlWE=; b=B6swLswZU1E4f8k3XgL92bVfKZGlYCfj65tpX4ftNHW1Dw
    AJzAU1ZJObpAdGnKENtnvaFGUyfJFNuVf5iJGAOKPGARvXuMcpqWQTBpkvU/jjTA
    m2teyBa81TflgFdaysuKcZVb4TgqzAD1d7uXo/DhT2GVMeuY0EN9VHjF7Wz9yT6Q
    E90TJcG7Hl9AyHjj3hK3rQl6aG/di0Qo2p+Tnxi2TcG1i3ro99CCk1vQWP2JEcIW
    BXR2XKN68UoQ3WK6GKyEcAVlk0pV2xZzabrHVcZTWMDXg6klEJ0Bp631ZFrGFryd
    eiEj/axiI4k7nJL3kNTbF8u7UDHuFMiEh0Z+GoeQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=eh6MC9GD
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=eh6MC9GD
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfARttUpVFSWi3NQj4KCxxsguvojaB+IsQoQZCx7qjBbMncxpiIRh9Y3A+mLx2L7LOwK1AX3h5Mr55kvhON1+jx4DGCvbbo1IgzxkJPrVULZovyPtxNym
    KjQ1chTjfcLdCFdm8FNBeUGhWZ2VceJt30nT3SyAq6p4nOGYOP3yhxNAePVAOcrfT5dDkPfxWRCFs6HkuzKyTR/baCG2awZy10o8rYht9MS1ds03kFYdYW3X
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=7Qk0fJ1BySL2App3qm4A:9 a=CjuIK1q_8ugA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbeERP4h (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 11:56:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57430 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750763AbeERP4g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 May 2018 11:56:36 -0400
Date: Fri, 18 May 2018 08:56:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@ZenIV.linux.org.uk, willy@infradead.org, andres@anarazel.de
Subject: Re: [RFC PATCH 01/11] vfs: push __sync_blockdev calls down into
 sync_fs routines
Message-ID: <20180518155636.GB16931@infradead.org>
References: <20180518123415.28181-1-jlayton@kernel.org>
 <20180518123415.28181-2-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518123415.28181-2-jlayton@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1097,7 +1097,7 @@ xfs_fs_sync_fs(
>  	 * Doing anything during the async pass would be counterproductive.
>  	 */
>  	if (!wait)
> -		return 0;
> +		goto out;
>  
>  	xfs_log_force(mp, XFS_LOG_SYNC);
>  	if (laptop_mode) {
> @@ -1108,8 +1108,8 @@ xfs_fs_sync_fs(
>  		 */
>  		flush_delayed_work(&mp->m_log->l_work);
>  	}
> -
> -	return 0;
> +out:
> +	return __sync_blockdev(sb->s_bdev, wait);

XFS never uses the block device mapping for anything, so this is
not needed.

> +/*
> + * Many legacy filesystems don't have a sync_fs op. For them, we just flush
> + * the block device (if there is one).
> + */
> +static inline int call_sync_fs(struct super_block *sb, int wait)
> +{
> +	if (sb->s_op->sync_fs)
> +		return sb->s_op->sync_fs(sb, wait);
> +	return __sync_blockdev(sb->s_bdev, wait);
> +}

The proper name for this would be vfs_sync_fs.  And I don't think it
warrants an inline.
