Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A658C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3B4B20848
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 16:17:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MOoUaMmW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B4B20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeJZAuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 20:50:50 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:46496 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbeJZAut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 20:50:49 -0400
Received: by mail-yw1-f67.google.com with SMTP id j202-v6so3823316ywa.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 09:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3j45hIzyzqgD/dqPnE7SYNhLfQMVaUcuA9INIDfZccY=;
        b=MOoUaMmWYnQjBNDjq/gaE/uqKy5HLYOg6rCUhNRylYw/mJdlqnZ1Qt9ft+2EGfzBeH
         B0kZItOLkDoilkN3yKtRzMru8uJwnHZ4C3DSuGGktf31j2Yoso3Gh3vFyGIsq8nESvDp
         Csb9j6b6clxzAoV9tdSHxEwER6I66ih0nlQZssXzsqRBPacE7TeDBLeI1xAFT/lq03Nu
         UP2q2TO6JYO2pOcthxCUu3O43wuxLOSX9G+YFKC3nWChk7I3xcEFwTljquQmPQVbWkJh
         8BujoaUDRgKDm0JkyrCaEnAy/59hp8jxVlp7+NFFrkcGXtrQ35McO9WH/269y1HaywQu
         Vldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3j45hIzyzqgD/dqPnE7SYNhLfQMVaUcuA9INIDfZccY=;
        b=O+1gzDutsNth3bldyI2gIvzQ4ImkhVElB+oHk8V7ZJQ7Gg8hB618Pqdl5cpWapjOYM
         ndaOTWMxQkFy1yAPLnpb19C46t9XcBUt1NwYrVUX+h978iRSaQeyCkFtv3RkxVu5PvGv
         mt0JdVX3ykUlJoCUv88Wri9nWo2gfH8fQAHIMQ9LxaGTSP7jITKJup4P4+ydL7ARWb0z
         tHiHF2z7aZHK3m09pia33qLSBwdLqQmdBWJ65jILwb2RDNZwVhmlr29ar4nU9OVCQjii
         sQIVSLLrW624oRV5lH+3k6ks28+krmRBD4s4fZq0+p1ZbNIEyCbHxvLzqqjr/SLPmh7D
         /HwQ==
X-Gm-Message-State: AGRZ1gIFOb8jiO9JFKQnkcHmdzZRGeVF2FHjB0vIGMttwenGB+fidboj
        ZUAzv2aCH0T/dZJxsseAqUw=
X-Google-Smtp-Source: AJdET5ekPr3O6OEGnH9YM0u44xDx55ISes4VL3X5zmCu1B+EuYjwsE8YaKQx00rexV29/0M4WuWciw==
X-Received: by 2002:a0d:e3c6:: with SMTP id m189-v6mr2110264ywe.317.1540484241100;
        Thu, 25 Oct 2018 09:17:21 -0700 (PDT)
Received: from localhost.localdomain ([198.52.185.227])
        by smtp.gmail.com with ESMTPSA id n62-v6sm1937069ywf.105.2018.10.25.09.17.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 09:17:20 -0700 (PDT)
From:   thesven73@gmail.com
X-Google-Original-From: TheSven73@googlemail.com
To:     svendev@arcx.com, p.zabel@pengutronix.de, denis@eukrea.com,
        rmk+kernel@arm.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [RFC v1 1/1] imx-drm: match ipu_di_signal_cfg's clk_pol with its observed behaviour.
Date:   Thu, 25 Oct 2018 12:17:11 -0400
Message-Id: <20181025161711.13727-2-TheSven73@googlemail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025161711.13727-1-TheSven73@googlemail.com>
References: <20181025161711.13727-1-TheSven73@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <svendev@arcx.com>

We used an oscilloscope to observe the actual polarity of the
DI's pixel clock, and saw the following:

DI_GENERAL bit 17 is SET:
	pixel data is stable on the pixel clock's FALLING edge
DI_GENERAL bit 17 is CLEAR:
	pixel data is stable on the pixel clock's RISING  edge

However, the current driver configures the exact opposite of the
behaviour documented in video/imx-ipu-v3.h:
  unsigned clk_pol:1;     /* true = rising edge */

Fixes: 85de9d17c485c4196f74 ("imx-drm: match ipu_di_signal_cfg's clk_pol with its description.")
Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>
---
 drivers/gpu/ipu-v3/ipu-di.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/ipu-v3/ipu-di.c b/drivers/gpu/ipu-v3/ipu-di.c
index d2f1bd9d3deb..f296fa461875 100644
--- a/drivers/gpu/ipu-v3/ipu-di.c
+++ b/drivers/gpu/ipu-v3/ipu-di.c
@@ -619,7 +619,7 @@ int ipu_di_init_sync_panel(struct ipu_di *di, struct ipu_di_signal_cfg *sig)
 	if (sig->mode.flags & DISPLAY_FLAGS_VSYNC_HIGH)
 		di_gen |= ipu_di_gen_polarity(sig->vsync_pin);
 
-	if (sig->clk_pol)
+	if (!sig->clk_pol)
 		di_gen |= DI_GEN_POLARITY_DISP_CLK;
 
 	ipu_di_write(di, di_gen, DI_GENERAL);
-- 
2.17.1

