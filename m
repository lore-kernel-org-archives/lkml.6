Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330B2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 03:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6679205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 03:31:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=areca-com-tw.20150623.gappssmtp.com header.i=@areca-com-tw.20150623.gappssmtp.com header.b="ifQb+O4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfAQDbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 22:31:34 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39052 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727815AbfAQDbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 22:31:33 -0500
Received: by mail-pf1-f196.google.com with SMTP id r136so4103891pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 19:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=areca-com-tw.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iVmAbdXCtqVd6ESGpT5I4aoH5j3NoxSBrNUT+bKKNBc=;
        b=ifQb+O4+gM5otJLyU/XB7x9PPJTVQ/MRN8HDJZdDgvPtFWCXtQF1s3xcm9TBGYbXEY
         Iu8cbQYjxVIDSGe6or/HoSLp5L/2HXuUUGnQnZxsXYVp4mNOXTG/sJMKVOpufutP7/Hb
         4wLjK/ThlpXr/ivlIzJOc6pWZc1rAVNGMwU0APnKkig6zsNC8qDnMEwbfc/UPwpLg5Ck
         RJKTlv/JTRVQWYwK7l2tOf93eEsJYw2qk8aQlNNkV5b/9COjLf8WCL3vkGv5TGPpUlJc
         IuSw92hmUmMOuHQ8gI8Wn9QBdCm6+mCezrUFJTfcGrAyMt1Kfjj9MLLpVi3HFEeejfaK
         2Ung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iVmAbdXCtqVd6ESGpT5I4aoH5j3NoxSBrNUT+bKKNBc=;
        b=CZqo4GKz0U45jgXDeNA6oAi4OoesbUtUSDCxtkHi0AZvObHCq0IVkMRMDluHLrxjxZ
         koCzeGgcJjISnh3/RblQKfEfiKuuo6LrX7C3kVd2E1nkBq3/xGKRuPjoyyimA8WLx1kP
         ZFoZfCPNLuRlAmi5oMeZvFzhsS4wJo5EwZiKceryOvDnyLFbKsVRv5qulKwu7G7BNoxt
         hvAuWMHirfWFQXSarrN8tJl67D0ki145oUznqwDVFQ6+yxXE0ztzfhwpzhyjdLgYtWYU
         4XgluXxKPqozC0h7oth9qIdLMSf6mr0xzQY6AuuG6Kmkyctr4pARH6U/hchf3bdgd/vq
         NWSg==
X-Gm-Message-State: AJcUukc9PmQNcWapA6EIQ+tfgJzu6/lTxavc2h/b0cWQdSolWInexBid
        zf3j8PUk05N71DPLoDN6n/xIFg==
X-Google-Smtp-Source: ALg8bN6FWYDVZEzhd6Kfpot3KARLCUU9Pi2DdmiWyC1lzSCLDkyShM4krP27G/HdzELXCJcvVmKPZw==
X-Received: by 2002:a62:cec6:: with SMTP id y189mr13689062pfg.100.1547695892810;
        Wed, 16 Jan 2019 19:31:32 -0800 (PST)
Received: from [192.168.0.79] (60-248-88-209.HINET-IP.hinet.net. [60.248.88.209])
        by smtp.gmail.com with ESMTPSA id d69sm316078pfg.168.2019.01.16.19.31.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 19:31:32 -0800 (PST)
Subject: Fix suspend/resume of ACB_ADAPTER_TYPE_B part 2
From:   Ching Huang <ching2048@areca.com.tw>
To:     martin.petersen@oracle.com, James.Bottomley@HansenPartnership.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dan.carpenter@oracle.com, hch@infradead.org,
        colin.king@canonical.com
Content-Type: text/plain; charset="UTF-8"
Date:   Thu, 17 Jan 2019 11:31:29 +0800
Message-ID: <1547695889.4339.10.camel@Centos6.3-64>
Mime-Version: 1.0
X-Mailer: Evolution 2.32.3 (2.32.3-37.el6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series are against to mkp's 5.1/scsi-queue.

1. Due to dma_zalloc_coherent will be phase out, so use dma_alloc_coherent to replace it.
2. Fix suspend/resume of ACB_ADAPTER_TYPE_B part 2.
3. Update driver version to v1.40.00.10-20190116
---

