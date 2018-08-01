Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2463C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB61208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 10:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BB61208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387709AbeHAMdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 08:33:01 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:39182 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387581AbeHAMdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 08:33:01 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fkofP-0006WB-Cm; Wed, 01 Aug 2018 10:47:43 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Jaya Kumar <jayakumar.alsa@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Olivier Moysan <olivier.moysan@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] ALSA: asihpi: remove redundant variable max_streams
Date:   Wed,  1 Aug 2018 11:47:34 +0100
Message-Id: <20180801104742.4328-2-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180801104742.4328-1-colin.king@canonical.com>
References: <20180801104742.4328-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable max_streams is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'max_streams' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/asihpi/hpi6205.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/pci/asihpi/hpi6205.c b/sound/pci/asihpi/hpi6205.c
index 8d5abfa4e24b..2864698436a5 100644
--- a/sound/pci/asihpi/hpi6205.c
+++ b/sound/pci/asihpi/hpi6205.c
@@ -635,7 +635,6 @@ static u16 create_adapter_obj(struct hpi_adapter_obj *pao,
 	{
 		struct hpi_message hm;
 		struct hpi_response hr;
-		u32 max_streams;
 
 		HPI_DEBUG_LOG(VERBOSE, "init ADAPTER_GET_INFO\n");
 		memset(&hm, 0, sizeof(hm));
@@ -660,10 +659,6 @@ static u16 create_adapter_obj(struct hpi_adapter_obj *pao,
 		pao->type = hr.u.ax.info.adapter_type;
 		pao->index = hr.u.ax.info.adapter_index;
 
-		max_streams =
-			hr.u.ax.info.num_outstreams +
-			hr.u.ax.info.num_instreams;
-
 		HPI_DEBUG_LOG(VERBOSE,
 			"got adapter info type %x index %d serial %d\n",
 			hr.u.ax.info.adapter_type, hr.u.ax.info.adapter_index,
-- 
2.17.1

