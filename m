Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26835C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43D42173F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 09:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stHA6wXF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C43D42173F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732377AbeHCLgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 07:36:44 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44175 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728450AbeHCLgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 07:36:44 -0400
Received: by mail-qt0-f195.google.com with SMTP id b15-v6so5416993qtp.11;
        Fri, 03 Aug 2018 02:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6IArTodsa9u5fUdvQjsYVOidH/UVn71Z7VpvvMGWhCo=;
        b=stHA6wXFCRD85eNCBibPyHUbBv53YdD/7e736LHD3kmXYymE26k8vtykiIxokEzoIJ
         X7T5eveO1QwnzlXS9nltIZF08sSJqnFMMaCIq1DIrW9tZUKhCC4QH9qRVGOcsN7H+IRF
         JAyBwQMq5uLRgedhVuXPoR1KrQ2rJar6nXx1Ss7ZU/uM2ICF7QnJNwvOCfUGfE8ICQKt
         pgGj0e22aAB/mxI+SJZo0VJac6IdeFN5SBUg1qSTtpgII5DOZhTQg8svP8/gi15uBRiU
         CEICyZqPukrNy60KHa26egu9S+7/Zh5N2/u3feo7A/rdPr9FMxunuFP+4b2Pu+yccxuG
         rkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6IArTodsa9u5fUdvQjsYVOidH/UVn71Z7VpvvMGWhCo=;
        b=uoORrTD1ZU7breGroiqa52Guu4KOX/Y0kvfnHzL2GtBe/JSSXpxxQprnsb1pxLuC0z
         eA0HD9P04e5lvUBGJBYVGY80uv24/FXeLP4UaNM976o9Glq+/j5hB8zerRjMfoRGhaXF
         DW8o3t3HsAOwNbFsyj4UqjnqQ2cH6ebW44JGpBXH9c+RXOTvs1gE7ChrGZJHR6/yUWsi
         kgELcL2gSsbPRywH5RQJrHy2gLTPhz3aiy2fO8JWX9k7MLjbNN1xboG4Cyygtan4oH/9
         OVNsGPDGr5US95gWuFVaxbCntGbe0TXiFdgen8srvcd0FoiXtnlj7HPxQbgPfsf13Ryr
         3/Eg==
X-Gm-Message-State: AOUpUlGvm24U6+9pkeivrQ0FlhWD4O2Mob3i3hFOyUP3+LnbvSGHRi+a
        dJH07L67KfY9T0KYBVwVwmM=
X-Google-Smtp-Source: AAOMgpc7bRNAEFqkW37G5TuY8A/7NwOQUj0UMzdyqR5ZWOHrbmJ3tAKvH6+08vqmHcBoNdYZryM/pA==
X-Received: by 2002:ac8:32a1:: with SMTP id z30-v6mr1537653qta.323.1533289273832;
        Fri, 03 Aug 2018 02:41:13 -0700 (PDT)
Received: from localhost.localdomain ([45.56.155.220])
        by smtp.gmail.com with ESMTPSA id q51-v6sm4399482qta.92.2018.08.03.02.41.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 02:41:13 -0700 (PDT)
From:   Ocean He <oceanhehy@gmail.com>
To:     dan.j.williams@intel.com, ross.zwisler@linux.intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com, rjw@rjwysocki.net,
        lenb@kernel.org
Cc:     linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ocean He <hehy1@lenovo.com>
Subject: [PATCH] ACPI: nfit: return -ENODEV if fail to find NFIT at startup
Date:   Fri,  3 Aug 2018 05:39:58 -0400
Message-Id: <1533289198-11400-1-git-send-email-oceanhehy@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ocean He <hehy1@lenovo.com>

In the beginning of acpi_nfit_add, if fail to find NFIT table then should
return -ENODEV, instead of 0.

Signed-off-by: Ocean He <hehy1@lenovo.com>
---
 drivers/acpi/nfit/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 7c47900..1790d7c 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3355,7 +3355,7 @@ static int acpi_nfit_add(struct acpi_device *adev)
 	if (ACPI_FAILURE(status)) {
 		/* This is ok, we could have an nvdimm hotplugged later */
 		dev_dbg(dev, "failed to find NFIT at startup\n");
-		return 0;
+		return -ENODEV;
 	}
 
 	rc = devm_add_action_or_reset(dev, acpi_nfit_put_table, tbl);
-- 
1.8.3.1

