Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1892792-1519750511-2-15535034854460839106
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519750510; b=dfNJLLrgvaeiUsizC3JDj2sUCOAszrdr6EvV9h5FkdC+EaE
    FkG/xKzbCl+xHKsMjxbUfXYhs3hCfx2U3HLBVaHAwFQ+8YIwulWNY2XRoXvIB5GD
    pBHNUqgRrGgzV6JU2zuOgT0e/3IrXwTHss8eX5c3O66cFjCT7Yrps0tvCu/ISToO
    HeW7ydXvYZrw6C1iwnGYA3HfbWm7QvElqD7h2QbGXOq8yBxMeM6jdCykFWNwIDdi
    23A4yoDGz3bDqyW8r7+wBhCTpkMZ1qBdKth0HXYdF91o9ddFDu70LL55/DNcMuPo
    pc/Jr+TNn3kRGJ/wilDBIcDDbUlZV2lH7HtQlww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519750510; bh=l3tdIyeJ3hg95XMhuZRSPc7zhn
    3tXRtR3yt+g3F9KLY=; b=oBGxoRjSchrw/E56HZrYBi1N0kCaq5uwlDL+/dNhsW
    sECcwxCTbJWa0s25lPg60SRYCqh0+uQkAsYuizHFxCZWuADAr9f4RTmnNPKZtfP+
    8Lm74LQb6iPhKwg6dRkhyJFpoP3N0R7WMpgKWgnPBeDE3VaGjrHKxZuqYxFVTE6Z
    p1rSaTMhwMRX5ZjYwzNiTLOJ5d4CpUKSrdqLvN/sPTM4VwLzVoaPoEf04rbgGMWN
    22ePl2P9+e8podXx92LZxZ5Gsxtg15VYVR98J5O2kJBlI2QkMEB7wvZbDL6O4s5M
    n9452OzpWDRwryhX3VBX+U1m31zLRPQ/sfFu2z1BVXRQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751818AbeB0Qyz (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 11:54:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:46812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750938AbeB0Qyx (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 27 Feb 2018 11:54:53 -0500
Date: Tue, 27 Feb 2018 17:54:49 +0100
From: Jan Kara <jack@suse.cz>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "supporter:XFS FILESYSTEM" <linux-xfs@vger.kernel.org>,
        linux-mm@kvack.org, Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: Re: [PATCH v4 02/12] dax: introduce IS_DEVDAX() and IS_FSDAX()
Message-ID: <20180227165449.abbhpu7gwqpxcqst@quack2.suse.cz>
References: <151970519370.26729.1011551137381425076.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151970520551.26729.12707678649514382892.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151970520551.26729.12707678649514382892.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon 26-02-18 20:20:05, Dan Williams wrote:
> The current IS_DAX() helper that checks the S_DAX inode flag is
> ambiguous, and currently has the broken assumption that the S_DAX flag

I don't think S_DAX flag is really ambiguous. It is just that in
CONFIG_FS_DAX=n + CONFIG_DEV_DAX=y case, the compiler is not able to figure
out some calls behind IS_DAX() are dead code and so the kernel won't
compile / link. Or is there any other problem I'm missing?

If I'm indeed right, then please tell this in the changelog and don't talk
about abstract ambiguity of S_DAX flag.

As much as I'd prefer to solve link-time problems with stubs instead of
relying on dead-code elimination, I can live with split macros so once the
changelog is settled, feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> is only non-zero in the CONFIG_FS_DAX=y case. In preparation for
> defining S_DAX to non-zero in the  CONFIG_FS_DAX=n + CONFIG_DEV_DAX=y
> case, introduce two explicit helpers to replace IS_DAX().
> 
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> Cc: linux-xfs@vger.kernel.org (supporter:XFS FILESYSTEM)
> Cc: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> Cc: <stable@vger.kernel.org>
> Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
> Reported-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  include/linux/fs.h |   22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 79c413985305..bd0c46880572 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1909,6 +1909,28 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
>  #define IS_WHITEOUT(inode)	(S_ISCHR(inode->i_mode) && \
>  				 (inode)->i_rdev == WHITEOUT_DEV)
>  
> +static inline bool IS_DEVDAX(struct inode *inode)
> +{
> +	if (!IS_ENABLED(CONFIG_DEV_DAX))
> +		return false;
> +	if ((inode->i_flags & S_DAX) == 0)
> +		return false;
> +	if (!S_ISCHR(inode->i_mode))
> +		return false;
> +	return true;
> +}
> +
> +static inline bool IS_FSDAX(struct inode *inode)
> +{
> +	if (!IS_ENABLED(CONFIG_FS_DAX))
> +		return false;
> +	if ((inode->i_flags & S_DAX) == 0)
> +		return false;
> +	if (S_ISCHR(inode->i_mode))
> +		return false;
> +	return true;
> +}
> +
>  static inline bool HAS_UNMAPPED_ID(struct inode *inode)
>  {
>  	return !uid_valid(inode->i_uid) || !gid_valid(inode->i_gid);
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
