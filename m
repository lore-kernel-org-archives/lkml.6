Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE757C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:23:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA9A217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOH2WC6H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403789AbfBRRXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:23:05 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37683 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391203AbfBRRXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:23:01 -0500
Received: by mail-qt1-f196.google.com with SMTP id a48so20028257qtb.4;
        Mon, 18 Feb 2019 09:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=inBs+3iKjDTu7VeFonH5OLuJ3LxLJbSDrBJSJabl4kk=;
        b=GOH2WC6HAmQOLtoN+VxhtKSOFNMTphWQ9jQ2wZ6rHW4ASVls6ndTxWhbOskrsjFnK0
         CM6VjBdgxyFMmgDksZ1FG8l5xAI0emQivOrUJTT7WZvyD4ZGkmSDYdeBca5EbIEN9fLq
         3GyntPepAUIyzC7epbgK7maa43F/OAGlWpbK77sVavHtitsR8cZ4KJJg6aXSbMJ79aR1
         leHnYv0TdTOsjVNmMi2iMQiHAcZWzgQmbSNSnpDh7hqjYx6xh3Rj3BfYBOfFX+U8mJal
         MVBlreCMDwSvv4HjvR6KUR00POgRKX0BKh7pLKu1b+RmMbHV6lbH2mH/h30AQ4FlcqkR
         cqJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=inBs+3iKjDTu7VeFonH5OLuJ3LxLJbSDrBJSJabl4kk=;
        b=T2foVBzhPQtm+ZxeB3d+1/udhK79/CCDx2A/oi/QUF06iYgFhh4a4npAmA0mLiMSUF
         RtR4058hjYEJy5wE4yD75siMYqu69WOxJNGwJeeBIqXb9fE/ghs3Q4GnHBw9nqcJcGM4
         dp2hNBeq67Frwn+yfgu6Y0iAjKggdJ7HjL+7svdcxI4eGawkgTMmZlHC6H2gY8cKk4sT
         gaKONUhDzOwKi0tx8CaJ5/k2uiWtsrSp6bzNMy1zl/xck5FS5VYSKeU4wUggB3AsU4eE
         l32wYQJba5VWYX69n+KzwMK2zH+sxSqVEqXAJxej4sZSx1apG7Z8D034Aq1qnb+2ESXv
         Jo4g==
X-Gm-Message-State: AHQUAubkAzgh8zfnP1CGw90ZP/zSDZ3RN1Tzhhvn3Zb1TiwhiwYQm/kW
        XLL5wGcoPDxb3PCqOOC1KNw=
X-Google-Smtp-Source: AHgI3IYEcfQDPE70DvMOsyKjBS2aFKDR5Ty3EvpQSI5ANYAKN6DAKHnbINWQgqi9sB7aupxCpPHDww==
X-Received: by 2002:a0c:aff1:: with SMTP id t46mr18328036qvc.54.1550510580046;
        Mon, 18 Feb 2019 09:23:00 -0800 (PST)
Received: from wall-e.ime.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id v18sm6525275qkj.13.2019.02.18.09.22.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 09:22:59 -0800 (PST)
From:   Lucas Oshiro <lucasseikioshiro@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Anderson Reis <andersonreisrosa@gmail.com>
Subject: [PATCH 4/5] iio:potentiostat:lmp91000: invert if statement
Date:   Mon, 18 Feb 2019 14:22:35 -0300
Message-Id: <20190218172236.7781-5-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218172236.7781-1-lucasseikioshiro@gmail.com>
References: <20190218172236.7781-1-lucasseikioshiro@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Invert if statement arms in line 214, in order to make the code cleaner

Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: Anderson Reis <andersonreisrosa@gmail.com>
---
 drivers/iio/potentiostat/lmp91000.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index 6dba26121a62..7229ef59590a 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -211,12 +211,11 @@ static int lmp91000_read_config(struct lmp91000_data *data)
 
 	ret = of_property_read_u32(np, "ti,tia-gain-ohm", &val);
 	if (ret) {
-		if (of_property_read_bool(np, "ti,external-tia-resistor")) {
-			val = 0;
-		} else {
+		if (!of_property_read_bool(np, "ti,external-tia-resistor")) {
 			dev_err(dev, "no ti,tia-gain-ohm defined");
 			return ret;
 		}
+		val = 0;
 	}
 
 	ret = -EINVAL;
-- 
2.20.1

