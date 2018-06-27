Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28703C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C623025BC8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 18:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WonU5f2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C623025BC8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966061AbeF0Sy6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 14:54:58 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:36328 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965942AbeF0Sy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 14:54:57 -0400
Received: by mail-ot0-f196.google.com with SMTP id c15-v6so3348821otl.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 11:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=uc/UjFRrWmidtXfz5VqR8440a8qsAfKyn3lCsAeIauA=;
        b=WonU5f2DJuGD3eoI7LI8eJDNx3oHDysYjewiueTBtdCO/LlptNFKXZ5FquYI7PjnK+
         5GPK4dbCqUPJ2DtxewPp641+oQbHQmCr5wKWwPQ6SI0712/ZOdn8kC7VUyM39ybAUT3P
         gqG49Q5ahHHuxcjZrTsG7EV56OpZfaCdSRJV/6yjrYZoJ3pWaIoBn61lb/nE+/TBuzb4
         zMmHxcQTQcvNka/XrbmFdmSBAEJ0Ti7Y2BNSbHCDSFX//LhTPUGl4j2iwBg/oIpS4KER
         Vw2aT8bJLAIMBKsdDwFYPELAkIaR0OF4d6etRe0x0JO5s1Lpu6XruK9EirjEWi8G0KBY
         yNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uc/UjFRrWmidtXfz5VqR8440a8qsAfKyn3lCsAeIauA=;
        b=ZQECIryJUjGVK8Ejn/OyqrI4M1B/s8r6sHS232YrLhcF9UXWfa41RXa/GALgACyP8l
         a/BNQVeH6o38HbWxW/50AcCLjbElhUCl2gHm2CIHiwGieWC4FgBBDAANi6od0XsgHH1P
         D/pTLJRODzO6OndvIvqkS3kBFihxc6Xapwj5uF0sHBC2ZpcsGYzFHdbKRzeEJM/GJCGv
         To9kw4ogKULXbJ4jD3aBWAjxigekhhkvuIj74pbDE9i+DVgA3vgpKiVAhC1TFwCG8Y6U
         iZUwTSioyQN1KqQimO2RAWjtzXzt0hZEAMtZaISufMiTDkmDKC97pQz0g7zhOnd9LS5Q
         FzAg==
X-Gm-Message-State: APt69E0xU1H5TvoZtQjbn3eNZ34s2cQCYWE89gYeeDi54077T16TbcOO
        Qo5K0kBfBYNSJ0lssVQgsUw=
X-Google-Smtp-Source: AAOMgpf5ErCLS03oXJE48K25HRnsmhWpNT4bQLiU6Qj8pLgOI3kQw5oo+AnZ43N9qNhiPVVlXIc4Jw==
X-Received: by 2002:a9d:4c0f:: with SMTP id l15-v6mr4462108otf.26.1530125696546;
        Wed, 27 Jun 2018 11:54:56 -0700 (PDT)
Received: from guyc-Aspire-ZS600.asus ([173.216.132.44])
        by smtp.googlemail.com with ESMTPSA id t10-v6sm2470094ota.23.2018.06.27.11.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Jun 2018 11:54:56 -0700 (PDT)
From:   Guy Chronister <guylovesbritt@gmail.com>
To:     guychronister@outlook.com
Cc:     Guy Chronister <guylovesbritt@gmail.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Fixed typo on line 733.
Date:   Wed, 27 Jun 2018 13:54:34 -0500
Message-Id: <1530125674-11412-1-git-send-email-guylovesbritt@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Guy Chronister <guylovesbritt@gmail.com>
---
 sound/pci/oxygen/oxygen_mixer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/oxygen/oxygen_mixer.c b/sound/pci/oxygen/oxygen_mixer.c
index 81af21a..ba87213 100644
--- a/sound/pci/oxygen/oxygen_mixer.c
+++ b/sound/pci/oxygen/oxygen_mixer.c
@@ -730,7 +730,7 @@ static int ac97_fp_rec_volume_put(struct snd_kcontrol *ctl,
 	oldreg = oxygen_read_ac97(chip, 1, AC97_REC_GAIN);
 	newreg = oldreg & ~0x0707;
 	newreg = newreg | (value->value.integer.value[0] & 7);
-	newreg = newreg | ((value->value.integer.value[0] & 7) << 8);
+	newreg = newreg | ((value->value.integer.value[1] & 7) << 8);
 	change = newreg != oldreg;
 	if (change)
 		oxygen_write_ac97(chip, 1, AC97_REC_GAIN, newreg);
-- 
2.7.4

