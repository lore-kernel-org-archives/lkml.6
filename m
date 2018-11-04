Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953BCC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 12:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 383D72082D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 12:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uOplY7hr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 383D72082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729830AbeKDWK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 17:10:28 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35533 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729388AbeKDWK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 17:10:28 -0500
Received: by mail-pl1-f195.google.com with SMTP id n4-v6so3123047plp.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 04:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WXAewJDXDzYaN5Foswz70U2PjKMjY8rdpZEmG1i03ho=;
        b=uOplY7hrncZcHQ7zJyc46rz3mruQyjQZkSKBNrX/vFARmFsEUMRIEISceMLxUcs/OY
         IV9cgkzEfHdAzTxO3NuH9zvGIzQLJ7zEcHY6JY3ilzlBx1InTssMWz4X9tWK9Cpf1y/L
         wXFrSRgKwuVDbyrUc5hqFFURtXRoq+8bfIQwiw107+yU2hwqAqfJXcyxdcm65n6Pe/Fw
         PAA9xfGOL3/plGtG6Pg4h2gWI7lhk+kc83GsHgmXgMA8525rUF8HTf3mIiU/dGKSTfFI
         oQ22Ce8PLqspkHdkdutZMtVuBRixF24flgGIjdi6Y4PKFKDNZdKUEPiu6cfQgPHdHGCW
         T3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WXAewJDXDzYaN5Foswz70U2PjKMjY8rdpZEmG1i03ho=;
        b=TtFiZmuwtKoy8sx2zrheFoGlJiCt2h0PSmT44VZaO1aBEIgKgqdbn3de4E1Q7NvgFF
         JfpNJVTdqfhdQTQopsrWJUWCMwSjnxTTeNJ/HF6fbo+Nl3CPG2qXQcMeOmMxBshqfZ8h
         uYisFmNjfqr3/FYHSyNzl1IIGy8IQ8Uh+K148haJ8PjhisHuS4iWnByiLMg92ZuQr4mi
         v7cD4A7+RU+kuamfXfHWXaX3FupAl9cpdPZ0dMWuNe6wYzvUdLMOFQVQh+QmgWDkYnEJ
         In/qh8autlOUURRa/KviJqab+aaU9YtjN6htjok0wn28emrgijy5MOoz66kh+leGLd5s
         Z81w==
X-Gm-Message-State: AGRZ1gKYfwxF5gPsTSPEvfFSvE1CsYkXxKhmlHsk5QY5Rf3EgY9mjNRM
        DlqNxSnKDW3BXUVoOGdRSFo=
X-Google-Smtp-Source: AJdET5ffck4Wz9T2BHoHJA8Rg0klAJJPYzT9ikPyZ2NHricE2H5zERXQRgbVBMqBbtK1Xn6E+OhPjQ==
X-Received: by 2002:a17:902:8bc6:: with SMTP id r6-v6mr4264995plo.194.1541336134057;
        Sun, 04 Nov 2018 04:55:34 -0800 (PST)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id p62-v6sm58614084pfp.111.2018.11.04.04.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 04:55:33 -0800 (PST)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, KCHSU0@nuvoton.com, gustavo@embeddedor.com,
        abhijeet.kumar@intel.com, kuninori.morimoto.gx@renesas.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] SoC: nau8825: remove unnecessary unlikely()
Date:   Sun,  4 Nov 2018 07:55:29 -0500
Message-Id: <20181104125529.3681-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to use
unlikely.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 sound/soc/codecs/nau8825.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index b9fed99d8b5e..7bbcbf5f05c8 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -424,10 +424,8 @@ static u32 nau8825_xtalk_sidetone(u32 sig_org, u32 sig_cros)
 {
 	u32 gain, sidetone;
 
-	if (unlikely(sig_org == 0) || unlikely(sig_cros == 0)) {
-		WARN_ON(1);
+	if (WARN_ON(sig_org == 0 || sig_cros == 0))
 		return 0;
-	}
 
 	sig_org = nau8825_intlog10_dec3(sig_org);
 	sig_cros = nau8825_intlog10_dec3(sig_cros);
-- 
2.17.0

