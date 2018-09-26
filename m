Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD92C004D1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88BB2154B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 21:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKv6YnLy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E88BB2154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeI0EFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 00:05:43 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34190 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbeI0EFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 00:05:42 -0400
Received: by mail-ot1-f66.google.com with SMTP id i12-v6so550678otl.1;
        Wed, 26 Sep 2018 14:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zeKJdm4bhFF3SZzdQkl7G7DnwzXobdl8B5SvqUw4jWo=;
        b=RKv6YnLyn75OvqP+cjrhYZJZKg4s+vfDytHPCITweojsNY0UTv3l1tt7wAcbFMBRPy
         f8ilA2ktx74d9NuOPhaPp8+TzWQpn9AkDqdjEgemVMjIy0UmX+2FyAojpgOOrWWvgYF+
         x8YXlthejOTekqjyj8EtGw2xM3TqcjtNsgzFdk9NRc+bS1Eh6H5zzF0xVRIpEOZQgqx2
         ZDG0v5uWVkkeWjcz44WdEcfJawOe+JGxePeCPq69vT3mEngfh9kcLzT1WVBQCyMmL61y
         BRptEWI9xFpfPe0X1U5w5/oNlrD3IDlNrIVkN3uMeJZaBc7OpWBVqNZrN9StJuLLs8FL
         0E9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zeKJdm4bhFF3SZzdQkl7G7DnwzXobdl8B5SvqUw4jWo=;
        b=irk5P7FMvWFXKB5Clp8DSF0D1IJyXtCu5twFwgRSEEqmmDZDfQs938Cbz8pJJH3Tr9
         FSG7qggYBiM7n8tkZ+0cz2qlCz3gZYytG2ZQgCEk/A6H8Msj0+rYaHGh0swGLrAZmyx9
         z31PcIZ62KodZizaXoHA1bMsZl82TxHsPuqIE+36vVMcft6cCXzk22PKlpWfQJca/feS
         cpjN0jlpzy6OxCCrAZynj6YBKCNrM4G53piJpXn1vuQtqcg3+E1kzkgtTGlng+n6sY/u
         6mQsCSGwpcaBcc1ZWgoHECNP2OM4s+JHCaqpevV4gpsf2kmcUbZnI9hySkXbt4EqZunD
         76ug==
X-Gm-Message-State: ABuFfoik/eU2eGl+OPv5gah3fjC8lsCD3e8f5bH+pEYJvSIWp4u6/LcT
        CcYXXudwCG4z877CS9Th6y0=
X-Google-Smtp-Source: ACcGV606/iSqXAXgY9g4MMqcCC7PZhU+AGDEycsRQu09oTxG7nYe5nG2zTk8dKjKl/iLYFKmW0rIZg==
X-Received: by 2002:a9d:12f5:: with SMTP id g108-v6mr5658520otg.373.1537998643110;
        Wed, 26 Sep 2018 14:50:43 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id b124-v6sm95121oii.14.2018.09.26.14.50.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 14:50:42 -0700 (PDT)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Doug Warzecha <Douglas_Warzecha@dell.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v2 5/5] MAINTAINERS: Update maintainer for dcdbas and dell_rbu
Date:   Wed, 26 Sep 2018 16:50:21 -0500
Message-Id: <20180926215021.30471-6-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180926215021.30471-1-stuart.w.hayes@gmail.com>
References: <20180926215021.30471-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign maintainer for dell_rbu driver, and reassign maintainer of dcdbas
from inactive maintainer (current maintainer is aware of this change--
see https://www.spinics.net/lists/platform-driver-x86/msg16336.html).

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
Acked-by: Doug Warzecha <Douglas_Warzecha@dell.com>
---
v2 changes:
 - remove extra whitespace
 - add acked-by from (previous) maintainer of dcdbas

 MAINTAINERS | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ece30f15777..efb162a422a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4188,6 +4188,12 @@ M:	Pali Rohár <pali.rohar@gmail.com>
 S:	Maintained
 F:	drivers/platform/x86/dell-rbtn.*
 
+DELL REMOTE BIOS UPDATE DRIVER
+M:	Stuart Hayes <stuart.w.hayes@gmail.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/dell_rbu.c
+
 DELL LAPTOP SMM DRIVER
 M:	Pali Rohár <pali.rohar@gmail.com>
 S:	Maintained
@@ -4195,10 +4201,11 @@ F:	drivers/hwmon/dell-smm-hwmon.c
 F:	include/uapi/linux/i8k.h
 
 DELL SYSTEMS MANAGEMENT BASE DRIVER (dcdbas)
-M:	Doug Warzecha <Douglas_Warzecha@dell.com>
+M:	Stuart Hayes <stuart.w.hayes@gmail.com>
+L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/dcdbas.txt
-F:	drivers/firmware/dcdbas.*
+F:	drivers/platform/x86/dcdbas.*
 
 DELL WMI NOTIFICATIONS DRIVER
 M:	Matthew Garrett <mjg59@srcf.ucam.org>
-- 
2.19.0

