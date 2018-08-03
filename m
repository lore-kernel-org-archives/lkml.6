Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63088C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2BA2175E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsMhqqx3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2BA2175E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbeHCOEy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:04:54 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44514 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbeHCOEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:04:53 -0400
Received: by mail-qt0-f196.google.com with SMTP id b15-v6so5775566qtp.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Aug 2018 05:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fYNPFFzCaPQ5hb7ccwLeOi3sJkgyu++vOi33TMFT6xs=;
        b=VsMhqqx3bzEAVdZmNqIkxgfTNXgeYRxbbImXkAvo3EGNCKex52cV4Jr6yJPYYL9gzB
         yLYXaIL7bsB6OdJSnCGE/9t/vG8J98VKfntMwV5MzO7cxGs+K/LiflnXTYiDX3C4Tkny
         HfNIMdKY4ibFJ1g3/8wc5XWXFW/Xn2bi/ndc+nJgZQ+U7JyVO22wIha3QMEpTOyGdiCk
         tlDbVvYwPOeNXxGCx80G9UI9X2sFQfZEplmgl8Kt/Bcx2OOnLQ+YPUPPB1fb6nysqgix
         nF+PMWJ+qR1OSCD9QS0ElG5XkJXnyZGItPoO0J7bz9YLu3n/b/78pDxSrWeaLVHW+wB4
         MlnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fYNPFFzCaPQ5hb7ccwLeOi3sJkgyu++vOi33TMFT6xs=;
        b=OcSTRumDskdLSV30Ee081+QdTYbW4cyBZCoQcIVNr6UOtofdqTojONIF+MUWbqD4VD
         HWDAJM2oFX15uHRvq0crOH+dtYWLBaDMG5i6rtyefS4k9x8EscsguLKXgJ59uaBpZi1a
         GJWl8yH+3+7rJ21HhhqGAhB4i55gTEy+8LNhA63DrpnpvigjgwJA3bCSMI8BSx1W/vNy
         y4G9g6stOj1rwe9AaDFCNgkDLD/lkihxcdNWJqwyEtviO/xjRKHIFygbcVe3FGEyzfUI
         nYOEmJOZgMYAkZ4c9tojFLJ29POknIdsD8FQdSL3L7uoD0gAA1Fu8RhXBXrPllYg8jw2
         /gAA==
X-Gm-Message-State: AOUpUlFSNv++6O0SGXtglHFot8zgpeknH9uCgmWBfOc652bhv+9KsDap
        aI3SIZJHs3xPbMtIiu5d5Wk=
X-Google-Smtp-Source: AAOMgpf4OiefWaqvgYEYMcJDSYUlwmsTcvHuGEXQXrk0Wv5tMANO1sJj6Z4dryrnvzVxBLvOuadskQ==
X-Received: by 2002:ac8:40d1:: with SMTP id f17-v6mr3481424qtm.96.1533298130929;
        Fri, 03 Aug 2018 05:08:50 -0700 (PDT)
Received: from localhost.localdomain ([45.56.155.220])
        by smtp.gmail.com with ESMTPSA id r27-v6sm4801509qkr.17.2018.08.03.05.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 05:08:50 -0700 (PDT)
From:   Ocean He <oceanhehy@gmail.com>
To:     dan.j.williams@intel.com, ross.zwisler@linux.intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com
Cc:     linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
        Ocean He <hehy1@lenovo.com>
Subject: [PATCH] libnvdimm, bus: check id immediately following ida_simple_get
Date:   Fri,  3 Aug 2018 08:08:33 -0400
Message-Id: <1533298113-17495-1-git-send-email-oceanhehy@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ocean He <hehy1@lenovo.com>

The id check was not executed immediately following ida_simple_get. Just
change the codes position, without function change.

Signed-off-by: Ocean He <hehy1@lenovo.com>
---
 drivers/nvdimm/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index 27902a8..ab28e7c 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -350,12 +350,12 @@ struct nvdimm_bus *nvdimm_bus_register(struct device *parent,
 	INIT_LIST_HEAD(&nvdimm_bus->mapping_list);
 	init_waitqueue_head(&nvdimm_bus->probe_wait);
 	nvdimm_bus->id = ida_simple_get(&nd_ida, 0, 0, GFP_KERNEL);
-	mutex_init(&nvdimm_bus->reconfig_mutex);
-	badrange_init(&nvdimm_bus->badrange);
 	if (nvdimm_bus->id < 0) {
 		kfree(nvdimm_bus);
 		return NULL;
 	}
+	mutex_init(&nvdimm_bus->reconfig_mutex);
+	badrange_init(&nvdimm_bus->badrange);
 	nvdimm_bus->nd_desc = nd_desc;
 	nvdimm_bus->dev.parent = parent;
 	nvdimm_bus->dev.release = nvdimm_bus_release;
-- 
1.8.3.1

