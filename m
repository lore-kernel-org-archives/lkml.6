Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB4EDC6786F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 21:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97E7E2081F
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 21:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97E7E2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeKDGfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 01:35:03 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:52977 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeKDGfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 01:35:02 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mk178-1fqdUU31mS-00kNkD; Sat, 03 Nov 2018 22:21:42 +0100
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mk178-1fqdUU31mS-00kNkD; Sat, 03 Nov 2018 22:21:42 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: Intel: mrfld: fix uninitialized variable access
Date:   Sat,  3 Nov 2018 22:21:22 +0100
Message-Id: <20181103212140.890081-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:Pk5aNWkpTapeDiotbwA0EVAWE9C4BExUYHaanHRQV7J5dt0G5Aa
 Uw0JKQi3PTBOqT/Y1D11E215GmanctkBSd3RluS7TwXhk0TwPV1TUJt3a5H6F6SELnL83jo
 zmUNtVk/yrK8zy0aL1G7715b06b7aVJN5bS274UzUDR7NOQxuBxnqhepVbNWGMyBmf2OvYl
 jp2T52TyFaNy/xNqxyDzA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:d2nEmYLaZpQ=:Gj38oqf5TV7f/AI5yFS5gy
 DDfQp7BTi8eRzG4gVQPfbRoD7lte0MYOYsLVyFb5NtwNGHFLfUPhrSRUpoG5SxA52TMrksZ30
 f42F0wedgo+PApFzIrcqU5eWxj3QOkMLI2JihlTd+mxbbjiBAo4JIT7FN7ZUadrthQHX7ukND
 ZqNyCjxxfmGfeJfxTueVqU+X+RT0fRzjKjuec4UTeVadgj/lEBYnV/GcgzN4q2GigvABONu0E
 a6mfrRay1JKgxW4Wx2+FVOZbVQD7XLUzO0OJBSmvLhItz1ODKEpS44VBvWn7XWDfmIgX4N8c0
 dQxCmJCktZJ57z1y8o9/oDLABbqIfuC1w/vyfdy8CcUPbUnjUQIneiw2RbA3I+7B5horbFrLp
 jg88t7ZD8hdMyYPeOUwqf8TRKZcNmz6GCdFuk8Tfas5FqclEipGzEnZPF6jLVJHmjVlOLXunl
 XLFOv8drNFlah2t4JD5znRQcPl5WhqXeT+UGeD2JJgw8cqdbpezWOG2iUlCHu8KpLcbXpB3Pf
 3qURKDtR6Og0ZxHxL1uwlwXow3qOFF+gIvXzUAnDipvIkaau0krVM0PcqkEPxjBojttxn2YJO
 V/lYlpf6RXN3Qyb3SQaAMUp9AdbbWohExjGNIylJn/xKwIEw38bjQo1VtM28RGij4m80m/Q/V
 Z+zJAtnhsSeAUIn4GV/LJF48ezXxQe7iMuhBpDqI0bQcuLLriM15YErYUqS1EFnOg6R8ZY0CI
 3nEW2vzzvXFkjxWxAKglpzkR3P3EPC9kGTORMy+6EXtlynZgDTQZMT9HC5E35hp5bYwyiSXHm
 UCVgtPp
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randconfig testing revealed a very old bug, with gcc-8:

sound/soc/intel/atom/sst/sst_loader.c: In function 'sst_load_fw':
sound/soc/intel/atom/sst/sst_loader.c:357:5: error: 'fw' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  if (fw == NULL) {
     ^
sound/soc/intel/atom/sst/sst_loader.c:354:25: note: 'fw' was declared here
  const struct firmware *fw;

We must check the return code of request_firmware() before we look at the
pointer result that may be uninitialized when the function fails.

Fixes: 9012c9544eea ("ASoC: Intel: mrfld - Add DSP load and management")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/intel/atom/sst/sst_loader.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_loader.c b/sound/soc/intel/atom/sst/sst_loader.c
index 27413ebae956..b8c456753f01 100644
--- a/sound/soc/intel/atom/sst/sst_loader.c
+++ b/sound/soc/intel/atom/sst/sst_loader.c
@@ -354,14 +354,14 @@ static int sst_request_fw(struct intel_sst_drv *sst)
 	const struct firmware *fw;
 
 	retval = request_firmware(&fw, sst->firmware_name, sst->dev);
-	if (fw == NULL) {
-		dev_err(sst->dev, "fw is returning as null\n");
-		return -EINVAL;
-	}
 	if (retval) {
 		dev_err(sst->dev, "request fw failed %d\n", retval);
 		return retval;
 	}
+	if (fw == NULL) {
+		dev_err(sst->dev, "fw is returning as null\n");
+		return -EINVAL;
+	}
 	mutex_lock(&sst->sst_lock);
 	retval = sst_cache_and_parse_fw(sst, fw);
 	mutex_unlock(&sst->sst_lock);
-- 
2.18.0

