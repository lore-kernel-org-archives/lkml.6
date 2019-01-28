Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01879C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE9462147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 13:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XKO7Pj6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfA1Ndi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 08:33:38 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44218 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfA1Ndh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 08:33:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0SDTRot129794;
        Mon, 28 Jan 2019 13:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=YdMMLjt0gxeP8KhdI7P/Mha5J0O0hRqJOnX2qcshMM8=;
 b=XKO7Pj6Xu5U18VDpvEJlTglmBJHEvAqDjmclAPzyh2TBHyouafGk6NLb+wTLex0x0SpQ
 zRu8gBrKruavoNDS5vgZiabIT3kXoJ/1rXzfXO1zUCE9JkSkf6iCJ7ptwP2p8kPe9Wie
 LnI/mKzEHT3n/TNpR/IXv7NUaxueSYHt0vu964viG8GEkwO4l5MQXLAfuqNPjrqc6IKs
 2RJd1XuiDDN68GcptHGFFslBXXFUt+Nde/oLus0Xq5OUuM2DQj16TuijRsfaqLL6+yui
 A/U5drWeyEYnfaMNsfhmbVwa0W5zcBAAR89Br7SfAhe6i27iQvE7aSL+WsFjvM/qpnsR 2A== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2q8eyu63a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jan 2019 13:33:21 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x0SDXDeF005874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jan 2019 13:33:14 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0SDXDRm031706;
        Mon, 28 Jan 2019 13:33:13 GMT
Received: from kadam (/197.157.34.178)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 28 Jan 2019 05:33:12 -0800
Date:   Mon, 28 Jan 2019 16:33:02 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Gao Xiang <gaoxiang25@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        weidu.du@huawei.com, Fang Wei <fangwei1@huawei.com>,
        Miao Xie <miaoxie@huawei.com>
Subject: Re: [PATCH v2 2/2] staging: erofs: complete POSIX ACL support
Message-ID: <20190128133302.GI1795@kadam>
References: <20190125161007.4447-1-gaoxiang25@huawei.com>
 <20190125161007.4447-2-gaoxiang25@huawei.com>
 <94daa491-40c8-4a09-a0b5-55a7e92dc3fc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94daa491-40c8-4a09-a0b5-55a7e92dc3fc@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9149 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901280105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 26, 2019 at 10:48:53AM +0800, Chao Yu wrote:
