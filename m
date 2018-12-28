Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88B5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 20:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70B662146F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 20:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="KMRGGgVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387960AbeL1UDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 15:03:30 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:45536 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbeL1UDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 15:03:30 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 7EF27D9D
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 20:03:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2Ve_o4lwoTeT for <linux-kernel@vger.kernel.org>;
        Fri, 28 Dec 2018 14:03:28 -0600 (CST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 52ACBD5F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 14:03:28 -0600 (CST)
Received: by mail-io1-f70.google.com with SMTP id v8so25779236ioh.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 12:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6HU4GYw9w97SjMNZqgxMv9haqNXMFmRRQpnbKAb7h4M=;
        b=KMRGGgVXODt5AidcZ+eQzoTSPIG2VTPkcL5nbR7lAEaPigN73Rm3n7bgclZtbmBwrm
         VS0e1DH+XPnwkMhcrAAwtFC45fEbPv8tFAlDB18uexj9QJqgzcISiAX0SahQJuay7X42
         +jErU4fTajLuA7o+fbcMU52X8BcaxsAyJ/2KxwfxWL8z4JvN0HjzCLUy6J0q3sU6KuAZ
         UpXk/ds/P+jZJj7u7IxJK2syAS+s6KAnxqIRGbhvPngBIfCpIEr5XfnPQ7xAg9bpKj8p
         wxcAOQ8wpLMtZImELdLDVR9jrmCRjIUYcGfGrfujXy1flbgw/dwYLSBhi/EpsR3uzOnM
         5k/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6HU4GYw9w97SjMNZqgxMv9haqNXMFmRRQpnbKAb7h4M=;
        b=lBY4qjyntCihj6J4AZ0+tY9/EJupZzPoWvheZ3h8gmVaLkd5jPCjfOySMLz+L41B4G
         acbfozplzd3XjwAoYdwCHFrM7AVY5cVuW3Fezr6oPGTjMJ9YBDG8BTamDTS1CRplTPOz
         KIlwZ6FZxmF5p2fR/qqaWfuYhHCF+/M68fq+3zgJZFW2eQFOP3vF4SgWEGham3ycnZm/
         DxAMUzfoTzOWkePVvJYJyubqpy7zi1ndNZ5HDr0XvIi9P+7WOkmhLzYv/FQnKBVGH56K
         uuouIqlLZSeBPJGPbUVcBIaK+4Nso2e+UOTa2sI+Zo3PagCNKf0vMz5QBuuIkyjdHl08
         zOsQ==
X-Gm-Message-State: AA+aEWZ9jwX3HIK8GgbmzN4ywyrzXWjeI3xM3AkVa1pDLcrcBAanVo1X
        eQEEWBsX6DqXtgKYbRi5jaRZACARocCcEnBnN/U0mbVu3gsD41f7MlDIUajfSmVegvBwAABd5tc
        w+aDt5RGdwDXX95WzPK8UnADTq8B5
X-Received: by 2002:a24:a04:: with SMTP id 4mr18420151itw.122.1546027407890;
        Fri, 28 Dec 2018 12:03:27 -0800 (PST)
X-Google-Smtp-Source: AFSGD/VRMJoq4QwqTUgUA6lR030Cl4EaWFTFOwtSITNTOuCitmjsVvrZdWMJ+PBatBLNrt/YmOuwOQ==
X-Received: by 2002:a24:a04:: with SMTP id 4mr18420137itw.122.1546027407625;
        Fri, 28 Dec 2018 12:03:27 -0800 (PST)
Received: from cs-u-syssec1.cs.umn.edu (cs-u-syssec1.cs.umn.edu. [134.84.121.78])
        by smtp.gmail.com with ESMTPSA id t71sm11045076ita.32.2018.12.28.12.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 12:03:27 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Lee Jones <lee.jones@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: sm501: Check for driver register failure
Date:   Fri, 28 Dec 2018 14:03:15 -0600
Message-Id: <20181228200316.11473-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While initializing the driver, the function platform_driver_register can
fail and return an error. Consistent with other invocations, this patch
returns the error upstream.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/mfd/sm501.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index a530972c5a7e..62cf62636ae6 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1729,7 +1729,11 @@ static struct platform_driver sm501_plat_driver = {
 
 static int __init sm501_base_init(void)
 {
-	platform_driver_register(&sm501_plat_driver);
+	int rc;
+
+	rc = platform_driver_register(&sm501_plat_driver);
+	if (rc)
+		return rc;
 	return pci_register_driver(&sm501_pci_driver);
 }
 
-- 
2.17.1

