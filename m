Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F27FECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:43:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E79C208E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 08:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E79C208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729607AbeGPJJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 05:09:39 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42965 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727712AbeGPJJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 05:09:39 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fez66-0001jg-Go; Mon, 16 Jul 2018 08:43:10 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: es1688: remove redundant pointer chip
Date:   Mon, 16 Jul 2018 09:43:08 +0100
Message-Id: <20180716084308.15571-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer chip is being assigned but is never used hence it is
redundant and can be removed.

Cleans up clang warning:
warning: variable 'chip' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/isa/es1688/es1688.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/isa/es1688/es1688.c b/sound/isa/es1688/es1688.c
index a826c138e7f5..3dfe7e592c25 100644
--- a/sound/isa/es1688/es1688.c
+++ b/sound/isa/es1688/es1688.c
@@ -260,7 +260,6 @@ static int snd_es968_pnp_detect(struct pnp_card_link *pcard,
 	struct snd_card *card;
 	static unsigned int dev;
 	int error;
-	struct snd_es1688 *chip;
 
 	if (snd_es968_pnp_is_probed)
 		return -EBUSY;
@@ -276,7 +275,6 @@ static int snd_es968_pnp_detect(struct pnp_card_link *pcard,
 			     sizeof(struct snd_es1688), &card);
 	if (error < 0)
 		return error;
-	chip = card->private_data;
 
 	error = snd_card_es968_pnp(card, dev, pcard, pid);
 	if (error < 0) {
-- 
2.17.1

