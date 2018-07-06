Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B740C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B80223FFC
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 13:24:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B80223FFC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933267AbeGFNYr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 09:24:47 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:36921 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932851AbeGFNYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 09:24:43 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue002 [212.227.15.129]) with ESMTPA (Nemesis) id
 0M4voU-1gK3JU3ABa-00zCZT; Fri, 06 Jul 2018 15:24:10 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-scsi@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Omar Sandoval <osandov@fb.com>,
        Ming Lei <ming.lei@redhat.com>,
        Paolo Valente <paolo.valente@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sbitmap, scsi/target: add seq_file forward declaration
Date:   Fri,  6 Jul 2018 15:23:43 +0200
Message-Id: <20180706132407.4069001-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:lZRQ91uDatO7y/AU7/kLvX3NKTb3L3JSh7f6nWFoQHSdss4gJTo
 iQR/rMntK/StqcAjdBI94OQ1HCodfOc7nNacyjBDLetNNSYYonTlF7FGDoXXJga7bx524m+
 X3f01QAkPK+vUSNLv1W7Zt41IG+HggRGdMVxcLCNiRKWItwYJly4GB6e0Y3YZFOsivoI4fn
 mOv+DJfj/qK8Y6qhLhgFw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OMcUL2J1jw4=:TOHx8p5wZq8fAMC1JIx2Hv
 1vRAKmQLWM5yw7RDEeLXU0oVBs/vovIrMi3DsFrZKNCQANdFcJIMyd1Afrej3kKl2+/lfCtmz
 z8y9LGNHKSZ5EzUw7IOEEHJxbwK56YZeUSZ6MFWMQ8KeAiHqzVJDQwdd3EnTr/Qe1kP3Injhz
 MZ3+Jdwz35JiIxxfmUFvKRorLQKFTRybSgd4ThfttgArhct9MSEnjChhePw0igaXdRjofI9G0
 CGNAAmhsHUhgyrry3ZSTM4H23TpL1sODkd4a/nUxbkHNQqa2SzXl2+Lm0olBNeD0IXYIgLHqs
 90FT2JFGMsBFW5oB3O6Mi5jluqGV35B7Dg18uC2sW+Y5cCNjeXcXMQFcIPXer1PCNSbk21Ok1
 0pLNPokjYPl8GG71pjrTM7SdfvGGjkEy1sxJPoifWb0eGQTNURgz79XfxYd4droqzWHOUUNwS
 yTJG1NPVC0wrTIN8XqLHQBcuMzsYHXGjV1tvciZvxvP5BzfMvXqWeGP/daThDKtrBcBPPtFOZ
 rPy2C+CamjEZ069RLfCP8XcHIUGf/D1E3Mr9Ht+GG1MdK9vyceSuhgg91mJysiOGruGlVh+Pa
 4Dt0kHIE7EdZjaTm9jhsUWsIrhkAMiFwQGYBwh5nFFzLu2BBk3pxjIEEyVz1Zwltg40PWJeLL
 EGWg/9jggQCDkVcWxTa8UxV/v8z1AiJyrr1/geRgYMH291pCI/yHentWh8tHv5RHWSaw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The target core runs into a warning in the linux/sbitmap.h
file in some configurations:

In file included from include/target/target_core_base.h:7,
                 from drivers/target/target_core_fabric_lib.c:41:
include/linux/sbitmap.h:331:46: error: 'struct seq_file' declared inside parameter list will not be visible outside of this definition or declaration [-Werror]
 void sbitmap_show(struct sbitmap *sb, struct seq_file *m);
                                              ^~~~~~~~

In general, headers should not depend on others being included first,
so this fixes it with a forward declaration for that struct name, but
we probably want to merge the patch through the scsi tree to help
bisection.

Fixes: 10e9cbb6b531 ("scsi: target: Convert target drivers to use sbitmap")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/sbitmap.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index e6539536dea9..cc54b9f7ff8b 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -321,6 +321,8 @@ static inline int sbitmap_test_bit(struct sbitmap *sb, unsigned int bitnr)
 
 unsigned int sbitmap_weight(const struct sbitmap *sb);
 
+struct seq_file;
+
 /**
  * sbitmap_show() - Dump &struct sbitmap information to a &struct seq_file.
  * @sb: Bitmap to show.
-- 
2.9.0

