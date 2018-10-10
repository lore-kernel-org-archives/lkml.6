Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06A9C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6FCE214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 08:38:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6FCE214FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbeJJP7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 11:59:13 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:54545 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726636AbeJJP7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 11:59:13 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M5gAG-1g45CM05T0-007FAR; Wed, 10 Oct 2018 10:38:00 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M5gAG-1g45CM05T0-007FAR; Wed, 10 Oct 2018 10:38:00 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Liam Girdwood <lgirdwood@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: max98988: add I2C dependency
Date:   Wed, 10 Oct 2018 10:37:13 +0200
Message-Id: <20181010083758.2874864-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:Qfp5pR79lWCJfM7fzvmyq3zfD5sS62VxeRjIUGvcmhXMSJz3wMx
 OEyKQStrCCY6Wcc8Kdlliv4shBj00DvvvT+UZMCxlCck0yS1YDG8NeOsumTrmi9gwCn9cuQ
 1U6KISHonGpf8IFfxdFhQXi7FrTiTSubIFI6sBjdy63t9+9zBbp/H+WDEnQ/BXR998erYxN
 bSkUd1v8j3zxIljVfVNZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mDyJl6/+grM=:lb6ZdQPw7JjdTzftFf5dAS
 y/Ia+wXBcsfgcRUsZxZuvnKhc9osF1BNB4qEhUZ5UYovkiSUAydwxmyKCWiAA1mxLQn859PsP
 I0MvTQayK78uASBaHW52JtEIUVF6wXZGviECkGv1vN8hj7QlxGr3xgqCMOd8CmuIN4YmGGunc
 6K1nso9ELBtzfQyjm6iB48d25Vs5YGyYsSvh+sIIlFHtfh4ycnfsdv4Rl5f1cWU8RElhJreol
 VYDC4siKTOoJIHJncVYqzwsComQdnLn4FVhSEooZobmVa4fTqHcy1gvsoFJ6rwdtiKzUguNaq
 BReQEdeBMuSJv7IIeTnRrDSQ1r1qrW9t+nZQcH8Qp4Ht0unheXYdxVJF0dPHWyOJ34rXTj/YB
 CiBDl6idskWi2z+C6Z2P1vsxtUPheTQJNhbZRoQIN3xT9Yai6s3HCxYG4cWfMA3hT94ek2SiI
 k0Ins8l0fTKqDKKUowf54bpHJl1O+QaJ6yseWWyKgGwgflOuwmHVrNdkDSFuXHoRNhMsQ3276
 x+5m1rw5kIT3Xd3CZPhPyhPBNL1j+5p8cg+nXt9HpvFmAbRX+m7Zq3yqEsKQnzGISlFjxdtNv
 +88N99nTC4Kjqx1YamEtdWhjsSNKjMAi/4X6kZH8W1i9bHiAG04NQhvREvgrTm91+zn9x9k5B
 xi79zf7dgKf0BcGJ2T2ZVrMVclDDYF6LiDRFL6CKDMMk1wKvdm5mcZWyxqSXhKiuBtwE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max98988 only builds with I2C support enabled, otherwise we get a build error:

sound/soc/codecs/max98088.c:1789:1: error: data definition has no type or storage class [-Werror]
 module_i2c_driver(max98088_i2c_driver);
 ^~~~~~~~~~~~~~~~~
sound/soc/codecs/max98088.c:1789:1: error: type defaults to 'int' in declaration of 'module_i2c_driver' [-Werror=implicit-int]
sound/soc/codecs/max98088.c:1789:1: error: parameter names (without types) in function declaration [-Werror]
sound/soc/codecs/max98088.c:1780:26: error: 'max98088_i2c_driver' defined but not used [-Werror=unused-variable]

Fixes: 24ae67c58250 ("ASoC: max98988: make it selectable")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 3c6bd6019b92..774d38310875 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -641,6 +641,7 @@ config SND_SOC_LM49453
 
 config SND_SOC_MAX98088
 	tristate "Maxim MAX98088/9 Low-Power, Stereo Audio Codec"
+	depends on I2C
 
 config SND_SOC_MAX98090
        tristate
-- 
2.18.0

