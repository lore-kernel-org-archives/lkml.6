Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-321498-1526073161-2-15683865093946741752
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526073160; b=A5nY5Y7ybAhLbgWuYMKUSjnRkFJzuCF74xlwT9lVw2NckoC9zI
    lYnD8pFsNIaa49OeF37bbDMmnJTPNgDgq6Huen/PWhvKGWaV7Iq+8IoqJ3GFlMfH
    LNJJrvAAAZnjgID8DZKmfKqON7Gcq+sCozYNfoqxemilG0PAtLu3cG5sW+gNct59
    TD79Qz6vnS+zFe+fD6M61WrPl9lOpfb982eqxtgAXSFXeBmPVH3z2Sxuhs64kS3O
    oYhpzCFtLyDzV4dhoUC/UsJRlPHlnBiNMGD605dHweRSAlMM8/llmL+jgFmLxEVh
    QeVH4fjiyaJMncI/BlFNNbzKzqH893EBUUIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526073160; bh=hwhnts2nL3Fu1gQyM151BbvlH1ufPp
    UUABUcD9NplVw=; b=ggf4R1WKDUsx4mJtGLwLsq67PTsDmqnXRMW/xXCFL2NRbc
    jfdzYWMQdAUotrnzFj+5cBzBgZva0mN/wtmNFDHZcF4/WC+5ds4G7oZYBSeNUYZ3
    0pFkTgzoL0L4HmDQB18QTM2VHwZeEvms39mvfBYRchBpQTU5cejroSBgV9E+EtXX
    sEaDaLdZXDbpQMCEJi+dwg/PCrokmOWjiJSdarlosGFKPQtULwMvssF4PmeFr5Dq
    auE3mTbQ69DE+OHPRyLB255xKEqM+OhlKfnBTjAJCO2CZOu0xoB8ilJxCe8dWP83
    L5qEFcTKqMbwZ9Jt/d/r5hHTMXF+XnjGpwCMR3uw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNU8dDwEeOzGthV8d2D7JKSbIqE8lDOVY1sVH4uIlvHUPs5PXa1uOah2T2xye2WUxUi9qWSMQwIpXTlA7GG5xZh7+BNFDEcmvgV3gSO76FyieYf8flPH
    44POa+CI37cxgqamRrEzLEOpE5Tb5edezjOM2n86rxCd3kOTbZF7o6klDHcYnds0jN/i61N17CHUvLM/RxXIyKtl62uV58Z3Xdmu+Z4/sVPwLZg5tSFH+q+k
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=iox4zFpeAAAA:8 a=8gZpy_ZW4O30cTR4d4kA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751596AbeEKVMX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 17:12:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:37712 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750989AbeEKVMV (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Fri, 11 May 2018 17:12:21 -0400
Date: Fri, 11 May 2018 23:12:18 +0200
From: Jan Kara <jack@suse.cz>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: viro@zeniv.linux.org.uk, darrick.wong@oracle.com, tytso@mit.edu,
        adilger.kernel@dilger.ca, clm@fb.com, jbacik@fb.com,
        dsterba@suse.com, sandeen@sandeen.net, dhowells@redhat.com,
        fliu@suse.com, jack@suse.cz, jeffm@suse.com, nborisov@suse.com,
        jake.norris@suse.com, mtk.manpages@gmail.com,
        linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC v2 3/4] ext4: add verifier check for symlink with
 append/immutable flags
Message-ID: <20180511211218.rs365ftuw53c4qj2@quack2.suse.cz>
References: <20180510231359.16899-1-mcgrof@kernel.org>
 <20180510231359.16899-4-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510231359.16899-4-mcgrof@kernel.org>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu 10-05-18 16:13:58, Luis R. Rodriguez wrote:
> The Linux VFS does not allow a way to set append/immuttable
> attributes to symlinks, this is just not possible. If this is
> detected inform the user as the filesystem must be corrupted.
> 
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>

Looks good to me. You can add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 37a2f7a2b66a..6acf0dd6b6e6 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4947,6 +4947,13 @@ struct inode *ext4_iget(struct super_block *sb, unsigned long ino)
>  		inode->i_op = &ext4_dir_inode_operations;
>  		inode->i_fop = &ext4_dir_operations;
>  	} else if (S_ISLNK(inode->i_mode)) {
> +		/* VFS does not allow setting these so must be corruption */
> +		if (IS_APPEND(inode) || IS_IMMUTABLE(inode)) {
> +			EXT4_ERROR_INODE(inode,
> +			  "immutable or append flags not allowed on symlinks");
> +			ret = -EFSCORRUPTED;
> +			goto bad_inode;
> +		}
>  		if (ext4_encrypted_inode(inode)) {
>  			inode->i_op = &ext4_encrypted_symlink_inode_operations;
>  			ext4_set_aops(inode);
> -- 
> 2.17.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
