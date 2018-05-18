Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-142507-1526666180-2-6185724792381904122
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526666180; b=PPBP9/xjmsnqVsxH+2W72nPpC9k1pOywlo06r2sx2rIbvoOH5r
    n6CnNwTgG+Ny3xuGYSfkmF8uaKe+3nNximeaIhxNx9Xk/R+WKd4WQfP+XGefjHsh
    UbB6RsyzYpEe8hZIUQ9o3qxn3diwKDAlkdpYLRFO8/aT0t8yqgFyM38ad88s7O/b
    tGcU2pJGFZ6U2VR9n7CHmufS375pEh0y6xZ5++nPIzrzH9HNGzSYws9YbyVDXgih
    ytrHb5IxWUz1oqyQ4sutmNk8RA9Xqod9Hlu5/OVoCm6Q8T9JHWjg582ZYruFkv0g
    t8K0h0ORyX5DWtt1LHVj79AWeXTBuXqdTm/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526666180;
    bh=+bpd2VBWoMn3lBXO4LJGm/A9F/b50iHhm9s6U8oOPMQ=; b=FeWAy4U7b3nt
    Vu+eT2l1UfiMxr6/1u/kJdw9rsQ2hTLZEqGN7SlaV7MlpEJe43qE+8wqZ/VBK9EC
    zobLSZxpSZYMoEESNJb1Xkc2rkL/XzXVB5bbuVzW62JZOnJrEcsMY8Nj0hvDPQJm
    Zq+NCXYhL03Ehl8ucLJc+a1hjkt4xYEw5u+U8c2zgxQ+3dV8lCnhB+iBiArEnEdh
    5rI21rs0IUkcMcElL+gjpXtKesQzKxHrd7Fv7/j5MzCfSSxCSGDlKDc9L13H2JdF
    tVZZ/3fIaoUOcdRQPxZtEhMvb9JCjM1HMftOcmEqtBBE7Zpxiqx6eSVK0/Oje069
    9F74kfrMPg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=NS5NimSt x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=NS5NimSt x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHXphLO5a2QHqrxd9BfYUzHxECEGriVDh3nb/vquQ4SLjKW2UdEiDYxclclSEXcZ0rE8myzS0SUKD6zwMzLwsnvTQphH+SoZcSz9iQ1cFyx53uHRJk8X
    2Mu1KjzcPXu6MOyYiLVef5LI9zHlBYE7/rM0zjWwgxkhMoHL+VmfD2WStS9zWSd317JtuX3cJ070fM2xE3WfqC3b8IMHTNwBMxRq17RHLkk2xoJDekfdSTd0
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=LtpHWJk-x2IrBlcYkBMA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751534AbeERR4Q (ORCPT <rfc822;linux@kroah.com>);
        Fri, 18 May 2018 13:56:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:37928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751197AbeERR4P (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 May 2018 13:56:15 -0400
Message-ID: <750c0197e6891caf348c4766396fb569db4f3e1f.camel@kernel.org>
Subject: Re: [RFC PATCH 01/11] vfs: push __sync_blockdev calls down into
 sync_fs routines
From: Jeff Layton <jlayton@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@ZenIV.linux.org.uk, willy@infradead.org, andres@anarazel.de
Date: Fri, 18 May 2018 13:56:07 -0400
In-Reply-To: <20180518155636.GB16931@infradead.org>
References: <20180518123415.28181-1-jlayton@kernel.org>
         <20180518123415.28181-2-jlayton@kernel.org>
         <20180518155636.GB16931@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.2 (3.28.2-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-05-18 at 08:56 -0700, Christoph Hellwig wrote:
> > --- a/fs/xfs/xfs_super.c
> > +++ b/fs/xfs/xfs_super.c
> > @@ -1097,7 +1097,7 @@ xfs_fs_sync_fs(
> >  	 * Doing anything during the async pass would be counterproductive.
> >  	 */
> >  	if (!wait)
> > -		return 0;
> > +		goto out;
> >  
> >  	xfs_log_force(mp, XFS_LOG_SYNC);
> >  	if (laptop_mode) {
> > @@ -1108,8 +1108,8 @@ xfs_fs_sync_fs(
> >  		 */
> >  		flush_delayed_work(&mp->m_log->l_work);
> >  	}
> > -
> > -	return 0;
> > +out:
> > +	return __sync_blockdev(sb->s_bdev, wait);
> 
> XFS never uses the block device mapping for anything, so this is
> not needed.
> 

Thanks, I wasn't sure about xfs. I'll drop this hunk.

FWIW, I think pushing this call down into the sync_fs routines is still
probably the right thing to do, regardless of the state of the later
patches.

> > +/*
> > + * Many legacy filesystems don't have a sync_fs op. For them, we just flush
> > + * the block device (if there is one).
> > + */
> > +static inline int call_sync_fs(struct super_block *sb, int wait)
> > +{
> > +	if (sb->s_op->sync_fs)
> > +		return sb->s_op->sync_fs(sb, wait);
> > +	return __sync_blockdev(sb->s_bdev, wait);
> > +}
> 
> The proper name for this would be vfs_sync_fs.  And I don't think it
> warrants an inline.

I patterned the name after the call_mmap (and now-defunct call_fsync)
helpers. I'll rename it and change it to be non-inlined.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>
