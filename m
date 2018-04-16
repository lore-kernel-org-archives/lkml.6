Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217916-1523852140-2-1224765414868078093
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
    1523852139; b=BxS36GwXDXUCJThFzsVhX74QCBJ2Q+uM+nFeTmjrWJ0cLZeXFl
    1/gGd1a/DIOBnPZHpb4r9W6/aeCiNxq9gTfrU3DHidwY3WQJwJIWa+nVH0MRAFLO
    G9qajB265cT1rhtkvQD6uv63AgFu24qiExQnfdo/M+PHOsoWuQNeHSg5hwf6PyTz
    pkFtNJsd0Q6ihSvtaT1s1lL8vyAiHQpi/zjdZC7liWKDdQw2OzFGXm+2evWRG3TP
    VmJsPjsNxN36iw3Zrdo6+7VYJlb9Kdor/ldBcgAYCzuxEn6p0qeP5qNoUAAu0mTX
    bR+Fi4uLgNRfMQ9xmcOnf5zxJ9Bl3rQ1zkqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523852139; bh=NWQkV
    SbpCptfRGp/N/b6Nqd4eh34OX3I2DtOaCZvKu8=; b=OIBRXXF5Yu9S49V0FkDwd
    crfm/XW3lhs449z4bdxRMgOp+S+KqWwDleo6FK4UHIA8K2U742Z/Rm6BiXmz58Ed
    BnoGz1YbSHH/87ctcjC2kuuUPE//BiJXHYtLDD+tRtrM9YJYh2a9YxCnHmKwAinv
    xkdbyCbiEY+WccyiNS+cJ0fW2LUVj4xQFYCSILpaL6Cy5PjukNzuVf8siCVDWLRY
    4Qr1dkkdoGsTKjzeZ3vI3jE8cMTiVaL0nPD6h65HJFvvEmMfMIQClamFCXCGfIPd
    dUR/mL7W4vbu6IIxloYnBoIFKxljs8MHABqZ20gTbs7rGB4eXpcjOdPQgIfDlE9C
    g==
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
X-CM-Envelope: MS4wfODGGHvLczYM2pOWw3W1HOmNHSZpI4vsD2OnCg7Z8mo59wZzFfZQFO5g2pDRpgw5GsfjGINMb8ErkXdlz9GP9YWVIhw0BMPJ9JzPlQcS/W8vd5kbN68I
    nd0WwcHGe7gPyvb2kHnHa6FQ0q0psgeOkXjzkJyaLuBm9Bui8n+5iGKOMIsmwSh5SjP6QdkUyv8FNQvbJkpql3FnzMdH9dnpigfzMI8dwhD/oTvEUWToucaw
    7IbG1i66Mc03FdGJQvG5gQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8
    a=ySfo2T4IAAAA:8 a=lB0dNpNiAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=U36ad4flq29OS6uHCJAA:9 a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22
    a=c-ZiYqmG3AbHTdtsH08C:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 06/22] staging: lustre: llite: Remove filtering of seclabel
 xattr
Date: Mon, 16 Apr 2018 00:14:55 -0400
Message-Id: <1523852111-17321-7-git-send-email-jsimmons@infradead.org>
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
Cc: Robin Humble <plaguedbypenguins@gmail.com>,
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

From: Robin Humble <plaguedbypenguins@gmail.com>

The security.capability xattr is used to implement File
Capabilities in recent Linux versions. Capabilities are a
fine grained approach to granting executables elevated
privileges. eg. /bin/ping can have capabilities
cap_net_admin, cap_net_raw+ep instead of being setuid root.

This xattr has long been filtered out by llite, initially for
stability reasons (b15587), and later over performance
concerns as this xattr is read for every file with eg.
'ls --color'. Since LU-2869 xattr's are cached on clients,
alleviating most performance concerns.

Removing llite's filtering of the security.capability xattr
enables using Lustre as a root filesystem, which is used on
some large clusters.

Signed-off-by: Robin Humble <plaguedbypenguins@gmail.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9562
Reviewed-on: https://review.whamcloud.com/27292
Reviewed-by: John L. Hammond <john.hammond@intel.com>
Reviewed-by: Sebastien Buisson <sbuisson@ddn.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/llite/xattr.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
index 2d78432..55a19a5 100644
--- a/drivers/staging/lustre/lustre/llite/xattr.c
+++ b/drivers/staging/lustre/lustre/llite/xattr.c
@@ -117,11 +117,6 @@ static int xattr_type_filter(struct ll_sb_info *sbi,
 	     (handler->flags == XATTR_LUSTRE_T && !strcmp(name, "lov"))))
 		return 0;
 
-	/* b15587: ignore security.capability xattr for now */
-	if ((handler->flags == XATTR_SECURITY_T &&
-	     !strcmp(name, "capability")))
-		return 0;
-
 	/* LU-549:  Disable security.selinux when selinux is disabled */
 	if (handler->flags == XATTR_SECURITY_T && !selinux_is_enabled() &&
 	    strcmp(name, "selinux") == 0)
@@ -383,10 +378,6 @@ static int ll_xattr_get_common(const struct xattr_handler *handler,
 	if (rc)
 		return rc;
 
-	/* b15587: ignore security.capability xattr for now */
-	if ((handler->flags == XATTR_SECURITY_T && !strcmp(name, "capability")))
-		return -ENODATA;
-
 	/* LU-549:  Disable security.selinux when selinux is disabled */
 	if (handler->flags == XATTR_SECURITY_T && !selinux_is_enabled() &&
 	    !strcmp(name, "selinux"))
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
