Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1751251-1520506595-2-12957278521147067108
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520506594; b=ew42WoAbQycXZh/i0NzkoiLvWT3pHqFtCQc+f/fIvbSchLy
    IPol2bAvuLheKzWpLV8nE9t469eKeanH1xDIh2r3rO22OOlh/4Ra9VnlNd/hHiCo
    GT3vWMO/jBPyMyZASa/b4sSs8wxzysjWTNfRmozk6Ux7JVPu4jlg3MWw5kuNxDrD
    H1dkDOg/nc1qc03uPdhca4znUMFfgnAQx1BkW4b0+6SrZubPbcCd/HQPmIlAC/R9
    erY8tZNJ/ATiy/imd/Z0aQYSWP4nuZn4aUsrXRq1byBRByP1tJOIbTxELXlfOZV5
    8b4PhaiKXJuwBuh6EW701l8sSdUotJqPDdaotlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520506594; bh=b
    qP9DpFRhaYEPNty8m6C8MI5Vre0NeBksmlmI+Szy98=; b=CQPSia/5tMiq4CSHk
    GEX+kNvdqI3jPJbUQqsZ1/9fvqQHtLVMEPxjih7jLdP+cucH4Ex+v8DnlnnQ1zrX
    1Sgd8jBfuW6Sz24/t46dH4b+qGrdtQo+9BXj7Q9MvMlKV6mj2zQPTDD27lmV0uqN
    bGSBQC3qdnWdeUEAoAtXJqrWnTJFOteeGp9MI/s+89EMoXXPEgDEb7tWw/Wxapxf
    5iSBKoCoaMUbMZlPN86BZNhiWOOCKPCjbdNvhsnS8Q+TADkEH88ErQ8OB70XlGXw
    M2KmpjqvAJp/ybJWLzfN4luCyJ3WmP4QnHJuZHw8FgHbH/cT9ZALmu8LL0PX2klk
    je2Qg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=YSoB6VG1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=YSoB6VG1 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 8 Mar 2018 13:43:09 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH] staging: lustre: Remove VLA usage
Message-ID: <20180308104309.l3j2deqrgq5d472g@mwanda>
References: <20180307054608.GA9300@beast>
 <d5de0034-6f74-5b73-2df8-dbe5b366c2fc@prevas.dk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d5de0034-6f74-5b73-2df8-dbe5b366c2fc@prevas.dk>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8825
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803080130
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
 Tycho Andersen <tycho@tycho.ws>, Andreas Dilger <andreas.dilger@intel.com>,
 Kees Cook <keescook@chromium.org>,
 Kernel Hardening <kernel-hardening@lists.openwall.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Gargi Sharma <gs051095@gmail.com>, Oleg Drokin <oleg.drokin@intel.com>,
 lustre-devel@lists.lustre.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 02:10:41PM +0100, Rasmus Villemoes wrote:
> On 2018-03-07 06:46, Kees Cook wrote:
> > The kernel would like to remove all VLA usage. This switches to a
> > simple kasprintf() instead.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/staging/lustre/lustre/llite/xattr.c | 19 +++++++++++++------
> >  1 file changed, 13 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
> > index 532384c91447..aab4eab64289 100644
> > --- a/drivers/staging/lustre/lustre/llite/xattr.c
> > +++ b/drivers/staging/lustre/lustre/llite/xattr.c
> > @@ -87,7 +87,7 @@ ll_xattr_set_common(const struct xattr_handler *handler,
> >  		    const char *name, const void *value, size_t size,
> >  		    int flags)
> >  {
> > -	char fullname[strlen(handler->prefix) + strlen(name) + 1];
> > +	char *fullname;
> >  	struct ll_sb_info *sbi = ll_i2sbi(inode);
> >  	struct ptlrpc_request *req = NULL;
> >  	const char *pv = value;
> > @@ -141,10 +141,13 @@ ll_xattr_set_common(const struct xattr_handler *handler,
> >  			return -EPERM;
> >  	}
> >  
> > -	sprintf(fullname, "%s%s\n", handler->prefix, name);
> 
> It's probably worth pointing out that this actually fixes an
> unconditional buffer overflow: fullname only has room for the two
> strings and the '\n', but vsnprintf() is told that the buffer has
> infinite size (well, INT_MAX), so there should be plenty of room to
> append the '\0' after the '\n'.
> 
> > +	fullname = kasprintf(GFP_KERNEL, "%s%s\n", handler->prefix, name);
> > +	if (!fullname)
> > +		return -ENOMEM;
> >  	rc = md_setxattr(sbi->ll_md_exp, ll_inode2fid(inode),
> >  			 valid, fullname, pv, size, 0, flags,
> >  			 ll_i2suppgid(inode), &req);
> > +	kfree(fullname);
> >  	if (rc) {
> >  		if (rc == -EOPNOTSUPP && handler->flags == XATTR_USER_T) {
> >  			LCONSOLE_INFO("Disabling user_xattr feature because it is not supported on the server\n");
> > @@ -364,7 +367,7 @@ static int ll_xattr_get_common(const struct xattr_handler *handler,
> >  			       struct dentry *dentry, struct inode *inode,
> >  			       const char *name, void *buffer, size_t size)
> >  {
> > -	char fullname[strlen(handler->prefix) + strlen(name) + 1];
> > +	char *fullname;
> >  	struct ll_sb_info *sbi = ll_i2sbi(inode);
> >  #ifdef CONFIG_FS_POSIX_ACL
> >  	struct ll_inode_info *lli = ll_i2info(inode);
> > @@ -411,9 +414,13 @@ static int ll_xattr_get_common(const struct xattr_handler *handler,
> >  	if (handler->flags == XATTR_ACL_DEFAULT_T && !S_ISDIR(inode->i_mode))
> >  		return -ENODATA;
> >  #endif
> > -	sprintf(fullname, "%s%s\n", handler->prefix, name);
> 
> Same here.
> 
> I'm a little surprised this hasn't been caugt by static analysis, I
> thought gcc/coverity/smatch/whatnot had gotten pretty good at computing
> the size of the output generated by a given format string with "known"
> arguments and comparing to the size of the output buffer. Though of
> course it does require the tool to be able to do symbolic manipulations,
> in this case realizing that
> 
> outsize == strlen(x)+strlen(y)+1+1 > bufsize == strlen(x)+strlen(y)+1

That kind of symbolic manipulation is crazy hard to do.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
