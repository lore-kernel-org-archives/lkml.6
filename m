Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2771586-1526396505-2-10037404198454455364
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES roenca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526396499; b=OPbE9ccHVTIjqEJA3GddKx0mIK7OOP2/E+hbYKNcR9SHVrzzWB
    cQvp34+Wpcdk/XuxtZHfGj3L6qH5O3ZQOHzNJ1r/Mml30Qt/iLfJZmxCttjEfdno
    6e6z2CKjsWh9KZK89aBFhe4tj2i+tfExRDKAvduUrsl5vjKjnURIgNMTB2TxeIav
    W43jMK/8vMcFlVPheXbRw88AE/qfapBev5pQ7IrWMOS5FWiQ4jap/w7HHHokCo60
    kDWOzbjNQKGZxoLhuMIlxqG1PmD83yjYnAbTS13fEpQ0vIMDXBq4cbLpbbNbF/ZI
    wI7Tia7abpEFKsJKcoSJqYngDOoPCh9ltXaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526396499; bh=cPsfk
    B7ARECuGVs9cvn98yjYvurKWbggOUfhvWGGAZ4=; b=MhWAL7ZVGNbkhjjeejQa0
    ebsPqsc3HFLmN550U/CB0S+JiFqCcwHSkF5appo4INteK5IHTlgX45tYOLlMOatv
    JaOfMQ64K9qpqAEzrMnfhRa8H+rGH6HZ+YHK5FAx1m99aZS67ZAk0hfvP99op+vN
    2LpkeoMzMW578lJhOBbbEumzl0rv6syEuDgHeX5RmWLJ99Lv0+i4noTUzHZIUn4L
    +A1+N93dIZOO1y5OuAPedsk0cZcPsSSx2h6bjHzMTVUtKloMw/yFGTC49nwO7fLD
    zMGhoeXCibranX2v4VHL5T5n809VsE7/EbyNjitI/T7Iwe0ULWyPJCZUGBxlo0CD
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=qJ/rNbVS
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=qJ/rNbVS
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIec3ta7TqCcXYoXb6p16Qf86UBfeGylzMfRmHGRPyaXlgnxT+WepHDhgVknLmPOSEX+JKi+50oO7mn9XxjD1ao9zQ4abPJgn2+86nBgj4msSO9qD19g
    2c2pWDGM7n/2HJe0SeTgND7/I9uiCmBo3eCgEIsfV4X6KHCJx+yNpwjRv7uj/qn9Dz6JvM7wnVmwdkHFHsn7X7xa1tCITXPTHdHq6G99vSYd1kwhlPHLVRCa
    y4PTVC62aHje5F/jotHF8A==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=CjxXgO3LAAAA:8
    a=ySfo2T4IAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=Y-UXKRvapeC9QzRg5woA:9
    a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Improper folded header field made up
 entirely of whitespace (char 20 hex): X-Spam-Report: ....0 points, 5.0
 required)\n \n  pts rule nam[...]
Date: Tue, 15 May 2018 16:01:28 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH v2 1/5] staging: lustre: llite: add support set_acl method
 in inode operations
In-Reply-To: <878t8l7ext.fsf@notabene.neil.brown.name>
Message-ID: <alpine.LFD.2.21.1805151600430.28403@casper.infradead.org>
References: <1526350623-4616-1-git-send-email-jsimmons@infradead.org>
 <1526350623-4616-2-git-send-email-jsimmons@infradead.org>
 <878t8l7ext.fsf@notabene.neil.brown.name>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180515_160129_039667_2E2B8083 
X-CRM114-Status: GOOD (  31.39  )
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Dmitry Eremin <dmitry.eremin@intel.com>,
 James Simmons <uja.ornl@yahoo.com>, Andreas Dilger <andreas.dilger@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Oleg Drokin <oleg.drokin@intel.com>,
 "John L. Hammond" <john.hammond@intel.com>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> On Mon, May 14 2018, James Simmons wrote:
