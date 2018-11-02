Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDDFC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:45:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CC102081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 12:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rEV8v/ey"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CC102081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbeKBVws (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 17:52:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33270 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeKBVws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 17:52:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id x6-v6so992981pln.0;
        Fri, 02 Nov 2018 05:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=e6jFR1ALXwYhaYHe/N6ISJN/k/hi7NKFhT6aKpD96MU=;
        b=rEV8v/eyzrzg3YsFnQyQkaXkV1iMXsSlpk53rwaelxbVvrsvoj+zqKvwMGPx7CV7dK
         4x6/pEC384nIi7RCqLy9IYFWktyYC+IK82/HN0h/7jvujJgsymuHZDv1cSUWZ+crdrdc
         /vjcRj1Re2p8xCmMEEtNfEGuQ6KOdNYuj4uZ+RUgGoFez9NbR/wzod7/Grvk4ihgETf3
         BCyE5wKG8qbLKsCgyzkIpbcnnVr0dSJi2kUx3XO74Lo0C1nrb59T7P2bwiQ6prUcu2yc
         mfO1fkqGRF711Ku33q1Cav8Tn0LKxN9ehfIfuqdYll/JrRECEoDfgyeRZoD2J45HtMTS
         wo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e6jFR1ALXwYhaYHe/N6ISJN/k/hi7NKFhT6aKpD96MU=;
        b=So7hVdhdqI/Z6VUiGFFYxFqBYTVQpsc48TiaY47NIfQLFobbAynlzjBGS1OyK0Y+Sv
         j6XddagyvKqrb9knUxAQJ5v8ajQ7LVSjex3DZJNzv5sHjj2LCEgSiYL8bG8+jlt4Wan9
         169XmU/h2x6LizWDpazck/P6xGQe0mXpIlf/Yb6EiQ7965X0zDQHooYbY/rgUgY01xBy
         pecjlsYnDfTMWu7xcw920dfeZtqbJ3FGoBIu7nyg0MiRaogXJWsP3mshsrcOkbHv5T0j
         30/JJJmJmW+j7z3MwxaXrFRKNwojDxtBwv95agbItZXYnFawiqXxwS1lD4H846980c9d
         lzdQ==
X-Gm-Message-State: AGRZ1gI/z5WT4YABaa2g6TglqXWpVLu1l0JON5aLgy6EaZ5grF1bbyWz
        EnHsVoHtdXBNM+64S/rR2VU=
X-Google-Smtp-Source: AJdET5eKL0sn7Yt3blKvX8SxHZA3O21ZRW92YOB6RJXkC5S5rpyFwxa0vN/Qc60OOWn8PkqUtDz7Nw==
X-Received: by 2002:a17:902:da8:: with SMTP id 37-v6mr11761891plv.12.1541162743967;
        Fri, 02 Nov 2018 05:45:43 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id l129-v6sm43830714pfc.155.2018.11.02.05.45.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 05:45:43 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     heiko@sntech.de
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH v2] i2c: rk3x: fix some typo
Date:   Fri,  2 Nov 2018 08:45:35 -0400
Message-Id: <20181102124535.24331-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix multiple instances of a misspelled "Calculates".

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
---
Changes in v2:
-add commit message
---
 drivers/i2c/busses/i2c-rk3x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-rk3x.c b/drivers/i2c/busses/i2c-rk3x.c
index b8a2728dd4b6..fe347e8e2a23 100644
--- a/drivers/i2c/busses/i2c-rk3x.c
+++ b/drivers/i2c/busses/i2c-rk3x.c
@@ -555,7 +555,7 @@ static const struct i2c_spec_values *rk3x_i2c_get_spec(unsigned int speed)
  *
  * @clk_rate: I2C input clock rate
  * @t: Known I2C timing information
- * @t_calc: Caculated rk3x private timings that would be written into regs
+ * @t_calc: Calculated rk3x private timings that would be written into regs
  *
  * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that case
  * a best-effort divider value is returned in divs. If the target rate is
@@ -716,7 +716,7 @@ static int rk3x_i2c_v0_calc_timings(unsigned long clk_rate,
  *
  * @clk_rate: I2C input clock rate
  * @t: Known I2C timing information
- * @t_calc: Caculated rk3x private timings that would be written into regs
+ * @t_calc: Calculated rk3x private timings that would be written into regs
  *
  * Returns: 0 on success, -EINVAL if the goal SCL rate is too slow. In that case
  * a best-effort divider value is returned in divs. If the target rate is
-- 
2.17.0

