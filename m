Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90058C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393C6206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U35wVhCq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 393C6206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbeI2AZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:25:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39177 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeI2AZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:25:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14-v6so7298734wrw.6;
        Fri, 28 Sep 2018 11:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wA5posi+vGig+3+fjgVLM2GVtCwL3CSWCPE/7mJdTTs=;
        b=U35wVhCqIKfsfBMkrDtFEsxwaw5fogUYy1Jo9safJ9s6Zb0EElCIEjNXhOtK0sTHmU
         xcJph24nW81WPoOZ/GDXGbOhcybXnTC2o4q6FWm1ERB1st1IFFXVd5VQpL9TiaMp5EGU
         anff9llz/2/QJ+qGna5MUWMtaRF/z1v8WTfJ/MKogfP1tk34Cxu1EqAKn213sNTBt/dP
         FedH075Nz8rLrOBeSkg/JexWVfrSNQHnHmm2UlUDfxO5O7d/Czfhvz+5sYGD9k87zybA
         FomiXzEXALIDFlKHpsXwi6TyWKm+i4TukZRdq+WJeiYXw5rq4FgcCf2gx4ssHNcTXsjl
         KEUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wA5posi+vGig+3+fjgVLM2GVtCwL3CSWCPE/7mJdTTs=;
        b=PpMqIwY6GZFRB6/+1Aduh4Qi/VOTVJmLRB+hi+PYBi3XOOUhFrrr4xLaRZqDNX1BOg
         Q3LI+0DTt0iUlgT1YyXAKxUM4PjuDA+ofNEWA0LzxnI/j9sd5uL6XrgQe47fwBk+VZ0j
         zbZDDhd9qhRJP7JpU0av8P3X9NkgWcwMbxKTSOsWkh7lB4ZRcpkXBcay4K1w95CV+MmL
         Mx5cAuOgBIOvTPV5pR0l89QtWE4PB5LxdtpSwflN7l2PSLqSX3UBZ+DGrGwgyp9sZYfc
         INmR5ZZXxrIHToVitL85tlNnWK/uUZhuqP+ewggMC09ghp1HBqQp0CEj6u8gzrhA2UQ4
         Rhwg==
X-Gm-Message-State: ABuFfohgLOn3XAibYegOL45CeKXgjhZu7lhGuZ7IBR2ffP4orthfyhvw
        sXHg/R5goGPE/gexqq3UWUU=
X-Google-Smtp-Source: ACcGV60+ViiGSFPM+emRMj6uwO+OF7oQlC0unBBfm0jLLLkzDBHGWHzQwoF5gB1FUuQbAWB7bwdv+Q==
X-Received: by 2002:adf:81c3:: with SMTP id 61-v6mr12975633wra.120.1538157657433;
        Fri, 28 Sep 2018 11:00:57 -0700 (PDT)
Received: from localhost.localdomain ([141.226.14.107])
        by smtp.gmail.com with ESMTPSA id j46-v6sm9606897wre.91.2018.09.28.11.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 11:00:56 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Jan Harkes <jaharkes@cs.cmu.edu>, Mark Fasheh <mark@fasheh.com>
Subject: [PATCH] fs: fix access beyond unterminated strings in prints
Date:   Fri, 28 Sep 2018 21:00:48 +0300
Message-Id: <20180928180048.14259-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN detected slab-out-of-bounds access in printk from overlayfs,
because string format used %*s instead of %.*s.
Found and fixed 4 other places that use %*s incorrectly in filesystems.

> BUG: KASAN: slab-out-of-bounds in string+0x298/0x2d0 lib/vsprintf.c:604
> Read of size 1 at addr ffff8801c36c66ba by task syz-executor2/27811
>
> CPU: 0 PID: 27811 Comm: syz-executor2 Not tainted 4.19.0-rc5+ #36
...
>  printk+0xa7/0xcf kernel/printk/printk.c:1996
>  ovl_lookup_index.cold.15+0xe8/0x1f8 fs/overlayfs/namei.c:689

