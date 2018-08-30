Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92465C43334
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6A020834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 22:35:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMVYhxaU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6A020834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbeHaCkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 22:40:19 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45690 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeHaCkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 22:40:18 -0400
Received: by mail-lf1-f65.google.com with SMTP id r4-v6so8461832lff.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 15:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0CoPjnGDX1qnLOkJ5zdzj0Bi0tX3W2cV1jd68oHh3Lw=;
        b=lMVYhxaUI+0ocJq6Pq6HeZ1dFOGE2SNOUpbtjlT79zBNq8uhYqBwbPPI2LI+0UvyC4
         9S5AbYmNn0+A5iy0UG11Ho57MVSpclhZwnS1ZJEQoNK/Y/eEm8fSTj5FiDemkYUJtU6D
         2iny680XttaafN4Q5skSdxfwGZq0byV0aiP+LgxGjiNccWqjfCVtHm0Mv7gweSJEinW+
         LwHmP6aE65gYxGCuUc68OMvPYtPTg8CtuWt10XWjWZfMcAaBTAAn/gZubf8eXLpgtdYR
         kzkLPhpOxQ9gtkCNcuXBwvY0+NXVx3MugMcZlFG4ruZxByaBX4Fjplynmtxf4AdiXh9U
         GcCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0CoPjnGDX1qnLOkJ5zdzj0Bi0tX3W2cV1jd68oHh3Lw=;
        b=drfj7juOsfKuQe5SJ9q0bx7TodhW9sb/k4ziOWLmEnElvTKyFVvOUqKdDUGmRG6rhp
         TbW7rDpO7ygQTMBlKpMbJq/3T0Jccr0Hw+wdw9v3vTy2oJb8AMaSuH6uniPKQgDi0yox
         cZXS5tLLnl7jC5K6oKAKdUfFun11RkTR9AZII1MWyGACJ4/QgfFR1X9Bz8KdSxmXHfcJ
         qnvIxoVWI+B31J0mu3bIe6zCpPPPWB8JweimYhYHV/2Z+5BUA+OHJh/Vnyi/9Oniaxzy
         0bcPT6GT8WPwSNUFxV1TkE9UME8Yxo1JUFXgeZFBL8gP/0aTN5RHub0+131qXvW4FtPH
         40iw==
X-Gm-Message-State: APzg51DMF4k48TMXo/6he3vraBMuSeKHeZk+k4CX96rOSU63VgiaAlxT
        yRCGtC7yDmiUi5c4BHyFtyozaZk/1yc=
X-Google-Smtp-Source: ANB0VdbS7ZA9q8EUkMf47zWdy+Mg4TmcYW0cVFg9Q4Kr6yLSsKyOALnb/PFtghrpcFVEihi4VnzSlQ==
X-Received: by 2002:a19:1388:: with SMTP id 8-v6mr9073506lft.12.1535668552575;
        Thu, 30 Aug 2018 15:35:52 -0700 (PDT)
Received: from Mort.jumbo.freeair (91-159-62-202.elisa-laajakaista.fi. [91.159.62.202])
        by smtp.gmail.com with ESMTPSA id u28-v6sm1455376ljd.61.2018.08.30.15.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 15:35:51 -0700 (PDT)
From:   Igor Stoppa <igor.stoppa@gmail.com>
X-Google-Original-From: Igor Stoppa <igor.stoppa@huawei.com>
To:     linux-kernel@vger.kernel.org
Cc:     igor.stoppa@gmail.com, Igor Stoppa <igor.stoppa@huawei.com>,
        zijun_hu <zijun_hu@htc.com>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Dennis Zhou <dennisszhou@gmail.com>
Subject: [PATCH 20/23] mm: percpu: remove unnecessary unlikely()
Date:   Fri, 31 Aug 2018 01:34:26 +0300
Message-Id: <20180830223429.30051-21-igor.stoppa@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180830223429.30051-1-igor.stoppa@huawei.com>
References: <20180830223429.30051-1-igor.stoppa@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON() already contains an unlikely(), so it's not necessary to
wrap it into another.

Signed-off-by: Igor Stoppa <igor.stoppa@huawei.com>
Cc: zijun_hu <zijun_hu@htc.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Dennis Zhou <dennisszhou@gmail.com>
---
 mm/percpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index a749d4d96e3e..f5c2796fe63e 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -2588,7 +2588,7 @@ int __init pcpu_page_first_chunk(size_t reserved_size,
 	BUG_ON(ai->nr_groups != 1);
 	upa = ai->alloc_size/ai->unit_size;
 	nr_g0_units = roundup(num_possible_cpus(), upa);
-	if (unlikely(WARN_ON(ai->groups[0].nr_units != nr_g0_units))) {
+	if (WARN_ON(ai->groups[0].nr_units != nr_g0_units)) {
 		pcpu_free_alloc_info(ai);
 		return -EINVAL;
 	}
-- 
2.17.1

