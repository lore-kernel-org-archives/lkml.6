Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 7Z21BKo1HlsuHAAAmS7hNA
	; Mon, 11 Jun 2018 08:42:46 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4E093607BB; Mon, 11 Jun 2018 08:42:46 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0wtaMN1"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9968F60385;
	Mon, 11 Jun 2018 08:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9968F60385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932545AbeFKImm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 04:42:42 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35844 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932277AbeFKImj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:42:39 -0400
Received: by mail-pg0-f66.google.com with SMTP id m5-v6so9409884pgd.3;
        Mon, 11 Jun 2018 01:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1zZqQVbIflai8UKGfLModv4cFzr21IsS9JYm+ux3D+A=;
        b=E0wtaMN10tn4JIJxW8IvuXpZfM7N+G46n4PE5Bcoh5ComyjtneuQBwifedRSeHFg9J
         lsmB4QoD/xC7vPC3eh0MWMlU5rrgo0ZW9IjRR5CNF2/2PP9gGP61NJgSPka4oifU4T1w
         WYKclHwejxuBGMzmWec6dqPMzm7ipYgvx8JZN2yTApc7Zrf49YP+iHbspfNO+GQJRaij
         pUChC0kaRqNGv1KlFHZPgW5j6PacwcYZyYDRMtPHvHeV4d0ZvIGYj6cqvL4Cu7u0+TjO
         1Wgvb5Ww+b2TSgvHH1pBx7RilWFdrn15bTYfXKIDENYcrcwwpkN7qEtflzzDa/4Yr7/0
         KV9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1zZqQVbIflai8UKGfLModv4cFzr21IsS9JYm+ux3D+A=;
        b=cw8klxBtdbQ3c1SMmubP4h1/fYtgsOzoeI1RivwTuETcIisNPM36MPudVyEh6iK1so
         EIns/fKhwZILxY9OFvakMicKH53ECs9vZQdNWux4a6bsOckmNp550IbOyxhFITfenYs2
         GhQ8XmJu3f6WqE0Rm024qXmVmQC+ZRuMWplcx4IaZrYygVr3A2TY24Ht/pfYBD8Tb1GT
         oHerRY8XAXA/PgBurkrYSA6Y+GKdSWPYJXrCim+NOtxBLLihQVBKNrjW6qjFWiEnG0hj
         oU4kiW8w03919SEbBW4CGY6zgrDWeEafKb+cIPOizRZQY/mhk65zE+ntngo0FuOvh5vL
         VUrw==
X-Gm-Message-State: APt69E26WTKBx9j14dOHRXyK3TiZs3bANqDdV6IeAlMXXkyYNP9jiCdv
        JOCQYJLRhfGwqseEY/oy1PlbpmBN+DA=
X-Google-Smtp-Source: ADUXVKKX9DT+k9jwbnNsbAez0N93maZGpCNzBEO7Z5EwW+k72IZh8LpFZpzGLXYK4d7Tch6HtBx4GQ==
X-Received: by 2002:a65:4cc3:: with SMTP id n3-v6mr13806871pgt.98.1528706558668;
        Mon, 11 Jun 2018 01:42:38 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id r11-v6sm73258289pfb.139.2018.06.11.01.42.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 01:42:38 -0700 (PDT)
From: Zhouyang Jia <jiazhouyang09@gmail.com>
Cc: Zhouyang Jia <jiazhouyang09@gmail.com>,
        Santosh Raspatur <santosh@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: cxgb3: add error handling for some functions
Date: Mon, 11 Jun 2018 16:42:26 +0800
Message-Id: <1528706547-35243-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When sysfs_create_group or alloc_skb fails, the lack of error-handling
code may cause unexpected results.

This patch adds error-handling code after the functions.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
index 2edfdbd..bb51b7e 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c
@@ -545,6 +545,8 @@ static int init_tp_parity(struct adapter *adap)
 	if (skb == adap->nofail_skb) {
 		i = await_mgmt_replies(adap, cnt, 16 + 2048 + 2048 + 1);
 		adap->nofail_skb = alloc_skb(sizeof(*greq), GFP_KERNEL);
+		if (!adap->nofail_skb)
+			goto alloc_skb_fail;
 	}
 
 	t3_tp_set_offload_mode(adap, 0);
@@ -3362,6 +3364,10 @@ static int init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	err = sysfs_create_group(&adapter->port[0]->dev.kobj,
 				 &cxgb3_attr_group);
+	if (err) {
+		dev_err(&pdev->dev, "cannot create sysfs group\n");
+		goto out_free_dev;
+	}
 
 	print_port_info(adapter, ai);
 	return 0;
-- 
2.7.4
