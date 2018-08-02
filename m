Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C226CC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7420420C0C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 08:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmBfVE+/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7420420C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732120AbeHBKeX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 06:34:23 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35280 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbeHBKeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 06:34:23 -0400
Received: by mail-qk0-f195.google.com with SMTP id u21-v6so1026319qku.2;
        Thu, 02 Aug 2018 01:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=L0QuFqGTDC7c3vLAvTOolp2gyhmIHADwyhlDFdB+fHg=;
        b=GmBfVE+/rZxssXpqqODlL8SDcFLgwjYdmLRLWQnp8pnmsluSemGJHsefk4LgLX30+J
         p8a8Z9oQL8zC7isu01fkRZPpgByIL0o+DKoyIuXBCHDIMBin9y395PHHPAFa9GDiHkOV
         p8DUJYGyDXuhYc8H/Tp1ewnJl96wOJvSJ7if0uWJA4WEgDxTDqYnQniYbhLDZ5Pufqp4
         1ReGS/9ts2gkmTRMr32cqm+oAlv1kl1IodwPc1M1JVrEUDcEPuIRXC+nf5bBlo1T8btj
         6EhFFYIIgWw0ENnX5jsOmNKYV03Q92WGUGpnKAWN51JuzoMJsaSkLpEskD9pV3iXSxLh
         osAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L0QuFqGTDC7c3vLAvTOolp2gyhmIHADwyhlDFdB+fHg=;
        b=ivV9z8KQAUSswa8LKaz4NAxBGTWncNB9NA7d/52aipyIbwAYIhxfwhzMHLrt33bVvo
         flrhbnTMF2rLFEDkCydf6pi6xGNRiZaNgESxtjGlDUNjQ3UpHAUQnYED5V5JP2CoGsq8
         yjFbG8hCrdkZmbeIcS/HLTRujPXQXJk+rV37w4KpkbcDFFhUZaHn5lQNAacoIvutVF1R
         nW9vO8Ur8VjSZT8dO/lFRRqcogRHXUzXhhhvteei8XEyS+rBhWgE9EPD3iiKSDDzXDZd
         UgI2T5defMqwp2x0MvZ9xVnky1VXPwIUKkM/fQ7sk+8sSDxgesPyorcEBOK9lNA4Em1j
         nkVg==
X-Gm-Message-State: AOUpUlEkadGz1Kf79Bn1XVMlZGVcZbiKz86rDU2qE6PFbZoOju5KjF6D
        oHCcKFlxU8pQynuPgRTYmIs=
X-Google-Smtp-Source: AAOMgpexuBvXZFN1KXu1jNzdDXjUYvRKvgfG7d+RYv8Hx/GUxsJgO61P0lkH/3urGmDAdew/4tMfTw==
X-Received: by 2002:a37:bd02:: with SMTP id n2-v6mr1081507qkf.336.1533199454653;
        Thu, 02 Aug 2018 01:44:14 -0700 (PDT)
Received: from localhost.localdomain ([104.237.86.58])
        by smtp.gmail.com with ESMTPSA id g39-v6sm881943qtb.47.2018.08.02.01.44.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Aug 2018 01:44:14 -0700 (PDT)
From:   oceanhehy@gmail.com
To:     dan.j.williams@intel.com, ross.zwisler@linux.intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com, rjw@rjwysocki.net,
        lenb@kernel.org
Cc:     linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ocean He <hehy1@lenovo.com>
Subject: [PATCH v2] ACPI: nfit: remove redundant assignment if nfit_mem found
Date:   Thu,  2 Aug 2018 04:44:04 -0400
Message-Id: <1533199444-29607-1-git-send-email-oceanhehy@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ocean He <hehy1@lenovo.com>

When nfit_mem is found via list_for_each_entry, it has already been
assigned valid value. There is no need to assign it again in the following
codes.

Signed-off-by: Ocean He <hehy1@lenovo.com>
---
v1: https://patchwork.kernel.org/patch/10553277/
v2: Sorry for noise. I got an email problem, so I have to resend to loop 
linux-nvdimm@lists.01.org.

 drivers/acpi/nfit/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 7c47900..85dde54 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1048,9 +1048,7 @@ static int __nfit_mem_init(struct acpi_nfit_desc *acpi_desc,
 				break;
 			}
 
-		if (found)
-			nfit_mem = found;
-		else {
+		if (!found) {
 			nfit_mem = devm_kzalloc(acpi_desc->dev,
 					sizeof(*nfit_mem), GFP_KERNEL);
 			if (!nfit_mem)
-- 
1.8.3.1

