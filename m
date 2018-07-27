Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2EAC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:43:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D6620894
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 08:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="c2tg0aTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79D6620894
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730425AbeG0KEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 06:04:06 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37102 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729489AbeG0KEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 06:04:06 -0400
Received: by mail-qt0-f195.google.com with SMTP id n6-v6so4307235qtl.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 01:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dRsRKUQPdwNYNTxz6q02fRHlzHdX/461VYoPo64gEig=;
        b=c2tg0aTKWMCixDGvlDJJY9QzDy6F1oKtJnIybONfhSu+Yigi5GbaLt9qGazgamsia3
         75d8P4rxRGlKSngUqSDMy6TNQetao3oB4hXic9q+RFofC0PdvokHXiHjNawM2omHyIbH
         40yfihpBKPfKgaC/yE603fb8AW7qo2lRNcLQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dRsRKUQPdwNYNTxz6q02fRHlzHdX/461VYoPo64gEig=;
        b=dZyPDjb6OUPEhiYhTStgdXRwGhIx7phDQH2i5YD9uzuKVfo1jRGVrNJHRV+1nNjJQk
         +L72UPSyVvjakEKyjZXF2RhWfMFpS+pmGSN4iXgtmueKVEc+vEYSYBCooNEmV9YWcGt+
         YiP7GbdQ4mO7MYLKl/hO6CqXqXpyBLI72gg7Bt/97/G05pM6OdmfAwj3BRilfbAKDfGF
         lm8Zzbyg5+4vYYlzuEE4EsULwxZEz+IrydYvx09nlaYbn7gRMDFf/GED7PM74Ok7yG7L
         97UKFJP/qKR9NfgDE4cdtc6zyXe9aR4z6BAJ23/KNFf8y0oFe54UmGpxneufPIv54JGV
         x2Jw==
X-Gm-Message-State: AOUpUlHOCg9agLCaNi+I6xhGH+P8TU6ZV4wIPQjqw0jsT/lqP5MEUyam
        pO/8+jeC/IX9sBP9BPi+unEFSA==
X-Google-Smtp-Source: AAOMgpd4VZTnz5Y/F49iFbvz5YDe8t0XBSFL+/RwuOEbWsTmx1aNexiIzvJ0tUsRTp37UgKxtI9wyw==
X-Received: by 2002:a0c:c963:: with SMTP id v32-v6mr4742201qvj.215.1532680994394;
        Fri, 27 Jul 2018 01:43:14 -0700 (PDT)
Received: from mannams-OptiPlex-7010.dhcp.broadcom.net ([192.19.252.250])
        by smtp.gmail.com with ESMTPSA id v71-v6sm2681470qkl.42.2018.07.27.01.43.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 27 Jul 2018 01:43:13 -0700 (PDT)
From:   Srinath Mannam <srinath.mannam@broadcom.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, vikram.prakash@broadcom.com,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Srinath Mannam <srinath.mannam@broadcom.com>
Subject: [PATCH v2] serial: 8250_dw: Add ACPI support for uart on Broadcom SoC
Date:   Fri, 27 Jul 2018 14:12:50 +0530
Message-Id: <1532680970-5703-1-git-send-email-srinath.mannam@broadcom.com>
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

