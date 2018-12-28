Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A5EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E87EC20866
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 17:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6qhHIPc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387604AbeL1Rxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 12:53:34 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41621 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729898AbeL1Rxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 12:53:33 -0500
Received: by mail-ed1-f65.google.com with SMTP id a20so11300014edc.8;
        Fri, 28 Dec 2018 09:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I476dXzolvS36Jo8keWAqI+uNVpug96GEqSAmmxEOBM=;
        b=X6qhHIPcmynvX6WXNf8TQbRGT5b97pOPe+7NTxz+tNxhXZDxqzAKD1dyjlAmsvSDPl
         TMiE2OnBAgPD5dCoOJOxkdFI8qeoq19BywD73NqqHgzMMyD9Fa3IDTO5RWAZRy6kNkRe
         NPF4V3pxnWAiDFvaL8B6ltiKSkPcOSHSg42s94c1RMtzRPHyq8j2OjaO2fx/Aj6gfYHG
         jKF1tmGnIF5anVeGGyLDx54kHTBSNpEVqPMGUcxQt5Jo9ZJJJtfhaosfYNGE7kqd1fLp
         KEfdu9BBSY2CX+F1WxM4iJH0isgncFTjgohPSfOiNh6sCoYhZ7B0W+Q+lNWVWlKharEf
         0vYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I476dXzolvS36Jo8keWAqI+uNVpug96GEqSAmmxEOBM=;
        b=XF7niHp9hte/wB7W1miYkXrrNyT7Bs9dT00hXMaOPbe2sYhZJSJzbKg9/7vrA1sLNA
         IRdEMuQjZtMFlL032ptqVAcwzGJp7HJfuce7V3Oj/OATzAILbht+9fWVeqvh6JYTs9EB
         mNh41aBaNFiBWXht4cjOeLRdj/vVn39xDzj+96cZMUNz4AfMMvqCafzuXFNIFPuF9dxd
         turOTwSZHq8wHVJVo5CLPMtbjus6VGMrzvP3CRwKo3xr3rXZm3AF+W7jhVICmwZwE1xK
         iRPqs/W2kKrv1Y1R280YKvW/umsU22GRvBjacom9zoUOCPOUjSqjVRabJy0gPAnBzuro
         9yOQ==
X-Gm-Message-State: AA+aEWayi//ygnHSuAiGXJxDXMrEwhESNQ0OX8UD3APmIA4kpwLjvhq/
        wopTKk04T0qIWY5mW1N6WvWxUXMJZ3M=
X-Google-Smtp-Source: AFSGD/VZSmt9+afVDr+tfxq5UivXBT6u/d9XH9YxpLjaWBAZgKSZ7Jbu4bH50ZZE7htqURJ1LfrWIg==
X-Received: by 2002:a17:906:d41:: with SMTP id r1-v6mr19309835ejh.186.1546019611291;
        Fri, 28 Dec 2018 09:53:31 -0800 (PST)
Received: from manjaro.fritz.box (adsl-84-226-151-28.adslplus.ch. [84.226.151.28])
        by smtp.gmail.com with ESMTPSA id p22-v6sm7207665ejf.48.2018.12.28.09.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 09:53:30 -0800 (PST)
From:   Philipp Kaelin <kaelinphilipp@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Philipp Kaelin <kaelinphilipp@gmail.com>
Subject: [PATCH] Elantech Touchpad: Fix Elantech touchpad and trackpoint for Lenovo ThinkPad notebooks.
Date:   Fri, 28 Dec 2018 18:53:27 +0100
Message-Id: <20181228175327.14863-1-kaelinphilipp@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initial situation:
- The touchpad of a Lenovo ThinkPad L580 doesn't work with newer kernel versions eg. 4.20
- It used to work on earlier versions eg. 4.14

Cause:
- The elantech driver was adapted in to support SMBus wich not all firmware versions
  of the elantech firmware support. The SMBus is used as default.

Solution:
- Previously a blacklist was introduced for devices which doesn't support the access using SMBus.
  The ThinkPad P52 and P72 have already been fixed by adding it to such a blacklist in a prevois patch.
  The exact same solution fixed also the issue on the mentioned ThinkPad L580.

Change:
1) The firmware id of the ThinkPad L580 was added to this blacklist.
2) To not have a half baked solution the information which firmware versions are using the same driver
   and therefore most probably have all the same issue was extracted from the Lenovo Windows driver package.
   All these firmware versions are now also added to the blacklist.

Risk assesment:
As in prevois versions of the kernel eg. 4.14 none of the devices used to be accessed via SMBus
(and they are reported to work at this time) it's quite safe that this blaklisting doesn't cause
any harm on devices which have not been testes but included in the blacklist.

Signed-off-by: Philipp Kaelin <kaelinphilipp@gmail.com>
---
 drivers/input/mouse/elantech.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 9fe075c137dc..e5fa8cfd8393 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -1772,10 +1772,25 @@ static const char * const i2c_blacklist_pnp_ids[] = {
 	 * These are known to not be working properly as bits are missing
 	 * in elan_i2c.
 	 */
-	"LEN2131", /* ThinkPad P52 w/ NFC */
-	"LEN2132", /* ThinkPad P52 */
-	"LEN2133", /* ThinkPad P72 w/ NFC */
-	"LEN2134", /* ThinkPad P72 */
+	"LEN2131", /* Walter-3	w/ NFC		ThinkPad P52 w/ NFC	*/
+	"LEN2132", /* Walter-3	w/o/ NFC	ThinkPad P52		*/
+	"LEN2133", /* Chiron	w/ NFC		ThinkPad P72 w/ NFC	*/
+	"LEN2134", /* Chiron	w/o/ NFC	ThinkPad P72		*/
+	"LEN2037", /* Lando	w/ NFC		ThinkPad L580 w/ NFC	*/
+	"LEN2038", /* Lando	w/o/ NFC	ThinkPad L580		*/
+	"LEN004F", /* Storm	w/o/ NFC				*/
+	"LEN005C", /* Storm	w/ NFC					*/
+	"LEN2030", /* Carling						*/
+	"LEN2031", /* Bell						*/
+	"LEN2032", /* Bell-2						*/
+	"LEN2033", /* Storm-2						*/
+	"LEN2034", /* Storm-3						*/
+	"LEN2035", /* Solo	w/ NFC					*/
+	"LEN2036", /* Solo	w/o/ NFC				*/
+	"LEN2039", /* Leia						*/
+	"LEN2130", /* Kylo	(Clamshell)				*/
+	"LEN008F", /* Kolar	w/o/ NF					*/
+	"LEN0090", /* Kolar	w/ NFC					*/
 	NULL
 };
 
-- 
2.19.2

