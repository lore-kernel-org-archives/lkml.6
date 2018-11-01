Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770E2C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23F4A20823
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 00:57:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgfDop+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23F4A20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbeKAJ6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 05:58:25 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53864 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbeKAJ6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 05:58:24 -0400
Received: by mail-wm1-f67.google.com with SMTP id v24-v6so10517wmh.3;
        Wed, 31 Oct 2018 17:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NHkWX3Ynrpx1x/BstLxZy3SYlKkmIbrrl/8dz4sPuZA=;
        b=fgfDop+2yk/8Bj0YDueQ3DZWPtbaLbn8LiaerUY1UwESuviuMDlnQ88pAdLYgk16yo
         EGco/rlC+WrL7ueZNzGfbQMZVH3zXNrRldQue18qAujqj5a8wba9fclfFc/4AixVYMu2
         VeHwQ9FyyaaWSEf3zRTCqJBH+UmQ7eahCqt2OLxVM5NjPEeHdMK0lQMIrzduuMXjbOBC
         EAOpzvOpE6kCO/RJesxrXgLFBR2vWrf0NJdWHyEwOX1BzL44NP+wlZe50oVAOhlt2wwR
         n2DOGcF2qHbzOFkYz1H8Jm1aZZptxm2mJ4aFGJwq8H8TZiFEaAZs8BfryZ23oylq7/aL
         Od1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NHkWX3Ynrpx1x/BstLxZy3SYlKkmIbrrl/8dz4sPuZA=;
        b=jhqbRWoNlXMP3/E8Z4NR5mFQDAkXxpwA+OwTbfGK9x/vmonY/qt/GybEcWQrOMbc41
         inCvc7OqvneWV0PadphR65Tl3rVESClUgM+3cRzYDMRPq6MBck8Bj1DWPLfH5sz0nrf0
         LkeHoKG+I96HeTi5FODpDkMpu8VdnwULjZD2lnG1Gc2vt6pyalJkXNJvQC+QhIy4kH8n
         YzIhFogOF2mDQdrmyiBlFcy91bX9yMYp2Viq4ITYMHmFJUy5MQxbJskMKlpgCFQMyg+d
         u1IpzgxcNUoMUsPqEBwfxfIO4Bh4zafb6z+Os3fG6YoAaPiamGJumgr8LeJ7Px5DeT14
         2tQA==
X-Gm-Message-State: AGRZ1gJVMZMOkQLfqZ7ONVvSwmKup2/4pUJmwzc5jy6ATohqPblXGIq/
        6bjFiiuqjCP2FEIK5p3Ot18=
X-Google-Smtp-Source: AJdET5eA3s3upi/lC1xWGAHj7ge9pYPUvPTOyF7Ugi8fG/y82KOzWFO/rYoFsAkktOrySgUXcf/Wgw==
X-Received: by 2002:a1c:4a:: with SMTP id 71-v6mr3853782wma.96.1541033863867;
        Wed, 31 Oct 2018 17:57:43 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id b71-v6sm23764588wma.13.2018.10.31.17.57.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 17:57:43 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Michal Simek <michal.simek@xilinx.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] pinctrl: zynq: Use define directive for PIN_CONFIG_IO_STANDARD
Date:   Wed, 31 Oct 2018 17:57:24 -0700
Message-Id: <20181101005724.9622-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when one enumerated type is implicitly converted to another:

drivers/pinctrl/pinctrl-zynq.c:985:18: warning: implicit conversion from
enumeration type 'enum zynq_pin_config_param' to different enumeration
type 'enum pin_config_param' [-Wenum-conversion]
        {"io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
        ~               ^~~~~~~~~~~~~~~~~~~~~
drivers/pinctrl/pinctrl-zynq.c:990:16: warning: implicit conversion from
enumeration type 'enum zynq_pin_config_param' to different enumeration
type 'enum pin_config_param' [-Wenum-conversion]
        = { PCONFDUMP(PIN_CONFIG_IOSTANDARD, "IO-standard", NULL, true),
            ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
macro 'PCONFDUMP'
        .param = a, .display = b, .format = c, .has_arg = d     \
                 ^
2 warnings generated.

It is expected that pinctrl drivers can extend pin_config_param because
of the gap between PIN_CONFIG_END and PIN_CONFIG_MAX so this conversion
isn't an issue. Most drivers that take advantage of this define the
PIN_CONFIG variables as constants, rather than enumerated values. Do the
same thing here so that Clang no longer warns.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/pinctrl/pinctrl-zynq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
index a0daf27042bd..57046c221756 100644
--- a/drivers/pinctrl/pinctrl-zynq.c
+++ b/drivers/pinctrl/pinctrl-zynq.c
@@ -972,14 +972,11 @@ enum zynq_io_standards {
 };
 
 /**
- * enum zynq_pin_config_param - possible pin configuration parameters
  * @PIN_CONFIG_IOSTANDARD: if the pin can select an IO standard, the argument to
  *	this parameter (on a custom format) tells the driver which alternative
  *	IO standard to use.
  */
-enum zynq_pin_config_param {
-	PIN_CONFIG_IOSTANDARD = PIN_CONFIG_END + 1,
-};
+#define PIN_CONFIG_IOSTANDARD		(PIN_CONFIG_END + 1)
 
 static const struct pinconf_generic_params zynq_dt_params[] = {
 	{"io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
-- 
2.19.1

