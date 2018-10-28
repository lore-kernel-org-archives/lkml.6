Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C586ECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 06:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F1320870
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 06:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aol.com header.i=@aol.com header.b="EQqjk13c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F1320870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=aol.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbeJ1O5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 10:57:38 -0400
Received: from sonic309-26.consmr.mail.ir2.yahoo.com ([77.238.179.84]:33190
        "EHLO sonic309-26.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725837AbeJ1O5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 10:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1540707238; bh=VhxQaZVeo56RaiB8wyhLO+qK877wT7vkbBj9B1knW1o=; h=From:To:Cc:Subject:Date:From:Subject; b=EQqjk13cvjvftxTWPOA76Vgk35NxkjU5vhq4Y/neGnm5IrSRv6sgaWlJP57XOuOi4/B4qmaRnmS5N+VBfAPmee1xjkAlklR79s70K7OFMnCQ6sje/22wTa/Lk5R3eOLzqkGRBIZzRl+W6izlHBSw9UXwWM3nwLdKORAoB/ZmqvMAh9PNaFXLCwUgm0JnkXcwemUEhhXnSkksZFgLKxjLELnqqWE2hRuH0CWp7ThjUpd0j/0Z+fF3HuiFbBdmOYZoVrUz00rNHwStqq9w2Cl7YQehKu9Y9E027UGcVk19DC9gqSlPa2j/9t7rkEJf+JTJyr1KRAhIncv6j6erymDbpA==
X-YMail-OSG: 1sf1u20VM1kzHYmcXk_ampsE0BbxDPD.j15Ay7eNV2uJzVImzuVZu.wgxf2SrAl
 rrEYTPbznokyVP3LWIj2VxvHPWkEc8tcRQsOhU6NLoBaLRM6OI.5Nt52b8aTA0rkmK8SLGqAe9Sp
 M2NykEp5PAiNa.bE_CA.JYlDwP1PJzDfnQ_BfmJAukXrb9rxVPwGyO7pDSfLZQLywKWA52IQEkFW
 OI4.4R3PycmRCtqA8oZKy6UvC6Ff1FgEiJqlkbJEsHaLISFRvcTqvOXMZvTUY_cFpD_CScd.572J
 oSXwdpkAffJpBAM4mXR_DuTHzIRMtSy8nEEvw0fzv3U7wfa.bMsdFWjBo36N5D6SDcPiyMefK8Ig
 xyNk4XWYGrcRAQW5qIQkdUJCv.JHE_nCa8h304dYcB5WuEAMjVGUJLvpd4XWUhAcK_rGEif60adM
 xmEz42evtYIAOMxX9ZOTJEEWcMsUOXkNcD9pixGqR4P9Z9MtsfxFKfWMszOfRwR0SGLfU7j.xdGi
 d4LSGJ2F1YE3KJmaZFuc53gKLGbp.1CW59f9rS.yjTdEsnReB.cCRTjtaF_HojAddO.mB70ZGos1
 UTtbBNOPOLDSJmIO0EpmXQToxAZEzEG3TdVlUD0xzngfI1d0VJxCTsv5HzJb3I88Vex0kHDbUUYq
 MCwSomaUZSriVcYbgsQ9fzpdaX6GWXtBw_Pn5Dx7V7Q1z8lLVKgv9kPpr8BHZwjtyYG55r7JSW.P
 ZaHMwC6CvS8IvUkR5tr8yc.b9xQsUibbcHpR75XkxepBBQy9wYzlgrN_TfA9N1kgEDjtXy9K4pGx
 n9CWnAUF7r4OCPLgJxBqlhEhGMA9r3_Whaw_FMWV_7Aqm_0jnlomfyVFpTisQC4hMxX9jfKuOZMk
 b7L5CrPnALPUN2aFXRFbppjbM_smie8hYJxl9ZaqTmLOWUdxfz2Anw52bXCJ6tvR3ySBiIvzQz5Z
 289GUggBq2M_pG9ycnuasnMQfMEtQ1uRM6IcmSj2JmTgr3j7vAYEgK.7mY.385cZQEpP8wtM_mOv
 LCq1rd0ZoBLtrzXu_egzU_ImmSaBRiUVTYytWwRPOYOgw3QPnf.c6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ir2.yahoo.com with HTTP; Sun, 28 Oct 2018 06:13:58 +0000
Received: from 115.192.33.5 (EHLO localhost.localdomain) ([115.192.33.5])
          by smtp401.mail.ir2.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID b5523328932f1292aff25b91619b79bc;
          Sun, 28 Oct 2018 06:13:56 +0000 (UTC)
From:   Gao Xiang <hsiangkao@aol.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Fengguang Wu <fengguang.wu@intel.com>,
        Gao Xiang <hsiangkao@aol.com>
Subject: [PATCH] mm: simplify get_next_ra_size
Date:   Sun, 28 Oct 2018 14:13:26 +0800
Message-Id: <1540707206-19649-1-git-send-email-hsiangkao@aol.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's a trivial simplification for get_next_ra_size and
clear enough for humans to understand.

It also fixes potential overflow if ra->size(< ra_pages) is too large.

Cc: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 mm/readahead.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 4e63014..205ac34 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -272,17 +272,15 @@ static unsigned long get_init_ra_size(unsigned long size, unsigned long max)
  *  return it as the new window size.
  */
 static unsigned long get_next_ra_size(struct file_ra_state *ra,
-						unsigned long max)
+				      unsigned long max)
 {
 	unsigned long cur = ra->size;
-	unsigned long newsize;
 
 	if (cur < max / 16)
-		newsize = 4 * cur;
-	else
-		newsize = 2 * cur;
-
-	return min(newsize, max);
+		return 4 * cur;
+	if (cur <= max / 2)
+		return 2 * cur;
+	return max;
 }
 
 /*
-- 
2.7.4

