Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E30C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77F6C20879
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hhnqp/NH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77F6C20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbeI3AHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 20:07:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37696 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbeI3AHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 20:07:34 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so9504610wrr.4;
        Sat, 29 Sep 2018 10:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=S4GYO6qQM6hycV2212WiqOdnP9/swVQYL2c+zcxseIk=;
        b=Hhnqp/NHKg6iGncE0nPSQVShhFTQnIH5v6a72rm03/r+AyXA+iGNC4trvPMTGhsd++
         ABZlPOtDgAmdDwiTb3Eitzi/u/yY05n1Mq8y4awmyTYkGwj1SV/Ord2YcAl64FAV1GJd
         JzFITj9jXGBWEAEGXb8BDVY7HymX2V6My5IJt4nN6wHnX0bR5IAJOO1IL8GfNopK9V5u
         bV/YtlbK8I+gU69a5KDWfM6dOh6mvOHvvFUTj7G0Ht/1XeKM9eya/UJ3J1lgzlLrpdwH
         z7wL+JbvGNtZFqCIade6FT/85v12C9xBDRcyOx26PeVzRQB9agSQvJjJubU2hUrJR+sw
         0tpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=S4GYO6qQM6hycV2212WiqOdnP9/swVQYL2c+zcxseIk=;
        b=GqIvogV2YcQaOqA7XlHb+GxPZb/J6DUySj22Xes3ltYl/2PXFNpY5Fd0e191YBjJ6o
         fYXCuZRNCihm4BsvTTVdOpPLDwOuvgt3g9kKxXSB5PQmKj0YBo4Ts57jt6ZqInkwaRvO
         KV92R1ju+W2fwTgpV/477fyPzPqD7HnBk9F6kjcnw9aFDUu1odzo/sVY2yTQa2j0XjUx
         Rl2NiIATeOtvmgcaI7rkVc2o3fJTvGb3C27hiMylJhNLgH4HcZtg1gpsfyaNq2kXEoul
         kldVl906WIW6sOgf50lnhrlHbolFBdpYLmqJSG1QB0iqiwH6DMEeZuwwNLDhZr4db2ow
         Sosw==
X-Gm-Message-State: ABuFfoi6GX+uN7nW4Ot+EnfyxqwsfsNbeqLbcqHeMmnkeRPKxrk6j3Fj
        pilcNL0YwvQlrK32GciQxEgkZrnWH5E=
X-Google-Smtp-Source: ACcGV63epCX511jS0LpL01+7mfhihe9Yt27leIaTJY1d+E/41qBEqoZ7kYgzJtQqh3E7zAIZrxnRww==
X-Received: by 2002:adf:94c2:: with SMTP id 60-v6mr2356598wrr.247.1538242696370;
        Sat, 29 Sep 2018 10:38:16 -0700 (PDT)
Received: from localhost.net ([2a01:388:3ce:110::1:5])
        by smtp.gmail.com with ESMTPSA id v21-v6sm13934598wrd.4.2018.09.29.10.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 29 Sep 2018 10:38:15 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Aymen Qader <qader.aymen@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] staging: sm750fb: Remove extra space character
Date:   Sat, 29 Sep 2018 18:38:07 +0100
Message-Id: <20180929173807.14261-1-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an extra space in ddk750_mode.c to fix indentation

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 drivers/staging/sm750fb/ddk750_mode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
index 7e22d093b091..4dac691ad1b1 100644
--- a/drivers/staging/sm750fb/ddk750_mode.c
+++ b/drivers/staging/sm750fb/ddk750_mode.c
@@ -131,7 +131,7 @@ static int programModeRegisters(struct mode_parameter *pModeParam,
 				  DISPLAY_CTRL_HSYNC_PHASE |
 				  DISPLAY_CTRL_TIMING | DISPLAY_CTRL_PLANE);
 
-			 poke32(CRT_DISPLAY_CTRL, tmp | reg);
+			poke32(CRT_DISPLAY_CTRL, tmp | reg);
 		}
 
 	} else if (pll->clockType == PRIMARY_PLL) {
-- 
2.17.1

