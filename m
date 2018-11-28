Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38508C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 02:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E5E20817
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 02:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp8QIzHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E5E20817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727270AbeK1NrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 08:47:19 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43100 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeK1NrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 08:47:19 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so8773863pgk.10;
        Tue, 27 Nov 2018 18:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PQ6jE0EA3nrCqQ0O3jBflH5NGaxX2VUanEYetn1Nt3s=;
        b=Gp8QIzHIt2rDpQan3axrlqRVIpaTBRaj46CuYhwNy83J3W4dQDIZIW1orm9g4GvIOW
         S7aJUzOjRjGbC11X94QNr0yzSnLkajsxZk2QbTm3Cx1AfcH4yi/aDyguJA84DYcjRVlo
         GHVbFKXfyHizBIV5Epy+KanfuWapCdfuq5EhPwks43/qIRyK7pHtzkjUbYJcCvFHEXLw
         l7GFNs9JI94Hkn2t40L4rHOnv2Yb+PkTp9kY1XaOIaXBzZSBbgI+1Diu8OXl0erYlWjK
         TBjdzuSY4XBtt/COg0bySRO8wm7SxBzLiafTgcgzaecUTcwhrBGA54PNs5CKrAVN9mkj
         SCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PQ6jE0EA3nrCqQ0O3jBflH5NGaxX2VUanEYetn1Nt3s=;
        b=eJddEIcq0Jz9qB9IBHHyWRIWJ1nxCCiEcz7oSJPweWWb/Tcr32t/YIMDYi02k0/ISH
         HZNzFM1qfNi1l8K2+d6L39sTVbEvzVSul/+hqLZXe0mCqPHoY1GgVv9jKxw/UQjGr4nT
         a2r2OCPt3YSfJRf9OCmufC3+kgellpcoEXc5TsTuJ/cyPzaD66I8ttyCD71l/SLLiaqj
         1hZuqWc+aFkhrgIPXLECzN6q7MnyNq7qPmgaU9UebYfDUzl0oiU6Jh8ow/MnUhRDFWoP
         wejemobDvRXjjxjyEYS76OrLaQ+EETka8Cd4ox8x3HyDA9V8RyyxVnHSa4paFKhxt18Z
         AO+g==
X-Gm-Message-State: AA+aEWbxqljrQ6Ys7rrPEy5EavDt1F88JrYdz30/aPNI3JqQXav3jRsg
        M2F9DuX+N1mqGHGN3ouo6PvJMi6sC2Y=
X-Google-Smtp-Source: AFSGD/VjFGQ65b2WysOz97OJuJDY7WUxJQpwZPbzdiFQIBXq3WDozR6FASnBe8DZ6h2222icPuv2ZQ==
X-Received: by 2002:a63:7b06:: with SMTP id w6mr31483622pgc.288.1543373239766;
        Tue, 27 Nov 2018 18:47:19 -0800 (PST)
Received: from jupiter.localdomain ([2604:4080:1012:8070:9a48:b5d:be16:1cdc])
        by smtp.gmail.com with ESMTPSA id h8sm5422110pgv.27.2018.11.27.18.47.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Nov 2018 18:47:19 -0800 (PST)
From:   Cameron Gutman <aicommander@gmail.com>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmitry.torokhov@gmail.com
Cc:     mark@furneaux.ca, ramzeto@gmail.com
Subject: [PATCH] Input: xpad - quirk all PDP Xbox One gamepads
Date:   Tue, 27 Nov 2018 18:47:10 -0800
Message-Id: <20181128024710.10932-1-aicommander@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we continue to find tons of new variants [0,1,2,3,4,5,6] that
need the PDP quirk, let's just quirk all devices from PDP.

[0]: https://github.com/paroj/xpad/pull/104
[1]: https://github.com/paroj/xpad/pull/105
[2]: https://github.com/paroj/xpad/pull/108
[3]: https://github.com/paroj/xpad/pull/109
[4]: https://github.com/paroj/xpad/pull/112
[5]: https://github.com/paroj/xpad/pull/115
[6]: https://github.com/paroj/xpad/pull/116

Fixes: e5c9c6a885fa ("Input: xpad - add support for PDP Xbox One controllers")
Cc: stable@vger.kernel.org
Signed-off-by: Cameron Gutman <aicommander@gmail.com>
---
Dmitry,

This patch applies to your for-linus branch, since another PDP
quirked device was added there.


Regards,
Cameron
---
 drivers/input/joystick/xpad.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index d4b9db487b16..cfc8b94527b9 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -480,18 +480,18 @@ static const u8 xboxone_hori_init[] = {
 };
 
 /*
- * This packet is required for some of the PDP pads to start
+ * This packet is required for most (all?) of the PDP pads to start
  * sending input reports. These pads include: (0x0e6f:0x02ab),
- * (0x0e6f:0x02a4).
+ * (0x0e6f:0x02a4), (0x0e6f:0x02a6).
  */
 static const u8 xboxone_pdp_init1[] = {
 	0x0a, 0x20, 0x00, 0x03, 0x00, 0x01, 0x14
 };
 
 /*
- * This packet is required for some of the PDP pads to start
+ * This packet is required for most (all?) of the PDP pads to start
  * sending input reports. These pads include: (0x0e6f:0x02ab),
- * (0x0e6f:0x02a4).
+ * (0x0e6f:0x02a4), (0x0e6f:0x02a6).
  */
 static const u8 xboxone_pdp_init2[] = {
 	0x06, 0x20, 0x00, 0x02, 0x01, 0x00
@@ -527,12 +527,8 @@ static const struct xboxone_init_packet xboxone_init_packets[] = {
 	XBOXONE_INIT_PKT(0x0e6f, 0x0165, xboxone_hori_init),
 	XBOXONE_INIT_PKT(0x0f0d, 0x0067, xboxone_hori_init),
 	XBOXONE_INIT_PKT(0x0000, 0x0000, xboxone_fw2015_init),
-	XBOXONE_INIT_PKT(0x0e6f, 0x02ab, xboxone_pdp_init1),
-	XBOXONE_INIT_PKT(0x0e6f, 0x02ab, xboxone_pdp_init2),
-	XBOXONE_INIT_PKT(0x0e6f, 0x02a4, xboxone_pdp_init1),
-	XBOXONE_INIT_PKT(0x0e6f, 0x02a4, xboxone_pdp_init2),
-	XBOXONE_INIT_PKT(0x0e6f, 0x02a6, xboxone_pdp_init1),
-	XBOXONE_INIT_PKT(0x0e6f, 0x02a6, xboxone_pdp_init2),
+	XBOXONE_INIT_PKT(0x0e6f, 0x0000, xboxone_pdp_init1),
+	XBOXONE_INIT_PKT(0x0e6f, 0x0000, xboxone_pdp_init2),
 	XBOXONE_INIT_PKT(0x24c6, 0x541a, xboxone_rumblebegin_init),
 	XBOXONE_INIT_PKT(0x24c6, 0x542a, xboxone_rumblebegin_init),
 	XBOXONE_INIT_PKT(0x24c6, 0x543a, xboxone_rumblebegin_init),
-- 
2.19.1

