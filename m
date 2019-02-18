Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED5FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397E3217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BSynU4j7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391295AbfBRRXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:23:08 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40424 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403774AbfBRRXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:23:03 -0500
Received: by mail-qt1-f193.google.com with SMTP id j36so20006623qta.7;
        Mon, 18 Feb 2019 09:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bpm4uv7ht7FRHap3/HLE7Hw5o+LrP45Gwqaa5tT8iVY=;
        b=BSynU4j7WSq5kg40pvVsfv/0dOdWzXwAAbhh1spJXKwhUKsupYqORZoFxefqHPO8oA
         QbImx0RefbX0sSH0OtQKkB6/ZwgJ92zFlKtWfKvYylR31FXSy45JJt33YbM3S7bCq2as
         R2/puNqxKYLW7TPzmoXj4DxCaL+ggpQ2NPUjXKS/KAdD7Bi7gwLpGdQs3hjEO2NKKkwv
         qaG5YwuZvHdF1jNTGrFAUtY0Qd0WER2xn2aCUtzzD/O/k+8rq2hqPMfIysIABzXiuL7T
         3N5W26bBb3ToBAmbtQrwrBe4uSBx3xt/Z3GsfLpmv7cmOuQO/+H5tBzPFu7OoSEJSLvL
         MKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bpm4uv7ht7FRHap3/HLE7Hw5o+LrP45Gwqaa5tT8iVY=;
        b=DHJ+kMAmcTcQgZgOS2QCTNCZvO2pN/3/jfiwmIba/F19jeUYwp+NMh7VoD4jMBn5yN
         XjMeyinW3x5yYKbrQb0CanDKkd+S9tTVF/iiaZUtIzCXoADEKEjxhUA4Ix8xy5sK5AEp
         ZREhN5u8OemTw3kQL8uvIq5DBg7H1CgyO5supq2S6xRAqRbRUPAAaQfsUA7uKx9e5YfN
         f83OgQT6OgXwqYithvbjjjEZD0CS1dAxw0HCsWXugWbC53oQAseIlgYxAuuPMikZTAZJ
         RwVSRSnPlSiZPUzreAxMpL+OsE+LPP1Au+6/SYdEIid1tyvqlWPfiEzIVZP5dc7+Ahhs
         mi2Q==
X-Gm-Message-State: AHQUAuZSG//s/VlIUkiwgyTMox4oiil/8XlJUx6m7Y0IZcLRG78aCvDR
        etidPdfNK+rRHaE8JLunsEc=
X-Google-Smtp-Source: AHgI3IZ0DDPlDCNBTFxSGjJe6+FtcTQq2tiPOeCHMj4ocf3fVvzDFL57fUpFbAfID+15uochVFQJMA==
X-Received: by 2002:ac8:34b2:: with SMTP id w47mr19513924qtb.112.1550510582324;
        Mon, 18 Feb 2019 09:23:02 -0800 (PST)
Received: from wall-e.ime.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id v18sm6525275qkj.13.2019.02.18.09.23.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 09:23:02 -0800 (PST)
From:   Lucas Oshiro <lucasseikioshiro@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Anderson Reis <andersonreisrosa@gmail.com>
Subject: [PATCH 5/5] iio:potentiostat:lmp91000: add '\n' on dev_err
Date:   Mon, 18 Feb 2019 14:22:36 -0300
Message-Id: <20190218172236.7781-6-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218172236.7781-1-lucasseikioshiro@gmail.com>
References: <20190218172236.7781-1-lucasseikioshiro@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing '\n' at the end of dev_err message on line 215.

Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: Anderson Reis <andersonreisrosa@gmail.com>
---
 drivers/iio/potentiostat/lmp91000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index 7229ef59590a..aecdda757586 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -212,7 +212,7 @@ static int lmp91000_read_config(struct lmp91000_data *data)
 	ret = of_property_read_u32(np, "ti,tia-gain-ohm", &val);
 	if (ret) {
 		if (!of_property_read_bool(np, "ti,external-tia-resistor")) {
-			dev_err(dev, "no ti,tia-gain-ohm defined");
+			dev_err(dev, "no ti,tia-gain-ohm defined\n");
 			return ret;
 		}
 		val = 0;
-- 
2.20.1

