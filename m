Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3427C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03E65217C9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AyddTb7I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E65217C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbeHIMRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:17:51 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:32511 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727563AbeHIMRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:17:51 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20180809095344epoutp048857b604f2b67748479e1e9d5206af2d~JLqLBffsm2053720537epoutp04E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Aug 2018 09:53:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180809095344epoutp048857b604f2b67748479e1e9d5206af2d~JLqLBffsm2053720537epoutp04E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1533808424;
        bh=N51gdx0muhWDFOIBdjidWrgUkhK6WCaG8gUwvaF6C1A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AyddTb7IkzGpSMraPx7YSdCQOLppiPNkCVfo1dz4abdW/Lcf/Y1VaSNwV0G2wQpoy
         dolYWw2gYEIV+wz7jAvevcaTu03yyYTQ+JqrKe8n98i8WR0ztsBPH1BQa9D+bMX8TN
         EfjIxb8INNle21eEIewC7VdM+22wh+FuI3PhFZi0=
Received: from epsmges1p5.samsung.com (unknown [182.195.40.153]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180809095342epcas1p2248fb23cead3cc88b0f9fa8554659c98~JLqJcpGdj0579405794epcas1p2f;
        Thu,  9 Aug 2018 09:53:42 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        90.42.04144.62F0C6B5; Thu,  9 Aug 2018 18:53:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20180809095342epcas1p425d6ada22d3863459e44c335b51801de~JLqInMQtE1558515585epcas1p4v;
        Thu,  9 Aug 2018 09:53:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180809095342epsmtrp26b1ddff80d2376537de37157ca02be85~JLqIkyFAO0832908329epsmtrp2r;
        Thu,  9 Aug 2018 09:53:42 +0000 (GMT)
X-AuditID: b6c32a39-b9dff70000001030-8b-5b6c0f26ed70
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.22.03759.52F0C6B5; Thu,  9 Aug 2018 18:53:41 +0900 (KST)
Received: from localhost.localdomain (unknown [10.113.63.222]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180809095341epsmtip1f16e8dba6cb625406e444f9aa7eac6be~JLqIbXnnQ1957119571epsmtip1q;
        Thu,  9 Aug 2018 09:53:41 +0000 (GMT)
From:   Seung-Woo Kim <sw0312.kim@samsung.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        gregkh@linuxfoundation.org
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, jslaby@suse.cz,
        sw0312.kim@samsung.com
Subject: [PATCH 3.18.y 3/5] security_d_instantiate(): move to the point
 prior to attaching dentry to inode
Date:   Thu,  9 Aug 2018 18:53:42 +0900
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1533808424-20649-1-git-send-email-sw0312.kim@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRjHed12drRWh1n5tLDWoQQjp2dzeTTtajVI0jAisrCTvm3iLrKz
        SRak4S2kvHQhyxUz/bDS8pKpWWZZTT/YBYpABGUiQhelNA2SLmceo0/vj//zf573z8NDSpQj
        MhWZZXVgu5Uz00SQtP15uCYibKk5LcpVHMu6mhoJtrCuiWCn57pk7LsuF8G6W0YRW33pI8GO
        lk/I2Te/+mTbSEN/9ZzU0HOjUW4ob7uDDAPuF3LDdOtqQ+vYREAKcRjHmzCXie1qbM2wZWZZ
        jQn03tT0nen6TVFMBBPLxtBqK2fBCXRiUkrE7iyzEIhW53JmpyClcDxPR26Jt9ucDqw22XhH
        Ap3GMFoNExWj0WqFV3c0TqsXLMewqblllMgZDD05c80nL0CPoAwFkkBFw4+hAnkZCiKVVCeC
        C7eKAvwFJTWF4MmzZLEwi2DEOyD919FWU4nEQjeCn9+G5WLHNIJ3dcf9TFAboad+TubnZdRB
        aPBdIfwsofJh8M/veQ6mzPBqrFviZym1Hn78rJGJH6jBPTwx7wmk9kBnyfiC3khA5dkTflZQ
        ufDmsStA1BOh9unthXDB8KmvTS6yCqYnuwmRSxE8u3bGHxqoywg+/JpaMOlgvLZMGEQK4cKh
        qStSzLkEJmfOy/wyUAo4V6IU3evg4cuLhCir4Hpzqigb4JzPKxNX0o/gbv8HSSUKvf5/qBuh
        O2gFzuEtRswzOXoNz1l4p9WoybBZWtH8cW2I7UTe10m9iCIRvVjxdkl2mlLG5fJ5ll4EpIRe
        plj0R5AUmVzeKWy3pdudZsz3Ir2wvCqJanmGTThVqyOd0Wt1Oh0bzWzSMwwdotDuS01TUkbO
        gbMxzsH2f30BZKCqAGXk1zxo8CRXGNUPv+wO2XvaY7LX1/lccQe+F61trorL2/f8q3ZlQ9a9
        GzxBdSQ7wysiXdvLdoXtH04MKymtutjVc19yymsM6rjqcR5qyt1RUTLiSSQoy81Pnq3N7Wvq
        3te/0thw4eUH5d7i0CM3y6Mubf485GHAN7sqKHymevwMLeVNHLNBYue5v25FdlxyAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDLMWRmVeSWpSXmKPExsWy7bCSnK4af060wTkliznr17BZNC9ez2bx
        +fcuVovLu+awWSzY+IjRYsbkl2wWj/resluc/3uc1YHD48SM3ywe++euYffo27KK0ePMgiPs
        Hp83yXlsevKWKYAtissmJTUnsyy1SN8ugStjw8ZHbAU3ZSu+znzI3sC4W6KLkZNDQsBEYsvs
        CYxdjFwcQgK7GSXuvnvNBJGQkpj7bTtQggPIFpY4fLgYouYjo8STh2tZQWrYBHQk9i/5DWaL
        CERIHHg2mQ2kiFmglVHizJLDTCDNwgJZEjcOi4HUsAioSnz/NRusnlfATeLYkqVsELsUJBbc
        ewtmcwq4S+xoewZWIyRQIjHz6B/2CYx8CxgZVjFKphYU56bnFhsWGOallusVJ+YWl+al6yXn
        525iBIehluYOxstL4g8xCnAwKvHwXuDLjhZiTSwrrsw9xCjBwawkwsv9HyjEm5JYWZValB9f
        VJqTWnyIUZqDRUmc92nesUghgfTEktTs1NSC1CKYLBMHp1QDYx/T2uL3JzfZhG6Wn1J3UjlO
        9bJ4sGMOS+TV+M5F7ZHTGzfcLp1ikPTJVkFwnULev06dj70P2s848nk1n7pVlbPmonj+QQ3u
        9pNLT53/9EJsS94EBXeVmzv6wm75bg1/1CT14srzm64TarO7o/ob112RVHuvsl6E607/sz2V
        S3Xv9Zh32m0TVmIpzkg01GIuKk4EAAMAqn8/AgAA
Message-Id: <20180809095342epcas1p425d6ada22d3863459e44c335b51801de~JLqInMQtE1558515585epcas1p4v@epcas1p4.samsung.com>
X-CMS-MailID: 20180809095342epcas1p425d6ada22d3863459e44c335b51801de
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180809095342epcas1p425d6ada22d3863459e44c335b51801de
References: <20180705005205.GC30522@ZenIV.linux.org.uk>
        <1533808424-20649-1-git-send-email-sw0312.kim@samsung.com>
        <CGME20180809095342epcas1p425d6ada22d3863459e44c335b51801de@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

commit b96809173e94ea2fa8c19c2e40e8545a1821bf57 upstream.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

[sw0312.kim: backport to 3.18]
Signed-off-by: Seung-Woo Kim <sw0312.kim@samsung.com>
---
 fs/dcache.c |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index a34d401..6a4290a 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1729,12 +1729,12 @@ static void __d_instantiate(struct dentry *dentry, struct inode *inode)
 void d_instantiate(struct dentry *entry, struct inode * inode)
 {
 	BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
+	security_d_instantiate(entry, inode);
 	if (inode)
 		spin_lock(&inode->i_lock);
 	__d_instantiate(entry, inode);
 	if (inode)
 		spin_unlock(&inode->i_lock);
-	security_d_instantiate(entry, inode);
 }
 EXPORT_SYMBOL(d_instantiate);
 
@@ -1795,16 +1795,15 @@ struct dentry *d_instantiate_unique(struct dentry *entry, struct inode *inode)
 
 	BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
 
+	security_d_instantiate(entry, inode);
 	if (inode)
 		spin_lock(&inode->i_lock);
 	result = __d_instantiate_unique(entry, inode);
 	if (inode)
 		spin_unlock(&inode->i_lock);
 
-	if (!result) {
-		security_d_instantiate(entry, inode);
+	if (!result)
 		return NULL;
-	}
 
 	BUG_ON(!d_unhashed(result));
 	iput(inode);
@@ -1826,6 +1825,7 @@ int d_instantiate_no_diralias(struct dentry *entry, struct inode *inode)
 {
 	BUG_ON(!hlist_unhashed(&entry->d_u.d_alias));
 
+	security_d_instantiate(entry, inode);
 	spin_lock(&inode->i_lock);
 	if (S_ISDIR(inode->i_mode) && !hlist_empty(&inode->i_dentry)) {
 		spin_unlock(&inode->i_lock);
@@ -1834,7 +1834,6 @@ int d_instantiate_no_diralias(struct dentry *entry, struct inode *inode)
 	}
 	__d_instantiate(entry, inode);
 	spin_unlock(&inode->i_lock);
-	security_d_instantiate(entry, inode);
 
 	return 0;
 }
@@ -1930,6 +1929,7 @@ static struct dentry *__d_obtain_alias(struct inode *inode, int disconnected)
 		goto out_iput;
 	}
 
+	security_d_instantiate(tmp, inode);
 	spin_lock(&inode->i_lock);
 	res = __d_find_any_alias(inode);
 	if (res) {
@@ -1953,13 +1953,10 @@ static struct dentry *__d_obtain_alias(struct inode *inode, int disconnected)
 	hlist_bl_unlock(&tmp->d_sb->s_anon);
 	spin_unlock(&tmp->d_lock);
 	spin_unlock(&inode->i_lock);
-	security_d_instantiate(tmp, inode);
 
 	return tmp;
 
  out_iput:
-	if (res && !IS_ERR(res))
-		security_d_instantiate(res, inode);
 	iput(inode);
 	return res;
 }
@@ -2817,6 +2814,7 @@ struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
 		return ERR_CAST(inode);
 
 	if (inode && S_ISDIR(inode->i_mode)) {
+		security_d_instantiate(dentry, inode);
 		spin_lock(&inode->i_lock);
 		new = __d_find_any_alias(inode);
 		if (new) {
@@ -2836,13 +2834,11 @@ struct dentry *d_splice_alias(struct inode *inode, struct dentry *dentry)
 			__d_move(new, dentry, false);
 			write_sequnlock(&rename_lock);
 			spin_unlock(&inode->i_lock);
-			security_d_instantiate(new, inode);
 			iput(inode);
 		} else {
 			/* already taking inode->i_lock, so d_add() by hand */
 			__d_instantiate(dentry, inode);
 			spin_unlock(&inode->i_lock);
-			security_d_instantiate(dentry, inode);
 			d_rehash(dentry);
 		}
 	} else {
@@ -2876,6 +2872,7 @@ struct dentry *d_materialise_unique(struct dentry *dentry, struct inode *inode)
 		goto out_nolock;
 	}
 
+	security_d_instantiate(dentry, inode);
 	spin_lock(&inode->i_lock);
 
 	if (S_ISDIR(inode->i_mode)) {
@@ -2927,7 +2924,6 @@ found:
 	spin_unlock(&inode->i_lock);
 out_nolock:
 	if (actual == dentry) {
-		security_d_instantiate(dentry, inode);
 		return NULL;
 	}
 
-- 
1.7.4.1

