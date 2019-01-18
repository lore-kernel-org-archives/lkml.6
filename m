Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C65C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D75D620855
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 02:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="rO0HGKRU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbfARCr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 21:47:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43574 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfARCr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 21:47:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id w73so5800663pfk.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 18:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Os4/lrR4FDyW4kqiyHnEagj4yEUM1GPwMYoR/Eb8uUQ=;
        b=rO0HGKRUy7MSA22tXUw6KP3CpxcHYzkt8EbTKWSJFTMnYVvUBIOOtEkIgx5oXE/AEo
         6096lAC43uWtDzktRXfXuHE59zLJN2ivlchQLAyUblHpStRYSG1CB5D0NJYNb4AHla7x
         HrB0nodQ1hZx3m2MXdXbUVYQAmIIuqDL1JUimFg7vuxH9EGKVeVksQDc+ZvFEjGjkx/R
         1+mdhn1bd0DVR96I4Ce5+LNLxpaj093k8iexFAxFyxCP4ngVvcLHC8nwWR0NR7gPyfGF
         eMiGE0SRCBaotPui9mNI37tYq9dCcSpOWqDYImc4rVaG8fV9ZgQSfJPZnez41UiOLVOb
         Rqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Os4/lrR4FDyW4kqiyHnEagj4yEUM1GPwMYoR/Eb8uUQ=;
        b=kFEK+5TuNx3zR3dDdJN3bKS/N0FT+RiCetdE9PPCUQKldbDRztyUCCLyYya1wmd40i
         9GntC6J3ecp6qs3ErLgkOyRfFNxivQTj+fzM0NuF0afNoUEBL9NyPjBDFgNv1GPv+/st
         e45RfgcQGWPx25icLr86sKrMxCV0Mp9hENLY9BFFyYdWJgg9SecBrBW+BbZYQevucgkR
         kbOxhx1lb/9gGN9L/JEK1Pu33M+pL1SFl7aLayz4U4rvY3/KttWO2GdYyPdxJQDztp0A
         k1+uc0ZQcLGpav+X7HjoT5wG1cpLUSVRxPFYjiwtoBSSQ+gKZ3y0kMUh0rjl2PUAc2gh
         1xmQ==
X-Gm-Message-State: AJcUukfKwJuCn82y3gLBmtXFcTaZjm1Kh5mwv4qmSzpSB5rVv9yYIf04
        JrlBDcSzu4gbSqEPzZpe4VTPww==
X-Google-Smtp-Source: ALg8bN7NUFBHhPYg+pV7y9t+NycL7TuLeSdUfoezt0HxMESb0R1beIMm/3VLXt46tDB6A/p6OqrjVQ==
X-Received: by 2002:a62:6b8a:: with SMTP id g132mr17659342pfc.201.1547779648340;
        Thu, 17 Jan 2019 18:47:28 -0800 (PST)
Received: from [192.168.0.79] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id k129sm4185795pgk.29.2019.01.17.18.47.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 18:47:27 -0800 (PST)
Subject: [PATCH v2 0/3] scsi: arcmsr: Fix suspend/resume of
 ACB_ADAPTER_TYPE_B part 2
From:   Ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date:   Fri, 18 Jan 2019 10:47:25 +0800
Message-ID: <1547779645.4532.9.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series are against to mkp's 5.1/scsi-queue.

1. Due to dma_zalloc_coherent will be phase out, so use dma_alloc_coherent instead.
2. For ACB_ADAPTER_TYPE_B controller, the read/write after hibernate and resume may
got 'isr get an illegal ccb command' in log/messages sometimes. This patch fix it.
3. Update driver version to v1.40.00.10-20190116
---


