Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADAEC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91B0724037
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:26:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B0724037
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753485AbeGEN0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:26:49 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:35022 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753186AbeGEN0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:26:47 -0400
X-Greylist: delayed 571 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Jul 2018 09:26:46 EDT
Received: by wens.csie.org (Postfix, from userid 1000)
        id D3EC25FC04; Thu,  5 Jul 2018 21:17:13 +0800 (CST)
From:   Chen-Yu Tsai <wens@csie.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] Input: i8042 - add Lenovo LaVie Z to the i8042 reset list
Date:   Thu,  5 Jul 2018 21:08:49 +0800
Message-Id: <20180705130849.10479-1-wens@csie.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Lenovo LaVie Z laptop requires i8042 to be reset in order to
consistently detect its Elantech touchpad. The nomux and kbdreset
quirks are not sufficient.

It's possible the other LaVie Z models from NEC require this as well.

Cc: stable@vger.kernel.org
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/input/serio/i8042-x86ia64io.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index b353d494ad40..136f6e7bf797 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -527,6 +527,13 @@ static const struct dmi_system_id __initconst i8042_dmi_nomux_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "N24_25BU"),
 		},
 	},
+	{
+		/* Lenovo LaVie Z */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "Lenovo LaVie Z"),
+		},
+	},
 	{ }
 };
 
-- 
2.18.0

