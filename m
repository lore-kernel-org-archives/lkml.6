Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1297442-1523954356-2-13954955212828791368
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523954355; b=svGXoBrGuBc7cUo40X9OJGoUqNr1OMeQ+z3B5w5V/Q01mirQN+
    smqPUZRwx+YKINyK5wFLq0hSM7zGXnMe3DJ0OV+/OlAcKpSLrrJruLR5/7ntXUCX
    NL8fvP6AESItrMv+IJNSCHIEiN1alKvAijxg6zx/7drET3uVYvcNpQUOFAQGz9n7
    rIBBh385hE1Lg6PCiWmkSbSBB+AIHeMjLTQLBAbmH4eRTwmJEcasZpr5296fxBi2
    l1Eo2XYiVFLqRo+ojy8uS97go1hQLyw0XshZAauPk6KaTjshO0MKG99vJzLy2Amv
    rxcWt1uOLC2dyj0J3tvAnuWw7pWyDl7t1xGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523954355; bh=SN4pk
    yBoreEwFQJKYn3JZnNnQbOnqhp8wKPpp6isRKY=; b=OhoGPcAhXTJEn8FQyFJAa
    Egm3hWGIGiylon8MshBa6FwGKJc7RQ16tTtuwRlifqwKGK2kP+GVIK9SBtGFfATf
    ngTbMZ/nxYm8xgR4ZZHhK4HuzNRgUwwa+8TrJE3FjMSSN/e6EoRJJMMq8VVuxdKd
    XD2RNYvpfxHeRshLhlJ4dgsOSvEPvz5ESL6y05vuf2/ioqmw1rcmtod6+bMTpEXu
    PWeAFgnuH/1N5qN7lYtpUgbm+Y2V0oLffwdTINt3HhdqgxIDinYO6YYrR7k+u52m
    MTKnki1dwLHFw7jJ5fwVzrXK1caJsIGj/Idmc49owkjJik/tEO3yuTE24S38lnMu
    Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=l+sksSjQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=l+sksSjQ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPTG9SupSpp0Qg4JCVSUhwhlKTAjN4pMBA03niOGTj6FgqSF0XmDAuhYcBhwUMN/50+spk5GxaVa8Pd0yq110TJv494NMR6RsW/eAym0HpUWR0uMCGfs
    P+G2DRqb2Va4NHuyVcecTKthPJQh8UThELzowKE3CfqOsmrwWos3Xid58Tf6m1d+Uz/3ViikhWEblVup5mtcSRA81I883D93yVdX1oCR/OiDYR9ADeeCyMA+
    Wfw8t/X2AaCP/S2grxyaOg==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=yy8AwNkixpI6Rqx6vDQA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Tue, 17 Apr 2018 11:38:54 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH 19/22] staging: lustre: llite: add support set_acl method
 in inode operations
Message-ID: <20180417083854.7dgypv3eu4tc4e2c@mwanda>
References: <1523852111-17321-1-git-send-email-jsimmons@infradead.org>
 <1523852111-17321-20-git-send-email-jsimmons@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1523852111-17321-20-git-send-email-jsimmons@infradead.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8865
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804170079
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
 Andreas Dilger <andreas.dilger@intel.com>,
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

On Mon, Apr 16, 2018 at 12:15:08AM -0400, James Simmons wrote:
> +int ll_set_acl(struct inode *inode, struct posix_acl *acl, int type)
> +{
> +	struct ll_sb_info *sbi = ll_i2sbi(inode);
> +	struct ptlrpc_request *req = NULL;
> +	const char *name = NULL;
> +	size_t value_size = 0;
> +	char *value = NULL;
> +	int rc;
> +
> +	switch (type) {
> +	case ACL_TYPE_ACCESS:
> +		name = XATTR_NAME_POSIX_ACL_ACCESS;
> +		if (acl) {
> +			rc = posix_acl_update_mode(inode, &inode->i_mode, &acl);
> +			if (rc)
> +				goto out;
> +		}
> +
> +		break;
> +
> +	case ACL_TYPE_DEFAULT:
> +		name = XATTR_NAME_POSIX_ACL_DEFAULT;
> +		if (!S_ISDIR(inode->i_mode)) {
> +			rc = acl ? -EACCES : 0;
> +			goto out;

I just hate "goto out;" labels...  They're so impossible to review...
Why are we calling forget_cached_acl() when we haven't set anything?  I
have no idea.  Perhaps it's not even intentional.

> +		}
> +
> +		break;
> +
> +	default:
> +		rc = -EINVAL;
> +		goto out;

And on this path we're calling forget_cached_acl(inode, type) with an
invalid "type" so it will trigger a BUG()...  That's obviously not
intended...  Who knows what's going on when all the names are vague and
hand wavy.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
