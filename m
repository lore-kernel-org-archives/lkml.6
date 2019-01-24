Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB5AC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE0AB218FC
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HqDgNskN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731950AbfAXTdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:33:08 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36134 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731501AbfAXTdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:33:04 -0500
Received: by mail-qt1-f193.google.com with SMTP id t13so8054516qtn.3;
        Thu, 24 Jan 2019 11:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dABOoRdMc3ONkW9VtJfZtO0pYsaEfgtakPv9Q33V1xw=;
        b=HqDgNskN3KNCjeq7bYYjInz0eTtzLRFdJntR0+tGj7QEum40oadzieHkbtjwBreVh5
         botrSZPeNoMbGwqMDbzyJ52cv5tSnbdx7b4KWJZRTy+beQDtCi0xQXXqQy6Yimwvz42l
         4kZ0C0J9gCvghZBoDeNR2V+qb7sVOGWepUyjd4WPjNOJDPINkgk3BvNPDLgmdtaaGhR0
         z2gwn0UhthzBfoCFXdzTVp0G2YpsOtpA+UTDt1lZJdmi5zvyiZgONLYSGKGqaTcPbb2R
         8dOXN+X/DjaehXJrgd9tzUhMKJuGHO72rjDIt+LODd697gcB7D0NQAAPBn3TM1q2WJC7
         i2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dABOoRdMc3ONkW9VtJfZtO0pYsaEfgtakPv9Q33V1xw=;
        b=R9l7aH75MXEeezwYquRfoTgw1IIowMg4YmEqAlHCEwpgN91PwUSkpwZmrUGPbSVA84
         3zX056bb31ySb6pX5ms4XVqrBaushVZSocMCWe7d8Yh1NW4WrD2PYaaJdksOgzJUaBeD
         bPnVEh8JCzzzi9SDAqqXvLYWVr2tNm4IhzNxmoADVoh5jqgnL3umrd7cjUg8wYLf8w9U
         6I2cemSKCTxAuOuHdpEduKGEn/8e6Lvo70112WVvvWeO9HrsNZeQekvFZ/RBlHMfs+Yd
         +QzIQBZUqRnS2CYMe9/g8MX6QiTySwgSlsUFolPpnCsy6M3j3UxX8PHTJ7L7jnWW7HBo
         C++A==
X-Gm-Message-State: AJcUukf0GPFEP/JQwNhF5LI1onxusXq1D4g4PNW9LJzNjejkJfRyUhlN
        I5XUaLWYvwd8MpyUrRmGqRdQjFxgQLf+rg==
X-Google-Smtp-Source: ALg8bN5X3awJxgpBPV2BIyRUDKstA5j4mU44edb0fBso5pQQjKhhcmfBpyVpcaM5goZQ3+NJs7fFFQ==
X-Received: by 2002:ac8:2bd4:: with SMTP id n20mr8019780qtn.172.1548358383782;
        Thu, 24 Jan 2019 11:33:03 -0800 (PST)
Received: from rodrigo-note.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id t5sm48752762qkl.14.2019.01.24.11.32.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Jan 2019 11:33:03 -0800 (PST)
From:   Rodrigo Ribeiro <rodrigorsdc@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com,
        Rafael Tsuha <rafael.tsuha@usp.br>
Subject: [PATCH] staging:iio:ad7152: Rename misspelled RESEVERD -> RESERVED
Date:   Thu, 24 Jan 2019 17:31:56 -0200
Message-Id: <1548358316-8062-1-git-send-email-rodrigorsdc@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the checkpatch.pl check:

CHECK: 'RESEVERD' may be misspelled - perhaps 'RESERVED'?

Signed-off-by: Rodrigo Ribeiro <rodrigorsdc@gmail.com>
Signed-off-by: Rafael Tsuha <rafael.tsuha@usp.br>
---
This macro is not used anywhere. Should we just correct the
spelling or remove the macro?

 drivers/staging/iio/cdc/ad7152.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/iio/cdc/ad7152.c b/drivers/staging/iio/cdc/ad7152.c
index 25f51db..c9da6d4 100644
--- a/drivers/staging/iio/cdc/ad7152.c
+++ b/drivers/staging/iio/cdc/ad7152.c
@@ -35,7 +35,7 @@
 #define AD7152_REG_CH2_GAIN_HIGH	12
 #define AD7152_REG_CH2_SETUP		14
 #define AD7152_REG_CFG			15
-#define AD7152_REG_RESEVERD		16
+#define AD7152_REG_RESERVED		16
 #define AD7152_REG_CAPDAC_POS		17
 #define AD7152_REG_CAPDAC_NEG		18
 #define AD7152_REG_CFG2			26
-- 
2.7.4

