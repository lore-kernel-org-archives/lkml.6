Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B64BC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEDBA206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 02:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+7ieaIV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEDBA206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbeG0D6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 23:58:52 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:37236 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731994AbeG0D6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 23:58:52 -0400
Received: by mail-pl0-f68.google.com with SMTP id 31-v6so1657026plc.4;
        Thu, 26 Jul 2018 19:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=U/8EoisJiNq1/K+lxiMq3yA2CfsmBsV97hxFEcc1F9s=;
        b=P+7ieaIVd07WkS0XWvfiPYWgrwl8ijwgtXnNRNoKSvEgU5Xptc8CATUz5oHuU8qUXu
         /2farl/x0EAo4PV7DIbU1RoLFxdi+l2u2pU2ZAX6FlrxJAWMHO2rdwt3tf8j06j1WBQ5
         mkBXzMlce2HYYKriPAb3sEr9HbrnChLwNYA3zXU63teQhGLejf1EN9mkLJJyD92ndSIa
         ReLGIqoNL7TntQsq1pM4Z0wvDS5Mq6GFA9WMD4IZHpTgZLZAXR7v4CvQKAAL49L44Vqb
         4nUHH+X7MgPUHvaiMFJGnCowKOy8YRoEdKV/lcI/Ryalc7qSdBIm6IrW89DnjPgEvjny
         Wb9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=U/8EoisJiNq1/K+lxiMq3yA2CfsmBsV97hxFEcc1F9s=;
        b=c3oFV7mrElmuVMYrp8SGTO3RiMUom0HNlmRctjORNqyKeAZTpBlAcmuQWvNTSA8dMN
         IhVyXzFdgJ+agfF1TeHYhXqyhRr9sQQr0Dlpwb0tRQ0DhXDjLkAd2A3evuOV34lZ6YLb
         /VC9QdJhuNlia8tFH1ptrO230Spf8o5Buno8OVRGwLwbCZqrkbN4Lck/CYbwNPSz44x3
         3SOqKXap9vIoRR5gXdKwNKFYQluffGMSD0EdW7hCMtofPTnyYkphw/dQgIRXFAEBDdLN
         UWr0yHSGA2IvqhTu6gEplfiZNleUhgeWgtUAMAIROoTipt77XPbkezCD7oI5IDx0H9cw
         JHAg==
X-Gm-Message-State: AOUpUlGyopHmfH+00fB0zH6WAONLgAmAlep+oHPqmOKILct1ORqQG3Mk
        2g65WPfLqNoA9rkdw+C6DCE=
X-Google-Smtp-Source: AAOMgpfkijHESp0cJDaCURPHCX6J+ijsvTu8tkmaC6bQcCwfgOzM4S3dul/cQM3yWq3SQ9rDmF5LoA==
X-Received: by 2002:a17:902:6e16:: with SMTP id u22-v6mr4128507plk.13.1532659155564;
        Thu, 26 Jul 2018 19:39:15 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id g11-v6sm9575217pgi.90.2018.07.26.19.39.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 19:39:14 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     isdn@linux-pingi.de, keescook@chromium.org, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] isdn: mISDN: hfcpci: Replace GFP_ATOMIC with GFP_KERNEL in hfc_probe()
Date:   Fri, 27 Jul 2018 10:39:06 +0800
Message-Id: <20180727023906.1590-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hfc_probe() is never called in atomic context.
It calls kzalloc() with GFP_ATOMIC, which is not necessary.
GFP_ATOMIC can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/isdn/hardware/mISDN/hfcpci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/hardware/mISDN/hfcpci.c b/drivers/isdn/hardware/mISDN/hfcpci.c
index 34c93874af23..5a2e2455761f 100644
--- a/drivers/isdn/hardware/mISDN/hfcpci.c
+++ b/drivers/isdn/hardware/mISDN/hfcpci.c
@@ -2219,7 +2219,7 @@ hfc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct hfc_pci	*card;
 	struct _hfc_map	*m = (struct _hfc_map *)ent->driver_data;
 
-	card = kzalloc(sizeof(struct hfc_pci), GFP_ATOMIC);
+	card = kzalloc(sizeof(struct hfc_pci), GFP_KERNEL);
 	if (!card) {
 		printk(KERN_ERR "No kmem for HFC card\n");
 		return err;
-- 
2.17.0

