Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id g7ISOKNkHlt2BwAAmS7hNA
	; Mon, 11 Jun 2018 12:02:18 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4F62C607A4; Mon, 11 Jun 2018 12:02:18 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wv9Ryx0F"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9F3E4601C3;
	Mon, 11 Jun 2018 12:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9F3E4601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933336AbeFKL7L (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Mon, 11 Jun 2018 07:59:11 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40217 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933169AbeFKL7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 07:59:06 -0400
Received: by mail-wr0-f195.google.com with SMTP id l41-v6so20099266wre.7;
        Mon, 11 Jun 2018 04:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qErnL5qEjYyTMjOuhmCeo/OjDicbWGBMEoPtEs6s6m4=;
        b=Wv9Ryx0FudjKTzdkuapzrFjgylNlvA6HOxlhr4okkMONWGB4i+1Q7jnG4JNupkUmjL
         8xWIEDA07HlNgMgxUlpty04CtsS/tSoXG1p+2nblp3CbirJVEj9BJb84Edbrcy1XCpQi
         NmUgY2Gpkz8B8DXFQK82lAotK7NB3O6J3A6UVsp1YAGj96dGO/dmaRcFghS0kmR1ODWA
         nA//nWI40LDHuCV9GQpZudEFPg0c7MvHn4nBpVjbyYBXjY/3CLaxoPLVh/WnMmZmHQjt
         erGGifL5d/Hk9FCocOQWD2kub3Ebq+uR+qUTk6w97mlpOdQvrSOljdSvM02FxMdpg0Vg
         gxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qErnL5qEjYyTMjOuhmCeo/OjDicbWGBMEoPtEs6s6m4=;
        b=ErfoVSAa7KbntPTza7M6S+hkrVxfa/mxZ31nqx3Gv6mufYmiEnmb2IcJ7aqYcYGrh5
         WfaRvsDvDnQNJPgS7PQpQ+Qq9JEan5sQ9JzoMlob6OYrGeFsAt5h/1gKvep6qkMue+Do
         hMZyDppTXXVPz6P14cb72Kek4UrKWeqyT7chomCef+Vk/dhfERiPkWiZU2ArUCGAggAL
         8e+0ULKN11RfUTZZBrJMxeYiguLzPgYC2ze30UbQ6o0Tbgm05/jwClfAscGmb9qLk6l6
         W8zn7vmo+AM7/3bdetM7sIXYHQUZYpO/F8ytTfkRNwk1X8ZyPSNTqbnvxsrQ9FIZDnoz
         pUkw==
X-Gm-Message-State: APt69E1E+vy7mhdgCD3+8lZqemj5gNDK4yjBoCpHdXeTRS2aSW7M4k4p
        AxWuPBOQDG9GBNM0L6rq7DDQ72Tm
X-Google-Smtp-Source: ADUXVKKXe3gYI0HNergXaZUqGdgFVm2615lG7SeDva8/ALz4hb7CKOzeQ/gBcd8LvhNdfp2TMwNnnw==
X-Received: by 2002:adf:9441:: with SMTP id 59-v6mr12026501wrq.274.1528718344680;
        Mon, 11 Jun 2018 04:59:04 -0700 (PDT)
Received: from kurokawa.lan (ip-86-49-107-50.net.upcbroadband.cz. [86.49.107.50])
        by smtp.gmail.com with ESMTPSA id t124-v6sm7974796wmt.29.2018.06.11.04.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 04:59:04 -0700 (PDT)
From: Marek Vasut <marek.vasut@gmail.com>
X-Google-Original-From: Marek Vasut <marek.vasut+renesas@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Steve Twiss <stwiss.opensource@diasemi.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH v6 02/14] mfd: da9063: Replace mfd_add_devices with devm counterpart
Date: Mon, 11 Jun 2018 13:58:39 +0200
Message-Id: <20180611115851.1987-2-marek.vasut+renesas@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
References: <20180611115851.1987-1-marek.vasut+renesas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_mfd_add_devices() instead of plain mfd_add_devices(), which
removes the need for da9063_device_exit() altogether and also for the
.remove callback in da9063-i2c.c .

Signed-off-by: Marek Vasut <marek.vasut+renesas@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-renesas-soc@vger.kernel.org
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
V5: New patch
V6: No change
---
 drivers/mfd/da9063-core.c       | 11 +++--------
 drivers/mfd/da9063-i2c.c        | 10 ----------
 include/linux/mfd/da9063/core.h |  2 --
 3 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
index 2647bb371d86..76258e5709f8 100644
--- a/drivers/mfd/da9063-core.c
+++ b/drivers/mfd/da9063-core.c
@@ -226,20 +226,15 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
 
 	da9063->irq_base = regmap_irq_chip_get_base(da9063->regmap_irq);
 
-	ret = mfd_add_devices(da9063->dev, -1, da9063_devs,
-			      ARRAY_SIZE(da9063_devs), NULL, da9063->irq_base,
-			      NULL);
+	ret = devm_mfd_add_devices(da9063->dev, -1, da9063_devs,
+				   ARRAY_SIZE(da9063_devs), NULL,
+				   da9063->irq_base, NULL);
 	if (ret)
 		dev_err(da9063->dev, "Cannot add MFD cells\n");
 
 	return ret;
 }
 
-void da9063_device_exit(struct da9063 *da9063)
-{
-	mfd_remove_devices(da9063->dev);
-}
-
 MODULE_DESCRIPTION("PMIC driver for Dialog DA9063");
 MODULE_AUTHOR("Krystian Garbaciak");
 MODULE_AUTHOR("Michal Hajduk");
diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 981805a2c521..29456e807ed4 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -270,15 +270,6 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
 	return da9063_device_init(da9063, i2c->irq);
 }
 
-static int da9063_i2c_remove(struct i2c_client *i2c)
-{
-	struct da9063 *da9063 = i2c_get_clientdata(i2c);
-
-	da9063_device_exit(da9063);
-
-	return 0;
-}
-
 static const struct i2c_device_id da9063_i2c_id[] = {
 	{"da9063", PMIC_DA9063},
 	{},
@@ -291,7 +282,6 @@ static struct i2c_driver da9063_i2c_driver = {
 		.of_match_table = of_match_ptr(da9063_dt_ids),
 	},
 	.probe    = da9063_i2c_probe,
-	.remove   = da9063_i2c_remove,
 	.id_table = da9063_i2c_id,
 };
 
diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
index 9ab7049977aa..8e6684d884e0 100644
--- a/include/linux/mfd/da9063/core.h
+++ b/include/linux/mfd/da9063/core.h
@@ -94,6 +94,4 @@ struct da9063 {
 int da9063_device_init(struct da9063 *da9063, unsigned int irq);
 int da9063_irq_init(struct da9063 *da9063);
 
-void da9063_device_exit(struct da9063 *da9063);
-
 #endif /* __MFD_DA9063_CORE_H__ */
-- 
2.16.2
