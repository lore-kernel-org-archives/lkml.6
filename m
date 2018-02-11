Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3604363-1518385097-2-11589450296020776536
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518385096; b=TzRAK1UODDiMdgYYIHXp+DceTgg4RvYenPdXxC6RDpoKqgK
    rKAHvnL65CW9ipzqGJLskt2RZHyE1oxJwp+Qv2oEjvrF4PX89DNHbluIThmTXnIT
    Kyea0kzTa5PzXnLofncswJFyVHW7GXnzJMThIxQA6SWw0iR1iUJiNlN2S8wmNtH0
    KiUh1K52VKt1KZn0pX0/BCGABwu0Dja/2dc1/TkGz57MFxJFb1whMgRhQkzj95pU
    r5UdJeg/oqNXh4a8dyW59UZtMJ4vb6/7Io1AV0M5wubFjuKthx7B2DGAEwN63wxy
    QsEB8V4OAHfOzCPZbli1zRoxHmXpvRt26Rc/uaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:in-reply-to
    :message-id:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1518385096; bh=f
    zsYFE5pcuNXEil5Eoxh3mFL6m+YwGHhFb5aqyH8zv0=; b=PYL7fZf7HimIi3YOC
    X8leNne4XucRqPjS5SJ3nWzQJOE8X4PilEvcPCOLyBoqOy0cYSVjkSJt6PtoUCM2
    e+9yd2zQPNfNLO2wkMORVQDVMwQBubB5JteOFdLJcnGOfLf0khpcl/CSEXdG97kv
    M+yYie62T7O8CT6WWX4HEGhzTUD8bodjtJbasANAsulm8IStYm8FkHVoSuk5AcjX
    h5sJKGgMhKnT+8dJNpT4WBVLGW5JfrUlRH2Gzjss6L7p1mPZkLPigP4JvaSAlM9E
    akwExkIkN8cRYiwYwIl86Cc6kL9fvWgOQ38H4wKWd9JhEJiNDTWV+uNFt+3NTEvW
    cXEZw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=dRnoIFnj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=dRnoIFnj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=casper.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amavis-Alert: BAD HEADER SECTION, Improper folded header field made up
 entirely of whitespace (char 20 hex): X-Spam-Report: ....9 points, 5.0
 required)\n \n  pts rule nam[...]
Date: Sun, 11 Feb 2018 21:38:01 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: Sven Dziadek <sven.dziadek@gmx.de>
Subject: Re: [PATCH] staging: lustre: llite: replace variable length array
In-Reply-To: <58963c7f-139c-1156-0179-13decf0bcddf@gmx.de>
Message-ID: <alpine.LFD.2.21.1802112136420.21780@casper.infradead.org>
References: <20180127214228.26986-1-sven.dziadek@gmx.de>
 <D887F611-EA3C-45CD-BEBC-3BA994048B59@intel.com>
 <58963c7f-139c-1156-0179-13decf0bcddf@gmx.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20180211_213802_191253_BBEAD002 
X-CRM114-Status: GOOD (  29.27  )
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
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>, "Eremin,
 Dmitry" <dmitry.eremin@intel.com>, "Dilger,
 Andreas" <andreas.dilger@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 lkml <linux-kernel@vger.kernel.org>, "Drokin, Oleg" <oleg.drokin@intel.com>,
 lustre-devel <lustre-devel@lists.lustre.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


