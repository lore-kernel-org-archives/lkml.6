Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217916-1523852145-2-7883374991936197974
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523852144; b=pKKV4grIBF14Ys6YF54XyNf9pwV2KwlGB5FB5HkpOJHM1yIqe7
    LIijHKWAv6FInKnTigfQLZQ65ThY5yeRpPOzMBtY3xt7jxLapHs/aCW3iRTb7NkL
    mA4lFIsFBeGIaRn1BF298jJl6bo9K2S8tuzIZObbCF9DF2MYg9qWbHgE5KsaARr/
    As24+YL2hsP2sEmPOyIAb2T8bbcOrw8em7mgzaVfV6g38m1fly96mRROq8qvC7Gs
    KIrYLw++QnAgRn716j/mgl7wmFUi3Xt2+pwt9SdGQWYzbifET8Thao+2DiW5lRCB
    eOdddR26E552l++CslCYLO9YeZdM/fF9Eq0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523852144; bh=/Wudj
    gbJaoRc28PTMy0XVTVzcys/YhcBaVuTmxjK+zM=; b=JFEkvYQ8cc8UBznmY4MxX
    +7QibtHttrPSOdRXUCCM5ugzAH/YPRsr1yFrx+8rDHWwco9mV0aV+l25KESThELu
    PQRStYsVn/Fh0Ygv3oFFXRmw6ATp6M3/ehV30QzrVxe2BfwP8C+QKcL+P022PuXh
    jePd3AKVyKIm4FPJpHOtIHcCZl0CLIf6m5sRIgU3cgvt2UJ1MrNDZHUFqbCRwgCf
    o5RHRLg1NCG5M6vHoLOtukrkdmrP/6phjjbkwz8l/0udYXN/cP5cECpFhCLTZiAi
    GNwjsV6ZcVTfxlhZF5pKpmCUcEN4uo+4+s43YP8fwtBvW8FNwPAs6fxkfgg2+08H
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=infradead.org;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=infradead.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMAE5PeXp4nz9QoOhMFPleCy68tcfacPKjOZzr85+s4vD3iEFjkbqM2S8SNdfZFm1yENwR+30f+esOuhY3rrDUNLnZkJwLfg0Ls8E8uGB3qRjQP0AqQ4
    VfhdmZLgPyYfa7CBHr/5r1r2krFZjiHhXwhBRdh5ZVstHUkb0zSygpJyRphNrLNzONm1NGlLUcyGnN+Qba/QMSqun3ubEuxtz4FTZZVaSsk6dUoZAXOlMsOa
    mkpeNuTZZu7nqn/Qj6c6mA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=CjxXgO3LAAAA:8 a=QyXUC8HyAAAA:8
    a=ySfo2T4IAAAA:8 a=lB0dNpNiAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=Qr_XwV165R2JM6pMR2sA:9 a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22
    a=c-ZiYqmG3AbHTdtsH08C:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 15/22] staging: lustre: llite: cleanup posix acl xattr code
Date: Mon, 16 Apr 2018 00:15:04 -0400
Message-Id: <1523852111-17321-16-git-send-email-jsimmons@infradead.org>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1523852111-17321-1-git-send-email-jsimmons@infradead.org>
References: <1523852111-17321-1-git-send-email-jsimmons@infradead.org>
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
Cc: James Simmons <uja.ornl@yahoo.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Having an extra ifdef makes the code harder to read. For the case
of ll_xattr_get_common() we have a variable initialized at the
start of the function but it is only used in XATTR_ACL_ACCESS_T
code block. Lets move that variable to that location since its
only used there and make the code look cleaner.

Signed-off-by: James Simmons <uja.ornl@yahoo.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9183
Reviewed-on: https://review.whamcloud.com/27240
Reviewed-by: Dmitry Eremin <dmitry.eremin@intel.com>
Reviewed-by: Bob Glossman <bob.glossman@intel.com>
Reviewed-by: Sebastien Buisson <sbuisson@ddn.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/llite/xattr.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
index 3ab7ae0..147ffcc 100644
--- a/drivers/staging/lustre/lustre/llite/xattr.c
+++ b/drivers/staging/lustre/lustre/llite/xattr.c
@@ -396,9 +396,6 @@ static int ll_xattr_get_common(const struct xattr_handler *handler,
 			       const char *name, void *buffer, size_t size)
 {
 	struct ll_sb_info *sbi = ll_i2sbi(inode);
-#ifdef CONFIG_FS_POSIX_ACL
-	struct ll_inode_info *lli = ll_i2info(inode);
-#endif
 	char *fullname;
 	int rc;
 
@@ -422,6 +419,7 @@ static int ll_xattr_get_common(const struct xattr_handler *handler,
 	 * chance that cached ACL is uptodate.
 	 */
 	if (handler->flags == XATTR_ACL_ACCESS_T) {
+		struct ll_inode_info *lli = ll_i2info(inode);
 		struct posix_acl *acl;
 
 		spin_lock(&lli->lli_lock);
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
