Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2210789-1523852151-2-1039915499194934185
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523852150; b=gSEJkrPixakdv/mr++yc7cgJ1D5woIDzX1qMPM2KBJsQpwiNWE
    oRzXLFQgjFcK8UGqewkUbbdOVoJW5jRhKXBCg75zcAeMqXWD4tGJ8k0wbZNoREq4
    LGm4tfcSX5LoAcfdVHLnfx3y+ibkJ5rOjfoGIJiFElApJQmHIoZ1Qjy1IOsTGt2O
    qj++b15h4WYrpzSXOsOtE5X43Zy44al+mqFHQeD6P7Ne+z4QeQGfNhm/bIicZhlT
    GzOQ1WOPdLPgHw/ZgXCFLhqlp+SK1B9bvXNKb8vzvTdsSN41W60+HpQdBZMUUFwF
    3LnxQvexgLUmpiBakKv0Sv0SdwRzQzp4Memw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523852150; bh=Mk8Nj
    RmvtTt+Txf1Q5OAzLpBqPP+ugNJGZwgTJF0kYU=; b=iszniQEwkXgFI0ugLukYY
    b70ND/a7cgy3pZZY1ITy41d7FNwBdCH877zuMNeywRvpj5H/k4TUipXVvE6096Bj
    PpQHf2JgC4DP87uiS8ElFl6GAHdZzh2wyyu9kewMPyHKypMceKtCQVIIEauzHjYA
    IAUXX3vfng+t7w5QOa2MRJED6KqAOzeyJK/W9VL8jW22R+JDZu1dVZT6xuSRUtDr
    MnXshoAcEMWndFaxXWH0zfjAxBrwrhHulNRMl1zVCYJhS9Z/Rd1gPcIf/M4Qg4yf
    3xiwjEXtzjDDBO+dJcjCVL0rJ9rg3uHDd/EOxy8j7gHG6QE2MHTiRSVds8PH2/W7
    g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfOrc27NKmWG1nme0dyRh2JgcL8ktda7DmREss+vLOr9YJLCOhOLvyqOMXtrgcBso5591+dtaQTmuyZ6pkIBai6fXePx9Sd6N+weTYUJPGkrggTxQj0Fd
    WDyhbMOTOC9EJr/1u+kAVJn1dHf+CUCyfIhi6/PbHuBa3tFjrANp3yX47Nx6dBExY7hsOCxiSx6ghkEP9r+R0EDMZ+dpaRIURs+b4FishC/NQMQiSWLWnjSi
    JUZ6lxhWiSGKBSxmTvnFqQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=ySfo2T4IAAAA:8
    a=CjxXgO3LAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8 a=RVLwQC8yu6WcoleD26kA:9
    a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 20/22] staging: lustre: llite: use xattr_handler name for ACLs
Date: Mon, 16 Apr 2018 00:15:09 -0400
Message-Id: <1523852111-17321-21-git-send-email-jsimmons@infradead.org>
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
Cc: "John L. Hammond" <john.hammond@intel.com>,
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

From: "John L. Hammond" <john.hammond@intel.com>

If struct xattr_handler has a name member then use it (rather than
prefix) for the ACL xattrs. This avoids a bug where ACL operations
failed for some kernels.

Signed-off-by: John L. Hammond <john.hammond@intel.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-10785
Reviewed-on: https://review.whamcloud.com/
Reviewed-by: Dmitry Eremin <dmitry.eremin@intel.com>
Reviewed-by: James Simmons <uja.ornl@yahoo.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/llite/xattr.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
index d08bf1e..e835c8e 100644
--- a/drivers/staging/lustre/lustre/llite/xattr.c
+++ b/drivers/staging/lustre/lustre/llite/xattr.c
@@ -46,15 +46,16 @@
 
 const struct xattr_handler *get_xattr_type(const char *name)
 {
-	int i = 0;
+	int i;
 
-	while (ll_xattr_handlers[i]) {
-		size_t len = strlen(ll_xattr_handlers[i]->prefix);
+	for (i = 0; ll_xattr_handlers[i]; i++) {
+		const char *prefix = xattr_prefix(ll_xattr_handlers[i]);
+		size_t prefix_len = strlen(prefix);
 
-		if (!strncmp(ll_xattr_handlers[i]->prefix, name, len))
+		if (!strncmp(prefix, name, prefix_len))
 			return ll_xattr_handlers[i];
-		i++;
 	}
+
 	return NULL;
 }
 
@@ -627,14 +628,14 @@ ssize_t ll_listxattr(struct dentry *dentry, char *buffer, size_t size)
 };
 
 static const struct xattr_handler ll_acl_access_xattr_handler = {
-	.prefix = XATTR_NAME_POSIX_ACL_ACCESS,
+	.name = XATTR_NAME_POSIX_ACL_ACCESS,
 	.flags = XATTR_ACL_ACCESS_T,
 	.get = ll_xattr_get_common,
 	.set = ll_xattr_set_common,
 };
 
 static const struct xattr_handler ll_acl_default_xattr_handler = {
-	.prefix = XATTR_NAME_POSIX_ACL_DEFAULT,
+	.name = XATTR_NAME_POSIX_ACL_DEFAULT,
 	.flags = XATTR_ACL_DEFAULT_T,
 	.get = ll_xattr_get_common,
 	.set = ll_xattr_set_common,
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
