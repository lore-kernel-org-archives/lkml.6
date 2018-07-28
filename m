Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47337C28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 15:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E211820878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 15:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JlsHo778"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E211820878
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbeG1Qwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 12:52:37 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:45414 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbeG1Qwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 12:52:37 -0400
Received: by mail-qk0-f196.google.com with SMTP id c192-v6so5233420qkg.12
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 08:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=GBAf6aD+yCnCrvhJWqr/SOPg60z4IJ+cJ6NpSHr5p0U=;
        b=JlsHo7788tHlxVKSm2qAnm/NLzLaGzVuu+KxBdiiZZnEaONbpgKF50k6LfLy6k0owq
         E6fXWVDYKKogtCmdJH50pe6EJRVTVHZ70unW2HBTbqVl/8Lw2Sg+x3/HirSier44Q0R2
         m8VcHI4Uf5uOyPb4S/RYAt4lW7BxT9eNQm5qQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GBAf6aD+yCnCrvhJWqr/SOPg60z4IJ+cJ6NpSHr5p0U=;
        b=W+adyDVVaImmuOsJVVSQnk7Ez/FeQFV1BJ5ERKmgWY/T2CrD5x0C1mCKCj/j6tI4oy
         4b/shaqtrqpZU3nRIkZGVnVvTuu7J3kQAWiea+DCWD8CP+U26MireEPR2iYavSqFKSWo
         AoYHUL/jSoQWk0G0OGxvA3Ki7f5TART8Me1f5J2fAF5nXftvMojlY4Zj82b10XtDNBv5
         RJjU+McUa0vVfrnfOl/nfeGV3HZmCqXmCdcwVXNpPGuL1o91M3rhYfHQfDmSUHmOsy4v
         ziYTtFfIDF82ywqdvUaDJgAFBuS2LMbhzQIHFGSH+ZNbGcrbAOu7hIRHMnQvEA9zXGLL
         OyyA==
X-Gm-Message-State: AOUpUlGDoRHC0jneIX8EDJr/nELEnxlqxl7MBHrUxVXE1mpNCO4gl6nC
        HBd5OPOesERPNjOmE7nDuZeT8w==
X-Google-Smtp-Source: AAOMgpc6a2gGqJXKkyYNqHG+ay/lkDqyY/gfZd0ndJ0eae3v4pJpgO6iqBmjpAaNxyQvNhrCeWXtww==
X-Received: by 2002:a37:2fc6:: with SMTP id v189-v6mr9941600qkh.433.1532791544322;
        Sat, 28 Jul 2018 08:25:44 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.252.250])
        by smtp.gmail.com with ESMTPSA id r13-v6sm4250607qke.21.2018.07.28.08.25.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 28 Jul 2018 08:25:43 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, vikram.prakash@broadcom.com,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v3] serial: 8250_dw: Add ACPI support for uart on Broadcom SoC
Date:   Sat, 28 Jul 2018 20:55:15 +0530
Message-Id: <1532791515-5603-1-git-send-email-srinath.mannam@broadcom.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ACPI identifier HID for UART DW 8250 on Broadcom SoCs
to match the HID passed through ACPI tables to enable
UART controller.

Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Reviewed-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
Tested-by: Vladimir Olovyannikov <vladimir.olovyannikov@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Changes from v2:
   - Missed to add details about v1 changes.

Changes from v1:
   - Change to keep acpi Id string in alphabetical order
   - Added Reviewed-by Andy Shevchenko

 drivers/tty/serial/8250/8250_dw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index aff04f1..40811df 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -707,6 +707,7 @@ static const struct acpi_device_id dw8250_acpi_match[] = {
 	{ "APMC0D08", 0},
 	{ "AMD0020", 0 },
 	{ "AMDI0020", 0 },
+	{ "BRCM2032", 0 },
 	{ "HISI0031", 0 },
 	{ },
 };
-- 
2.7.4

