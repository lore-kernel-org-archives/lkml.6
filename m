Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE50C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3AEA26932
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 11:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aO2MCVoS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3AEA26932
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934845AbeFZLis (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 07:38:48 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34576 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934556AbeFZLir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 07:38:47 -0400
Received: by mail-wm0-f66.google.com with SMTP id l15-v6so15031200wmc.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 04:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=uWZD0fkPL3tst0V/VPLp6biYOcHEuJtoKACaWNvtcHY=;
        b=aO2MCVoSCAqYKEUBWd/Nli1/mV9vbP+ADJqXtTw1IcxCqc22qlJNDzgM4oGQQ1VPR9
         2Arg8TcuPfP65Zet2G4sMw6Ox3FnSSmAOi1rv78IpBLMgb1JNyhjp3raStZnwWQm6GhG
         dwv+6NxljvBKQJE7ZQ54j6HHvH5hMIb1eXDBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uWZD0fkPL3tst0V/VPLp6biYOcHEuJtoKACaWNvtcHY=;
        b=q/B3ERl7Kv7aAotXM91UbOCl+RevpN9Bip0bJ5lXDHVcB1Y8fWOLsRs+Uv2ZR+gX9W
         cUrpdXimlEVF8B2mil/XLbQf5pjCGzIfB6LcW9nAn8IMOfLMYxe/5VUBJGr5/I1ukuEy
         VbNwuwoW54T3pBfJ2uTY1USJQH1w0H3fTXOOZEctV1E/zvOAhqg1arIw/10r018+vBS/
         PeOleMyU3ueK0QhTcpKbqqBIgkZLBoVt0ISSipdC5ed01AdxQlBp+mEN7dkwRrVkRPne
         JqrJAujrS0dgvYHXEIKWEwBV+tt/3Nlj2ljobk2Sj6pWJo6taP2NCMLGtuHUf8HejJir
         GEmQ==
X-Gm-Message-State: APt69E0U+CBEf0eUqvSnXwQWrvv0KpPrqOL2R81ewJN2FiW3bO1YZVfG
        AUcRB4kFhDAMOcV5pTfrWFCDzg==
X-Google-Smtp-Source: AAOMgpfKrUKTay6i3vksdn4JxApZgzlIhwZxTlqMoKhUqgcQyg/XY103n8K16EPxzzV8iQV1GkPAqQ==
X-Received: by 2002:a1c:9253:: with SMTP id u80-v6mr1411966wmd.52.1530013126218;
        Tue, 26 Jun 2018 04:38:46 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id p4-v6sm1057426wrj.71.2018.06.26.04.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 04:38:45 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, bgolaszewski@baylibre.com,
        andrew@lunn.ch,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] nvmem: core: remove unused nvmem_device ncells member
Date:   Tue, 26 Jun 2018 12:36:40 +0100
Message-Id: <20180626113640.24825-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvmem ncells can be over written by calling nvmem_add_cells()
multiple times. I see there is no real point of maintaining count
of cells when we have a list of cell.

Remove this to avoid any confusion!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index b5b0cdc21d01..34b71b1c69f4 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -31,7 +31,6 @@ struct nvmem_device {
 	struct device		dev;
 	int			stride;
 	int			word_size;
-	int			ncells;
 	int			id;
 	int			users;
 	size_t			size;
@@ -389,7 +388,6 @@ int nvmem_add_cells(struct nvmem_device *nvmem,
 		nvmem_cell_add(cells[i]);
 	}
 
-	nvmem->ncells = ncells;
 	/* remove tmp array */
 	kfree(cells);
 
-- 
2.16.2

