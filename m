Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7059C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72BF52075C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="P40er/r6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730502AbfBLPOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:14:34 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39371 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730324AbfBLPOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:14:30 -0500
Received: by mail-wr1-f68.google.com with SMTP id t27so3075551wra.6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 07:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MVuAZg4+nnaFhkjixBpLWEg1hgwoQXD2AQa4Piwf/Kk=;
        b=P40er/r6P/7FvxPmzAj4Jeqy8C+ftJ64TIv40uLZkY7eLCYXjxZA+ihx+B20EsjfOe
         d8Hcj4JN0Y1mgW13FXKJdnNsPdIvnn4Xmy4ZC/0fjyc25lButzdg+S3xXRFD3ltPbJiu
         99Xf6iHMirR01tgRgRITZr/oZQuiHNipmXMt6WSf8sRCHCc+UTR4Oa6rfVvZUsEbvLwZ
         4w/3opyC0gV6FjVWVbOoPDe86j+cAY6HyoQnzOjnN0XLmO6uib9zk0HFnnM71OjbK1IZ
         kvPFijmREiVFgfQHmg+wM+P0P4acTS0OfZVyPL+tSQWpxS8SO1WlW+jkzyDF1c638jZv
         3gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MVuAZg4+nnaFhkjixBpLWEg1hgwoQXD2AQa4Piwf/Kk=;
        b=IaiWGSjGKrsaMMfHfRaqOh002+tzKd7l90igUVaeKyHTvTf1mNoUdJQrbP8Lv6YCUR
         LsvesSiX9RvuilwrfQVEmD2z0na/Ji9kAGSu85XUf2I7td2Dde9oJn6YaZHviCyGwX7u
         aNYA/cD2yBqAKhx+b4YO8EGQ8Cq6zPOI41dGMUr3s8fy39BDV4WUggMk5lPzwYY3sfN5
         K1ZavmtebHzRTRXrSSuuLNT21rJp4TXJxHuCEdNZvIoWt739S5iCxkTzGHF0PoRC5TWw
         ordK22fnizUsuaBo/q7PRTl71MaSzc/GK1XQPIMHB/+MHZuYNbVdBbH0Q0RpxHp6Fi4E
         q2BA==
X-Gm-Message-State: AHQUAuakHJzLJD7bLJyqyeHeGHcO572LFC1bDK9pwRBnl8EsBBohskRn
        uZ45NPE/RbNnbssS9Ty5B6UxYg==
X-Google-Smtp-Source: AHgI3Ib8qsN5pafZuMij0Y61VcZJP+TdDFNb8ylW8TSsoKfu3Xta3Ek2WjN0TpRQVeMJggKMsWws5A==
X-Received: by 2002:adf:df08:: with SMTP id y8mr3104780wrl.23.1549984468407;
        Tue, 12 Feb 2019 07:14:28 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c1sm1589515wmb.14.2019.02.12.07.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Feb 2019 07:14:27 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
        kishon@ti.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] usb: dwc2: Add Amlogic G12A DWC2 Params
Date:   Tue, 12 Feb 2019 16:14:12 +0100
Message-Id: <20190212151413.24632-8-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212151413.24632-1-narmstrong@baylibre.com>
References: <20190212151413.24632-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchs sets the params for the DWC2 Controller found in the
Amlogic G12A SoC family.

It mainly sets the settings reported incorrect by the driver,
leaving the remaining detected automatically by the driver and
provided by the DT node.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/usb/dwc2/params.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 24ff5f21cb25..442113246cba 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -121,6 +121,16 @@ static void dwc2_set_amlogic_params(struct dwc2_hsotg *hsotg)
 	p->power_down = DWC2_POWER_DOWN_PARAM_NONE;
 }
 
+static void dwc2_set_amlogic_g12a_params(struct dwc2_hsotg *hsotg)
+{
+	struct dwc2_core_params *p = &hsotg->params;
+
+	p->lpm = false;
+	p->lpm_clock_gating = false;
+	p->besl = false;
+	p->hird_threshold_en = false;
+}
+
 static void dwc2_set_amcc_params(struct dwc2_hsotg *hsotg)
 {
 	struct dwc2_core_params *p = &hsotg->params;
@@ -167,6 +177,8 @@ const struct of_device_id dwc2_of_match_table[] = {
 	  .data = dwc2_set_amlogic_params },
 	{ .compatible = "amlogic,meson-gxbb-usb",
 	  .data = dwc2_set_amlogic_params },
+	{ .compatible = "amlogic,meson-g12a-usb",
+	  .data = dwc2_set_amlogic_g12a_params },
 	{ .compatible = "amcc,dwc-otg", .data = dwc2_set_amcc_params },
 	{ .compatible = "st,stm32f4x9-fsotg",
 	  .data = dwc2_set_stm32f4x9_fsotg_params },
-- 
2.20.1

