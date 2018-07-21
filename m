Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFDBECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6577420849
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 12:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=markrailton-com.20150623.gappssmtp.com header.i=@markrailton-com.20150623.gappssmtp.com header.b="guIYqJ7K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6577420849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=markrailton.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeGUNKn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 09:10:43 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41320 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727404AbeGUNKn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 09:10:43 -0400
Received: by mail-ed1-f66.google.com with SMTP id s24-v6so11819644edr.8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 05:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=markrailton-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=bI0o4TD9+ZZ21UVL0QwRXo/nMoehDSjWIVp7zWqULvM=;
        b=guIYqJ7KMZgBHY98jU4rfXO9U6aLZU5/q9hyaM79WfK3SVQ0H4GfvjZQbg5JD8b45D
         6tTqFyEj04wmKaSxtKJjKJ85D66LCfgv63y6lJUpUVDOEXe8bnKQrJuWXCjgzeE2Vz6K
         KRyvsxbPVt7af8Axv/TeH17/G54m7Ol0F1s3KorstS+l0sbPtevJdkhhjDs6H4N2YBmt
         hUc3svnKqBuMNiqGdZ1v42a6YOwZdQ3ihrM3TXIXhwfzwGHB/moaKiE2dkp7T+BEkNYM
         51zmhpQL580IkxR4rjnZni5JlgP2uDPlYS4gxilvIdoFgppBE3/od7PtnaxqE2M2C++4
         m1gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bI0o4TD9+ZZ21UVL0QwRXo/nMoehDSjWIVp7zWqULvM=;
        b=UX29SnE/r2wW2vK+AFcCmCSK0dOA61+TaJnrLcbXOjhUc6incI+MxDfsEZqhSgKMRT
         AFDhk3rHD9BsobGfx8pq89bIdfDEL9OaeJeM+k6O7cabGFGYu7i+LkR8A/2GtfBFe7TQ
         MOu/XlEEe2tfulEEjDNQNcRRoyWTuGGtjE7BkOD2KttFuj5hkcWgBlKEwco3wmOvkFGw
         WpOkfI25iOFF90eQdgFPsAglDFKFyIoi3b/wJwiJmME9U3eADi7b64FYhsaDPKFxe+wV
         zRlRQAgA9J7z/+9hAciHlcfsFOoeXtGLVN0BB6ydcGImM5JlG8Huwmpj3/FMD9pkERFv
         ec4g==
X-Gm-Message-State: AOUpUlEcAmi10VtBBd+6Ym8oZ00rjoZMSuxSHJTHcy9MvdNIyPVX+EyA
        Ebq7MFmQeXpagkRY6Awm7DdC5d36UOKudQ==
X-Google-Smtp-Source: AAOMgpeI34b78BlbIJ7NRHKRxwPI0yzuVvaHscdNUDGqxoQ5BAlqiwAHUj6po9udTG0iipi9hhUFPA==
X-Received: by 2002:a50:b399:: with SMTP id s25-v6mr6709040edd.217.1532175488699;
        Sat, 21 Jul 2018 05:18:08 -0700 (PDT)
Received: from ZeroCool.lan.bitbuzz.net ([89.204.252.36])
        by smtp.gmail.com with ESMTPSA id k4-v6sm2354550edl.22.2018.07.21.05.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 05:18:07 -0700 (PDT)
From:   Mark Railton <mark@markrailton.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Mark Railton <mark@markrailton.com>
Subject: [PATCH 2/2] Drivers: Staging: pi433: remove unsused case
Date:   Sat, 21 Jul 2018 13:17:58 +0100
Message-Id: <20180721121758.7480-1-mark@markrailton.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed a commented out case statement

Signed-off-by: Mark Railton <mark@markrailton.com>
---
 drivers/staging/pi433/rf69.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/pi433/rf69.c b/drivers/staging/pi433/rf69.c
index 14826fb505dd..b2d69af6d3fe 100644
--- a/drivers/staging/pi433/rf69.c
+++ b/drivers/staging/pi433/rf69.c
@@ -617,9 +617,6 @@ bool rf69_get_flag(struct spi_device *spi, enum flag flag)
 		return (rf69_read_reg(spi, REG_IRQFLAGS1) & MASK_IRQFLAGS1_SYNC_ADDRESS_MATCH);
 	case fifo_full:
 		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_FIFO_FULL);
-/*	case fifo_not_empty:
- *		return (rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_FIFO_NOT_EMPTY);
- */
 	case fifo_empty:
 		return !(rf69_read_reg(spi, REG_IRQFLAGS2) & MASK_IRQFLAGS2_FIFO_NOT_EMPTY);
 	case fifo_level_below_threshold:
-- 
2.17.1

