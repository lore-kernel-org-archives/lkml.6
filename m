Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2080671-1520012757-2-12728960360616617064
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
    t=1520012756; b=Jetqt+ApWER6yDcNBVZZjhvO2LLEwFTKmJi0j0+V3ELGHaZ
    wVgVhF6cZBsT6rQRXx2nBlWcZaBf9zOYpQ2NOqKc+ilLZdZX73GngB1djvXg0BS8
    6P4h1tlUqoCXlUkHlnm1uNc1YTPj/0aFilvF8mXniQBuzJk8Meu4zL9GMtENGBIQ
    e6POKsvHLFxYG7NAu3fo4R8xLwQSz/3nf3euUykDvPg6uCzGOCJxynwzVs7HWOdE
    HXyksQzonjcWpG8t6vw2J9HcrQwdr8UMcCPMqmzfUuJ7GuQwOCMSHy+59xb7LqXz
    uupxOC1c+Vh6jIAIfYQkReZzyOPGudgCPNuZAvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520012756; bh=oQv/naU0ffRqEAxYEVpNgigqhl
    EK8I6ogIeAyTAJVFk=; b=Atbf0tGmBZq0qAZLLEIm00bHzP7Xnz8gCkNKsPP530
    et22KM4Cp7wmGqp192sDUqqMMWoc8K3cCUMj9KxU+y6AcQBRZqVfqqyWZqyigbDy
    nUsxai7BkCOCmbXpXxHATu69HPJs1jEpVA7YHkQJTB3MNUJYnYkgCsqjJ2kPOvmc
    WaNj15jL93gi/ES172/LAyFl766mqdz0hkN1qcy4iPrRyXbSAM/a/lJg6kmmbq3s
    a6oQR0Eby9E8ptSbQDctpfyJPOmIRGE2dzKKQm4Vb/9GAGW7JXfJ9Q3rmdoN/qXK
    vk/u5fYTKMvWJWRFYhSHLak8uYYJzN3ALgubZ88uQuNw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=cIB8YQHZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=cIB8YQHZ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946825AbeCBRpy (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 12:45:54 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:57008 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946824AbeCBRpw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 12:45:52 -0500
Date: Fri, 2 Mar 2018 09:45:30 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-xfs@vger.kernel.org, Matthew Wilcox <mawilcox@microsoft.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        stable@vger.kernel.org, Jan Kara <jack@suse.cz>, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 02/12] dax: introduce IS_DEVDAX() and IS_FSDAX()
Message-ID: <20180302174530.GV19312@magnolia>
References: <151996281307.28483.12343847096989509127.stgit@dwillia2-desk3.amr.corp.intel.com>
 <151996282448.28483.10415125852182473579.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151996282448.28483.10415125852182473579.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8820 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803020209
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 01, 2018 at 07:53:44PM -0800, Dan Williams wrote:
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

I echo Jan's complaint from the last round that the dead code
elimination here is subtle, as compared to:

#if IS_ENABLED(CONFIG_FS_DAX)
static inline bool IS_FSDAX(struct inode *inode) { ... }
#else
# define IS_FSDAX(inode) (false)
#endif

But I guess even with that we're relying on dead code elimination higher
up in the call stack...

> +	if ((inode->i_flags & S_DAX) == 0)
> +		return false;
> +	if (S_ISCHR(inode->i_mode))
> +		return false;

I'm curious, do we have character devices with S_DAX set?

I /think/ we're expecting that only block/char devices and files will
ever have S_DAX set, so IS_FSDAX is only true for block devices and
files.  Right?

(A comment here about why S_ISCHR->false here would be helpful.)

--D

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
