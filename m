Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2507959-1526383857-2-766564623555757554
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES roenca, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526383857; b=kIFG2sMRVuRD9r3ZwVfWrI/AwKn0A7lcgLO+eB3Fn3Ee/f4ZRQ
    Q8hK3UYi/XTu70HZ7t1XTeP8FaAD0Si375pZ9L4xT4/29gXkDObna7nhaO/hti4V
    Znpq8mQzDiOHy7uZneG7FGNCV+ZDyZ38mRMFdzZC5baIA3oSC0cz7DcRKp7QU7DF
    WZKQnWivNN2l/E0owmHyzjpMJ9AfE7z15MhV5w1yQLJHrH7ilMxdh+jAWzkDuE7v
    shbwCy3SqIjrOvtoPsA3M52LpgBPYfuhhnHvE0KLMfdVMTnlc/OcYC+PH94sZnPz
    nUegG+hC24pNoVSUkmySWR3IwMFNROaxXCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526383857; bh=0PZHK
    qylmuHN2Y96wQ8zZWtKfIntwKindzOvpY1cqTA=; b=k5CSCUyOP0BNqwfSe69yX
    osQwrZwiZqdzzSAuGTFW0dzDaYdmWMYahDrmGBNkEKMJqX5qzLfRdbprBDvKwp7j
    8vNN27vZa26b5o9o2AOyC8m6RYU27Vni2muj9J+QgQ7y/UNN87EFdX6gAAIUlzCN
    2gRPXCVeRa22YmgC2wsF92TSjVj8voKVL8HYQJMCA6yShVRh4UJkAV6o48PQnX3j
    KYleJje0kvtrWZ6fOb55FfIzCVcr9T//CWIumFRSnQ/ix/MO2AT6kgfa5xvn0v4h
    jiPhilm5htpgaTyBBN4z4NI1fFz2Hoil1nN/Znw9I8g3q9eSJPXBktSuSCx1Sq/N
    Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=mlLNTHao x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=oracle.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=mlLNTHao x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=oracle.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH+1IWg35ue5Am1nFAq7BGHVaP0IJfdbJgUv4iPUiFVSfcmpogO1h7ZltL6ITApcKzAX27f2hvD248FkQXI/znWv+CKE0Z/cQxIM9nwEQDMO0Aa7sgq6
    VA5+c+T5eIYLWQl5Tyvrm5O9eP3ln0vhJ9Q4H6PY2GZ2WTvp5t7hsinLavZJ0EYwXXC8TIyfVJVbTR4bGf1/BIAajc2QA1bDogDLdXhFrfiFIlUE2kyDtiXV
    9W4mf4Or8FDpndIvqpkYrQ==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=ackJDXqzZs-4U3OfNdwA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 15 May 2018 14:30:35 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH v2 1/5] staging: lustre: llite: add support set_acl
 method in inode operations
Message-ID: <20180515113034.ywxhai4nrrvxs7nr@mwanda>
References: <1526350623-4616-1-git-send-email-jsimmons@infradead.org>
 <1526350623-4616-2-git-send-email-jsimmons@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1526350623-4616-2-git-send-email-jsimmons@infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8893
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=877
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805150119
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

On Mon, May 14, 2018 at 10:16:59PM -0400, James Simmons wrote:
> +#ifdef CONFIG_FS_POSIX_ACL
>  struct posix_acl *ll_get_acl(struct inode *inode, int type)
>  {
>  	struct ll_inode_info *lli = ll_i2info(inode);
> @@ -3043,6 +3044,64 @@ struct posix_acl *ll_get_acl(struct inode *inode, int type)
>  	return acl;
>  }
>  
> +int ll_set_acl(struct inode *inode, struct posix_acl *acl, int type)
> +{
> +	struct ll_sb_info *sbi = ll_i2sbi(inode);
> +	struct ptlrpc_request *req = NULL;
> +	const char *name = NULL;
> +	size_t value_size = 0;
> +	char *value = NULL;
> +	int rc;

"rc" needs to be initialized to zero.  It's disapppointing that GCC
doesn't catch this.

> +
> +	switch (type) {
> +	case ACL_TYPE_ACCESS:
> +		name = XATTR_NAME_POSIX_ACL_ACCESS;
> +		if (acl)
> +			rc = posix_acl_update_mode(inode, &inode->i_mode, &acl);
> +		break;
> +
> +	case ACL_TYPE_DEFAULT:
> +		name = XATTR_NAME_POSIX_ACL_DEFAULT;
> +		if (!S_ISDIR(inode->i_mode))
> +			rc = acl ? -EACCES : 0;
> +		break;
> +
> +	default:
> +		rc = -EINVAL;
> +		break;
> +	}
> +	if (rc)
> +		return rc;

Otherwise rc can be uninitialized here.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
