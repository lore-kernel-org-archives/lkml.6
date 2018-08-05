Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61264C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BC5D21925
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 20:08:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhFSiAwN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BC5D21925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbeHEWOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 18:14:12 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35822 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeHEWOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 18:14:11 -0400
Received: by mail-pf1-f193.google.com with SMTP id p12-v6so5790066pfh.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 13:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5l6e3aqrhUGYgPUgkdtnGYKFYS/VGvbquZsriioq4lk=;
        b=qhFSiAwN+orjnbAVl1vGuVBPjGyx2jbnG5xVG3Hiu4ZlbdNKVgE1Cx8xNywQWiH6Nn
         1E5rDZe3F6WhxaqmiZUdX2EAX9ucKIoy2RH5PmPUnirXsxl/uiUA6/xbYi1wK8lUiETF
         mYFm499DjNMZjtx6cpYJux/zrdUnccw65Hoj95xvJY5VTwSsL5PgCvHdVps0U5kri/xG
         XJ3nhP9H+14AvMIWpOqZ9200LICG3FWxvO16z7f//7/a31PBuhcQNlSLZouY8HU+8VzN
         gRvC0wqXBzQYKY/SiNYkvn3C7+icbV8ErqiNbzPQezR1OMCAhRY0VVK72GNZ6mVlFyYx
         Ww7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5l6e3aqrhUGYgPUgkdtnGYKFYS/VGvbquZsriioq4lk=;
        b=PTvRHGGXqojiUZNTBHFf8flyaq9E2zxty0XGzh2kMighTUTJRo/jjd6YBv0lOqS7rl
         KBNKtwXUhiPqTt0EtMQbc7b0lQfHzGHHtIbu9UXv+mfRBi3FEdlr3zs0YZo9Z0J4acKk
         iQA8FaealaHxoCQVapGOudtTvHM0DVocR7shY+PpNvUCaexB73XbRHmYad77kqmI/tv7
         tVTf/Yw6uL5PxRonCZn6cmrDemow8wuXt1bS7+vrbtCJKPoNZ4AB89QanALJ2GgyrG3H
         aAyNe0YtAZLRgzLaJoqctELVbXS0+1o629QMlYW6wi3yzRLir2ky06MB5ZGid2zs/FSp
         eRVQ==
X-Gm-Message-State: AOUpUlHj8DZr4Ab5/7qJkbGW2DIM2kA4ihUNZqYUAB1L4vkR/jNcAEpc
        9tAtRTFScMFKU7Kyc3n0yc0=
X-Google-Smtp-Source: AAOMgpcVHXyyB6ZzbfzYrpb5ccmfJoKO8HBLCbAI+LepAffKpkWfHaVn7wTHg6s233ajsma6V9VxHg==
X-Received: by 2002:a62:a6db:: with SMTP id r88-v6mr14092573pfl.60.1533499706964;
        Sun, 05 Aug 2018 13:08:26 -0700 (PDT)
Received: from toddpoynor2.mtv.corp.google.com ([2620:0:1000:3701:7d29:cd13:d903:7908])
        by smtp.gmail.com with ESMTPSA id o72-v6sm15038227pfk.76.2018.08.05.13.08.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 13:08:26 -0700 (PDT)
From:   Todd Poynor <toddpoynor@gmail.com>
To:     Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>,
        Ben Chan <benchan@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Todd Poynor <toddpoynor@google.com>
Subject: [PATCH 08/15] staging: gasket: apex: enable/disable gasket device from apex
Date:   Sun,  5 Aug 2018 13:07:42 -0700
Message-Id: <20180805200749.116693-9-toddpoynor@gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
In-Reply-To: <20180805200749.116693-1-toddpoynor@gmail.com>
References: <20180805200749.116693-1-toddpoynor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Todd Poynor <toddpoynor@google.com>

Gasket framework now places device drivers in charge of calling APIs to
enable and disable gasket device operations.  Make the appropriate calls
from the apex driver.

Signed-off-by: Todd Poynor <toddpoynor@google.com>
---
 drivers/staging/gasket/apex_driver.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/staging/gasket/apex_driver.c b/drivers/staging/gasket/apex_driver.c
index e2bc06b5244f7..1d8a100c52885 100644
--- a/drivers/staging/gasket/apex_driver.c
+++ b/drivers/staging/gasket/apex_driver.c
@@ -643,11 +643,23 @@ static int apex_pci_probe(struct pci_dev *pci_dev,
 		return ret;
 	}
 
+	pci_set_drvdata(pci_dev, gasket_dev);
+	ret = gasket_enable_device(gasket_dev);
+	if (ret) {
+		dev_err(&pci_dev->dev, "error enabling gasket device\n");
+		gasket_pci_remove_device(pci_dev);
+		pci_disable_device(pci_dev);
+		return ret;
+	}
+
 	return 0;
 }
 
 static void apex_pci_remove(struct pci_dev *pci_dev)
 {
+	struct gasket_dev *gasket_dev = pci_get_drvdata(pci_dev);
+
+	gasket_disable_device(gasket_dev);
 	gasket_pci_remove_device(pci_dev);
 	pci_disable_device(pci_dev);
 }
-- 
2.18.0.597.ga71716f1ad-goog

