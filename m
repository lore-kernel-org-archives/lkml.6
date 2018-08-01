Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395C4C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2C5420894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 09:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4cOsx6+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2C5420894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388841AbeHAL37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 07:29:59 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45657 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387639AbeHAL37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 07:29:59 -0400
Received: by mail-pg1-f195.google.com with SMTP id f1-v6so10545123pgq.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 02:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2WpIAkW8yzwjSoQSoK/B3tvLaHecjF2fDve8AviI17M=;
        b=J4cOsx6+k9C/Y5v8edhUb7HKWkggw8qUUixO86URpJcQ7NTtpbDfbM2JMnhL7BRW36
         ZdJzBejzWoX+98HmZpmqexREPzMJfgSJ1wSg8alkPARg/24/ack4FaQ9680FJNS5BOo8
         eNu1eJavvmWxmX6Bc5bGdfuEEraDBiQOAGlWcPzP8Umo8tDEF9ycHQVh150QFJoCou7I
         zUeJ7rjseiLvwevfXDyEIRrtienAUUPCvCn8CUpXmxggydB3F4t680XtkDqGKm02EPLK
         y6aF4yBJvmcCYzYdmbOMLOasulpxB6oGax4SydoSWY40nwi5o1GgwZmQhLUIv5PcEVzH
         Wbag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2WpIAkW8yzwjSoQSoK/B3tvLaHecjF2fDve8AviI17M=;
        b=HVTlQqXAJBaQhQEORF8Bd3QTCzQLP59LzlLWQWNt3yBqKAcRAjH4MAls907LzDhjwu
         dpMsLLO04MV7HD33zKaa2n5qLWz80s6gf3v0HJClVYgXFfx1zvxmuIhCdltrN4P1OUaN
         o5K6X3oJS8Ecajer7bm9ivwu6511PFTLgUDiJXCaY2OZbpcCKsvIsUtUNZ+V5DW63MyH
         PEayKN9fy1U2k2cdsra6qDjXnBRNg/bBs1Rg463H3KpcuTLYcIcXB1tWodwLgZPt14u8
         fbytmgsax/YLJ6quPrY9R1oKmijNjZYL7VRsjh4u/gAfLJ5DAqYdpbxSgq9Jwwxha4SL
         90QA==
X-Gm-Message-State: AOUpUlF1xi8dz5IDr2PItrFMBM6IiDs5m/WiTrnDO9s0hcpZFPXhc1SC
        kQMWPDXNvCizDtYKo06J4eFOacTB
X-Google-Smtp-Source: AAOMgpdFodwjjfx2AXKq0Y3W9ruo8ALFOhrd55uoMeL/opbTs5D1JCppzM22Erpqr4C6wGeCfPOPow==
X-Received: by 2002:a63:c14a:: with SMTP id p10-v6mr15448380pgi.305.1533116705165;
        Wed, 01 Aug 2018 02:45:05 -0700 (PDT)
Received: from localhost.localdomain (220-133-8-147.HINET-IP.hinet.net. [220.133.8.147])
        by smtp.gmail.com with ESMTPSA id w72-v6sm48877290pfa.26.2018.08.01.02.45.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 01 Aug 2018 02:45:04 -0700 (PDT)
From:   Jheng-Jhong Wu <goodwater.wu@gmail.com>
Cc:     goodwater.wu@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: mt29f_spinand: fix memory leak while programming pages
Date:   Wed,  1 Aug 2018 17:44:18 +0800
Message-Id: <1533116658-14924-1-git-send-email-goodwater.wu@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In spinand_program_page(), it uses devm_kzalloc() to allocate memory to
wbuf dynamically if internal ECC is on, but it doesn't free memory
allocated to wbuf at the end of this function. This leads to a memory leak
issue when internal ECC is on.

Signed-off-by: Jheng-Jhong Wu <goodwater.wu@gmail.com>
---
 drivers/staging/mt29f_spinand/mt29f_spinand.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index e389009..cf51ca8 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -553,6 +553,8 @@ static int spinand_program_page(struct spi_device *spi_nand,
 		}
 		enable_hw_ecc = 0;
 	}
+
+	devm_kfree(&spi_nand->dev, wbuf);
 #endif
 
 	return 0;
-- 
2.7.4

