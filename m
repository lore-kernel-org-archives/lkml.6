Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0BCC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 908E3217D9
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 17:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4Z4Peqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391154AbfBRRW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 12:22:56 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33059 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728216AbfBRRWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 12:22:53 -0500
Received: by mail-qk1-f195.google.com with SMTP id x9so10433159qkf.0;
        Mon, 18 Feb 2019 09:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8f/RQxPk8w5vx1KMybhUvbJejAVoWVDWzs9ol8JQZ1c=;
        b=D4Z4PeqmpMSIfmTDLPAvrbgJL/ta41Rym3oJMFZnKCdciMf5kXHCjoqqNvSnR4yMBv
         du07+VMTeIerJZ2HR5dg4HmIiDLSCID/ZHyYoSVoQhRSFa90YuUHpDmnISkuE0zDMFDj
         t5Nf2021PE0wglo8fXEQdq7czIdS+IDGY7tzh3wb4NZ5fwmWKD9Tr3mFXK2M8AsaKm+r
         xLp5F15Jcgjwih76PL2d1k8HyU9TYgfen9aWaPq8hhcd60HuRMLYIj302hMO7bQMDct8
         VPtGZePJPsV/MzxYohqfWdKxFgqX63zOgvtpzlu1Y51E3+nSqrRW9Hl+ZInMF3R/sSOH
         6KEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8f/RQxPk8w5vx1KMybhUvbJejAVoWVDWzs9ol8JQZ1c=;
        b=kwYCzF2DFoRtbyILf+w7yG47cF2V1cnl0ngsS5SthFbGFy1n8O/7lDEk2PmOgIEBcA
         6pJZ4zku5oLUPxGark267s2260nGT2DjU1xvy3eGyV3Qqq63PsUUoA+ky7xpPek+85VJ
         bc2RjsqjFtmz2yFALFDgTogoEyD/iTE4hXurlUlGkOqtFm4s3pXosrqxtciJF6t75y8R
         MqHvQuJyAWk0abcwHSbZiz2I+hfY+lCxh+6LCSF3cUycHVBWje29cNfEJ7h6gU4aXxAG
         vppSkxgWK7UOHpItsBVwP8hKrzF/Pu0C7QN5C17o6U+6QAs7AxXXXgc8KlKkZRuOyw+p
         siRQ==
X-Gm-Message-State: AHQUAuaEAB9kMCSwzDp5NmztoQtcrb1qcolaDTSIHsfmmzNPuGEz74g4
        tsrP025C5x05IjH41Xew1c0=
X-Google-Smtp-Source: AHgI3IbPOfnDVF554JcRsmLOcrYo+jAVM2pH8PtN413oi8Cl1ObCViKRfQ78/aM+BOQ3qU2ZlPW0PQ==
X-Received: by 2002:a37:6a44:: with SMTP id f65mr17961115qkc.244.1550510572615;
        Mon, 18 Feb 2019 09:22:52 -0800 (PST)
Received: from wall-e.ime.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id v18sm6525275qkj.13.2019.02.18.09.22.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 09:22:52 -0800 (PST)
From:   Lucas Oshiro <lucasseikioshiro@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-usp@googlegroups.com,
        Anderson Reis <andersonreisrosa@gmail.com>
Subject: [PATCH 1/5] iio:potentiostat:lmp91000: remove unnecessary parentheses
Date:   Mon, 18 Feb 2019 14:22:32 -0300
Message-Id: <20190218172236.7781-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218172236.7781-1-lucasseikioshiro@gmail.com>
References: <20190218172236.7781-1-lucasseikioshiro@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary parentheses on line 116, and solve these checkpatch.pl
CHECKs:

- lmp91000.c:116: CHECK: Unnecessary parentheses around 'state != channel'
- lmp91000.c:116: CHECK: Unnecessary parentheses around 'channel == LMP91000_REG_MODECN_TEMP'

Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
Signed-off-by: Anderson Reis <andersonreisrosa@gmail.com>
---
 drivers/iio/potentiostat/lmp91000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/potentiostat/lmp91000.c b/drivers/iio/potentiostat/lmp91000.c
index 90e895adf997..03d277621861 100644
--- a/drivers/iio/potentiostat/lmp91000.c
+++ b/drivers/iio/potentiostat/lmp91000.c
@@ -113,7 +113,7 @@ static int lmp91000_read(struct lmp91000_data *data, int channel, int *val)
 		return -EINVAL;
 
 	/* delay till first temperature reading is complete */
-	if ((state != channel) && (channel == LMP91000_REG_MODECN_TEMP))
+	if (state != channel && channel == LMP91000_REG_MODECN_TEMP)
 		usleep_range(3000, 4000);
 
 	data->chan_select = channel != LMP91000_REG_MODECN_3LEAD;
-- 
2.20.1

