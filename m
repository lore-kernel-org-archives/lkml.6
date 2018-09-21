Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837C5ECE566
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4212154E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 13:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jKw3g0ru"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4212154E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390438AbeIUTaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 15:30:01 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:52121 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390424AbeIUT37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 15:29:59 -0400
Received: by mail-it1-f196.google.com with SMTP id e14-v6so1998874itf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 06:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NTCthlsQ4NxuVZ0rEdDOEgk9ZVevHtsMIIbl81M9etE=;
        b=jKw3g0ru+DaWYGSva7WRJUIz9I38AyS8QUSiQXdb5JARDa4L6dSYn+qBebXd43z6SB
         QGupkSfV1+MAPKWU8bc3AB1MvoBnWArT1BKAxfAD18BL1irP599SZsrlTQAki2YnGX9b
         MpL/WtDAb+k99dY08vrXB4ehKqEqrYCyt8yIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NTCthlsQ4NxuVZ0rEdDOEgk9ZVevHtsMIIbl81M9etE=;
        b=Fk8YQsNO6db0uukKrsHJ5+OQrZtVyMU1bPn3NcCKK5bGJdTsGxYurwDDPs/Yo72ABH
         2sozkTCSwE8PwhduX2CYIKjY1rPO2SZzYKlY15u51w/meq1UJaFEGQztR+w7Wi8lH0pV
         gQ7u+LgtEAbcZmOtkK1py7e23CUvdTbP5yWM3vBoTsU6A0o4or/Lq0HfUvdLKS6PL8sE
         +2xTQICIbVONeU7A9zmGbLRQbvOSL+kcL+M9bGNDIVIWTetwcLgFqrbuTkpPjqY8N26T
         AFAd7tY/79zvZlXFoperv4bzkzm7FqmeP+Hc/yERiPDfAAvOMPKfacKayaLAV8E5292l
         Wkig==
X-Gm-Message-State: APzg51CHMdhlzmho7onDOMj3S+RkrBdCHem6XO025MuldN0qajqs8NGm
        sv6xngO0QA24QCWWnh2DD+MikUaZJKM=
X-Google-Smtp-Source: ANB0Vdbik4CbmTEjZFQGMRi8qRdZMSiUzD3cOqZS5gRvZg0TIBLvdWmkiC1CavGoOUoaatCHlAEGRg==
X-Received: by 2002:a24:de0a:: with SMTP id d10-v6mr5670938itg.124.1537537264449;
        Fri, 21 Sep 2018 06:41:04 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id c12-v6sm9896298ioq.81.2018.09.21.06.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 06:41:03 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 26/26] nvmem: make nvmem_add_cells() static
Date:   Fri, 21 Sep 2018 06:40:26 -0700
Message-Id: <20180921134026.4596-27-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
References: <20180921134026.4596-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Now we have new api nvmem_add/del_cell_table() we do not want users to use
nvmem_add_cells() anymore. So mark it accordingly. I guess it was missed in
original cleanup patch.

This also fixes below warning:
core.c:355:5: warning: no previous prototype for 'nvmem_add_cells'
 [-Wmissing-prototypes]

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index ad1227df1984..cc815bb2eebd 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -352,7 +352,7 @@ static int nvmem_cell_info_to_nvmem_cell(struct nvmem_device *nvmem,
  *
  * Return: 0 or negative error code on failure.
  */
-int nvmem_add_cells(struct nvmem_device *nvmem,
+static int nvmem_add_cells(struct nvmem_device *nvmem,
 		    const struct nvmem_cell_info *info,
 		    int ncells)
 {
@@ -391,7 +391,6 @@ int nvmem_add_cells(struct nvmem_device *nvmem,
 
 	return rval;
 }
-EXPORT_SYMBOL_GPL(nvmem_add_cells);
 
 /*
  * nvmem_setup_compat() - Create an additional binary entry in
-- 
2.19.0

