Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12043C67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17042087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 18:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="EEn66hIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C17042087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeJMBeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 21:34:05 -0400
Received: from sonic316-8.consmr.mail.gq1.yahoo.com ([98.137.69.32]:35533 "EHLO
        sonic316-8.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbeJMBeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 21:34:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1539367224; bh=ZOcg8hBbbIYxmvjOTZg/CZt6vhIGoyhwB4ZhaV2X2J4=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject; b=EEn66hIVdM/aziq9TCNO6H4O9ZpjgdfBat0APiAGdysVXo/R9mCTT8z1WR9GqfDf+U09/BKsD309V3s1bcJz8wF3/BKMaR80O0c1u+LTYTvRDcRUsdUej6dOp2Xeoq9Bfgs/nbLxo19bOtJaYYFlAeBo97bJx69iNt4/5U1RLjzHl+d1Qn2GKEOKzluOwPN4xkHSljwj7dt9GpGWDmh7ECN7q/KyCcMcuZT/4xeYfUFhh8tXCpH80KlXMeOoaWOUBh7iwYtjXPNE4seXzrGOKHFZSpa+PazyG70VQqj2hVWvIXX7TAc1snqBjV2oEdJG4tzR4eB+TWrRUxiwG8hctg==
X-YMail-OSG: t.lGShQVM1mSu0vl8XqWUxJrTjhth9LLyds6h4DgvwsHkPMoX638TL_mZ8K8uiv
 CqeUEwly17J_Y34MtbMLHlIkGa1f9_SgXNOpv2cHd0aBslf7UH_mZDib0mSzN1otKDZhaSz9ul6P
 kvMcVECB7wPWQKgcWj8zH18HJc4nmElmddgtxN5sRDEV64wQV8uGDrDGx4Y5tpu4Rnveqm.KwGF8
 jtcbCyj_oZgJYSFSha3O05iiPqOwJ.XSXcu_kGVE0lg1JMy9HYJhUEUbCYCPd3CaIdz8YDKZD_.V
 dV4M4xdplf9vvwkJStSyBRixhPKHSAVWfO.v5DwMwo.L1aKbAFlIfDtD._xLDP51h5xKNTHGsoCT
 in4elWrket8bY0lx6f_k6e71NF1TUT.gYls3fU.9SfNi_6kzt1ZXZek7bCUl_z48L3cw4TIMs0dB
 YpxOPp8TECMbhCHxgsTvy3i9eSTi8e4nwu0CuxDxHu.B0.Q_uLkb4l6qO1nrXAeV2_lhzseXiLli
 GbJo.5WtwnhWBcTvS8Gy8Ccvj.Gja2ikYR6tp_5id7hlYPv_JB0vsn2QMkXLMle8Gw4Q.EpYtubM
 Kg5.GZEbGrplLkLGduCEOl0Qw5sZnQ33u3453wU48ZVgUWiE18MAriU21LhyDKcvgkQ_hRag5uw3
 adw.Fixf0q3c3Btc0SWVG.S4Xc65Y1JUm0jd15d0W3cura52MUmWH0tZg1NT_1qj3laNbR5RkWqu
 Et8sxRTvBuUyZy6JmHYs5tc.QujZAlKHqEArREY0hq5NkHFhuxbHMXhvKWbtkJsyff78rNmJoJ.a
 Sb8tP9Xisx6fSt5JoAtcU4ClzBS0kdChdsV5SfC_INO.G2ywKJdHYfpi3L92_l0z1fuEjjAk.R36
 Hl1kcCntJ_NZigVkoQYG94SHgE8xZU1r1KRZQiCKg8qwQ9iZ_tAFbwM6pYCXiCo6NDJ3q0jjUKGE
 T1dzZAs0LqU07.MgtCA9FuCqUgFJX07rU5pDD8wqXOIcj7wd_U5Y1NpJRYUuRuwRUxNmxER1q5f3
 3NuGaaXioX8wO3g03AExJxhx__XeIaHeWrdU_FLs_xEO7KWzI0wHzEM6QoTUcFDkCwzKhotA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.gq1.yahoo.com with HTTP; Fri, 12 Oct 2018 18:00:24 +0000
Received: from 183.156.49.100 (EHLO localhost.localdomain) ([183.156.49.100])
          by smtp406.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID ed195a26657336ad6610d1a74a356e02;
          Fri, 12 Oct 2018 18:00:22 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>, Miao Xie <miaoxie@huawei.com>,
        Al Viro <viro@ZenIV.linux.org.uk>
Subject: [PATCH RESEND] staging: erofs: clean erofs_lookup()
Date:   Sat, 13 Oct 2018 01:59:49 +0800
Message-Id: <1539367189-20186-1-git-send-email-hsiangkao@aol.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <a267e4b0-887e-6de9-38db-7ca9a5518b72@aol.com>
References: <a267e4b0-887e-6de9-38db-7ca9a5518b72@aol.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@ZenIV.linux.org.uk>

	d_splice_alias() does the right thing when given
ERR_PTR(-E...) for inode.  No need for gotos, multiple
returns, etc. in there.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Reviewed-by: Gao Xiang <gaoxiang25@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
Hi,

Frankly, I think it is a straight-forward cleanup by Al enough
to be submitted to Linux 4.20 in constant to other pending fixes
found in the process of EROFS productization these days, which
I need more time to think over and fix formally to the community.

p.s. I have no idea whether this patch has been already queued up
in Al's fs tree for 4.20... :'( +Cc Greg / the staging mailing
list as well. Or please ignore this email...

Thanks,
Gao Xiang

 drivers/staging/erofs/namei.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/erofs/namei.c b/drivers/staging/erofs/namei.c
index 0039b76..5596c52 100644
--- a/drivers/staging/erofs/namei.c
+++ b/drivers/staging/erofs/namei.c
@@ -223,18 +223,13 @@ static struct dentry *erofs_lookup(struct inode *dir,
 	if (err == -ENOENT) {
 		/* negative dentry */
 		inode = NULL;
-		goto negative_out;
-	} else if (unlikely(err))
-		return ERR_PTR(err);
-
-	debugln("%s, %s (nid %llu) found, d_type %u", __func__,
-		dentry->d_name.name, nid, d_type);
-
-	inode = erofs_iget(dir->i_sb, nid, d_type == EROFS_FT_DIR);
-	if (IS_ERR(inode))
-		return ERR_CAST(inode);
-
-negative_out:
+	} else if (unlikely(err)) {
+		inode = ERR_PTR(err);
+	} else {
+		debugln("%s, %s (nid %llu) found, d_type %u", __func__,
+			dentry->d_name.name, nid, d_type);
+		inode = erofs_iget(dir->i_sb, nid, d_type == EROFS_FT_DIR);
+	}
 	return d_splice_alias(inode, dentry);
 }
 
-- 
2.7.4

