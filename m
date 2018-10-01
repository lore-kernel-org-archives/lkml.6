Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27EBEC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:01:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90EB204FD
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90EB204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbeJAWjg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:39:36 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33667 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725735AbeJAWjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:39:35 -0400
Received: by mail-ot1-f65.google.com with SMTP id m23-v6so13650048otf.0;
        Mon, 01 Oct 2018 09:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Nf4PT5shDPf/+hVggaq9t0eJSg99Emg2bpVIC5H56Po=;
        b=LSFvBpARdlg2y3RG42SJ605Gi/4veT8y2nAPBd3l0QETqnSUHTrXWejOxqOV0nE4a1
         UmnwwvlYuZkSv8oqgjQ64pCVw8JNj43jHI1z6A3+uVXAuQaWqZSTJR1NL40T7z+4ROIB
         JMJod8Lk2aHhAEgInXHXnxZ+iN0MML6ffQ2CG4FQWpaKcm7KxEZvES5k/iY57feWQg6G
         LFZ2sGmwyc294SKpaS15GybAZEfZaxjGlQv301eiSDjeL1SKgx8zffR0KMUAGHRaNVIQ
         6NcsGZjVjtV51bD8/6SUXJhHkfpdzDDHrMPNNr5npxohIC11sKNacI1+A4Um8lbTo9tK
         gXCQ==
X-Gm-Message-State: ABuFfogYRFHVYjG6agcLL06az0mABuSR1FOM074fZ8vjTKqXVkWtr1Sr
        kS7i5BD6KyvMF1ggGPdm+NMeGAaFxw==
X-Google-Smtp-Source: ACcGV62dDoBWge13Snu44fjlB7hKC42Bq5ydZ9VuakE8bb/28f2h/9fhXbc8yNUY5eFEBSUzEaLs9g==
X-Received: by 2002:a9d:36f:: with SMTP id 102-v6mr7176346otv.310.1538409666193;
        Mon, 01 Oct 2018 09:01:06 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id u17-v6sm4510946oia.43.2018.10.01.09.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Oct 2018 09:01:05 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>
Subject: [PATCH] of: Fix property name in of_node_get_device_type
Date:   Mon,  1 Oct 2018 11:01:04 -0500
Message-Id: <20181001160104.22573-1-robh@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0413bedabc88 ("of: Add device_type access helper functions")
added a new helper not yet used in preparation for some treewide clean
up of accesses to 'device_type' properties. Unfortunately, there's an
error and 'type' was used for the property name. Fix this.

Fixes: 0413bedabc88 ("of: Add device_type access helper functions")
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 include/linux/of.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/of.h b/include/linux/of.h
index f581531d797e..04cef4490efc 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -991,7 +991,7 @@ static inline struct device_node *of_find_matching_node(
 
 static inline const char *of_node_get_device_type(const struct device_node *np)
 {
-	return of_get_property(np, "type", NULL);
+	return of_get_property(np, "device_type", NULL);
 }
 
 static inline bool of_node_is_type(const struct device_node *np, const char *type)
-- 
2.17.1

