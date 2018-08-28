Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D44C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8685205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 05:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd8gQH7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8685205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbeH1Jip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 05:38:45 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44755 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbeH1Jip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 05:38:45 -0400
Received: by mail-oi0-f65.google.com with SMTP id l82-v6so696598oih.11;
        Mon, 27 Aug 2018 22:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I9yaeC8o347H9zCYUCuOeyyGHsohJP8MUFWbscsUaTM=;
        b=Qd8gQH7HS4ExJ9aYGz6BY5Flj+z1DlD2Av61zrQzCO5TZd7E6L1nmBwx3Td5iApyPO
         KgMWrPQb+B3Rw/wypOlNY71IQjgKS0nRGIEzTGCXMSupUTVnU6HxRfu0rLw8P607chhR
         /NJ7xRkwczLvXRjW3OmECRsogrxSPuJNHBkKbUzbKIsfF/Jyjld3mZwuOj1Juv3pydcy
         8nTSHFANN5ksmKNRuL9TfK5cfmySlmDICUNZIjlbfTgBDfp1yeoH/fXmrw6E5igWloNy
         HGe9aqcFlpASU5Pze7s3JKEpwT/dCo7iudPee4oQPRsxUuKRAwGacNkqdLz11Xh6DYo4
         MyNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I9yaeC8o347H9zCYUCuOeyyGHsohJP8MUFWbscsUaTM=;
        b=QGCUKrJtNmzu/0p7r9/sMRmWocK8M5cV9mbkqGJHCsLuluONvoj5e41ZBkoqrbHBRY
         UbpQ5toqK2+wppHqbgSub0YStOfGB5ZHPLmiJ4lrLNy95DgJJSlg0EL9cvN/wiHO/+lq
         infL5mPLUWkMTe8zmmBdiW+W1fCgNknV8WCAYzZuWNP8Mmw6Y+MEC2OOgc6i7u4r7L4c
         AUiYAgRjiF3PUopHO7ddRAdrb14uy/X0erhMbW3mNyf9XxUhGiLLtolQzPIPie2rPg2c
         1pMTYP0TvsqKk07X4qpXS45wIvf02NzQI5E94t36DfKbqiZxI9uOQb2UyjBr48MVKt1f
         V66Q==
X-Gm-Message-State: APzg51BbbkVjPNWbuAvEyMLta9lWFOXLA3AgcJPjF0316AF0XwPb960H
        qMJJ2O+Jyl4bjNNJbeSt/Ck=
X-Google-Smtp-Source: ANB0VdYz+yKv6EQ8QQvqLGF0nFMTq8ug6m0VdHDDNfsS40LbEHL+H5D2BzFefp2W5pB2UlbXS49a0g==
X-Received: by 2002:aca:4fcd:: with SMTP id d196-v6mr38240oib.51.1535435324629;
        Mon, 27 Aug 2018 22:48:44 -0700 (PDT)
Received: from localhost.localdomain ([187.247.209.67])
        by smtp.gmail.com with ESMTPSA id q63-v6sm54307oia.54.2018.08.27.22.48.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 22:48:43 -0700 (PDT)
From:   =?UTF-8?q?Ramses=20Ram=C3=ADrez?= <ramzeto@gmail.com>
Cc:     ramzeto@gmail.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Cameron Gutman <aicommander@gmail.com>,
        Mark Furneaux <mark@furneaux.ca>,
        Leo Sperling <leosperling97@gmail.com>,
        Enno Boland <gottox@voidlinux.eu>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Francis Therien <frtherien@gmail.com>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Input: Support for Xbox1 PDP Camo series gamepad
Date:   Tue, 28 Aug 2018 00:48:11 -0500
Message-Id: <20180828054812.14428-1-ramzeto@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "Xbox One PDP Wired Controller - Camo series" has a different
product-id than the regular PDP controller and the PDP stealth series,
but it uses the same initialization sequence. This patch adds the
product-id of the camo series to the structures that handle the other
PDP Xbox One controllers.

Signed-off-by: Ramses Ramírez <ramzeto@gmail.com>
---
 drivers/input/joystick/xpad.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index cd620e009bad..d4b9db487b16 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -231,6 +231,7 @@ static const struct xpad_device {
 	{ 0x0e6f, 0x0246, "Rock Candy Gamepad for Xbox One 2015", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x02ab, "PDP Controller for Xbox One", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x02a4, "PDP Wired Controller for Xbox One - Stealth Series", 0, XTYPE_XBOXONE },
+	{ 0x0e6f, 0x02a6, "PDP Wired Controller for Xbox One - Camo Series", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0301, "Logic3 Controller", 0, XTYPE_XBOX360 },
 	{ 0x0e6f, 0x0346, "Rock Candy Gamepad for Xbox One 2016", 0, XTYPE_XBOXONE },
 	{ 0x0e6f, 0x0401, "Logic3 Controller", 0, XTYPE_XBOX360 },
@@ -530,6 +531,8 @@ static const struct xboxone_init_packet xboxone_init_packets[] = {
 	XBOXONE_INIT_PKT(0x0e6f, 0x02ab, xboxone_pdp_init2),
 	XBOXONE_INIT_PKT(0x0e6f, 0x02a4, xboxone_pdp_init1),
 	XBOXONE_INIT_PKT(0x0e6f, 0x02a4, xboxone_pdp_init2),
+	XBOXONE_INIT_PKT(0x0e6f, 0x02a6, xboxone_pdp_init1),
+	XBOXONE_INIT_PKT(0x0e6f, 0x02a6, xboxone_pdp_init2),
 	XBOXONE_INIT_PKT(0x24c6, 0x541a, xboxone_rumblebegin_init),
 	XBOXONE_INIT_PKT(0x24c6, 0x542a, xboxone_rumblebegin_init),
 	XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_rumblebegin_init),
-- 
2.17.1