> 
> > From: Dmitry Eremin <dmitry.eremin@intel.com>
> >
> > Linux kernel v3.14 adds set_acl method to inode operations.
> > This patch adds support to Lustre for proper acl management.
> >
> > Signed-off-by: Dmitry Eremin <dmitry.eremin@intel.com>
> > Signed-off-by: John L. Hammond <john.hammond@intel.com>
> > Signed-off-by: James Simmons <uja.ornl@yahoo.com>
> > Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9183
> > Reviewed-on: https://review.whamcloud.com/25965
> > Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-10541
> > Reviewed-on: https://review.whamcloud.com/31588
> > Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-10926
> > Reviewed-on: https://review.whamcloud.com/32045
> > Reviewed-by: Bob Glossman <bob.glossman@intel.com>
> > Reviewed-by: James Simmons <uja.ornl@yahoo.com>
> > Reviewed-by: Andreas Dilger <andreas.dilger@intel.com>
> > Reviewed-by: Dmitry Eremin <dmitry.eremin@intel.com>
> > Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
> > Signed-off-by: James Simmons <jsimmons@infradead.org>
> > ---
> > Changelog:
> >
> > v1) Initial patch ported to staging tree
> > v2) Fixed up goto handling and avoid BUG() when calling
> >     forget_cached_acl()with invalid type as pointed out by Dan Carpenter
> >
> >  drivers/staging/lustre/lustre/llite/file.c         | 62 ++++++++++++++++++++++
> >  .../staging/lustre/lustre/llite/llite_internal.h   |  4 ++
> >  drivers/staging/lustre/lustre/llite/namei.c        | 10 +++-
> >  3 files changed, 74 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/staging/lustre/lustre/llite/file.c b/drivers/staging/lustre/lustre/llite/file.c
> > index 0026fde..64a5698 100644
> > --- a/drivers/staging/lustre/lustre/llite/file.c
> > +++ b/drivers/staging/lustre/lustre/llite/file.c
> > @@ -3030,6 +3030,7 @@ static int ll_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
> >  	return rc;
> >  }
> >  
> > +#ifdef CONFIG_FS_POSIX_ACL
> 
> Using #ifdef in  .c files is generally discouraged.
> The "standard" approach here is:
> - put the acl code in a separate file (acl.c)
> - optionally include it via the Make file
>      lustre-$(CONFIG_FS_POSIX_ACL) += acl.o
> 
> - in the header where ll_get_acl and ll_set_acl are declared have
>  #ifdef CONFIG_FS_POSIX_ACL
>    declare the functions
>  #else
>  #define ll_get_acl NULL
>  #define ll_set_acl NULL
>  #endif
> 
> Now as this is staging and that is (presumably) an upstream patch
> lightly improved it is probably fine to include the patch as-is,
> but in that case we will probably want to fix it up later.

So you want Lustre to be like everyone else :-)
Okay I will fix up and send a new patch series.

