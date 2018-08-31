Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39412C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB8420837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 20:16:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uxfEgYwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB8420837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727641AbeIAA0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 20:26:01 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33513 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbeIAA0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 20:26:00 -0400
Received: by mail-lf1-f65.google.com with SMTP id m26-v6so10923098lfb.0;
        Fri, 31 Aug 2018 13:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ptqFnecF06zJ9iUyMB1LOtz/ekDCfziX44fElmoudaE=;
        b=uxfEgYwk6tfMQlXAe/jQXUZ+G9wO2llBsX/IS2EoLC4yrl6lo0KxDXuHTnY7Ggjuh1
         W5vQiq1qteW/HPT9+Yy9apgvDGfLz5Tt1A9kbWj6KRPSR5abRqVijOIkVxcc4puHdyb2
         10N2Luzo/6IVsMLGWlhLpcDfwgOPjXxHwBwjuOv5RisDmvKb8J5CSooiVMhMWFtnxdj7
         UJwFi2z2ngjNwFpu5DcevqmBTxjuUpm/DqFnidmlktF+tEZt90uUTBnu1Zm/xLAAosy+
         9qErWrJdQF+8waZ1BGulda09vOTShh0iXSNQ3wwgWxn6+8Le1uDpmbRdSiUjsuuslSey
         KpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ptqFnecF06zJ9iUyMB1LOtz/ekDCfziX44fElmoudaE=;
        b=qYbfjcbVE8m1Chjkt0G/iuDPz+62MAod+JxtJwI8EzPhdtV/VP4nbegAKISOg2IeW5
         kHKJPPtFJjyxEvI/a17jAos222wCsLk0mLTYLKHRHY4Hd9KiF+9zWb7IMMETT4Kd3nzW
         JuQ6rzDu7sPyV/55FuNhkJCY0mVOeZ5JA2QEXS1+jU+fxiZopJ2Csl6SJNXmjJjH4udp
         LfOJoCin7dY+a0PJECkPCls+OiFY2pB5p2VDlkuiid9baLpjSZasVTtqiTxLcDzXj8Q/
         w6tCCz69DeeLf25tEpyeDAsQyPquVaouTVHlKJZAmEhObf5m5dMcuqK25y6toBQwEDXJ
         heKA==
X-Gm-Message-State: APzg51DpbNaWbU5DzMp183ZMWvXKYGW+8qv9YDS856w21j8Rnu4YRHBQ
        tue1MJdJcUmzuWA+aDttDz4=
X-Google-Smtp-Source: ANB0Vdaf63jPbYdAbrEpU6fLG9yNG0yPNjW/8JPhSX08ZgA3/2Xf7dscO9pPKFocSNX4sVsMYlqA2Q==
X-Received: by 2002:a19:1a52:: with SMTP id a79-v6mr244810lfa.139.1535746614066;
        Fri, 31 Aug 2018 13:16:54 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id m31-v6sm2060755lfi.17.2018.08.31.13.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 13:16:53 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] infiniband: scsi: remove unnecessary unlikely()
Date:   Fri, 31 Aug 2018 23:16:45 +0300
Message-Id: <20180831201645.15611-1-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to
wrap it into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Cc: linux-rdma@vger.kernel.org (open list:SCSI RDMA PROTOCOL (SRP) TARGET)
Cc: linux-kernel@vger.kernel.org (open list)
---
 drivers/infiniband/ulp/srpt/ib_srpt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
index f37cbad022a2..447d21ea479a 100644
--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2708,7 +2708,7 @@ static void srpt_queue_response(struct se_cmd *cmd)
 		break;
 	}
 
-	if (unlikely(WARN_ON_ONCE(state == SRPT_STATE_CMD_RSP_SENT)))
+	if (WARN_ON_ONCE(state == SRPT_STATE_CMD_RSP_SENT))
 		return;
 
 	/* For read commands, transfer the data to the initiator. */
-- 
2.17.1

