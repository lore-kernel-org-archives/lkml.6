Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A707C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3045D21871
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 02:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfAECEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 21:04:38 -0500
Received: from mga02.intel.com ([134.134.136.20]:23587 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726776AbfAECEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 21:04:35 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Jan 2019 18:04:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,441,1539673200"; 
   d="scan'208";a="307634853"
Received: from kgandham-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.251.139.169])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2019 18:04:33 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, liam.r.girdwood@linux.intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Oder Chiou <oder_chiou@realtek.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 21/21] ASoC: rl6437a: use __be32 for a __be32 buf
Date:   Fri,  4 Jan 2019 20:02:49 -0600
Message-Id: <20190105020249.8639-22-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
References: <20190105020249.8639-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bard liao <yung-chuan.liao@linux.intel.com>

The buf in rl6347a_hw_read is __be32.

Cc: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Bard liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rl6347a.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rl6347a.c b/sound/soc/codecs/rl6347a.c
index 8f571cf8edd4..c0d729b45277 100644
--- a/sound/soc/codecs/rl6347a.c
+++ b/sound/soc/codecs/rl6347a.c
@@ -64,8 +64,8 @@ int rl6347a_hw_read(void *context, unsigned int reg, unsigned int *value)
 	struct i2c_client *client = context;
 	struct i2c_msg xfer[2];
 	int ret;
-	__be32 be_reg;
-	unsigned int index, vid, buf = 0x0;
+	__be32 be_reg, buf = 0x0;
+	unsigned int index, vid;
 
 	/* handle index registers */
 	if (reg <= 0xff) {
-- 
2.17.1

