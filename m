Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70031C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:51:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28E0820C0B
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 07:51:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MfpTW8DR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28E0820C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbeHBJlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 05:41:45 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41406 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeHBJlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 05:41:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id y10-v6so818144pfn.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Aug 2018 00:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uHqYBTGj7l+UTAy/onljqj/iO9G4w3zhxWLocAZBwfY=;
        b=MfpTW8DRZd99RQAODwUR/mjydd0u7PmEZpkumSw8Y1Etnspuw+reB63LX4b2y/sTSR
         Q9CJfXDo9oy9qWR8ricu8p8VRiE+KL5i0pQ9RCDK6eJydOnNFzpm4CMIbpw1rOQGCMjL
         a3rtjTUKEeDQD0CAbJ100GQnzW2Vwv4+jG//NAoRT8/JDb6fsJXkE1sTAqjk7GH/hMcp
         PXpVKSktBcEb9wjck/QRrOa8nZYolQdUewvD0qe9wspSnyQlwSSEcfF6VsQs3Kd3sKaJ
         wXYzIoG0B6kK0kuzeTgUcWR247y2LBKPU59XHDsvB1flsoAUaviiumrbUetDpupURxol
         cnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uHqYBTGj7l+UTAy/onljqj/iO9G4w3zhxWLocAZBwfY=;
        b=ll8b2Ole66vV6gzEqRhUFyiRVmHLC9yGHOMrkpK5UltRLiYPWxWbonkllpTfxPHsOY
         YDQ6ysJ30DlL8jmI5Ec+Kf7RUw56PzWqy2a6qolacUFzl2fD+7cp274se3K6Y3O4Wkv5
         n3a28NfEz6DvsX0qwH27Yh6hIhxt/BMbVitG7URS6zNkbYKwCCj+gJd+zQWqppgCxZIs
         3W0wtUqhpGDb2nGX6eWuR7Jy/zA5kh9ceEQfW9/EvtDw0sGU+vWAMa9YovgiTRuuLOTa
         BGJ6PjUofd6WsZk6x/G09+X7B4FiYWOHXIZkPp1BTlX6tLD+PFvo0uvE1qQimJxU2JH7
         S/1g==
X-Gm-Message-State: AOUpUlGXbxS6NIuFNLTll8azRr3XdDldBezSzbwl2tCcsTGPhPXu4EQH
        vRDxqiGFRDSGirbxAM2LCHEVS5jQ
X-Google-Smtp-Source: AAOMgpcphDlfprI+3CFrqDIQPBYQuck5Tp9HghJ9ft3ipqwZ2mKRUARgqs+RgZV1zs6CzSG/vbUNgA==
X-Received: by 2002:a63:e318:: with SMTP id f24-v6mr1625927pgh.175.1533196309320;
        Thu, 02 Aug 2018 00:51:49 -0700 (PDT)
Received: from localhost.localdomain (220-133-8-147.HINET-IP.hinet.net. [220.133.8.147])
        by smtp.gmail.com with ESMTPSA id q25-v6sm3416293pfk.96.2018.08.02.00.51.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 02 Aug 2018 00:51:48 -0700 (PDT)
From:   Jheng-Jhong Wu <goodwater.wu@gmail.com>
Cc:     goodwater.wu@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: mt29f_spinand: fix memory leak while programming pages
Date:   Thu,  2 Aug 2018 15:51:30 +0800
Message-Id: <1533196290-9669-1-git-send-email-goodwater.wu@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533116658-14924-1-git-send-email-goodwater.wu@gmail.com>
References: <1533116658-14924-1-git-send-email-goodwater.wu@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In spinand_program_page(), it uses devm_kzalloc() to allocate memory to
wbuf dynamically if internal ECC is on, but it doesn't free memory
allocated to wbuf at the end of this function. Before the spinand device
is removed and frees memory automatically, programming pages may run many
times. This leads to a memory leak issue when internal ECC is on.

Changelog:

v2:
- use kzalloc()/kfree() to replace devm_kzalloc()/devm_kfree()
- add some descriptions to commit message

Signed-off-by: Jheng-Jhong Wu <goodwater.wu@gmail.com>
---
 drivers/staging/mt29f_spinand/mt29f_spinand.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/mt29f_spinand/mt29f_spinand.c b/drivers/staging/mt29f_spinand/mt29f_spinand.c
index e389009..d740c76 100644
--- a/drivers/staging/mt29f_spinand/mt29f_spinand.c
+++ b/drivers/staging/mt29f_spinand/mt29f_spinand.c
@@ -492,7 +492,7 @@ static int spinand_program_page(struct spi_device *spi_nand,
 #ifdef CONFIG_MTD_SPINAND_ONDIEECC
 	unsigned int i, j;
 
-	wbuf = devm_kzalloc(&spi_nand->dev, CACHE_BUF, GFP_KERNEL);
+	wbuf = kzalloc(CACHE_BUF, GFP_KERNEL);
 	if (!wbuf)
 		return -ENOMEM;
 
@@ -553,6 +553,8 @@ static int spinand_program_page(struct spi_device *spi_nand,
 		}
 		enable_hw_ecc = 0;
 	}
+
+	kfree(wbuf);
 #endif
 
 	return 0;
-- 
2.7.4

