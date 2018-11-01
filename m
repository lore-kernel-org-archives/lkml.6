Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3436C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760A32064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 15:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RfOnD/NO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 760A32064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbeKBAp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 20:45:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40563 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727950AbeKBAp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 20:45:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id o14-v6so9202948pgv.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 08:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RC92vL8QvvqnjQ8w3b8PwZCx2i+sM4l1FarSO3qj2u8=;
        b=RfOnD/NOlhMNg1XUg99GiOgXy5n6ioW+dhxYN/uzOdhb6WHbXfi/CnDHx7JkBKf8vL
         o/6CAj6AUvR89uz5nA3e5Ai77mQo7Bkh7cMZHywJ+lS4RFyKH4L/59VYOXQ7VUql1xUC
         ILIiMbXaEE6iWjiGU27he+eCaCcUAldqLLL7YeucG9RxmHPpsprGRJjnvJCsmZksMayz
         2ifD6JZEl5MNOcRCnmh80UO58Li5FUOOf/2flfntD2Ip/BO2HgKNHHnpKvdoUizLunex
         mxzer9LS15IaXN/3CGEwNqnheL7pUdMz9jdy+FRSi56H3BX4Z0Utcg5DbUJo3HvU4O8L
         /Pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RC92vL8QvvqnjQ8w3b8PwZCx2i+sM4l1FarSO3qj2u8=;
        b=H7z4+Wdmqxkd1spZO6hrrrGvtH/nFhdGhp0PfNxMS0/fSivXvPUQ7+Lqh2bAX/KkCz
         izQJq7XYdHVX89RG1KJLLA2szzcip7vOJlCsB9PkYExZR4BQ3DHl/BhWhe+hjVXwmCBe
         vxQzRh9FMnePcFaWNxKFfaatJ+G/GvGEGwSFBvDBZiN0bbwKiPzuV5A23EShKNjYImtS
         W6El0b1T+MXZgcU3uwblwtLMUI3MAX4C0KeCVcRyqcVYAerIbcN/OeJ/k9OhTUFTXJA+
         Ze9ey8d3RqV+MFoJAgq98hNccLKgVhwUfeLGH7UG+TigNma/RlspTTuAp1TWZ52QGRyN
         vbMw==
X-Gm-Message-State: AGRZ1gIcAkLRbp9lKjXOMDM4pb+TK01P8LeoWXj1R3Linl4DF6LrzgIb
        BwaEYHIa+1blHAGAoBxWyGQDqrZMxzo=
X-Google-Smtp-Source: AJdET5dHGaTSyJuRJvLGEBbFr6OjtvkPGU6tms/6+YNyMMyjNOdJ9TVPDCL7X2kaTo46vf35Lgrcow==
X-Received: by 2002:a63:e348:: with SMTP id o8mr7508070pgj.158.1541086917082;
        Thu, 01 Nov 2018 08:41:57 -0700 (PDT)
Received: from localhost (68.168.130.77.16clouds.com. [68.168.130.77])
        by smtp.gmail.com with ESMTPSA id 145-v6sm45160637pfw.17.2018.11.01.08.41.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 08:41:56 -0700 (PDT)
From:   Yangtao Li <tiny.windzz@gmail.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH] mfd: fix small typo
Date:   Thu,  1 Nov 2018 11:41:53 -0400
Message-Id: <20181101154153.23042-1-tiny.windzz@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/mfd/rave-sp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/rave-sp.c b/drivers/mfd/rave-sp.c
index 2a8369657e38..26c7b63e008a 100644
--- a/drivers/mfd/rave-sp.c
+++ b/drivers/mfd/rave-sp.c
@@ -109,7 +109,7 @@ struct rave_sp_reply {
 /**
  * struct rave_sp_checksum - Variant specific checksum implementation details
  *
- * @length:	Caculated checksum length
+ * @length:	Calculated checksum length
  * @subroutine:	Utilized checksum algorithm implementation
  */
 struct rave_sp_checksum {
-- 
2.17.0

