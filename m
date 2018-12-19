Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3744C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893662184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 08:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="jGCCk8an"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbeLSIRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 03:17:46 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:53351 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbeLSIRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 03:17:46 -0500
Received: by mail-it1-f193.google.com with SMTP id g85so8393346ita.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 00:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LPcF+ZbvmfyB4nSY0hddmWYxhZU706IZql+7QixMY2A=;
        b=jGCCk8anfLB375SEVpo2vBFIczqFi5XRlRxbsl2usSh6IHpP9H+E2loLoLrNlTHPzB
         PfZf0u07I8DoRlikLRexsLoxABk1gXB0smrAfm3NAn7bIPC52r3VSygp+5X3safzbBK4
         ZW8F3RzJudJJPblIpwG1IUd0cxywMTAR49cstW8Cq6UydBmW5edJVZY6ta29luikFhI/
         7omtYpisfS1A60vTkqvVFgSSb6572O8WSZbgtkQzIgTIVFGpVMlJ4HHI5waArjCpVUxm
         vOUfNMnhNodixBxVRFAvk1buFq5KzmgjlY5Ho1/ovZrWH19tgI2m/5wETGBNZcq6L6xE
         VjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LPcF+ZbvmfyB4nSY0hddmWYxhZU706IZql+7QixMY2A=;
        b=o8zXIbZxj9WOqYjm8bvbRluEb/v8qkaun6BT/OSM3EERED8kd0mIapxlz8OjIvqYKf
         kzmqwG4mXka1l6qrbMhJSoaqD1/p56NpMhikDjCKVeCgJzn45SOKs4944iEJ8e3Pjf7g
         VsuMPNzuHjqmoEX9qwNScFMJskFx6VDGU2w+8f5Oh2+oQfVkdFxTE2b/2HG00ngSIsVV
         86jwFb50tnMphpnXm9TrKLkmP1fYI7parS/R3JA5SKxr1hdqO/3jKA/dVCG8KK7o9hZ7
         vNljPjyknw7VfJoNxnOHLaW0CqK7AHPXUgMqwFhM9lxSGsRGR9ySNGbu+jLz5a61qh06
         /VZw==
X-Gm-Message-State: AA+aEWbMwlUUff/w6mdngiZAcTzRujwiU/DNYV9C0TVnzO82uxJM3OW9
        fOZUoClHG8Aiey4YBaMv8Jmpet19kp6o+g==
X-Google-Smtp-Source: AFSGD/Unx2UXq/nUU08hr5hADDDh4itFUxWTLBbwq3TxJXcnnkUh5jDcvCScKVe2XRJtqiWXFISkOw==
X-Received: by 2002:a24:b8c6:: with SMTP id m189mr5432687ite.72.1545207465292;
        Wed, 19 Dec 2018 00:17:45 -0800 (PST)
Received: from [192.168.0.130] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id t6sm9294208ioc.87.2018.12.19.00.17.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Dec 2018 00:17:44 -0800 (PST)
Subject: [PATCH 0/12] scsi: arcmsr: update for ccb structure address can
 above 4GB
From:   Ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date:   Wed, 19 Dec 2018 16:17:41 +0800
Message-ID: <1545207461.4457.10.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Ching Huang <ching2048@areca.com.tw>

This patch series are against to mkp's 4.21/scsi-queue.

1. Rename acb structure member roundup_ccbsize to ioqueue_size
2. Rename arcmsr_free_mu to arcmsr_free_io_queue
3. Merge arcmsr_alloc_io_queue to arcmsr_alloc_ccb_pool
4. Update arcmsr_alloc_ccb_pool for ccb buffer address above 4GB
5. Update codes for ACB_ADAPTER_TYPE_A in case of ccb address above 4GB
6. Update codes for ACB_ADAPTER_TYPE_B in case of ccb address above 4GB
7. Update codes for ACB_ADAPTER_TYPE_C in case of ccb address above 4GB
8. Update codes for ACB_ADAPTER_TYPE_D in case of ccb address above 4GB
9. Add an option of set dma_mask_64 for ACB_ADAPTER_TYPE_A
10.Separate 'set dma mask' as a function
11.Fix suspend/resume of ACB_ADAPTER_TYPE_B
12.Update driver version to v1.40.00.10-20181217
---

