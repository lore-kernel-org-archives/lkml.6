Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5662C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 04:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2312081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 04:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H17JttJV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A2312081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbeLKEUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 23:20:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40002 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727566AbeLKEUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 23:20:43 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so12614443wrt.7;
        Mon, 10 Dec 2018 20:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i165TCYKHA9gAwbRTOvrZg2Z7ZMrwAfkcsKJ8hDYaGY=;
        b=H17JttJVorHQx1d5TAt4Xps9WO4f9ENxcOT5bU6ES7wGXCYGfU+e3AI/HZVJoF9H79
         1agmESyRelm+kqUXnyYVDBECTZsGAY09NMWxthZ+ItZalWHrGNXZLnZ8CV1nWa/WCXpK
         uFdQGQxTGh53kfxzUug0sFwYCROrIAz1f0QdQ1vG+tiXLl5ZXVtgDawlkn5r/OjcJBh9
         M1dPg1sKpba7dXooMHgLkztdWlH4bqmYxvvvjlPpz/A4shKihmER6BAmo/gp0BL2C/tj
         tQA+XMCWjjm4h44ARTSGtsVOBuPmM629lxAzkHGkB1e+bwO/FwnGfP5IDDROzeEChyHD
         R1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i165TCYKHA9gAwbRTOvrZg2Z7ZMrwAfkcsKJ8hDYaGY=;
        b=Ls82twyNbnsc4zKnSmKpP7ex4kmjbe0ywkBK3Rt7OPrKS5B4jAyThe1o86c6/5GrrU
         ZyopQxVYFw4VYSi7/xkIUQCU4OJDzZ8bQ/XgQINlHMfZZvrqzOL/2za4mG6SeMqzuFzA
         3IviYSIUNHPo+JHmbidpcGWprbsqiXHQ8nxwqqGYmQC/hzddJ53uPvR41mj5r1d3Tak1
         SpoXxEsrHG4fDRDPT81xbRKlWDP5HR9d/CqdFrwipKjZVCDOkOCBT73KJ5J62iM+B7E5
         16oEUGv2SjCpR8M0pB5+u35TgZ9kTICdw7JbW8MQ/OpfCV3xupHKb0xo1DovslGpuUt7
         nmiQ==
X-Gm-Message-State: AA+aEWbeGbsYI9RJDQp21X2sYgSABBt5LyXz2l5bdP6XD1zqVbyAvf3v
        cuyrmgxGtvhCc3eEHMPiHHsoDHs9vX7cOQ==
X-Google-Smtp-Source: AFSGD/UaAhzcqtu8j26I5iWpeqG2VbZJGQdDSmHPyHfKg/zLLA+4rRgVFMtyDATR4Fq4G/2/uVx+3g==
X-Received: by 2002:adf:afdc:: with SMTP id y28mr2869942wrd.275.1544502040832;
        Mon, 10 Dec 2018 20:20:40 -0800 (PST)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id c8sm9270982wrx.42.2018.12.10.20.20.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 20:20:39 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Iyappan Subramanian <isubramanian@apm.com>,
        Keyur Chudgar <kchudgar@apm.com>,
        Quan Nguyen <qnguyen@apm.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drivers: net: xgene: Remove unnecessary forward declarations
Date:   Mon, 10 Dec 2018 21:20:30 -0700
Message-Id: <20181211042030.13712-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/net/ethernet/apm/xgene/xgene_enet_main.c:33:36: warning:
tentative array definition assumed to have one element
static const struct acpi_device_id xgene_enet_acpi_match[];
                                   ^
1 warning generated.

Both xgene_enet_acpi_match and xgene_enet_of_match are defined before
their uses at the bottom of the file so this is unnecessary. When
CONFIG_ACPI is disabled, ACPI_PTR becomes NULL so xgene_enet_acpi_match
doesn't need to be defined.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/net/ethernet/apm/xgene/xgene_enet_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
index 3b889efddf78..50dd6bf176d0 100644
--- a/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
+++ b/drivers/net/ethernet/apm/xgene/xgene_enet_main.c
@@ -29,9 +29,6 @@
 #define RES_RING_CSR	1
 #define RES_RING_CMD	2
 
-static const struct of_device_id xgene_enet_of_match[];
-static const struct acpi_device_id xgene_enet_acpi_match[];
-
 static void xgene_enet_init_bufpool(struct xgene_enet_desc_ring *buf_pool)
 {
 	struct xgene_enet_raw_desc16 *raw_desc;
-- 
2.20.0