Reported-by: syzbot+376cea2b0ef340db3dd4@syzkaller.appspotmail.com
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: Mark Fasheh <mark@fasheh.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Miklos,

I chose not to split the patches per fs in the hope that maintainers
would quickly ack the patch and ask you to carry it for them.

If this doesn't happen, feel free to drop non-acked bits from the patch.

Thanks,
Amir.

 fs/coda/dir.c            | 2 +-
 fs/lockd/host.c          | 2 +-
 fs/ocfs2/super.c         | 2 +-
 fs/overlayfs/namei.c     | 2 +-
 fs/overlayfs/overlayfs.h | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index 00876ddadb43..23ee5de8b4be 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -47,7 +47,7 @@ static struct dentry *coda_lookup(struct inode *dir, struct dentry *entry, unsig
 	int type = 0;
 
 	if (length > CODA_MAXNAMLEN) {
-		pr_err("name too long: lookup, %s (%*s)\n",
+		pr_err("name too long: lookup, %s (%.*s)\n",
 		       coda_i2s(dir), (int)length, name);
 		return ERR_PTR(-ENAMETOOLONG);
 	}
diff --git a/fs/lockd/host.c b/fs/lockd/host.c
index d35cd6be0675..93fb7cf0b92b 100644
--- a/fs/lockd/host.c
+++ b/fs/lockd/host.c
@@ -341,7 +341,7 @@ struct nlm_host *nlmsvc_lookup_host(const struct svc_rqst *rqstp,
 	};
 	struct lockd_net *ln = net_generic(net, lockd_net_id);
 
-	dprintk("lockd: %s(host='%*s', vers=%u, proto=%s)\n", __func__,
+	dprintk("lockd: %s(host='%.*s', vers=%u, proto=%s)\n", __func__,
 			(int)hostname_len, hostname, rqstp->rq_vers,
 			(rqstp->rq_prot == IPPROTO_UDP ? "udp" : "tcp"));
 
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 3415e0b09398..b74435dc85fd 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -259,7 +259,7 @@ static int ocfs2_osb_dump(struct ocfs2_super *osb, char *buf, int len)
 
 	if (cconn) {
 		out += snprintf(buf + out, len - out,
-				"%10s => Stack: %s  Name: %*s  "
+				"%10s => Stack: %s  Name: %.*s  "
 				"Version: %d.%d\n", "Cluster",
 				(*osb->osb_cluster_stack == '\0' ?
 				 "o2cb" : osb->osb_cluster_stack),
diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index f28711846dd6..9c0ca6a7becf 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -686,7 +686,7 @@ struct dentry *ovl_lookup_index(struct ovl_fs *ofs, struct dentry *upper,
 			index = NULL;
 			goto out;
 		}
-		pr_warn_ratelimited("overlayfs: failed inode index lookup (ino=%lu, key=%*s, err=%i);\n"
+		pr_warn_ratelimited("overlayfs: failed inode index lookup (ino=%lu, key=%.*s, err=%i);\n"
 				    "overlayfs: mount with '-o index=off' to disable inodes index.\n",
 				    d_inode(origin)->i_ino, name.len, name.name,
 				    err);
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index f61839e1054c..c096f12657cd 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -152,7 +152,7 @@ static inline int ovl_do_setxattr(struct dentry *dentry, const char *name,
 				  const void *value, size_t size, int flags)
 {
 	int err = vfs_setxattr(dentry, name, value, size, flags);
-	pr_debug("setxattr(%pd2, \"%s\", \"%*s\", 0x%x) = %i\n",
+	pr_debug("setxattr(%pd2, \"%s\", \"%.*s\", 0x%x) = %i\n",
 		 dentry, name, (int) size, (char *) value, flags, err);
 	return err;
 }
-- 
2.17.1

