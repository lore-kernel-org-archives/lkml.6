Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442A9C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FA82083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 10:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrQQ9clo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97FA82083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbeJRSeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 14:34:08 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:40527 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbeJRSeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 14:34:08 -0400
Received: by mail-ed1-f66.google.com with SMTP id r1-v6so27768463edd.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 03:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BlTG9fnnN08mCoKNQQn2SP/pFYcmG0sfdVH/GyUESlA=;
        b=XrQQ9cloXxIT5DrEuAmdI7l82FwbJUYRSmzQS9UiyOuegs/6y01nGoESIj2EwYplxN
         l18KUKLLbeMUIBhZpRSjqKufpsawH6Fq0jh/fkkMD5lcVqQBHPFH/DrkDDD4vzsyNOuI
         XMzAAWmNrVVL4A7UJX9qAtam03DIRsdvWm24HlliPbm2OvAi66b7h6w1BQeZNvuaOhUL
         oqh9RpsJynk9IfTAPYx25tcqGwT4nkFDOEJwEUr7eBXNL++7FNJyb7zhqpYIB3V6118y
         RqYpfgbwvtE5ORYUqrPAKEWvw1kq0YW3CI4j72VMbvz74vPuHZpIIVrq/Y24DAMt9qho
         ZyZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BlTG9fnnN08mCoKNQQn2SP/pFYcmG0sfdVH/GyUESlA=;
        b=eVRuYUfiBfmsC7fAOaSBvko2m1fQZR2UZelvszyP37vCTStU8YfPeG367HtpjhOC4Z
         VRTpCp7O8/bKnT2XvzroUYcxUb7pwrqrdT2fIpJlwLyOziNSudIRnUMx66JhJZGmPLfK
         hJtBypWuXg/TM7bZv2KAPJjJzLUQr7HgcV2o1i7g4S/GBJE75a5Gz1tcBPEcNi2vYMRC
         gkRk9zyWNEid3O4hKdAbF0MqQiVB3HtAwk+LfDbY7Fu6Ohe0lWJ8Jeof4H6X7kflyQus
         xq0WTdWc61SyOL4eBj9IaFyoZQZvawQXd49Xc+7ATLrBA2oZBAY8/u9+cutChUEcWWQy
         rEEQ==
X-Gm-Message-State: ABuFfoiUK8L/uPjf0+yekNwPcSVSrP+AOY3Aress5U1QXsK++agtGc95
        BK6+etQxpIIThFfnYpau2Nk=
X-Google-Smtp-Source: ACcGV60IRx6SHparKkbu2T1kxd1vzTb/LpK8aTWcwcGYWtIfbAeYxvC93cyK2KZVFbXGT66raaA/mQ==
X-Received: by 2002:a17:906:e1ce:: with SMTP id gp14-v6mr29209652ejb.221.1539858825344;
        Thu, 18 Oct 2018 03:33:45 -0700 (PDT)
Received: from Aperture.fritz.box (200116b826399a0005ef770f53f3b653.dip.versatel-1u1.de. [2001:16b8:2639:9a00:5ef:770f:53f3:b653])
        by smtp.googlemail.com with ESMTPSA id x57-v6sm7287168eda.65.2018.10.18.03.33.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Oct 2018 03:33:44 -0700 (PDT)
From:   Philipp Klocke <philipp97kl@gmail.com>
Cc:     lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        Philipp Klocke <philipp97kl@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] [sound/i2c/cs8427] Fix int to char conversion
Date:   Thu, 18 Oct 2018 12:33:02 +0200
Message-Id: <20181018103303.30226-1-philipp97kl@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling with clang yields the following warning:

sound/i2c/cs8427.c:140:31: warning: implicit conversion from 'int'
to 'char' changes value from 160 to -96 [-Wconstant-conversion]
    data[0] = CS8427_REG_AUTOINC | CS8427_REG_CORU_DATABUF;
            ~ ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~

Because CS8427_REG_AUTOINC is defined as 128, it is too big for a
char field.
So change data from char to unsigned char, that it can hold the value.

This patch does not change the generated code.

Signed-off-by: Philipp Klocke <philipp97kl@gmail.com>
---
 sound/i2c/cs8427.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/i2c/cs8427.c b/sound/i2c/cs8427.c
index 2647309bc675..8afa2f888466 100644
--- a/sound/i2c/cs8427.c
+++ b/sound/i2c/cs8427.c
@@ -118,7 +118,7 @@ static int snd_cs8427_send_corudata(struct snd_i2c_device *device,
 	struct cs8427 *chip = device->private_data;
 	char *hw_data = udata ?
 		chip->playback.hw_udata : chip->playback.hw_status;
-	char data[32];
+	unsigned char data[32];
 	int err, idx;
 
 	if (!memcmp(hw_data, ndata, count))
-- 
2.19.1

