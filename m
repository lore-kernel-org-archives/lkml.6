Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2591571-1524405501-5-10931763562475733232
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524405501; b=gRjklnJ8Hd+wMIR/QE/memSPAhqUm99lB27FeSmWJogDVfhMCf
    UKDBH83F50oS51rIM7Z4/cD2MznftplQ9S3nEXegQWv83EW89Gy14YS/iDPqdVk8
    FWHJ8bp/TZDcMc/WzIpUgSua3mkQhjWQQWTjCbCaJCw//ukiMRIjBAbf0zCmgVIe
    kJJWGnuIOam5bWIBFYLekjv3/OndesPmHaIuJi4IiljBwmXY2drv85TVzgVJjH44
    1Z3uziG8sfq1CRdMGiItCcoTq/vWf1n2IQUX5IqaqK6psxtP1RQ4DREzNt2fa7jk
    oucLKGa/KGSMoMX+AKUiNNkw+udYYp9bCbIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405501; bh=Xvf7f5nwZmgHnFDau3q5i3qV7jcIvL
    nR8sQFJhcEDok=; b=eYyFMVQeryCOnl09kyKDT1xPY3lKbp+c+qhHEkyF9TLEmG
    XYyLVux4XLLLdZJgzU6QQHfILWRJZbNQ1mhdM9cEFT5RHceRlvzIJ5ps66nDt19T
    rZU8fGLZtcaxOvIqWXi2JJuqElfS2q1C799kMEreu53NXKrr0oUuRkspuLLNEBJ0
    TuYRI0Q890XNIlinoIURu/9gxfCQIdpJE5eY3vly6Vsiv8wKczDXi4h7woTPmaSp
    91BqJulFo/vvN2klC0IDOMvC67DZ7v5SeuxckL/NXWwAC27m0Zf5C4bKlK9Ns2ir
    NRNYCv5PnlXhAIgl30CaeGhQH08A4+FuVIPK8+HA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLRaYrASTL7uYlAtH5Yor/kO98CwcrHcuaoukU3n3UtaxIz5c1tAJMOUotae30Wvo9XFScJ4iDWMdYoOl92fo4JoVZSueSVSNFnX9nVov5rkGP7HOO/W
    XasLeAvE9X7NX5CkjFG8nHYM6wCXjBycl9eUe8z0jHLU+fnEgJ/3O5g73EXGoVa8TJY1a2yHpwLiF+8Ecszslyx4ccu7e9i7L5kc3p0ACLwpkJqnUf/hR9tm
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yMhMjlubAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8
    a=Dg2ljCQCCZmBaCWO81UA:9 a=dRVSvrazRyft2pHp:21 a=2UmHkOUtiliz6zdM:21
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754089AbeDVN6Q (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 09:58:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46104 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754104AbeDVN6M (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 09:58:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Steve French <smfrench@gmail.com>,
        Pavel Shilovsky <pshilov@microsoft.com>
Subject: [PATCH 4.16 050/196] smb3: Fix root directory when server returns inode number of zero
Date: Sun, 22 Apr 2018 15:51:10 +0200
Message-Id: <20180422135106.677589103@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

commit 7ea884c77e5c97f1e0a1a422d961d27f78ca2745 upstream.

Some servers return inode number zero for the root directory, which
causes ls to display incorrect data (missing "." and "..").

If the server returns zero for the inode number of the root directory,
fake an inode number for it.

Signed-off-by: Steve French <smfrench@gmail.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
CC: Stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/cifs/cifsglob.h |    1 +
 fs/cifs/inode.c    |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1466,6 +1466,7 @@ struct dfs_info3_param {
 #define CIFS_FATTR_NEED_REVAL		0x4
 #define CIFS_FATTR_INO_COLLISION	0x8
 #define CIFS_FATTR_UNKNOWN_NLINK	0x10
+#define CIFS_FATTR_FAKE_ROOT_INO	0x20
 
 struct cifs_fattr {
 	u32		cf_flags;
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -707,6 +707,18 @@ cgfi_exit:
 	return rc;
 }
 
+/* Simple function to return a 64 bit hash of string.  Rarely called */
+static __u64 simple_hashstr(const char *str)
+{
+	const __u64 hash_mult =  1125899906842597L; /* a big enough prime */
+	__u64 hash = 0;
+
+	while (*str)
+		hash = (hash + (__u64) *str++) * hash_mult;
+
+	return hash;
+}
+
 int
 cifs_get_inode_info(struct inode **inode, const char *full_path,
 		    FILE_ALL_INFO *data, struct super_block *sb, int xid,
@@ -816,6 +828,14 @@ cifs_get_inode_info(struct inode **inode
 						 tmprc);
 					fattr.cf_uniqueid = iunique(sb, ROOT_I);
 					cifs_autodisable_serverino(cifs_sb);
+				} else if ((fattr.cf_uniqueid == 0) &&
+						strlen(full_path) == 0) {
+					/* some servers ret bad root ino ie 0 */
+					cifs_dbg(FYI, "Invalid (0) inodenum\n");
+					fattr.cf_flags |=
+						CIFS_FATTR_FAKE_ROOT_INO;
+					fattr.cf_uniqueid =
+						simple_hashstr(tcon->treeName);
 				}
 			}
 		} else
@@ -832,6 +852,16 @@ cifs_get_inode_info(struct inode **inode
 				&fattr.cf_uniqueid, data);
 			if (tmprc)
 				fattr.cf_uniqueid = CIFS_I(*inode)->uniqueid;
+			else if ((fattr.cf_uniqueid == 0) &&
+					strlen(full_path) == 0) {
+				/*
+				 * Reuse existing root inode num since
+				 * inum zero for root causes ls of . and .. to
+				 * not be returned
+				 */
+				cifs_dbg(FYI, "Srv ret 0 inode num for root\n");
+				fattr.cf_uniqueid = CIFS_I(*inode)->uniqueid;
+			}
 		} else
 			fattr.cf_uniqueid = CIFS_I(*inode)->uniqueid;
 	}
@@ -893,6 +923,9 @@ cifs_get_inode_info(struct inode **inode
 	}
 
 cgii_exit:
+	if ((*inode) && ((*inode)->i_ino == 0))
+		cifs_dbg(FYI, "inode number of zero returned\n");
+
 	kfree(buf);
 	cifs_put_tlink(tlink);
 	return rc;
