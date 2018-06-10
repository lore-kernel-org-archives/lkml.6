Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Oi0eOJ2hHVtnNwAAmS7hNA
	; Sun, 10 Jun 2018 22:09:36 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 53A6860791; Sun, 10 Jun 2018 22:09:36 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMbx12dD"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DB49E6032D;
	Sun, 10 Jun 2018 22:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB49E6032D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932153AbeFJWJd (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 21 others); Sun, 10 Jun 2018 18:09:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54908 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753692AbeFJWJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 18:09:31 -0400
Received: by mail-wm0-f67.google.com with SMTP id o13-v6so11434559wmf.4;
        Sun, 10 Jun 2018 15:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+Ryou1q5Q3g/roVK0v7fUP83I81z53Iy7orrPMdRuUM=;
        b=MMbx12dD4auWrfcO0iyvCPGZXwwYEpzCWRIkG9CNx5r9Lkyt+wKrI+z7nmB5/iBymN
         lOAV2MPgaNTSkKvEdaxhE+Pv9FGTQcW9Z6sm/6vhRGU9EER4xo7BEDX+I7Th4PSTAewj
         nkqCKXOjSxGniHAZ8vYHhBlj87b5S6J+LbbvR/8DNk2pOc4Gh6m5YVLhZDBpX08r4+Yy
         KQjk+YrhicjQJ86+NL4rJJrsreNaOosbVb6CfYywadXcTraRZP4KL61uCfl0zF7fFrjr
         Bh5sv0ex2i6wmwVTjHT0kdpMhzVMwMhcDZ5T4LStJzGgy60TMJpjkAYO4UimDxQ0z4Rd
         ErrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+Ryou1q5Q3g/roVK0v7fUP83I81z53Iy7orrPMdRuUM=;
        b=P+ZBcQTwXbgcvnf/UrIAFUNeP4/IUAdL5l5KSsh9mDLEFtzVvCJGhlzTqHRXUlz82y
         4ad65YwBvyZtO05qNvAtGUYPpQ1iqY13uiyymImtq5juPjUWTlz2FVIKym09n9Cy7epK
         TB1rym/CS7WBSrv0YuZCYVA1dH4p3rSywNaX6F0eAPGflAVtpqkbIKZsU+WMtggfagZZ
         YJxGNU15Lx3RuYC+RhxaaPrzNFbGzxsNm4JfvQ+gVHW1Lb5PvoIlr/OOrC1MfxYdcMsf
         Tearv6kLcC1sGNAWe5UWNm271HnQJSasPqBPuaoCoDqwAgAUA+8MT7k+Qr1E5WFms7yV
         B/iQ==
X-Gm-Message-State: APt69E3SUXW4wCp9bMGbTjsaLQUM6ICDcLQViyfYwV3sPWjVeeASaxgG
        I1h9drDpoqlS+Lh9uN8Ikbo=
X-Google-Smtp-Source: ADUXVKKXJ0zv7PzPTpFWGDNrLAg4uNRKzO93BHHpkhAK/qkySt0QSVIw0ltoLIuZwt884jMxBY/INQ==
X-Received: by 2002:a1c:c342:: with SMTP id t63-v6mr7066365wmf.123.1528668570445;
        Sun, 10 Jun 2018 15:09:30 -0700 (PDT)
Received: from localhost.localdomain ([156.219.244.88])
        by smtp.gmail.com with ESMTPSA id v138-v6sm11049162wmd.47.2018.06.10.15.09.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Jun 2018 15:09:29 -0700 (PDT)
From: Karim Eshapa <karim.eshapa@gmail.com>
To: lars@metafoo.de
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Karim Eshapa <karim.eshapa@gmail.com>
Subject: [PATCH] staging:iio:accel: use sign extend function avoiding code duplication
Date: Mon, 11 Jun 2018 00:09:20 +0200
Message-Id: <20180610220920.12244-1-karim.eshapa@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use sign_extend32 kernel function instead of code duplication.
This function is also safe for 16 bits.

Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
---
 drivers/staging/iio/accel/adis16201.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201.c b/drivers/staging/iio/accel/adis16201.c
index 0fae8aaf1cf4..fe4494e65395 100644
--- a/drivers/staging/iio/accel/adis16201.c
+++ b/drivers/staging/iio/accel/adis16201.c
@@ -227,9 +227,7 @@ static int adis16201_read_raw(struct iio_dev *indio_dev,
 		ret = adis_read_reg_16(st, addr, &val16);
 		if (ret)
 			return ret;
-		val16 &= (1 << bits) - 1;
-		val16 = (s16)(val16 << (16 - bits)) >> (16 - bits);
-		*val = val16;
+		*val = sign_extend32(val16, bits);
 		return IIO_VAL_INT;
 	}
 
-- 
2.17.1
