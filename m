Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2217885-1523852141-2-10438790127026157117
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
    1523852141; b=HT6kLDSEkWNpQES9y10wAVHi+TWQM/lENIWgKqFu+ZHMX8i2Vm
    7bjhoXYPvnAQEb8RzkKqXNuMkgJ7KJEcQfyRzhpbCuekBVUDezxPMtP0SSLiONwc
    VC/JattNpma4W39fR4xUMo62FvHq2u59VpfUa1h2HABKrro8rNtVSmeI7obqAFx4
    Gbh1TZpVjXJFmetV0JQS6rwGKM5g4U8jPdkghr/78KSXzJwoAhcxS6J/U7fRVs9s
    sgxIqeBtjDDKYjKzJSnMRrb75DqsTp3aZup8bm+VtfGjoJCkDgUHU1fxu/c+5AUc
    x86PTXE7tZJeMRzdSx/i401mQqcYt0uFnfHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :in-reply-to:references:list-id:list-unsubscribe:list-archive
    :list-post:list-help:list-subscribe:cc:mime-version:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523852141; bh=gsMyA
    xtzWSxhxd7gjVsgGhI6Uji4cMoFapYLD3tkgNU=; b=NpXpf92ntSh3PCTuSDFK+
    gd6nuaKvQzLw1ocVH7IHrbA8ThhnnH/HMl6T0s+TcXbx5q245PKkQ6rotKDWBgTD
    eAY+Szz9b0BQ5fJWaf80S5971aF8+G+8Ehulwtx4cJ4pl9CZv0KLX/KoE+2zWsCk
    199HD4qMP1JbslKnSWgWifVY+iGvrAVxxpyxNIoX6+YfwW5abLmAFq9cCuZa98vX
    ySKMnGzoiuwM9RKyw5vVR10No0d5a/01REsWQ0n+pJGWHjAktvn1dfpA6vuuBENO
    EXSQEEHAIxZiCRko3DItx7J7TGtFe90woJSU9LdgN4O5jyXMFx4COiWy8dFarAyG
    Q==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
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
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfIjimPHF8A0vfpHfqu8GAeg1miIG4sBBu9MFnwzkVqa01ubdUMXruhi5gv4XtaxNWZneRfc3tu+lcjygysBGJejAYIOj8UkcFqMUBkoUoh+lC31HcB4W
    GsX7ZbdZAd4YsUXDNl35KIKi46IAPRYC91r0Q2Lz4DXziAGQXDeXoA3ld+ZIC7XQM318QRJV8cwVXgoH5fc3aEgYqxHy/mNOEmle+e/QO6RLmo8wQjXVTnYh
    S0khDK7QqxtHx5AWrPbV9g==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=CjxXgO3LAAAA:8 a=QyXUC8HyAAAA:8
    a=ySfo2T4IAAAA:8 a=lB0dNpNiAAAA:8 a=JfrnYn6hAAAA:8 a=DDOyTI_5AAAA:8
    a=Vlp5QdiR3QFeWZbP00cA:9 a=CjuIK1q_8ugA:10 a=ZUkhVnNHqyo2at-WnAgH:22
    a=c-ZiYqmG3AbHTdtsH08C:22 a=1CNFftbPRP8L7MoqJWF3:22 a=_BcfOz0m4U4ohdxiHPKc:22
    cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: James Simmons <jsimmons@infradead.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, Andreas Dilger <andreas.dilger@intel.com>,
 Oleg Drokin <oleg.drokin@intel.com>, NeilBrown <neilb@suse.com>
Subject: [PATCH 13/22] staging: lustre: llite: remove newline in fullname
 strings
Date: Mon, 16 Apr 2018 00:15:02 -0400
Message-Id: <1523852111-17321-14-git-send-email-jsimmons@infradead.org>
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

In creating the full name of a xattr a new line was added that
was seen by the remote MDS server which confused it. Remove the
newline.

Signed-off-by: James Simmons <uja.ornl@yahoo.com>
Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9183
Reviewed-on: https://review.whamcloud.com/27240
Reviewed-by: Dmitry Eremin <dmitry.eremin@intel.com>
Reviewed-by: Bob Glossman <bob.glossman@intel.com>
Reviewed-by: Sebastien Buisson <sbuisson@ddn.com>
Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
Signed-off-by: James Simmons <jsimmons@infradead.org>
---
 drivers/staging/lustre/lustre/llite/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/lustre/lustre/llite/xattr.c b/drivers/staging/lustre/lustre/llite/xattr.c
index 42a6fb4..4b1e565 100644
--- a/drivers/staging/lustre/lustre/llite/xattr.c
+++ b/drivers/staging/lustre/lustre/llite/xattr.c
@@ -136,7 +136,7 @@ static int xattr_type_filter(struct ll_sb_info *sbi,
 			return -EPERM;
 	}
 
-	fullname = kasprintf(GFP_KERNEL, "%s%s\n", handler->prefix, name);
+	fullname = kasprintf(GFP_KERNEL, "%s%s", handler->prefix, name);
 	if (!fullname)
 		return -ENOMEM;
 	rc = md_setxattr(sbi->ll_md_exp, ll_inode2fid(inode),
@@ -435,7 +435,7 @@ static int ll_xattr_get_common(const struct xattr_handler *handler,
 	if (handler->flags == XATTR_ACL_DEFAULT_T && !S_ISDIR(inode->i_mode))
 		return -ENODATA;
 #endif
-	fullname = kasprintf(GFP_KERNEL, "%s%s\n", handler->prefix, name);
+	fullname = kasprintf(GFP_KERNEL, "%s%s", handler->prefix, name);
 	if (!fullname)
 		return -ENOMEM;
 	rc = ll_xattr_list(inode, fullname, handler->flags, buffer, size,
-- 
1.8.3.1

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
