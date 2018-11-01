Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A2CC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 239882064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pf63Bku6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239882064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbeKBAlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:41:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37662 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbeKBAlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:41:24 -0400
Received: by mail-pl1-f193.google.com with SMTP id bh10-v6so9128940plb.4;
        Thu, 01 Nov 2018 08:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zVP2pN0ye/FxR9GIxgZO//LqUu+GXTqXFpr2GoxixpM=;
        b=Pf63Bku6BEgT6IsjTFjT2FZRDkX1+l0HO0XIpHLOENLnkLn8Z7w0BECLuoBzwgKgTo
         jc6niN9VIg+r0lzAKs0vCVOGlBAajBppIwn1oJiPthDRgaayLlX++Ao7UdTaRFXPbgd6
         mraMveZnFIeYBufX12qjnXUXK19HsML7zzwW87Kk+F8KsTKHDAz2t2xBciB5k987BXtG
         EmDJh7Yr3B1BDBLVFgt3tPPdBX/kgBWtpSjm31vDXNEhDj1B4mhFQ72NQcTN+sixB7T1
         VdKbZbPqZvQJCvHwtYLGGtH10/4YzaIchH0P+DVrDnuppBMgbicYJ4S/+xmwUugMJWOU
         Lw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zVP2pN0ye/FxR9GIxgZO//LqUu+GXTqXFpr2GoxixpM=;
        b=jIQuhNe9YqnePC8fdQWVP5DlTc20tteE+uGSPuOuWLO9MPMiXZZbm+8vZ5OxDc6FMF
         0POtjGTnxizmxj+Tjes7sw/efnBYD7ZNLAjXb3FGb0f0RQUyuyI6+DCpjzq9GJHmj0OS
         Hqjt2OmgmiCE+aThG08Suz72As4hq5LJ1MKga/twM40poNiEktLEkgWO2W/cA+FqJAoW
         RK82ee5b9yaS1LPAHD+ztewN7IKcAcibW41bJNQd5rhE4TxuUpVbO8xAQXA57Ow0K3Ux
         s87LyCi5G8gH3Uw+2oTeZ16jo1tmYV34wqnRNVOo+pwl8VPXeUe1D5d07t+ZHvEqmxe4
         B4ZQ==
X-Gm-Message-State: AGRZ1gJLHqMbQOymOjG7WAnKzCTEYFQI84418SLfaC31FEGGHk/cSEqg
        3x5O2dvjIvHgGVkdww1MgOdcrdD+KiE=
X-Google-Smtp-Source: AJdET5dGFEmEEvUpN0BODRoF7heC4ENmoyUHi2V1+piuxcKCdpsql+5+CR5ODjaT8HyvlNR/WRB1JA==
X-Received: by 2002:a17:902:503:: with SMTP id 3-v6mr7785019plf.252.1541086676079;
        Thu, 01 Nov 2018 08:37:56 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id v12-v6sm2421001pfa.167.2018.11.01.08.37.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 08:37:55 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     heiko@sntech.de
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] i2c: rk3x: fix some typo
Date:   Thu,  1 Nov 2018 11:37:49 -0400
Message-Id: <20181101153749.22935-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
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

