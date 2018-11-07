Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BBBC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801C420862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AgWmWWJv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801C420862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730324AbeKGS04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 13:26:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34294 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbeKGS04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 13:26:56 -0500
Received: by mail-wr1-f65.google.com with SMTP id j26-v6so16508261wre.1;
        Wed, 07 Nov 2018 00:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ETL7Is+WZyqQ8ia+CkDrCnNCwY/JOaHMUTqHjGSCshY=;
        b=AgWmWWJvI9YsOOWIoioj3sjyqyWh6N7/25gBFO3/N4xCnxZ4k94B8qUCYe0rzPVBsu
         frROf9H5xTvxlRqahxbeXh0V+WNye266sTLkymlH767Hg1HgLiJ3a65/dLv/bZWHOoRp
         O1bX7W5RbYaSx3nD+sjb7aAhEukJu8WpHeLfge/1pz57qs5m7tPhY11F8JsJSsLVckFP
         441ttWdWIzUzxJWDHdREnnjiHYz7/Ei3HGsI9KKVHmL3FOfMHASAA1apYNhikmhv/zOZ
         ziwmsb3WGboWKVXMYRM0HjkY2qmIrlxzh3mi9o3JhktRyNeuVQTy0rCnywlEGL02Pe4I
         H7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ETL7Is+WZyqQ8ia+CkDrCnNCwY/JOaHMUTqHjGSCshY=;
        b=jHvfNxm6cGI2MymFp81TpTEYYenbTuOBQSSke9qCUK0IbsyaaEI9I5ku+KdMrWF0xA
         ZWKj6aHg+4QVjZss505aZWVy41jhCUXhZXYxZf7TRLwXzFfoh0jQKp0elnI8uy1ODLKO
         asKS+xDlv6yjFa58AR5z5v1HoaXkfy+qOFVEZ8uZ1JmuZX8yFKQnr+AP5GMJs9mPHgzl
         IWpzsm15ZCmfwUmIKEJ9zIJtROeV96DrDGJmW94gIBcP0lmNztp/nFKSGYKlhPd2jWFs
         nayjh8/o/I0IGcQwq1ntN3+pDR9rj/Dsagez1lcDJNTNOkPdJX3BaEI8tbj4wuUMZONe
         hCdA==
X-Gm-Message-State: AGRZ1gKq17pnP1ZJrQYoCzT0g5WJtYtmEU9sqsJ4U7wFy81lBsm1XAsx
        bevNri8rjNaBeQ0EX0Xsdhw=
X-Google-Smtp-Source: AJdET5cRv4Xw2d6lJjBIZSQ9GISpn3nVgwckqYAwNvh4tl3uTByoshAtbOkXexMc5tXdagTEnXYB9g==
X-Received: by 2002:a5d:62c1:: with SMTP id o1-v6mr969466wrv.83.1541581049999;
        Wed, 07 Nov 2018 00:57:29 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id j203-v6sm256150wmd.46.2018.11.07.00.57.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Nov 2018 00:57:29 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>
Cc:     linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] pinctrl: zynq: Use define directive for PIN_CONFIG_IO_STANDARD
Date:   Wed,  7 Nov 2018 01:56:40 -0700
Message-Id: <20181107085639.32366-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181101005724.9622-1-natechancellor@gmail.com>
References: <20181101005724.9622-1-natechancellor@gmail.com>
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

v1 -> v2:

* Avoid kernel-doc warning

 drivers/pinctrl/pinctrl-zynq.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-zynq.c b/drivers/pinctrl/pinctrl-zynq.c
index a0daf27042bd..90fd37e8207b 100644
--- a/drivers/pinctrl/pinctrl-zynq.c
+++ b/drivers/pinctrl/pinctrl-zynq.c
@@ -971,15 +971,12 @@ enum zynq_io_standards {
 	zynq_iostd_max
 };
 
-/**
- * enum zynq_pin_config_param - possible pin configuration parameters
- * @PIN_CONFIG_IOSTANDARD: if the pin can select an IO standard, the argument to
+/*
+ * PIN_CONFIG_IOSTANDARD: if the pin can select an IO standard, the argument to
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

