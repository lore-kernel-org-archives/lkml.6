Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D81C5ACC6
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7148214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 01:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uQVuRfKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7148214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbeJQJRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 05:17:45 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46049 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbeJQJRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 05:17:44 -0400
Received: by mail-pf1-f194.google.com with SMTP id u12-v6so12306999pfn.12;
        Tue, 16 Oct 2018 18:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jpZN/UlmIedOp/RKX94XiVdcF9ZfG+QGI91FHkbRWhk=;
        b=uQVuRfKtHlivOgY0ZxSOL9P+Hxz4gRsS2sD/9p0zKKEsIc6ZmC5IuhVYWLRVmUsbc8
         68JSzV2PfmYzj/saIZcAjhnpJ4yKxEkGComQyCOnWDGkBXF8iwEs3axTdI94YRFkPDRR
         v55r5B7VJ1drDS3topuadQJPFtlctvYrCQmfwUzJuNy/4OB/RQyvpdExIZuCCn3Tb6Ia
         1ZpekuXBaaV83/lD0icqDODzwTdHIqQbeBQgyW4rDVIxBuv0HNlWRIf4d7X+DsjOkbIy
         Bb6Yr+wLGPj6RgTqHMDTdkdyCVHWPQcch4RTnu4WUeeNfdQ7C2GnoYOBOHfNHHOoAs4I
         sjbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jpZN/UlmIedOp/RKX94XiVdcF9ZfG+QGI91FHkbRWhk=;
        b=Yabwtaiz8woRV13HMt4KqWlM83WOhCmeg6TapxlNYVBaepm9BnkJdYf8ePlbaXUJwf
         WYr46AMURpR4Ik43xCTtODeLOYyWugT6mY6bTADSkLpCBmtUlCJnA36tNSyPL4ioLTkX
         h0VeSMtVW1/QWqcH7/qLszqno4x2i/S4AjJmgIoRJvGe51RmgojE3iYkKzL5zpPA3rYb
         MqmP6DfKRseeVUU6gpX+LI/bmoXMmAGCgkFujQxioMyWxhFPgwZuzRPNS6mv/Y469YI4
         xq0ixNFZA7xqbtBhlthY/La+kR1LNes1CvNNB1D0LNLtbI42Kt56uydy8CPmxPEwjt1H
         ThDg==
X-Gm-Message-State: ABuFfoiTM1oDo4zVQMlQK8zmPcaMpfLsGrgPasN9a06Kx3+SReL2SMWQ
        g21w0OGjmgwwdZgXZ7NzOCE=
X-Google-Smtp-Source: ACcGV62dkkPktNSuueU1ZXn0foP9qAQS7q6lJUax7eTR8b1CYQLGgSa6Gt0TlpFE97ivKlG7DrUPXQ==
X-Received: by 2002:a62:15ce:: with SMTP id 197-v6mr15679172pfv.222.1539739473915;
        Tue, 16 Oct 2018 18:24:33 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n64-v6sm22841851pfi.185.2018.10.16.18.24.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 18:24:33 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] hwmon: (core) Inherit power properties to hdev
Date:   Tue, 16 Oct 2018 18:24:22 -0700
Message-Id: <20181017012426.26958-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181017012426.26958-1-nicoleotsuka@gmail.com>
References: <20181017012426.26958-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new hdev is a child device related to the original parent
hwmon driver and its device. However, it doesn't support the
power features, typically being defined in the parent driver.

So this patch inherits three necessary power properties from
the parent dev to hdev: power, pm_domain and driver pointers.

Note that the dev->driver pointer is the place that contains
a dev_pm_ops pointer defined in the parent device driver and
the pm runtime core also checks this pointer:
       if (!cb && dev->driver && dev->driver->pm)

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/hwmon/hwmon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 975c95169884..7c064e1218ba 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -625,6 +625,9 @@ __hwmon_device_register(struct device *dev, const char *name, void *drvdata,
 	hwdev->name = name;
 	hdev->class = &hwmon_class;
 	hdev->parent = dev;
+	hdev->driver = dev->driver;
+	hdev->power = dev->power;
+	hdev->pm_domain = dev->pm_domain;
 	hdev->of_node = dev ? dev->of_node : NULL;
 	hwdev->chip = chip;
 	dev_set_drvdata(hdev, drvdata);
-- 
2.17.1

