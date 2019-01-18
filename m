Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6534EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AF9220873
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="uheASdiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfARDBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 22:01:55 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44496 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfARDBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 22:01:53 -0500
Received: by mail-pl1-f193.google.com with SMTP id e11so5654701plt.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 19:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZqoXXRFbL8LOG168WUI36YcQoZy1XNTlv6gJAPqhUBQ=;
        b=uheASdiz6dEOFlkfiYGvugmTs/dB65fqRv+ESmJ8rgZmsYT9Yvuxpk1pHftqJD0hsU
         EhqP577sUOTCgf1u6pHrkzn8qU6hlM7dojRMQy/RKEWUdq918clNVkC/kAufQ2UHM1Gs
         Y7T+6pk5zfg9xCuFjF5qlMcXPLYgE0DPPaciL+5mSfnIbOTHuYDqdgM30SiXvaLv+y+V
         s/dXl2XhRL7C9jTEJJHen4M/6XYOiEDlqwYqgM1H7ML42v0ee/8fq//R16GF4IGzy/Df
         +nrryu4l28KFcOz6RDvDRXPjdEiIZMXtpB2KMnxAwAalWjFOLclLMqlwqoaWa4LoCWlA
         pu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZqoXXRFbL8LOG168WUI36YcQoZy1XNTlv6gJAPqhUBQ=;
        b=cNAEpNThQP6jlTba4aA11mfV1VJ7wPsJ+dql4SO7JJVxd4y98q7iqX4zk6D1PjxEVc
         0hg1s5I3c6n/9ByA585Tc1J5qpDYf/qezB//TBj4Yh0rJyvanSjYXw7UXA9zEI5gQ0tQ
         yo9kgGIWTSPMWwoUz/1sDJNsIrTMKSEHJMjFUK/kDtT4ET9GgYDcIlREOM1M/2xm/8BH
         IjO5kDae2MmLpZWIgF5azo075uliesLS3nKWmc/Y9KtCDVALSYYN8kN9itao2vOUsB9a
         G6X/QjwPgYcJwT9ZtqXZperVBpZIWxFDZ92pLLaX+nIQ+hUXoCX4nmoAT3ytbG9un4k3
         79fQ==
X-Gm-Message-State: AJcUukeyme9TvixBB83AsE1cB/+e9gHi6/SBCONbsNunyTbLtClKBy84
        PWkAe2U/KuT+pmqlKVmJJDrsQw==
X-Google-Smtp-Source: ALg8bN6PLc5phI3fRdBEwZdUBKj6aaNSOiIzYspd4qBbi3RJ+QNoLhzVVT+Lg/VQwenkRZXibb+wLg==
X-Received: by 2002:a17:902:7687:: with SMTP id m7mr17357284pll.187.1547780512578;
        Thu, 17 Jan 2019 19:01:52 -0800 (PST)
Received: from [192.168.0.79] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id r187sm10506737pfc.63.2019.01.17.19.01.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 19:01:52 -0800 (PST)
Subject: [PATCH v2 3/3] scsi: arcmsr: Update driver version to
 v1.40.00.10-20190116
From:   Ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 18 Jan 2019 11:01:49 +0800
Message-ID: <1547780509.4532.22.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Ching Huang <ching2048@areca.com.tw>

Update driver version to v1.40.00.10-20190116.

Signed-off-by: Ching Huang <ching2048@areca.com.tw>
---

diff --git a/drivers/scsi/arcmsr/arcmsr.h b/drivers/scsi/arcmsr/arcmsr.h
index a94c513..9220bcf 100755
--- a/drivers/scsi/arcmsr/arcmsr.h
+++ b/drivers/scsi/arcmsr/arcmsr.h
@@ -49,7 +49,7 @@ struct device_attribute;
 #define ARCMSR_MAX_OUTSTANDING_CMD	1024
 #define ARCMSR_DEFAULT_OUTSTANDING_CMD	128
 #define ARCMSR_MIN_OUTSTANDING_CMD	32
-#define ARCMSR_DRIVER_VERSION		"v1.40.00.10-20181217"
+#define ARCMSR_DRIVER_VERSION		"v1.40.00.10-20190116"
 #define ARCMSR_SCSI_INITIATOR_ID	255
 #define ARCMSR_MAX_XFER_SECTORS		512
 #define ARCMSR_MAX_XFER_SECTORS_B	4096