> On 01/30/2018 03:04 AM, Dilger, Andreas wrote:
> > On Jan 27, 2018, at 14:42, Sven Dziadek <sven.dziadek@gmx.de> wrote:
> >>
> >> The functionality of the removed variable length array is already
> >> implemented by the function xattr_full_name in fs/xattr.c
> >>
> >> This fixes the sparse warning:
> >> warning: Variable length array is used.
> >>
> >> Signed-off-by: Sven Dziadek <sven.dziadek@gmx.de>
> >> ---
> >> drivers/staging/lustre/lustre/llite/xattr.c | 12 ++++--------
> >> 1 file changed, 4 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
> >> index 532384c91447..4fd28213c6a1 100644
> >> --- a/drivers/staging/lustre/lustre/llite/xattr.c
> >> +++ b/drivers/staging/lustre/lustre/llite/xattr.c
> >> @@ -87,7 +87,6 @@ ll_xattr_set_common(const struct xattr_handler *handler,
> >> 		    const char *name, const void *value, size_t size,
> >> 		    int flags)
> >> {
> >> -	char fullname[strlen(handler->prefix) + strlen(name) + 1];
> >> 	struct ll_sb_info *sbi = ll_i2sbi(inode);
> >> 	struct ptlrpc_request *req = NULL;
> >> 	const char *pv = value;
> >> @@ -141,9 +140,8 @@ ll_xattr_set_common(const struct xattr_handler *handler,
> >> 			return -EPERM;
> >> 	}
> >>
> >> -	sprintf(fullname, "%s%s\n", handler->prefix, name);
> >> -	rc = md_setxattr(sbi->ll_md_exp, ll_inode2fid(inode),
> >> -			 valid, fullname, pv, size, 0, flags,
> >> +	rc = md_setxattr(sbi->ll_md_exp, ll_inode2fid(inode), valid,
> >> +			 xattr_full_name(handler, name), pv, size, 0, flags,
> >> 			 ll_i2suppgid(inode), &req);
> > 
> > Hi Sven,
> > thanks for the patch.
> > 
> > Looking at the details of "xattr_full_name()", this seems quite risky.  This
> > is essentially returning the pointer _before_ "name" on the assumption that
> > it contains the full "prefix.name" string.  IMHO, that is not necessarily a
> > safe assumption to make several layers down in the code.
> Thanks for your reply. And yeah, it feels strange, right.
> 
> But it really looks like this is how the name and the prefix is handled
> in the xattr code.
> It seems this helper function has been introduced with commit
> e409de992e3ea (which also removes some fullname pointer) and indeed,
> fs/xattr.c splits the prefix and the name in xattr_resolve_name.
> 
> So I still think the patch should be correct..?
> 
> > James, I thought you had a patch for this to use kasprintf() instead of the
> > on-stack "fullname" declaration?
> Sorry for replying that late, I though James would maybe know if the
> above assumption is correct..

Yes I do have a patch for this. I pushed them several months ago but they
got missed. It happens. I will the patches again very soon.
 
> >> 	if (rc) {
> >> 		if (rc == -EOPNOTSUPP && handler->flags == XATTR_USER_T) {
> >> @@ -364,7 +362,6 @@ static int ll_xattr_get_common(const struct xattr_handler *handler,
> >> 			       struct dentry *dentry, struct inode *inode,
> >> 			       const char *name, void *buffer, size_t size)
> >> {
> >> -	char fullname[strlen(handler->prefix) + strlen(name) + 1];
> >> 	struct ll_sb_info *sbi = ll_i2sbi(inode);
> >> #ifdef CONFIG_FS_POSIX_ACL
> >> 	struct ll_inode_info *lli = ll_i2info(inode);
> >> @@ -411,9 +408,8 @@ static int ll_xattr_get_common(const struct xattr_handler *handler,
> >> 	if (handler->flags == XATTR_ACL_DEFAULT_T && !S_ISDIR(inode->i_mode))
> >> 		return -ENODATA;
> >> #endif
> >> -	sprintf(fullname, "%s%s\n", handler->prefix, name);
> >> -	return ll_xattr_list(inode, fullname, handler->flags, buffer, size,
> >> -			     OBD_MD_FLXATTR);
> >> +	return ll_xattr_list(inode, xattr_full_name(handler, name),
> >> +			     handler->flags, buffer, size, OBD_MD_FLXATTR);
> >> }
> >>
> >> static ssize_t ll_getxattr_lov(struct inode *inode, void *buf, size_t buf_size)
> >> -- 
> >> 2.11.0
> >>
> 
> 
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
