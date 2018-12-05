Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0A5C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6426D20850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544039463;
	bh=6643YHTtYytPGQYQEuzzD3rtsiW+zmf9mhYKyJUDH+8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1xuPY9amb5tAoZ5H1wvp4xm3AQcS4I0S7PTvj6mIbDauG3Nu+xQipXlT8qSUHJ6dY
	 OQUao/WQpnjwh21lS2c9KbTzpM55hdsNx/Eby0fWLTmOKYGhmtjSL3TuF2jSrQlewU
	 K7HG5PI+3ZJoWIxzabpZLR1Sgeo4xQw6Ic0SS1XY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6426D20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbeLETvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:51:02 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33053 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728628AbeLETu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:50:59 -0500
Received: by mail-oi1-f195.google.com with SMTP id c206so18672388oib.0;
        Wed, 05 Dec 2018 11:50:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ipiihTdwGrlX+ons2IhQ9+ZcJCpVaVxx2iEVJRMYgr4=;
        b=eaEZ34Ro07sR7yL6mCKxdvhDJ91uB6I4fUlpM6asTZXp5jxL6Cr8fsmrKZpd6I6HkC
         jj1TshYTXNpeCAb25ukPd4YQej5JBLRxQWbT6FpIqV911Wm6R509ONCXQyNafTBmgQVF
         ojiniVAI8++Kzx/96vo7r5kvH6Gn5ZMLv7BeOEGAZlqhgk6zxyp/O8plHY34OvQrNu6N
         zaSafsekFKfF59qumsWot2hEyal6ZnVUx1poDAcwTnZ2kgPpL+4Rnob0iIgE+xOOemCj
         6qbxdvYumxXLOMIShBr7407Qv/C65r9DP+xRaWydM7ozrtgCoAjaK8fy8mB6ns4pAQM1
         GwTQ==
X-Gm-Message-State: AA+aEWY4tS0G2+dGGlSavtfe+z8rEZ4NP2+zOevGMJaFiiDlxCcP9oIv
        JmkG9l5dB6ggr1mamSVJY3Tq25w=
X-Google-Smtp-Source: AFSGD/UZvxBqCY3JOfT6rY2Quj+tFDglL3wTaHZAdpELyGuR1Pk+5RHWz0USV747XbenS/KHVaYvrQ==
X-Received: by 2002:aca:e401:: with SMTP id b1mr15022730oih.231.1544039457753;
        Wed, 05 Dec 2018 11:50:57 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id k13sm25759879otj.19.2018.12.05.11.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 11:50:57 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH] devfreq: Use of_node_name_eq for node name comparisons
Date:   Wed,  5 Dec 2018 13:50:22 -0600
Message-Id: <20181205195050.4759-6-robh@kernel.org>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

For instances using of_node_cmp, this has the side effect of now using
case sensitive comparisons. This should not matter for any FDT based
system which all of these are.

Cc: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/devfreq/devfreq-event.c     | 2 +-
 drivers/devfreq/event/exynos-ppmu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index d67242d87744..87e93406d7cd 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -240,7 +240,7 @@ struct devfreq_event_dev *devfreq_event_get_edev_by_phandle(struct device *dev,
 	}
 
 	list_for_each_entry(edev, &devfreq_event_list, node) {
-		if (!strcmp(edev->desc->name, node->name))
+		if (of_node_name_eq(node, edev->desc->name))
 			goto out;
 	}
 	edev = NULL;
diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index c61de0bdf053..c2ea94957501 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -529,7 +529,7 @@ static int of_get_devfreq_events(struct device_node *np,
 			if (!ppmu_events[i].name)
 				continue;
 
-			if (!of_node_cmp(node->name, ppmu_events[i].name))
+			if (of_node_name_eq(node, ppmu_events[i].name))
 				break;
 		}
 
-- 
2.19.1

