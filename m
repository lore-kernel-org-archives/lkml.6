Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-515344-1518542054-2-318340335016253964
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518542051; b=iPjY2Qt4QMQJu7ZLReoyCcBbADnyQTu3+BiMb0wM2Vsv8NF
    13TV58R5YrRhXLp3+hy/uXfu6fa4ZCXza/r4UdjuNc/2wats+Tau8MJtXH+7RJi6
    MUIC/uJavrSFXKM+qO77Acsfqmq+Zvj8BivDDBBw2H71V6/qf5v/3tMZwf9Nr4PT
    /Gbx36x7M7hA34DxwSAol8nycOCycCjjHlEpzYntqA4wrJBMKVOdjeI4FBhPaM9U
    dM6q7nLO//YNNWQOASnPYWj3+9onhHvZ5GNglgQdhUZMV87r7kzYFvHFT1EuX29n
    vEAsxuaZvcR7tpUmFufpIfH6mj1H37HN916KUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1518542051; bh=90hZCkfow5X7r738FHt92rcAmT20KXVIczhmq6dI43E=; b=H
    6k2Dg61kI0YYg1lTTUZQjLHEkxIocrWdSNTz/HkZQh3jNXwu/Qtj+WiikzebWYz0
    gMFsm7AdjUzChbx/3io02aoATaj0qDzUmNV342xXchKlyRhlqk15qssodzKT9tIV
    7ustQqW0RMWVZutfeY3gposK8jgB2QRY5jXYkThLfrN45tct6xCk85ESCzKlBUpb
    3nw3WejnzQfJYUXlsDn2LCW+HfbyyXckBxwX/fAhqLOBOnjBVbR5XjZrP6JL0+T7
    FEmOGbWVOT6jUhkF0CMb8AmUSqIpnkNYZV20V97Ijg8oZiwTYx12OMR61GB4mQ13
    xziarTnv+sV4W+qKfXFmg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ni.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ni.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ni.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ni.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965294AbeBMRN6 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 12:13:58 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:49086 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S965181AbeBMRN4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Feb 2018 12:13:56 -0500
From: Julia Cartwright <julia@ni.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Weinberger <richard@nod.at>
CC: Adrian Ratiu <adrian.ratiu@ni.com>,
        Xiaolei Li <xiaolei.li@mediatek.com>,
        Artem Bityutskiy <dedekind1@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: [PATCH 4.9.y] ubifs: Massage assert in ubifs_xattr_set() wrt. init_xattrs
Date: Tue, 13 Feb 2018 11:13:08 -0600
Message-ID: <20180213171308.23909-1-julia@ni.com>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-13_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=inbound_policy_notspam policy=inbound_policy score=30
 priorityscore=1501 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=30 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1802130206
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Xiaolei Li <xiaolei.li@mediatek.com>

This is a conceptual cherry-pick of commit
d8db5b1ca9d4c57e49893d0f78e6d5ce81450cc8 upstream.

The inode is not locked in init_xattrs when creating a new inode.

Without this patch, there will occurs assert when booting or creating
a new file, if the kernel config CONFIG_SECURITY_SMACK is enabled.

Log likes:

UBIFS assert failed in ubifs_xattr_set at 298 (pid 1156)
CPU: 1 PID: 1156 Comm: ldconfig Tainted: G S 4.12.0-rc1-207440-g1e70b02 #2
Hardware name: MediaTek MT2712 evaluation board (DT)
Call trace:
[<ffff000008088538>] dump_backtrace+0x0/0x238
[<ffff000008088834>] show_stack+0x14/0x20
[<ffff0000083d98d4>] dump_stack+0x9c/0xc0
[<ffff00000835d524>] ubifs_xattr_set+0x374/0x5e0
[<ffff00000835d7ec>] init_xattrs+0x5c/0xb8
[<ffff000008385788>] security_inode_init_security+0x110/0x190
[<ffff00000835e058>] ubifs_init_security+0x30/0x68
[<ffff00000833ada0>] ubifs_mkdir+0x100/0x200
[<ffff00000820669c>] vfs_mkdir+0x11c/0x1b8
[<ffff00000820b73c>] SyS_mkdirat+0x74/0xd0
[<ffff000008082f8c>] __sys_trace_return+0x0/0x4

Signed-off-by: Xiaolei Li <xiaolei.li@mediatek.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Cc: stable@vger.kernel.org
(julia: massaged to apply to 4.9.y, which doesn't contain fscrypto support)
Signed-off-by: Julia Cartwright <julia@ni.com>
---
Hey all-

We reproduced the issue fixed upstream by Xiaolei Li's commit in 4.9.y,
with the very similar backtrace:

   UBIFS assert failed in __ubifs_setxattr at 282 (pid 1362)
   CPU: 1 PID: 1362 Comm: sed Not tainted 4.9.47-rt37 #1
   Backtrace:
      (dump_backtrace) from (show_stack+0x20/0x24)
      (show_stack) from (dump_stack+0x80/0xa0)
      (dump_stack) from (__ubifs_setxattr+0x84/0x634)
      (__ubifs_setxattr) from (init_xattrs+0x70/0xac)
      (init_xattrs) from (security_inode_init_security+0x100/0x144)
      (security_inode_init_security) from (ubifs_init_security+0x38/0x6c)
      (ubifs_init_security) from (ubifs_create+0xe8/0x1fc)
      (ubifs_create) from (path_openat+0x97c/0x1090)
      (path_openat) from (do_filp_open+0x48/0x94)
      (do_filp_open) from (do_sys_open+0x134/0x1d8)
      (do_sys_open) from (SyS_open+0x30/0x34)
      (SyS_open) from (ret_fast_syscall+0x0/0x3c)

Please consider applying this to 4.9.y at the very least, it may apply
further back as well.

Thanks!
   Julia

 fs/ubifs/xattr.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index d9f9615bfd71..3979d767a0cb 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -270,7 +270,8 @@ static struct inode *iget_xattr(struct ubifs_info *c, ino_t inum)
 }
 
 static int __ubifs_setxattr(struct inode *host, const char *name,
-			    const void *value, size_t size, int flags)
+			    const void *value, size_t size, int flags,
+			    bool check_lock)
 {
 	struct inode *inode;
 	struct ubifs_info *c = host->i_sb->s_fs_info;
@@ -279,7 +280,8 @@ static int __ubifs_setxattr(struct inode *host, const char *name,
 	union ubifs_key key;
 	int err;
 
-	ubifs_assert(inode_is_locked(host));
+	if (check_lock)
+		ubifs_assert(inode_is_locked(host));
 
 	if (size > UBIFS_MAX_INO_DATA)
 		return -ERANGE;
@@ -548,7 +550,8 @@ static int init_xattrs(struct inode *inode, const struct xattr *xattr_array,
 		}
 		strcpy(name, XATTR_SECURITY_PREFIX);
 		strcpy(name + XATTR_SECURITY_PREFIX_LEN, xattr->name);
-		err = __ubifs_setxattr(inode, name, xattr->value, xattr->value_len, 0);
+		err = __ubifs_setxattr(inode, name, xattr->value,
+				       xattr->value_len, 0, false);
 		kfree(name);
 		if (err < 0)
 			break;
@@ -594,7 +597,8 @@ static int ubifs_xattr_set(const struct xattr_handler *handler,
 	name = xattr_full_name(handler, name);
 
 	if (value)
-		return __ubifs_setxattr(inode, name, value, size, flags);
+		return __ubifs_setxattr(inode, name, value, size, flags,
+					true);
 	else
 		return __ubifs_removexattr(inode, name);
 }
-- 
2.16.1
