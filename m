Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60513C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7FB020842
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 14:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ursulin-net.20150623.gappssmtp.com header.i=@ursulin-net.20150623.gappssmtp.com header.b="putyzTXK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7FB020842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ursulin.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbeIZU3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 16:29:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38212 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbeIZU3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 16:29:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id z16-v6so2557937wmi.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 07:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ursulin-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=/DchJTrUkEpVF8dshPLJsZKZiDKYm9rV0yoQggKTxyE=;
        b=putyzTXKZFw4teh2j8pqGjJ1mueHXBUbBd8CzT8OnRNGS9PzyyPm4efSbCqDTm1ESZ
         QOX1k9o8JCE3eHoSbfSKspmQb7i11MRcOLqxtvOjARs0rCvf52IaWc2cYudw2Uy842x1
         YLe11HRgvDid8SlZ8et/0uNNgddb/Ae+AtkHFYjheo73L0FAvRryuQdF3c8GiJio0ux2
         aHzB69L/edQGDxNtl1n6IbKLbPMX0Re4qdRBHjyW7H8iEW5sW1UPZ+dnb3RX7J3aMJ05
         vnAMscaoKlJfryRGAONks7rulIPnFNwLQvCPLJmem8sTRqlccqlRd78p7C6chpId0Gbw
         2dYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/DchJTrUkEpVF8dshPLJsZKZiDKYm9rV0yoQggKTxyE=;
        b=Bh4EH3B/j10Flf7bIHU2nN2CfhyCSyTG7RGWAJlOsSV2knlhSlQsDQjRSjRcnmsh+0
         1xQ/DS9aRNz+Vf/IZ7MkWeYlfl70PX0q+QhCHNuAXRwNw3lXrtTNtrGKMr+chsBq4X2n
         dhce4ZigfGvknmhjr5YXoHmI8sCJcrhAENO60Tcar9SKQSagH2i476nPw4oA9ke2O5DH
         rd4krYCZuuSgCuI7LC4sJEkENOwpTVvYZlw/Eih88W+4c4ktfWk0JxSE9oHnAkBYXNAw
         q5X7ubnI8OoUiJiK2jxKFrur7cf9nVghptUuIFQpJXoj0C6AOmMtFj1t7ZaudUE5M4xj
         yCEA==
X-Gm-Message-State: ABuFfohk70S3ZM/AvFHsLjk0Az2oE5u1yDlDEJrp7KdtE38gU1jL5n3C
        2sWhJNO5TARGU3ecVqruj9d9Ii2pqx0=
X-Google-Smtp-Source: ACcGV61HfS4vGu7j4PVt3iKUp/mEDUzoJjwt/spjIpnjsDFvZIwhckfd/4ifmN8gs2NjE0hcp8n0Cw==
X-Received: by 2002:a1c:1805:: with SMTP id 5-v6mr4682385wmy.25.1537971394102;
        Wed, 26 Sep 2018 07:16:34 -0700 (PDT)
Received: from localhost.localdomain ([95.144.165.37])
        by smtp.gmail.com with ESMTPSA id v14-v6sm3209974wmh.41.2018.09.26.07.16.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 07:16:33 -0700 (PDT)
From:   Tvrtko Ursulin <tursulin@ursulin.net>
X-Google-Original-From: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     tursulin@ursulin.net, tvrtko.ursulin@linux.intel.com,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Subject: [PATCH 0/6] lib/scatterlist: sgl API fixes and cleanups
Date:   Wed, 26 Sep 2018 15:16:19 +0100
Message-Id: <20180926141625.17727-1-tvrtko.ursulin@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Mostly same fixes and cleanups I've sent earlier in the year, but with some
patches dropped and some split into smaller ones as per request.

Tvrtko Ursulin (6):
  lib/scatterlist: Use natural long for sgl_alloc(_order) length
    parameter
  lib/scatterlist: Use consistent types in sgl API
  lib/scatterlist: Skip requesting zeroed allocations in sgl_alloc_order
  lib/scatterlist: Do not leak pages when high-order allocation fails
  lib/scatterlist: Use appropriate type for elem_len in sgl_alloc_order
  lib/scatterlist: Fix overflow check in sgl_alloc_order

 include/linux/scatterlist.h | 13 +++++++------
 lib/scatterlist.c           | 33 +++++++++++++++++----------------
 2 files changed, 24 insertions(+), 22 deletions(-)

-- 
2.17.1

