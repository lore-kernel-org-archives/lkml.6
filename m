Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD0FC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C090B2152F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 13:49:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKkKq2a+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C090B2152F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732673AbeITTd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 15:33:27 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41502 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbeITTd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 15:33:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id b12-v6so4385265plr.8;
        Thu, 20 Sep 2018 06:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hJtfzaWqDOMR9SRloAeCTQt+u6I1kYTCBu0ED+HiQyk=;
        b=mKkKq2a+9XhlRYcFeSFg7QoGO4JH60IJYzSzj61dbTRdP8vIieYTOQgkCeAyOc5go0
         OeQTLoPLkpltl8Wnz2yUoRSXkfFe1HYOuul69Zb+r7idWmUzj0/4fdgJRaAD0dswFpK+
         tOk1ddpTtoP3LWTFlPklFTzc6coYdCPlXq+vMgq+NWZGC+GZgVZaO8VGhmmMT+mJyx76
         VoM6n9ELjeveYzUKubebz72TjHU9LjkBnMbEMAn+jqygMgfbjW220qND22BNrCd3BVKf
         Y6vjyq7sSk5BKFgqOYMxICwIltSFZclP309XVeHYDeMeQyxW08PV9AMMBLVi8VBj1ml2
         stig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hJtfzaWqDOMR9SRloAeCTQt+u6I1kYTCBu0ED+HiQyk=;
        b=ZVaC2P2U8ncc/ERi7xxSWOFbOrYTlepaCuWpnRmylBvUmuQQRaiemGG0beKW+ZlhZt
         cRlorZ6LiDraSU7OY6QEqcF27KGSFaZY49aI+R9HEwO5ibJUcA77W/sdJigUUtX1DPYU
         ioG8rLos0qNsZmURyPZUG/cLvnwi2i28OKc37yAG9gytkhPhPrzAS6OKcLhuywoWjDID
         KmheezUVhmLJpH75eQOi44sxs+zY9ZwQHrry3ukwNr7+YUGF3YEDh/pjOoMUWmUMEeYO
         Q516xr6myFZK0CD+LrIAxxrePKKwWK1equDnFVcIltWiNOVIwqJUrXlDuSjFf3HzKtGZ
         r1kw==
X-Gm-Message-State: APzg51A5myTsTJR9bjEpkj4W+TqQrUoyAoqQiODBXz5Z/rl9pCmuL465
        XK+4/finL93TrHHHsQW36zc=
X-Google-Smtp-Source: ANB0VdYs6IEnweaYMIucpVb6k1WA/eIF9mtTVJMtBQZqxhJJMdUAAaQZ86uCgZNYC55aKB5GitZvwA==
X-Received: by 2002:a17:902:2804:: with SMTP id e4-v6mr39094401plb.327.1537451392696;
        Thu, 20 Sep 2018 06:49:52 -0700 (PDT)
Received: from localhost (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id p19-v6sm46402722pgh.60.2018.09.20.06.49.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 06:49:52 -0700 (PDT)
From:   Song Qiang <songqiang1304521@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, shubhrajyoti@ti.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH] iio: magnetometer: hmc5843: Fixed a comment error.
Date:   Thu, 20 Sep 2018 21:49:46 +0800
Message-Id: <20180920134946.9072-1-songqiang1304521@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'hcm5843' with 'hmc5843'.

Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
---
 drivers/iio/magnetometer/hmc5843.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/magnetometer/hmc5843.h b/drivers/iio/magnetometer/hmc5843.h
index 76a5d7484d8d..a75224cf99df 100644
--- a/drivers/iio/magnetometer/hmc5843.h
+++ b/drivers/iio/magnetometer/hmc5843.h
@@ -31,7 +31,7 @@ enum hmc5843_ids {
 };
 
 /**
- * struct hcm5843_data	- device specific data
+ * struct hmc5843_data	- device specific data
  * @dev:		actual device
  * @lock:		update and read regmap data
  * @regmap:		hardware access register maps
-- 
2.17.1

