Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2784231-1526396442-2-9174357119609239586
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526396441; b=hBYeeXSndDfQfFf9izCYO4nB0jc8nQ526ttrtil328q/oPXLa6
    N3DhV8YY/Ex+STn1W1SkvAYHTgQMT05JCrFI53saQHAoy8Pgjox5XSPH5D2JdMBC
    +moRASV2L9oZGoafaR38ujx6byXKF+cWao5kRVt3z367z/yXzycTYkqmCDAcMGDq
    9grJbXe9LNR6F4Tk2BPXqHfTkUo6wbNZDW99XLPhzVqfQw/JBpoNJ41n9HIVA2a9
    SN0oRKr037VcA4YttfGGwq3mO1Mzq/CQfXJB8mQYxJ6FnguZpArIg0Q391buK5Jq
    zm24Hcn0N1HWt0ezaNoTA7nTskUQiSX9AJdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526396441; bh=17mhP
    8jPTdMWcbJrT5OCdNLNRaGS4a/Fyzrg049I8uQ=; b=DqR5+TtB6ZSDffMeagKhW
    +8K99yM3bIcJl+9AAX8QGvuKxYAn9SE6VDI3CG/tjBMIYdAs8n5MB6Aqo7kNgaVJ
    NgqDtjRpf8/Zo0T30RWNJVViMrKriFMaBWsuf2ZCFmr6NOY3rIUxLXbbz0MD/7vq
    yfd+K0u32DDVLciedZVykc51jWcRowcgGwYMQnVUQ9UvxWOY0/KgJs+Sb16MYzZK
    6X+63Itcj3VOLiP95kKMdJnLCH7Vg67Kht785ziUMNqRaqaIMkGNNle3czHGuVbB
    H9RJqomv+g+rWPLePSIcKnEiqio6r9dcz689w4TNk33dD0Boh53cScwsRqS6W/PV
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=infradead.org header.i=@infradead.org header.b=uwLxTOEK
    x-bits=2048 x-keytype=rsa x-algorithm=sha256
    x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=infradead.org header.i=@infradead.org header.b=uwLxTOEK
      x-bits=2048 x-keytype=rsa x-algorithm=sha256
      x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=infradead.org header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAPLa/0ljtJFWTLciWJJuVASwuGyBuyA1Qg9S0nxzumneZrvDLykbfSF8TqXPNUqGgHS6Ww4rqCGJ4BV1o/FSjBrHAOpauxQpxO5eDeW/7MD4VCo5qpx
    XiamdomebFaANvfWOrIHwl736PnITPq8i7JgRpzCtQMILMy7CPm6C+aykGRnRX6aNL9PAdLHIEDv4gsxQvdJDIx5OKhNqLEFFNhKxIwQ9/DSStf6UfD5ocsJ
    z3SgyXLYyO4OZIC0hr9TXg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=f163IYkzVpVaqwlJQ74A:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Improper folded header field made up
 entirely of whitespace (char 20 hex): X-Spam-Report: ....0 points, 5.0
 required)\n \n  pts rule nam[...]
Date: Tue, 15 May 2018 16:00:22 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2 1/5] staging: lustre: llite: add support set_acl method
 in inode operations
In-Reply-To: <20180515113034.ywxhai4nrrvxs7nr@mwanda>
Message-ID: <alpine.LFD.2.21.1805151600080.28403@casper.infradead.org>
References: <1526350623-4616-1-git-send-email-jsimmons@infradead.org>
 <1526350623-4616-2-git-send-email-jsimmons@infradead.org>
 <20180515113034.ywxhai4nrrvxs7nr@mwanda>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180515_160022_194384_C1A02F76 
X-CRM114-Status: GOOD (  12.87  )
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
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, NeilBrown <neilb@suse.com>,
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


> On Mon, May 14, 2018 at 10:16:59PM -0400, James Simmons wrote:
> > +#ifdef CONFIG_FS_POSIX_ACL
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
> 
> "rc" needs to be initialized to zero.  It's disapppointing that GCC
> doesn't catch this.

Thanks Dan. Will fix.
 
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
> 
> Otherwise rc can be uninitialized here.
> 
> regards,
> dan carpenter
> 
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
