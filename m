Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26439C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 05:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C461120882
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 05:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="V1zRWQSv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C461120882
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbeG2HHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 03:07:19 -0400
Received: from sonic307-10.consmr.mail.gq1.yahoo.com ([98.137.64.34]:42139
        "EHLO sonic307-10.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726170AbeG2HHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 03:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1532842688; bh=8uEJBh1r38Cy4nGF46fOqUk/dlVg2JNdXuz5PWgi3k0=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=V1zRWQSvZv5Tlfn/yrdHUAySBbGKPaU0PJucVSTD4v1BmKwu1Kt1T+FNVgtdot0+IcX2f/lj/uqk5HKNspS30ulKSumhuLHsWUDeqoQQD35+LHH4G9ZbCh7gMZLBV8VYgfbVOWc9WDgwckdnTjF0vyP2W70R2ZVF+cdyVBNWXjlXuJV57pSBgD5d2sAiue8FT5EQfCSRDjSEpQiUXgWkzSETDFTgymLBQ3KyybHdf1zquswNr51Fey6lmaLlQwr60BXZ3dnBOATP/yYWaGsHI4kTc55ADFvB0wp3IDsadBcXQNwkYob4BgT29I5VVE+1y7lA3BFokSb8PZfMz2KPKw==
X-YMail-OSG: sxcyLR0VM1lT8_g5G_q.qCTEWIs8N30TjZUgEi0vQVjxlupx64x_2UPGxWOnUlM
 vuLyskTj6w7pxTnwihhR.bbbXAIlf2hrlB3ztHmx_l2SCUpsKq1sQwzazpmlR0ALTUvyitBfNEor
 Zqqu3Mlq8PmVFea7PO05sqHWuEyZIiNtFoFJ7LIf57Cc6ZMfJqXHEYb15EshI6c.zo_k5Fd23nMK
 3Pq4_hpYTZyRHCPE9EMtUJitkOXU8MapTcefKGzWDj_6jTnNjezH._TzTw7gbwvtHuw9C5RTqdV_
 9ySS1w57.74oYnIS8YJKoBydU7WlB2quL2ArKu5j9.qW.o2EWrMe_d7hp2eAfF_xOtMLCNuMrRas
 j2INbgZ9a2RwiuyLZVf3pys0IsqIZDCsEWZ9LRT.FGpKRaRDKzC._6sJ3Avme9OTdgU.vFuNmuxj
 _EOQ1OtV0x5B9GcVdVdzL6qC_kvMOOU74ahavJ2I.z0kuIPdWQ5GN6gOYyP1klVn2Joo27npxbTV
 GfY6BDxvcq8w0T2B5fIdWTOzcMa_KmnHGPwU8U1jPhlfrFhir8GuG0ZdVgmtMLW3Z89oJwT3jY2r
 RasDDb9y6YiteYft1rbYx8ThIuK_gl3751HAdS2KV0E4o_onvoXLyy_FjFcDDKa.6wqyHyLCuKdS
 88KDG8g.An77vuxnIRWxXgENCvukVZsdR9slawpT._gzyT6xSjH1WzLzabF21K2l2oW6oI1uwfn5
 QuyJnsybeJn54PWiOQA_uCL3n5Y7jWspKMYDFNm56JQ2TQZad07R7CF83cBVjfgVpL_l6Osxs73N
 V_.GwYscuPVcpwpyoFEDPS4L9FLbqkU21zXs5mwJ4PTcC4t4ODRc.znIxCRxYXqs9ncBHAZYw_QS
 ZlevdwL8hSQhbltlQXE61.y7QkqM6njGnqiyC9Lky0DSCO3_ObyWuqlZgB7SwUCc.XpJnCljh9pK
 6OY42saTQ7MduCKC8A0QuCpvyiqCZIPLIsUH9ggQOxgJjytucdeJqrw1Y90nI8ETgf0hsvzvs2Fk
 z
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.gq1.yahoo.com with HTTP; Sun, 29 Jul 2018 05:38:08 +0000
Received: from 116.226.251.211 (EHLO localhost.localdomain) ([116.226.251.211])
          by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 7ce059f3d9a879ff4cbac605423e52ff;
          Sun, 29 Jul 2018 05:38:07 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Chao Yu <chao@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Gao Xiang <hsiangkao@aol.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH 2/2] staging: erofs: fix conditional uninitialized `pcn' in z_erofs_map_blocks_iter
Date:   Sun, 29 Jul 2018 13:37:57 +0800
Message-Id: <20180729053757.34195-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180729053459.34140-1-hsiangkao@aol.com>
References: <20180729053459.34140-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds error handling code for
z_erofs_map_blocks_iter to fix the compiler blame.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---

let's solve the compiler warning first, more error handling code
for other functions will be added in the future patch.

 drivers/staging/erofs/unzip_vle.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 0e410a228cd4..bd2d7a8d5085 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -1532,13 +1532,14 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	unsigned long long ofs, end;
 	struct z_erofs_vle_decompressed_index *di;
 	erofs_blk_t e_blkaddr, pcn;
-	unsigned lcn, logical_cluster_ofs;
+	unsigned lcn, logical_cluster_ofs, cluster_type;
 	u32 ofs_rem;
 	struct page *mpage = *mpage_ret;
 	void *kaddr;
 	bool initial;
 	const unsigned int clusterbits = EROFS_SB(inode->i_sb)->clusterbits;
 	const unsigned int clustersize = 1 << clusterbits;
+	int err = 0;
 
 	/* if both m_(l,p)len are 0, regularize l_lblk, l_lofs, etc... */
 	initial = !map->m_llen;
@@ -1592,7 +1593,9 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 
 	end = (u64)(lcn + 1) * clustersize;
 
-	switch (vle_cluster_type(di)) {
+	cluster_type = vle_cluster_type(di);
+
+	switch (cluster_type) {
 	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
 		if (ofs_rem >= logical_cluster_ofs)
 			map->m_flags ^= EROFS_MAP_ZIPPED;
@@ -1608,13 +1611,24 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 			break;
 		}
 
-		BUG_ON(!lcn);	/* logical cluster number >= 1 */
+		/* logical cluster number should be >= 1 */
+		if (unlikely(!lcn)) {
+			errln("invalid logical cluster 0 at nid %llu",
+				EROFS_V(inode)->nid);
+			err = -EIO;
+			goto unmap_out;
+		}
 		end = (lcn-- * clustersize) | logical_cluster_ofs;
 	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
 		/* get the correspoinding first chunk */
 		ofs = vle_get_logical_extent_head(inode, mpage_ret,
 			&kaddr, lcn, &pcn, &map->m_flags);
 		mpage = *mpage_ret;
+	default:
+		errln("unknown cluster type %u at offset %llu of nid %llu",
+			cluster_type, ofs, EROFS_V(inode)->nid);
+		err = -EIO;
+		goto unmap_out;
 	}
 
 	map->m_la = ofs;
@@ -1630,6 +1644,9 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	debugln("%s, m_la %llu m_pa %llu m_llen %llu m_plen %llu m_flags 0%o",
 		__func__, map->m_la, map->m_pa,
 		map->m_llen, map->m_plen, map->m_flags);
-	return 0;
+
+	/* aggressively BUG_ON iff CONFIG_EROFS_FS_DEBUG is on */
+	DBG_BUGON(err < 0);
+	return err;
 }
 
-- 
2.17.1