> On 2019/1/26 0:10, Gao Xiang wrote:
> > Let's add .get_acl() to read the file's acl from its xattrs
> > to make POSIX ACL usable.
> > 
> > Here is the on-disk detail,
> > fullname: system.posix_acl_access
> > struct erofs_xattr_entry:
> >         .e_name_len = 0
> >         .e_name_index = EROFS_XATTR_INDEX_POSIX_ACL_ACCESS (2)
> > 
> > fullname: system.posix_acl_default
> > struct erofs_xattr_entry:
> > 	.e_name_len = 0
> > 	.e_name_index = EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT (3)
> > 
> > Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> > ---
> > change log v2:
> >  - add the missing SB_POSIXACL flag;
> >  - fix the on-disk detail, use .e_name_len == 0 and proper prefix value;
> >  - tested ok with xattr enabled erofs_mkfs;
> 
> >  .../erofs/Documentation/filesystems/erofs.txt      |  2 ++
> >  drivers/staging/erofs/inode.c                      |  3 ++
> >  drivers/staging/erofs/namei.c                      |  1 +
> >  drivers/staging/erofs/super.c                      |  8 +++++
> >  drivers/staging/erofs/xattr.c                      | 37 ++++++++++++++++++++++
> >  drivers/staging/erofs/xattr.h                      |  6 ++++
> >  6 files changed, 57 insertions(+)
> > 
> > diff --git a/drivers/staging/erofs/Documentation/filesystems/erofs.txt b/drivers/staging/erofs/Documentation/filesystems/erofs.txt
> > index 803988d74c21..961ec4da7705 100644
> > --- a/drivers/staging/erofs/Documentation/filesystems/erofs.txt
> > +++ b/drivers/staging/erofs/Documentation/filesystems/erofs.txt
> > @@ -36,6 +36,8 @@ Here is the main features of EROFS:
> >  
> >   - Support xattr inline and tail-end data inline for all files;
> >  
> > + - Support POSIX.1e ACLs by using xattrs;
> > +
> >   - Support transparent file compression as an option:
> >     LZ4 algorithm with 4 KB fixed-output compression for high performance;
> >  
> > diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
> > index 4f04f7c38cf2..924b8dfc7a8f 100644
> > --- a/drivers/staging/erofs/inode.c
> > +++ b/drivers/staging/erofs/inode.c
> > @@ -287,6 +287,7 @@ const struct inode_operations erofs_generic_iops = {
> >  #ifdef CONFIG_EROFS_FS_XATTR
> >  	.listxattr = erofs_listxattr,
> >  #endif
> > +	.get_acl = erofs_get_acl,
> >  };
> >  
> >  const struct inode_operations erofs_symlink_iops = {
> > @@ -294,6 +295,7 @@ const struct inode_operations erofs_symlink_iops = {
> >  #ifdef CONFIG_EROFS_FS_XATTR
> >  	.listxattr = erofs_listxattr,
> >  #endif
> > +	.get_acl = erofs_get_acl,
> >  };
> >  
> >  const struct inode_operations erofs_fast_symlink_iops = {
> > @@ -301,5 +303,6 @@ const struct inode_operations erofs_fast_symlink_iops = {
> >  #ifdef CONFIG_EROFS_FS_XATTR
> >  	.listxattr = erofs_listxattr,
> >  #endif
> > +	.get_acl = erofs_get_acl,
> >  };
> >  
> > diff --git a/drivers/staging/erofs/namei.c b/drivers/staging/erofs/namei.c
> > index 7fed1f996ab0..b1752adc5934 100644
> > --- a/drivers/staging/erofs/namei.c
> > +++ b/drivers/staging/erofs/namei.c
> > @@ -238,5 +238,6 @@ const struct inode_operations erofs_dir_iops = {
> >  #ifdef CONFIG_EROFS_FS_XATTR
> >  	.listxattr = erofs_listxattr,
> >  #endif
> > +	.get_acl = erofs_get_acl,
> >  };
> >  
> > diff --git a/drivers/staging/erofs/super.c b/drivers/staging/erofs/super.c
> > index 176fca2af379..54cd7dac0a1f 100644
> > --- a/drivers/staging/erofs/super.c
> > +++ b/drivers/staging/erofs/super.c
> > @@ -398,6 +398,14 @@ static int erofs_read_super(struct super_block *sb,
> >  	if (!silent)
> >  		infoln("root inode @ nid %llu", ROOT_NID(sbi));
> >  
> > +#ifdef CONFIG_EROFS_FS_POSIX_ACL
> > +	/* Update the POSIXACL Flag */
> > +	if (test_opt(sbi, POSIX_ACL))
> > +		sb->s_flags |= SB_POSIXACL;
> > +	else
> > +		sb->s_flags &= ~SB_POSIXACL;
> > +#endif
> > +
> >  #ifdef CONFIG_EROFS_FS_ZIP
> >  	INIT_RADIX_TREE(&sbi->workstn_tree, GFP_ATOMIC);
> >  #endif
> > diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
> > index 7de46690d972..6759485ae862 100644
> > --- a/drivers/staging/erofs/xattr.c
> > +++ b/drivers/staging/erofs/xattr.c
> > @@ -643,3 +643,40 @@ ssize_t erofs_listxattr(struct dentry *dentry,
> >  	return shared_listxattr(&it);
> >  }
> >  
> > +#ifdef CONFIG_EROFS_FS_POSIX_ACL
> > +struct posix_acl *erofs_get_acl(struct inode *inode, int type)
> > +{
> > +	struct posix_acl *acl;
> > +	int ea_prefix, rc;
> > +	char *value = NULL;
> > +
> > +	switch(type) {
> > +	case ACL_TYPE_ACCESS:
> > +		ea_prefix = EROFS_XATTR_INDEX_POSIX_ACL_ACCESS;
> > +		break;
> > +	case ACL_TYPE_DEFAULT:
> > +		ea_prefix = EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT;
> > +		break;
> > +	default:
> > +		return ERR_PTR(-EINVAL);
> > +	}
> > +
> > +	rc = erofs_getxattr(inode, ea_prefix, "", NULL, 0);
> > +	if (rc > 0) {
> > +		value = kvmalloc(rc, GFP_KERNEL);
> 
> erofs_kmalloc() is enough?
> 
> Thanks,
> 

Hopefully, regular kmalloc() is enough.

Do really need the erofs_kmalloc() function?  Regular kmalloc() has
fault injection already.  Have you tried to use it?

regards,
dan carpenter