> Thanks,
> NeilBrown
> 
> >  struct posix_acl *ll_get_acl(struct inode *inode, int type)
> >  {
> >  	struct ll_inode_info *lli = ll_i2info(inode);
> > @@ -3043,6 +3044,64 @@ struct posix_acl *ll_get_acl(struct inode *inode, int type)
> >  	return acl;
> >  }
> >  
> > +int ll_set_acl(struct inode *inode, struct posix_acl *acl, int type)
> > +{
> > +	struct ll_sb_info *sbi = ll_i2sbi(inode);
> > +	struct ptlrpc_request *req = NULL;
> > +	const char *name = NULL;
> > +	size_t value_size = 0;
> > +	char *value = NULL;
> > +	int rc;
> > +
> > +	switch (type) {
> > +	case ACL_TYPE_ACCESS:
> > +		name = XATTR_NAME_POSIX_ACL_ACCESS;
> > +		if (acl)
> > +			rc = posix_acl_update_mode(inode, &inode->i_mode, &acl);
> > +		break;
> > +
> > +	case ACL_TYPE_DEFAULT:
> > +		name = XATTR_NAME_POSIX_ACL_DEFAULT;
> > +		if (!S_ISDIR(inode->i_mode))
> > +			rc = acl ? -EACCES : 0;
> > +		break;
> > +
> > +	default:
> > +		rc = -EINVAL;
> > +		break;
> > +	}
> > +	if (rc)
> > +		return rc;
> > +
> > +	if (acl) {
> > +		value_size = posix_acl_xattr_size(acl->a_count);
> > +		value = kmalloc(value_size, GFP_NOFS);
> > +		if (!value) {
> > +			rc = -ENOMEM;
> > +			goto out;
> > +		}
> > +
> > +		rc = posix_acl_to_xattr(&init_user_ns, acl, value, value_size);
> > +		if (rc < 0)
> > +			goto out_value;
> > +	}
> > +
> > +	rc = md_setxattr(sbi->ll_md_exp, ll_inode2fid(inode),
> > +			 value ? OBD_MD_FLXATTR : OBD_MD_FLXATTRRM,
> > +			 name, value, value_size, 0, 0, 0, &req);
> > +
> > +	ptlrpc_req_finished(req);
> > +out_value:
> > +	kfree(value);
> > +out:
> > +	if (rc)
> > +		forget_cached_acl(inode, type);
> > +	else
> > +		set_cached_acl(inode, type, acl);
> > +	return rc;
> > +}
> > +#endif /* CONFIG_FS_POSIX_ACL */
> > +
> >  int ll_inode_permission(struct inode *inode, int mask)
> >  {
> >  	struct ll_sb_info *sbi;
> > @@ -3164,7 +3223,10 @@ int ll_inode_permission(struct inode *inode, int mask)
> >  	.permission	= ll_inode_permission,
> >  	.listxattr	= ll_listxattr,
> >  	.fiemap		= ll_fiemap,
> > +#ifdef CONFIG_FS_POSIX_ACL
> >  	.get_acl	= ll_get_acl,
> > +	.set_acl	= ll_set_acl,
> > +#endif
> >  };
> >  
> >  /* dynamic ioctl number support routines */
> > diff --git a/drivers/staging/lustre/lustre/llite/llite_internal.h b/drivers/staging/lustre/lustre/llite/llite_internal.h
> > index 6504850..2280327 100644
> > --- a/drivers/staging/lustre/lustre/llite/llite_internal.h
> > +++ b/drivers/staging/lustre/lustre/llite/llite_internal.h
> > @@ -754,7 +754,11 @@ enum ldlm_mode ll_take_md_lock(struct inode *inode, __u64 bits,
> >  int ll_md_real_close(struct inode *inode, fmode_t fmode);
> >  int ll_getattr(const struct path *path, struct kstat *stat,
> >  	       u32 request_mask, unsigned int flags);
> > +#ifdef CONFIG_FS_POSIX_ACL
> >  struct posix_acl *ll_get_acl(struct inode *inode, int type);
> > +int ll_set_acl(struct inode *inode, struct posix_acl *acl, int type);
> > +#endif /* CONFIG_FS_POSIX_ACL */
> > +
> >  int ll_migrate(struct inode *parent, struct file *file, int mdtidx,
> >  	       const char *name, int namelen);
> >  int ll_get_fid_by_name(struct inode *parent, const char *name,
> > diff --git a/drivers/staging/lustre/lustre/llite/namei.c b/drivers/staging/lustre/lustre/llite/namei.c
> > index 9ac7f09..b41f189 100644
> > --- a/drivers/staging/lustre/lustre/llite/namei.c
> > +++ b/drivers/staging/lustre/lustre/llite/namei.c
> > @@ -1195,7 +1195,10 @@ static int ll_rename(struct inode *src, struct dentry *src_dchild,
> >  	.getattr	    = ll_getattr,
> >  	.permission	 = ll_inode_permission,
> >  	.listxattr	  = ll_listxattr,
> > -	.get_acl	    = ll_get_acl,
> > +#ifdef CONFIG_FS_POSIX_ACL
> > +	.get_acl	= ll_get_acl,
> > +	.set_acl	= ll_set_acl,
> > +#endif
> >  };
> >  
> >  const struct inode_operations ll_special_inode_operations = {
> > @@ -1203,5 +1206,8 @@ static int ll_rename(struct inode *src, struct dentry *src_dchild,
> >  	.getattr	= ll_getattr,
> >  	.permission     = ll_inode_permission,
> >  	.listxattr      = ll_listxattr,
> > -	.get_acl	    = ll_get_acl,
> > +#ifdef CONFIG_FS_POSIX_ACL
> > +	.get_acl	= ll_get_acl,
> > +	.set_acl	= ll_set_acl,
> > +#endif
> >  };
> > -- 
> > 1.8.3.1
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
