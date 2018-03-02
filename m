Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2351456-1520020723-2-5775380285938129295
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520020723; b=K/QBM2sIi/P1KOiqAmX30Hbhdidtdoh20kQZEz1ljuacau2
    9msEBUwHeJ3XsdYDinx3HSAe2Ax4BXCPoJ2zOs45SboW9TGfLZ+gq5L0eE4BBueF
    yp2BYLGubpwqeKUN8okwO7tDgyfnU0ICCFaCDjiBEB0Kxnb1bvLB2fWuCxLTAWfx
    RXOgnaVF5wjl8Tw5pEWgFhnb9oD8/Edrj4gv6EPRjTepxuQppQdzoVWpx4QlKjoD
    P76lK41VHEAuTz3UiWaAsYvNBDDh5uHcbVVcTDW096OWbOlekgA5VId398jEbmaW
    d5kgj8+mLejWlBnYrw71GK6wqus93abYnWvFPjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520020723; bh=65LEN5xTWlQB/3uXYAZgDeJUe+
    lXVuUdeRDIZqrd/q4=; b=oZ9yWyH+xFQlbUEDwtSSzMsMgJW6IKlvkjjIsuyQu0
    cX6SYyiJZMfdLRXIR88sOM0PUapNJMVoUXagFmnrWjuvulthyYDfH/sd2OPOZJTO
    ef4siSE2K0AztPoZL5yQz6kZjDThU3SWY9t3u5Azjdy/1cFG4l+Q2//6VzA4RJq0
    IkIPR0wujKKBbxEHsf5EkyTxK3Jo3y3OgEDnO9AvLi+ZvFfjUyhHY9MUsvo8x3NS
    LCdGIg2IjTRS430Os4EFiW7eEkZNotTSr3SPAefWmJFq7IsUqNBnH4+//47rxG28
    Ver01CnX5xAgfrFHOy1/F2jgADKwze5GUYIgEhZ32u3w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=kDCsoWSN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=kDCsoWSN x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932494AbeCBT61 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 14:58:27 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60816 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932131AbeCBT60 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 14:58:26 -0500
Date: Fri, 2 Mar 2018 11:58:11 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-xfs@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] dax: introduce IS_DEVDAX() and IS_FSDAX()
Message-ID: <20180302195811.GA18989@magnolia>
References: <CAPcyv4iu32ja_vPiN=E0DP7_PFaj887XQ48EOMupE0Q4p1dCkQ@mail.gmail.com>
 <152001757529.22146.17936438768625217740.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152001757529.22146.17936438768625217740.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8820 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803020235
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 11:06:36AM -0800, Dan Williams wrote:
> The current IS_DAX() helper that checks if a file is in DAX mode serves
> two purposes. It is a control flow branch condition for DAX vs
> non-DAX paths and it is a mechanism to perform dead code elimination. The
> dead code elimination is required in the CONFIG_FS_DAX=n case since
> there are symbols in fs/dax.c that will be elided. While the
> dead code elimination can be addressed with nop stubs for the fs/dax.c
> symbols that does not address the need for a DAX control flow helper
> where fs/dax.c symbols are not involved.
> 
> Moreover, the control flow changes, in some cases, need to be cognizant
> of whether the DAX file is a typical file or a Device-DAX special file.
> Introduce IS_DEVDAX() and IS_FSDAX() to simultaneously address the
> file-type control flow and dead-code elimination use cases. IS_DAX()
> will be deleted after all sites are converted to use the file-type
> specific helper.
> 
> Note, this change is also a pre-requisite for fixing the definition of
> the S_DAX inode flag in the CONFIG_FS_DAX=n + CONFIG_DEV_DAX=y case.
> The flag needs to be defined, non-zero, if either DAX facility is
> enabled.
> 
> Cc: "Theodore Ts'o" <tytso@mit.edu>
> Cc: Andreas Dilger <adilger.kernel@dilger.ca>
> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
> Cc: linux-xfs@vger.kernel.org
> Cc: Matthew Wilcox <mawilcox@microsoft.com>
> Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
> Cc: <stable@vger.kernel.org>
> Fixes: dee410792419 ("/dev/dax, core: file operations and dax-mmap")
> Reported-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> Changes since v5:
> * add comments to clarify the S_ISCHR() checks (Darrick)

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> 
>  include/linux/fs.h |   24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 79c413985305..751975b8b29b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1909,6 +1909,30 @@ static inline bool sb_rdonly(const struct super_block *sb) { return sb->s_flags
>  #define IS_WHITEOUT(inode)	(S_ISCHR(inode->i_mode) && \
>  				 (inode)->i_rdev == WHITEOUT_DEV)
>  
> +static inline bool IS_DEVDAX(struct inode *inode)
> +{
> +	if (!IS_ENABLED(CONFIG_DEV_DAX))
> +		return false;
> +	if ((inode->i_flags & S_DAX) == 0)
> +		return false;
> +	/* regular files with S_DAX are filesystem-dax instances */
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
> +	/* character devices with S_DAX are device-dax instances */
> +	if (S_ISCHR(inode->i_mode))
> +		return false;
> +	return true;
> +}
> +
>  static inline bool HAS_UNMAPPED_ID(struct inode *inode)
>  {
>  	return !uid_valid(inode->i_uid) || !gid_valid(inode->i_gid);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-xfs" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
