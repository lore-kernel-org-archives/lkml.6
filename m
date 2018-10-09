Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E683BECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE84214DC
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNn7mfry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE84214DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeJIXqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:46:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36936 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbeJIXqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:46:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id 185-v6so2687440wmt.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 09:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2OWozK8lncn2tVCdlXSBXoTDRtVUMNg77hvggFKV1zs=;
        b=uNn7mfry3wKSwo98eAar+KCDtaVLI60ohm3SF9HZd0ZkUXTjxx9ra5AgDhBMAQdYAr
         nwh8xmidlSvg/oh0AcesVsyyfiBe1aXcFFpOoSGYPJFXjoLaZtiEGS0Rz6k5mzt3vtN2
         OHFUp3Z9PqXmkWolI1MjCVkS/iAioUA/m2rLKWg6fnYrVCyqwU8KFe7m7bZqHc0yymua
         KYs0H6DM7hZU+2hq5x/nuu3XZdsR941kz3Dy9MvbByFON3gKThsr8WqATOzJu15HklE0
         eozjjQfk0Avnl4xBHI00vd1msYmqC0gErxSyLfeda3x965SglAdGIdLVv7bQ3yH9BL1+
         jlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2OWozK8lncn2tVCdlXSBXoTDRtVUMNg77hvggFKV1zs=;
        b=oaSCi4+Hn+ROc45VCn9XoFJY0eTO4hWVhXww8uqgJWSLfPQfmAurzIYmAGIGygA66U
         Q9Cq7rvbQtn8liQ4vf6K5ev6E3icGsufbN0gHUbpvCs4PNUB8g3nkZ3hEhb3s7vEth5w
         W/H3RqbIqLQ+IH6JA3ud1s+gUixezrw9gUPPw+g7If/yxVa/p4i2vaMgKAixkunXcV9t
         T5LoVrmE2K7TMvWQalW4SD17qT0GoBZN4DajU9lvW1KeURZdSDbIg1BXdJeGjPMc1pF9
         8hpjg2/k6fXRfWa4y8wYzm5NRBxgYvCKDXB6eKj7IO+r7Eyarn9xEQcwsSbEYVyqX7QS
         8jBw==
X-Gm-Message-State: ABuFfojd/bKAc2x+em0UlU+hPmNvbkNAzxkwps8LQlvh/uysr5lXGQ2K
        vqcG3CiadaK4Bke8crDdAvs=
X-Google-Smtp-Source: ACcGV62NYdp6F+J9tG0w32x+rZAHmesgEYnXpxPAUHKAfW5rDVkcFsKlzq5xPSi7DzAjs5awumk3HA==
X-Received: by 2002:a1c:af07:: with SMTP id y7-v6mr2641280wme.33.1539102540509;
        Tue, 09 Oct 2018 09:29:00 -0700 (PDT)
Received: from kheib-workstation.mynet (bzq-109-64-21-122.red.bezeqint.net. [109.64.21.122])
        by smtp.gmail.com with ESMTPSA id h18-v6sm18082694wrb.82.2018.10.09.09.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 09:29:00 -0700 (PDT)
From:   Kamal Heib <kamalheib1@gmail.com>
To:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-kernel@vger.kernel.org, kamalheib1@gmail.com
Subject: [PATCH rdma-next 14/18] RDMA/qib: Initialize ib_device_ops struct
Date:   Tue,  9 Oct 2018 19:28:13 +0300
Message-Id: <20181009162817.4635-15-kamalheib1@gmail.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20181009162817.4635-1-kamalheib1@gmail.com>
References: <20181009162817.4635-1-kamalheib1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initialize ib_device_ops with the supported operations.

Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
---
 drivers/infiniband/hw/qib/qib_verbs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/infiniband/hw/qib/qib_verbs.c b/drivers/infiniband/hw/qib/qib_verbs.c
index 8a45964c4700..8fe2519e34d9 100644
--- a/drivers/infiniband/hw/qib/qib_verbs.c
+++ b/drivers/infiniband/hw/qib/qib_verbs.c
@@ -1496,6 +1496,11 @@ static void qib_fill_device_attr(struct qib_devdata *dd)
 	dd->verbs_dev.rdi.wc_opcode = ib_qib_wc_opcode;
 }
 
+static struct ib_device_ops qib_dev_ops = {
+	.modify_device		= qib_modify_device,
+	.process_mad		= qib_process_mad,
+};
+
 /**
  * qib_register_ib_device - register our device with the infiniband core
  * @dd: the device data structure
@@ -1626,6 +1631,7 @@ int qib_register_ib_device(struct qib_devdata *dd)
 			      dd->rcd[ctxt]->pkeys);
 	}
 
+	ib_set_device_ops(ibdev, &qib_dev_ops);
 	ret = rvt_register_device(&dd->verbs_dev.rdi, RDMA_DRIVER_QIB);
 	if (ret)
 		goto err_tx;
-- 
2.14.4

