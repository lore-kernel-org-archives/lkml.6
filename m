Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99BAC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2552082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 15:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pgBFw7/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2552082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbeJ3ADD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 20:03:03 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41905 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727674AbeJ3AC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 20:02:57 -0400
Received: by mail-wr1-f68.google.com with SMTP id x12-v6so9095391wrw.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 08:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4iCWujpwciyPGn/eyek7MRdxupz7S9P7JrT19wMcw9Y=;
        b=pgBFw7/KkVdREpcWrMHeYc6+YXXzwN+8mYGhNqfkbpPU9ZakIjpVeBcIvbedCtD4M0
         Lzg1jukcW81QbLb47RHp6xA/ItvcPKyDkpl45nswuqru3348F4GWvQkhiafHESKBLoUJ
         f5s47y3/VnQl9RCf+Vb+55i70SESdP/fZqwM7u9ylm1tiGN0b+1QKsElH01VpVogVnHO
         zEB5b1QTzDWrPdK6zcCrR6C3IFobqAfV35bdt7rmuqorIDwQ88QuZTdoCC0rxLCPeYBj
         QSULIyNbUQ7rFq4malSZ78I2M3RXE3esrF0M1XMelcwht4XXDT8iZfthf8prXQ57QNv7
         RJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4iCWujpwciyPGn/eyek7MRdxupz7S9P7JrT19wMcw9Y=;
        b=QtUzB7Qi3BAtlPjKvg6JSWIwSTCDd1Rpho7/zNWr22ujHiTeW/Uqbc00vcGgnJBe44
         Hw2CBbFnDvS8sYGR/5FMEJ6UOoyRLjYKeYrvRpiV53fYPTr4gHRo9O6HOqoOl9F6Yz3s
         POZerSaCo38CikvnJ2cKC0V/OY2D1H/pbVRGCDvBPJYwzyLPVGYg8/nTYN8qwBwaMw+W
         65OBNtLCAnjd9yL0sBVBTq3b+QzMgtXJH8VtHhsaXReC/m+vNIeyz+L/xAxChAVVTA84
         4cmNaeaoRXDRtTGCwEIs61IN6VcEpdL9MRLuQ7C4fYfehMbjKxEKTagrEwoQbEG07ngs
         DUmA==
X-Gm-Message-State: AGRZ1gKI4QKS3yIhQ5oKUaX1QoXtdkc63Tb5tyCtqJOheX2CvPAJCWKR
        A0ca5X08I6AkWRWi/gJxsI+VjQ==
X-Google-Smtp-Source: AJdET5cMDfspKkgE/rZOcyFre3G2rKV3Z5u93C5yA/yPl6i0LE0/2ebLygB6T4AZ/5//DoI35CjuVg==
X-Received: by 2002:adf:b211:: with SMTP id u17-v6mr14063772wra.52.1540826032557;
        Mon, 29 Oct 2018 08:13:52 -0700 (PDT)
Received: from boomer.baylibre.local ([90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i7-v6sm23045236wmd.41.2018.10.29.08.13.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Oct 2018 08:13:51 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] pinctrl: meson: fix meson8b ao pull register bits
Date:   Mon, 29 Oct 2018 16:13:40 +0100
Message-Id: <20181029151340.9087-5-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181029151340.9087-1-jbrunet@baylibre.com>
References: <20181029151340.9087-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AO pull register definition is inverted between pull (up/down) and
pull enable. Fixing this allows to properly apply bias setting
through pinconf

Fixes: 0fefcb6876d0 ("pinctrl: Add support for Meson8b")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pinctrl/meson/pinctrl-meson8b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
index bb2a30964fc6..647ad15d5c3c 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8b.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
@@ -906,7 +906,7 @@ static struct meson_bank meson8b_cbus_banks[] = {
 
 static struct meson_bank meson8b_aobus_banks[] = {
 	/*   name    first     lastc        irq    pullen  pull    dir     out     in  */
-	BANK("AO",   GPIOAO_0, GPIO_TEST_N, 0, 13, 0,  0,  0, 16,  0,  0,  0, 16,  1,  0),
+	BANK("AO",   GPIOAO_0, GPIO_TEST_N, 0, 13, 0,  16, 0, 0,  0,  0,  0, 16,  1,  0),
 };
 
 static struct meson_pinctrl_data meson8b_cbus_pinctrl_data = {
-- 
2.17.2

