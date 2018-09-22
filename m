Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C2CC433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 14:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3751A2146E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 14:44:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3751A2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbeIVUhf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 16:37:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:33787 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728585AbeIVUhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 16:37:34 -0400
Received: from localhost.localdomain ([116.30.192.174]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MdFwl-1gKz1s17LP-00IVAM; Sat, 22 Sep 2018 16:43:24 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     jaegeuk@kernel.org, yuchao0@huawei.com
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chengguang Xu <cgxu519@gmx.com>
Subject: [f2fs-dev][PATCH] f2fs: fix remount problem of option io_bits
Date:   Sat, 22 Sep 2018 22:43:09 +0800
Message-Id: <20180922144309.1969-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:shNNiifGoSwLU16i1AXr36pmCb75vvILmbg9jFwK+/dsU4y45VW
 COLaXkS6uEwsPB1nZ7etMnrcFC3iIkqbiMFHQDjbm4OF70+azrLTsGuzFj/DKUrHIyLDLbq
 0bzqO+YxjRLTZuszkOlKNuKyStBQoAWmhR59Aa80eF6CNhsfsUgBZFnC1mkxtBSqFFWdqos
 lAl8tFCoAd7zGWBYKNb2A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:g1ets4O9do8=:qKtf8mAOjFp2Ge2SuuH/al
 56wm4zgO0AtLYpHNy8I4WZ8oSnfd7/p9VclNcdozQUKoRLTX9Fiuq/sQWWr9C4PzLzhlbUD5y
 ycx5k/Q52uP3Y4pOENtN9tPWE73LfnOAfpcqDRjYwlDCHtuqOLLeMqbaMb7U/xalI7utM4ZjT
 DN8yq9JXXPymxGxNOJrjyTFj3fbw2BSvCUpaRD7CpN6qRNUsKAzvljMGktjJJwtudYbDlZkFF
 aO/AHc4sSKLMmDuWVsEjJZSBe7tFhKlH3eu/KTqQ5vy36ErYP0wuvtE2902ZW+yAqgKJjasJA
 VipRHsqVWjSNHu5CKgMkdw20gwA3CroK+vsSiisvWic784P9nOsmjVJ3OhSmxEv92YxsNgrpL
 xk1EMVnGs9Gb0ooQoJRqp3GJF/R+n6JcG3hdeB4FpCJLeunDjfzV85Avc6diZeZ31WMo6rYsS
 5RoJl6cyXDNSulAqhNy9129QeT42F9hK3XTXiDhmRIlmhmpQr16CiWBRGkkxTm9HA0LKsyzjo
 Phf5AG5c+t2OlrxqdlBAS6Gx5MmTcOUgJFxt5EGhyiZOzT70AbUAaKdaqby9xrqCamXeOADAy
 w4umJF36iSSIeecsexuRzEZXYRLSTSPf4snBl8GngFxuLheved/9DrTSZPwDdxzxvC/+m3S+d
 /BsdFhrigkJppiLv0bG7hO3MHtLCkSUVJXPDl92Wx54j3pzxrbvet/mwna+ykupJK4wjh78gs
 Pals4P9hH90csSAhNsMQoYAcbhsOuYKFxmyl024eIxqa6TpYr5p/D1dFNbA/4Qh69v8R6wkAh
 fpSl7P1Rv7SeZTt+b3G4p/BEMJawg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we show mount option "io_bits=%u" as "io_size=%uKB",
it will cause option parsing problem(unrecognized mount option)
in remount.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 fs/f2fs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 896b885f504e..8c96c4e9ee8d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1336,7 +1336,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 				from_kgid_munged(&init_user_ns,
 					F2FS_OPTION(sbi).s_resgid));
 	if (F2FS_IO_SIZE_BITS(sbi))
-		seq_printf(seq, ",io_size=%uKB", F2FS_IO_SIZE_KB(sbi));
+		seq_printf(seq, ",io_bits=%u",
+				F2FS_OPTION(sbi).write_io_size_bits);
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	if (test_opt(sbi, FAULT_INJECTION)) {
 		seq_printf(seq, ",fault_injection=%u",
-- 
2.17.1

