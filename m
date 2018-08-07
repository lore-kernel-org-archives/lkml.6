Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE49C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 989A321A12
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 06:15:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byxrzc4u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 989A321A12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387874AbeHGI23 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 04:28:29 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:47066 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728261AbeHGI22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 04:28:28 -0400
Received: by mail-qk0-f196.google.com with SMTP id 191-v6so10627339qki.13;
        Mon, 06 Aug 2018 23:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=upEb29oY+a89tcabrxtjbMHz3lful7Qiryf0EA4+c5c=;
        b=byxrzc4ukGdkvy5wIL//lhC6FqgmmF543vdu12IIDqdxXZVoiPTmDDy+czMal/+6aL
         q+zmX7HyyO005lqueZeHrgC1564f/ZpOGHSbs8tjeQQ1Q8+3q2TsS/yvrrW5Xf/qDA1W
         cb5yW0DVaHwexc9f5O4FtTBuUZ7xGNkEPlzA+5IocF6GRmFUUWW4Ci/bpdZn/GodgOLV
         ol+rqPaAQTp1nxacZQTSa+1VhWJ04jpc7/0n5UIMgWT0s9kWvC7KX3gACui4SmcTJRsM
         VCqpr21sCDg2m7jMdTR4hcTh+Bb6whhcmM7hva7CjAafhQq3Y6eWA/cK51J18TX0U9aZ
         nZAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=upEb29oY+a89tcabrxtjbMHz3lful7Qiryf0EA4+c5c=;
        b=InbjaQoXUViywf2hNpf4jnUGtrtlS4BL1QIiW19VB409kjexTyEPImQbYequurvM8X
         XDD/TlsxRJaxOJwaiW8bH4nqM8qvFares3MA78IlYU2vQxItrQeYYgI5KsSELyERZQoJ
         N1SZoxSt6wJ2FeictFwSC5AQt6XoUd0OGldaAPKfKrL93ybX/PkAwwEE8Pg0+ZcK4Sq4
         CvqdIDkAdKPeo5w3gx9ezukkJbMz/JtAB3DCYy3ylPMYrusD03kkblKe6sgeXH7Moxfk
         Z7ijW1qdnoEFhGjKGG+7tDHSHsNCB/5adDI92qFhlVCMvDVF0mUu7SBMq5UYe7pjR4Cy
         VG8A==
X-Gm-Message-State: AOUpUlEfXQ1xXCn3oQzgMCEVCnPxyybeMsjkMo35U65J13ELUBc/VhMO
        HDmALGXA9Ip/QbpVs9dj5e8=
X-Google-Smtp-Source: AAOMgpcbpA40ZhKWavakiFiRAGxRdiiTEbFVgHElzUEnLCZ1EZkcMSH/WbkW3dwqHGCnpVAvKXGZaQ==
X-Received: by 2002:a37:d61b:: with SMTP id t27-v6mr15491146qki.244.1533622544698;
        Mon, 06 Aug 2018 23:15:44 -0700 (PDT)
Received: from 192.168.190.131 ([104.237.86.234])
        by smtp.gmail.com with ESMTPSA id d2-v6sm303626qkj.76.2018.08.06.23.15.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Aug 2018 23:15:44 -0700 (PDT)
From:   Ocean He <oceanhehy@gmail.com>
To:     dan.j.williams@intel.com, ross.zwisler@linux.intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com, rjw@rjwysocki.net,
        lenb@kernel.org
Cc:     linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ocean He <hehy1@lenovo.com>
Subject: [PATCH] ACPI: nfit: adjust annotation for why return 0 if fail to find NFIT at startup
Date:   Tue,  7 Aug 2018 02:15:31 -0400
Message-Id: <1533622531-3617-1-git-send-email-oceanhehy@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ocean He <hehy1@lenovo.com>

Add detail explanation why it's ok to return 0 if fail to find NFIT at
startup, refer to chapter 9.20.2 NVDIMM Root Device in ACPI 6.2 spec.

Signed-off-by: Ocean He <hehy1@lenovo.com>
---
v1: https://lists.01.org/pipermail/linux-nvdimm/2018-August/017311.html 
v2: Per Vishal's comments of v1, it turns out that it's right to keep 
"return 0" if NFIT not found at boot time. This v2 adjust annotation
to avoid misunderstanding of "return 0".

 drivers/acpi/nfit/core.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 7c47900..1b982fe 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -3353,7 +3353,13 @@ static int acpi_nfit_add(struct acpi_device *adev)
 
 	status = acpi_get_table(ACPI_SIG_NFIT, 0, &tbl);
 	if (ACPI_FAILURE(status)) {
-		/* This is ok, we could have an nvdimm hotplugged later */
+		/* The NVDIMM root device allows OS to trigger enumeration of
+		 * NVDIMMs through NFIT at boot time and re-enumeration at
+		 * root level via the _FIT method during runtime.
+		 * This is ok to return 0 here, we could have an nvdimm
+		 * hotplugged later and evaluate _FIT method which returns
+		 * data in the format of a series of NFIT Structures.
+		 */
 		dev_dbg(dev, "failed to find NFIT at startup\n");
 		return 0;
 	}
-- 
1.8.3.1

