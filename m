Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A9BBC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B68EE21A34
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68EE21A34
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754240AbeFUSfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:35:05 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47731 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753987AbeFUSfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:35:04 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fW4Q6-0002Ke-6B; Thu, 21 Jun 2018 18:34:58 +0000
From:   Colin King <colin.king@canonical.com>
To:     Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/ca0132: make array ca0132_alt_chmaps static
Date:   Thu, 21 Jun 2018 19:34:57 +0100
Message-Id: <20180621183457.31008-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The array ca0132_alt_chmaps is local to the source and does not
need to be in global scope, so make it static.

Cleans up sparse warning:
warning: symbol 'ca0132_alt_chmaps' was not declared. Should it be
static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/pci/hda/patch_ca0132.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index d62c56feaf7d..4ff5320378e2 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -5665,7 +5665,7 @@ static const char * const ca0132_alt_slave_pfxs[] = {
  * I think this has to do with the pin for rear surround being 0x11,
  * and the center/lfe being 0x10. Usually the pin order is the opposite.
  */
-const struct snd_pcm_chmap_elem ca0132_alt_chmaps[] = {
+static const struct snd_pcm_chmap_elem ca0132_alt_chmaps[] = {
 	{ .channels = 2,
 	  .map = { SNDRV_CHMAP_FL, SNDRV_CHMAP_FR } },
 	{ .channels = 4,
-- 
2.17.0

