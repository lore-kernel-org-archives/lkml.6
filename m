Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id JEhfBLdtG1t8TQAAmS7hNA
	; Sat, 09 Jun 2018 06:03:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E5A58608B8; Sat,  9 Jun 2018 06:03:34 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFfMQETY"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5CA0460290;
	Sat,  9 Jun 2018 06:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5CA0460290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752702AbeFIGDc (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 02:03:32 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39626 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751344AbeFIGDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 02:03:30 -0400
Received: by mail-pf0-f193.google.com with SMTP id r11-v6so7643381pfl.6;
        Fri, 08 Jun 2018 23:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1dCCaHR6eY9TQSptyKJJTS1RLGrZrJY8a9bcNVXetUE=;
        b=PFfMQETYVRNqZ0MS0lvFnFaXjJnsKzbOxZqgGf5DyWUE6Y/Hk8zb7Avo3QGq+wMdFr
         KdMSwgH1X7s56qX0Wh94FvH1Rcf5wT4LokQ8feobs5JM002KPb2MdzqDo4GY971jNJ2L
         AIPKBQcyZ02+rFQZts8eefmcODchdimdYtiFBzTaFRbfcpMQzwuqug759ZOl3CUfumzx
         Szu5uFan+umYe9Jwvb/0E8RolF6SWt/HoFqL0oewwBOFagcSW9+YgHeyLuYl9cihVASl
         NcV6CuyelCWU4ThdUF9lqWgfCrBmew84C/nnPOBr3Nf3GQksmZKkX9qb9ayKiVxpVMHf
         YncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1dCCaHR6eY9TQSptyKJJTS1RLGrZrJY8a9bcNVXetUE=;
        b=KNt17a6ObFs0etbX4ajAgQ1MOqtOfqjKGJA9vG2HcW/36RK2JwPKZLbhYcIYQ468Ya
         l3swCWLRPVEGGrloZL24jZzJgFAm8GiOxzMRgjlTsCW4IQcoqDaVFGhgF4J7cjmiAeU5
         Rxo3qnnKazv1Lxv8Zmkf2QEc6rvDHFKoIsuMEAQXPDTPfKoqyGAgZhlCuHVQ+is5GVwB
         lJnU/1tMVw9IpsTdRd6c7U6k9z0TVc+giCuUAZwyenSh8ifMFgQ0HeehloiTx877bJ72
         acjS8EC8JcFMOYGGZkhNJJgg5S0OGLJpG6gjHAhqU+cwZ64H/oMVq4YMoq4GkmGqlAVN
         LfrA==
X-Gm-Message-State: APt69E1Iu9soB7KZb2PwPf9gmpK8rWzg5rREGZGFFXAIBwba3sYTD0GT
        +6vXbV9X12pUAd836tsTfs0=
X-Google-Smtp-Source: ADUXVKLRGU32X/ErAD7xMQNTOt7LSTDUgyHSJucxy9fQAXyNhw29xZIQ1FEcElTarsUGppscnnl+EA==
X-Received: by 2002:a62:fb05:: with SMTP id x5-v6mr478469pfm.210.1528524209846;
        Fri, 08 Jun 2018 23:03:29 -0700 (PDT)
Received: from joonhwan-virtualbox.localnet ([220.149.255.57])
        by smtp.gmail.com with ESMTPSA id f11-v6sm17669643pgq.18.2018.06.08.23.03.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 23:03:29 -0700 (PDT)
From: "JoonHwan.Kim" <spilit464@gmail.com>
To: gregkh@linuxfoundation.org
Cc: neil@brown.name, blogic@openwrt.org, christian@lkamp.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH 1/2] staging: mt7621-spi: change indentation from space to tab
Date: Sat, 09 Jun 2018 15:03:27 +0900
Message-ID: <1646985.m1Qjj59is2@joonhwan-virtualbox>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* fix checkpatch.pl error:
  ERROR: code indent should use tabs where possible

Signed-off-by: Joonhwan Kim <spilit464@gmail.com>
---
 drivers/staging/mt7621-spi/spi-mt7621.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-spi/spi-mt7621.c b/drivers/staging/mt7621-spi/spi-mt7621.c
index d9b55d2059b0..a11cca3e2304 100644
--- a/drivers/staging/mt7621-spi/spi-mt7621.c
+++ b/drivers/staging/mt7621-spi/spi-mt7621.c
@@ -105,7 +105,7 @@ static void mt7621_spi_set_cs(struct spi_device *spi, int enable)
 	int cs = spi->chip_select;
 	u32 polar = 0;
 
-        mt7621_spi_reset(rs, cs);
+	mt7621_spi_reset(rs, cs);
 	if (enable)
 		polar = BIT(cs);
 	mt7621_spi_write(rs, MT7621_SPI_POLAR, polar);
-- 
2.17.0
