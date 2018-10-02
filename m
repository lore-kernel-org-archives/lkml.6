Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FFDC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8693B2064A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 11:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="p223/OvF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8693B2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbeJBRpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 13:45:34 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38479 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbeJBRpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 13:45:34 -0400
Received: by mail-wm1-f66.google.com with SMTP id 193-v6so1732375wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 04:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZjH3oP4pB7OAvUTFFLHmADLqEaeyoxuNOhTzGEMhy38=;
        b=p223/OvFSla/ZIfxtenmivIM0JwkmCYd89pSV6ugHXqEqzDFhqrz7YpjxDz4kFnZNa
         cKKim/NmUWOTzDG/PKrIovNoivCk+Wv0WiStJ+q+h2K0yXrBpo7BIGMzhJnZuwjubChl
         UNyhYuMdBs1+K9SNUIrk+C7shlBtOS77JPn4iyGKzSAYWw+Zh7vyF4VrxKUwuclx+Huw
         RigFGNXjphcx+MZVDP3S980BsjdfpCL97jeL8eDKZWsqSmmSt4wimKC/UE555bTJiZq3
         8YkfnU0yTIIurxlyBiuH0qhkxLAqHxGwkaaNp0IgnhA6kvFdsVajXJx8SXbN7b2PvEgV
         TIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZjH3oP4pB7OAvUTFFLHmADLqEaeyoxuNOhTzGEMhy38=;
        b=TiKSVotks6I+/ugZHMm9FpaMkMi49e064m1pd2VhjXBudWe184fbfJM5v/ZSYuWC2E
         0LzIDLLFqaqG6lgKh/pZ7zFsjEys/3Zwg6am/ecVtL2sKMucKGnDm+XjsSMfoemXxXjn
         iPwrXFLntUXT48C3czC3Q+q8aSjyFwFs9YSLubp5t0AQi+7trsIx2kOqSBkJlVJteImW
         4jec4hEuwOx8bpqhluD5TKipa5m4T1lOPFGJcY4I9IHftaOZgN5+q+Ccqg4CzEWn8Zzt
         AaGzerKWSA8H5mWYEr/ivBFXaxeqz6a006v6NEL/u0jpKI8XGZ2B/cazewQSRPh1zRgf
         fOlA==
X-Gm-Message-State: ABuFfog3F7Ro/Be/n8vWmaNPStocmJc35zkTbJXKcxHgVnVe4siB6pdh
        c3Q6thceUbMFCIRs8g8IM6wtKw==
X-Google-Smtp-Source: ACcGV60+3qQXdLanrD+zQ8qm494BQgvLLztxXprHkpR6ol8PerKnk/MLh97c+snvUy2hcSTqyBYE/g==
X-Received: by 2002:a1c:2bc3:: with SMTP id r186-v6mr1533311wmr.71.1538478169390;
        Tue, 02 Oct 2018 04:02:49 -0700 (PDT)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:217b:7d7b:52aa:bc53])
        by smtp.gmail.com with ESMTPSA id y203-v6sm11118326wmd.1.2018.10.02.04.02.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 04:02:48 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Greg KH <greg@kroah.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH] nvmem: only build nvmem_find_cell_by_index() if OF is enabled
Date:   Tue,  2 Oct 2018 13:02:46 +0200
Message-Id: <20181002110246.3175-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

The following warning is produced when building nvmem core if
CONFIG_OF is disabled:

drivers/nvmem/core.c:496:1: warning: 'nvmem_find_cell_by_index' defined but not used [-Wunused-function]
 nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
 ^~~~~~~~~~~~~~~~~~~~~~~~

This is caused by the fact that the only caller of this routine is
under an ifdef depending on this option. Fix it by adding a relevant
ifdef to the function in question as well.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/nvmem/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index cc815bb2eebd..65f61cd0a687 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -492,6 +492,7 @@ static int nvmem_add_cells_from_table(struct nvmem_device *nvmem)
 	return rval;
 }
 
+#if IS_ENABLED(CONFIG_OF)
 static struct nvmem_cell *
 nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
 {
@@ -507,6 +508,7 @@ nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
 
 	return cell;
 }
+#endif
 
 static struct nvmem_cell *
 nvmem_find_cell_by_name(struct nvmem_device *nvmem, const char *cell_id)
-- 
2.19.0

