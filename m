Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A015C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7AA120657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 22:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LUCJ4X6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7AA120657
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbeJ3HHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 03:07:45 -0400
Received: from mail-ot1-f74.google.com ([209.85.210.74]:35885 "EHLO
        mail-ot1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbeJ3HHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 03:07:45 -0400
Received: by mail-ot1-f74.google.com with SMTP id v95so1143532ota.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 15:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=v2rMXvzKWECS79zyMLwtUWxdg5/xyv6bQsMHck8PeHs=;
        b=LUCJ4X6onUxUt+WiTRlTWYzC2I5Qs7dVa42ShD2nZxYWJSLPs9VeRT0iXu6rbPPmre
         qYEDlYXyyIk4zJTU/u7sMPSmX+Iau0sMeoXPV1EwFkfHExPObyFVY+ySelIRTInAASL4
         Urg8zM/rexr8FgHKuI1D3e2sSXn0ValX4gAjS/awKJ2Vfd7a3CI/Q5H60Z75cTPTSUx/
         1Q90nK6Tu+zwTlH/8jzH6hWQV5j/KhQq3jPVQLidwTUN2KM3Y/se4EjtdrCf7W6BFbNq
         wvKGretz1Gu4nBJi7sdj8JxxgtoZIGpR0LlSk3yJ5VUqCnAxzjiz4QISLhFybbTUNrlG
         tO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=v2rMXvzKWECS79zyMLwtUWxdg5/xyv6bQsMHck8PeHs=;
        b=MVc/5fyWOVZd0psjGH5WDETPHwV6AHEqMnB3pHxNX5VscrgKtkGcgjSq4sVCL2EcHf
         WSXPZeFGuXUDIxSdvBw0GrsUCpzdcSBXbBmzQ0nPWBfOniZDEEctDAGfRTeJO2kpJmCP
         7FThUkKQG2AhnSApAPLdp+Mbos45dL6Igz7kXh10D2ZBzmDIoXFDLeOMSskUdnLCLc0b
         lpPZ/20BX5tWxosrdqM/aiX7hHHvIHLUJM4VUVU+l1IGr/TQx2QK+cg14GffNi8DgqeB
         5xKXjGmMGx9mlBFa7lIDFdLDCmycMwH/NWz8SqlZsyAGKyXnCaGcs4ibFa5agNXBTAqJ
         yWiQ==
X-Gm-Message-State: AGRZ1gIQyJNZcCG1SqpSn+1AhaACGRqYp9dCNcoGbQz/RSL3fZuKY8wR
        MUGxU2hAfFcxrfXBXXBAdv3cM+ZF7LTZ
X-Google-Smtp-Source: AJdET5dBlSMM8lfjYMLAqPBijGOAbWSEAXhg9dhXCJwZUCFL5/Zq0I4DXXXV89TAzIbUCX4ehV1czbF9DzTO
X-Received: by 2002:a9d:6552:: with SMTP id q18mr11827520otl.37.1540851425913;
 Mon, 29 Oct 2018 15:17:05 -0700 (PDT)
Date:   Mon, 29 Oct 2018 15:17:01 -0700
In-Reply-To: <CAA93t1oaZ5zkv+BsGnYZg6pqKv0DzXi3j8oZHUyTyffUWHtHug@mail.gmail.com>
Message-Id: <20181029221701.51376-1-rajatja@google.com>
Mime-Version: 1.0
References: <CAA93t1oaZ5zkv+BsGnYZg6pqKv0DzXi3j8oZHUyTyffUWHtHug@mail.gmail.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [PATCH v2] mmc: sdhci-pci: Try "cd" for card-detect lookup before
 using NULL
From:   Rajat Jain <rajatja@google.com>
To:     adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dtor@google.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:

The card detect IRQ does not work with modern BIOS (that want
to use _DSD to provide the card detect GPIO to the driver).

Details:

The mmc core provides the mmc_gpiod_request_cd() API to let host drivers
request the gpio descriptor for the "card detect" pin.
This pin is specified in the ACPI for the SDHC device:

 * Either as a resource using _CRS. This is a method used by legacy BIOS.
   (The driver needs to tell which resource index).

 * Or as a named property ("cd-gpios"/"cd-gpio") in _DSD (which internally
   points to an entry in _CRS). This way, the driver can lookup using a
   string. This is what modern BIOS prefer to use.

This API finally results in a call to the following code:

struct gpio_desc *acpi_find_gpio(..., const char *con_id,...)
{
...
   /* Lookup gpio (using "<con_id>-gpio") in the _DSD */
...
   if (!acpi_can_fallback_to_crs(adev, con_id))
          return ERR_PTR(-ENOENT);
...
   /* Falling back to _CRS is allowed, Lookup gpio in the _CRS */
...
}

Note that this means that if the ACPI has _DSD properties, the kernel
will never use _CRS for the lookup (Because acpi_can_fallback_to_crs()
will always be false for any device hat has _DSD entries).

The SDHCI driver is thus currently broken on a modern BIOS, even if
BIOS provides both _CRS (for index based lookup) and _DSD entries (for
string based lookup). Ironically, none of these will be used for the
lookup currently because:

* Since the con_id is NULL, acpi_find_gpio() does not find a matching
  entry in DSDT. (The _DSDT entry has the property name = "cd-gpios")

* Because ACPI contains DSDT entries, thus acpi_can_fallback_to_crs()
  returns false (because device properties have been populated from
  _DSD), thus the _CRS is never used for the lookup.

Fix:

Try "cd" for lookup in the _DSD before falling back to using NULL so
as to try looking up in the _CRS.

I've tested this patch successfully with both Legacy BIOS (that
provide only _CRS method) as well as modern BIOS (that provide both
_CRS and _DSD). Also the use of "cd" appears to be fairly consistent
across other users of this API (other MMC host controller drivers).

Link: https://lkml.org/lkml/2018/9/25/1113
Signed-off-by: Rajat Jain <rajatja@google.com>
---
v2: Fix the commit log to take care of Andy's comments.

 drivers/mmc/host/sdhci-pci-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 7bfd366d970d..e53333c695b3 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1762,8 +1762,13 @@ static struct sdhci_pci_slot *sdhci_pci_probe_slot(
 		device_init_wakeup(&pdev->dev, true);
 
 	if (slot->cd_idx >= 0) {
-		ret = mmc_gpiod_request_cd(host->mmc, NULL, slot->cd_idx,
+		ret = mmc_gpiod_request_cd(host->mmc, "cd", slot->cd_idx,
 					   slot->cd_override_level, 0, NULL);
+		if (ret && ret != -EPROBE_DEFER)
+			ret = mmc_gpiod_request_cd(host->mmc, NULL,
+						   slot->cd_idx,
+						   slot->cd_override_level,
+						   0, NULL);
 		if (ret == -EPROBE_DEFER)
 			goto remove;
 
-- 
2.19.1.568.g152ad8e336-goog

