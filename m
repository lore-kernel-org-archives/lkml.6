Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F90C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 04:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7A320842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 04:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SV15j8QA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7A320842
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeG0FVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 01:21:16 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42071 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbeG0FVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 01:21:16 -0400
Received: by mail-qt0-f196.google.com with SMTP id z8-v6so3831148qto.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 21:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=X0w1efvXaK9Zo8ADrUTbqDp9GUR4TScxv019+ZKxMQI=;
        b=SV15j8QAw1/8S1hcCXIjBAkd3Dqy/91/4aYMtuuNQNXqiilCBQpPRwyGIN/WW0qAt0
         GXw9Dt2b+CiEKHAwRYPY6x7ZJKYyzFwA/4Cr29E34ONiYY1/eU7XY51RcIk3ezoG3J7Y
         DuhDLgva0g68iHQuwdpU7Sc4y5wzm2ZHwpbBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=X0w1efvXaK9Zo8ADrUTbqDp9GUR4TScxv019+ZKxMQI=;
        b=BJ1eHHpH9eh7EUZStx+3cpOFe2DmzICrSdvqNen9z2qngT4mXHRZZCJIuC6VnkB3y2
         MgjrHTkgxyBzuISZhhvEmiqJfVWWDE0Pv/XewBg/GdrzEdpQ10SOgd2CYWjN2gjI1LAZ
         xHw9pCMTUB+9et3cb+l1u14lWIq3OpipXUndZhwesdR9tGLsGE5YN/GvetTJ7yfLLI+/
         1Ih2h1mjjDNE4iZ3PihkCEVfLhTtRCa76BPIEYgPYCa3T6HvEYSJlIZ+xXHVCrwSj1dh
         En+PvJ8bEl8ZJaqSfjoA/2FOZN/aLI+P1vgii+b5b6fiIIgA8qZrgF+mtr+st4GcW65+
         xDdw==
X-Gm-Message-State: AOUpUlEjRKbYqhvfKJOVIoxFLz5tDwLeNznCIlvUG1HVxDAncDPLaALR
        HlQMN5tgzDsWvaZorysmIzWw3A==
X-Google-Smtp-Source: AAOMgpd1j2z/xdCcjFZuJE0ZwbT0xVxg6EBftjgYKgLAX+BTR9uSdnTCDmkr6p2XOAyDxu/P2U9aow==
X-Received: by 2002:ac8:530d:: with SMTP id t13-v6mr4369404qtn.396.1532664082422;
        Thu, 26 Jul 2018 21:01:22 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.252.250])
        by smtp.gmail.com with ESMTPSA id f184-v6sm2006522qkc.23.2018.07.26.21.01.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Jul 2018 21:01:21 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, vikram.prakash@broadcom.com,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH] serial: 8250_dw: Add ACPI support for uart on Broadcom SoC
Date:   Fri, 27 Jul 2018 09:31:06 +0530
Message-Id: <1532664066-30056-1-git-send-email-srinath.mannam@broadcom.com>
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
---
 drivers/tty/serial/8250/8250_dw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index aff04f1..7ea94ec 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -708,6 +708,7 @@ static const struct acpi_device_id dw8250_acpi_match[] = {
 	{ "AMD0020", 0 },
 	{ "AMDI0020", 0 },
 	{ "HISI0031", 0 },
+	{ "BRCM2032", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, dw8250_acpi_match);
-- 
2.7.4

