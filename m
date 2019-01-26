Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A4FC282C3
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF587218F0
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 03:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="DY6bBKgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728888AbfAZDsr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 22:48:47 -0500
Received: from sonic301-20.consmr.mail.gq1.yahoo.com ([98.137.64.146]:34987
        "EHLO sonic301-20.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725924AbfAZDsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 22:48:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1548474525; bh=fEICpJjWWzhjrr72FQ/QjjsO8F3wa705ICZLCTpLh94=; h=From:To:Cc:Subject:Date:From:Subject; b=DY6bBKgLtW08lC0ArUwTrHhOBos3Qd+zinLTOQa/Yn23FRH+3fR6OcThuvPimShsmAB+4tDDDy+43Zz0COMEbE3QYzK2UOZDqOo51B6cJb2EAeRMTic4KoqPptjNfWc2daWlvm9icl2q56vbUd0uo0XY3O5BHHgOR41FpZAe9ce3rhweIsizU7RjFaidUREpoTZ+8Sz8EtONN7/0MyXu/fXRV/X66AKHhf7HeLuA4t+Vyq3J0JnQ0GBE66nyspY0rvMepKh1l3bv+dd2Jant/TEbtONETaZILURyzKoH1kDCAyrjEhuwz+THhcRC67/9o9xzKoiHfDq+2Z2qqDUtJA==
X-YMail-OSG: .89TsswVM1l1o_9GHO31df.mB8UYasW8mZDx3y4jIQfzLB4lIayqrhUH5SvUeOt
 ChIO6KL6s3pzuhsH5f0M4BJ8XGS06XNPQm.wg.T1jJESGoLARN.mKrBinmb.kszGsq6d9BbUQGoM
 FgBlXzbw8sl6LpqjNeNenBIObBPlRy48TshdTDEbY0UGlmm8Xaok2vW64xnTjfyywdzlxngXW0oT
 eCWelfsH6wLvrIChKXr1JlshpgKPNqOv3CtgP7Rb5eC2iDZubE5344Fy0fOqOBOb5WXZOIq2u1L5
 pWrfqDm2hZn79.sCX7TwcXG6A7KbLh_eAVorq4oW53HouBmYIBDFI_rJtge50MtIXqJVduor4Hbm
 icN_hAizjwXPWrAZ.nfJd4tXUCTFQCcq64iz2WyE5JqcMnkifk2I7U7gtDgoqHoeRnXbx_IF.s1p
 o5AURsM9SLdMGZ8oTq3P1amy.vbGe.wP13cvWs26CQ1s9HIVpsoQZfb4KpqNT80rh4_wu.KBNlmH
 qqfqc.clg7MatKsOWRLD3WhhsHX_xyPmd.G0f1tPrmPU7m69A3TNwlSduFyOdF_ZuzFV2Ixp.61q
 ccf7CzGl7Rv5XgTpKVa5FhRucdrNkqRwiG16xYgh4vyKBE7S74v0e1SHrQZqRzSVJ1BQsxFxhvGn
 BN5.bQIxnPfHYToHt6D_iSutmTrdKeTVOBF5ARzHx74dAxJ7COjydICyci9UDHKYrCy2ZGryrJyN
 Paz2bC_cdAFYT79Y2IGuOE0XeiGjrFGzEZilutnu2Wm0WkRyOXEJm57cBggQ2TzykB.ZFRFXESZp
 AkbHHb9NFK5Q.YF5CMky495Lg.7Tb1SzkIZVdOt3NIiDtWFwS4Yn6Pf66VTm67MI71u1ISYmAlRf
 I1uU1GQJOXKiiw7.I75._8LQJiXtXhzk8afzm_C4bEbW3osXKJIQm3CdEBfNy6QMaUGfIB.H.VL7
 gaRjvvhWrdcgctvw6t2ro_utG_vlLLh8TSu42k0NFEaO9ypUsOuoMVI9btOZYJZPUWx79ZmKiytf
 EFL5UMZpZqfSR5u10H0i338hBV0WyOrm6Zphuyft2wZcenV0lVd0WJLKUB2uMsg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.gq1.yahoo.com with HTTP; Sat, 26 Jan 2019 03:48:45 +0000
Received: from 125.120.85.115 (EHLO localhost.localdomain) ([125.120.85.115])
          by smtp409.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 5574a3d7169bdadf60e8591b428ea179;
          Sat, 26 Jan 2019 03:48:42 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-erofs@lists.ozlabs.org,
        LKML <linux-kernel@vger.kernel.org>, chao@kernel.org,
        weidu.du@huawei.com, Miao Xie <miaoxie@huawei.com>,
        Gao Xiang <gaoxiang25@huawei.com>
Subject: [PATCH v3 1/2] staging: erofs: use xattr_prefix to wrap up
Date:   Sat, 26 Jan 2019 11:48:28 +0800
Message-Id: <20190126034829.11586-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gao Xiang <gaoxiang25@huawei.com>

Let's use xattr_prefix instead of open code.
No logic changes.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/xattr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
index 1c9498e38f0e..7de46690d972 100644
--- a/drivers/staging/erofs/xattr.c
+++ b/drivers/staging/erofs/xattr.c
@@ -520,8 +520,7 @@ static int xattr_entrylist(struct xattr_iter *_it,
 	if (h == NULL || (h->list != NULL && !h->list(it->dentry)))
 		return 1;
 
-	/* Note that at least one of 'prefix' and 'name' should be non-NULL */
-	prefix = h->prefix != NULL ? h->prefix : h->name;
+	prefix = xattr_prefix(h);
 	prefix_len = strlen(prefix);
 
 	if (it->buffer == NULL) {
-- 
2.11.0

