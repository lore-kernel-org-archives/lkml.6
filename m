Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5058C67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9C42098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 21:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cB5TpWgY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D9C42098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbeJSFyH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 01:54:07 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:43674 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbeJSFyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 01:54:07 -0400
Received: by mail-vs1-f73.google.com with SMTP id v76so13972405vsc.10
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 14:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=12a0pPTT0t2IzJ36ztwDZOEfbUvwt5h/3nY2mXK8uJc=;
        b=cB5TpWgYBTtKOMQv91oq6S6S9p8w1pitUcikiprRdaMczHJWuzo3gl+q02Nudqrd7a
         K+VrAM+8HPrCMzcrq1kINBnRbSKxyJ5hn2ul4ec+DfutZ4MmyATosrPKVsD5kdnV7DEP
         e3k2BFJvuJNHJUH+QqXb0Znm+FRrc9XxON9PSQPzlo6F3/1PQSaX87+spEPCFl3frbvF
         8O2Mb69sgaCemPYSrklpwAD4AJ1y8WJbuApn22v2mKZ1aRZVpfYRlvUxMlFdV7tGu4hy
         jNvQUVqS4fBD3UxUpT1ZYWli8y7aKe9I+63zhgWR9Qwz5wowluqbzpJWoiZMNIIFHf0Q
         Lsbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=12a0pPTT0t2IzJ36ztwDZOEfbUvwt5h/3nY2mXK8uJc=;
        b=fltTpIMGksiBwrcPBF6CfhSWUCXq0+wbxsHJQooFTd+Ay9+2SsVpmVSjNsO0qm7KFw
         LT/lUjpDhHImaXfG9WNmWrcJTHyY/y+x2Lba4XCSZVpd+ux6rqLQdlowgJm94OR9pVb9
         nX9PzgAVyEP0lGKP4AipZSYhFEjfXZDAgJvSx0EGK2AFt0NCErOXCb+TjqhvnX5r5SPa
         c6FGr9vrVFMY1+++cTtmKNK9JqHXD+RmS0R6qc9sw1qMbZ4S9fXNZH2o8Z7L+EpypvR/
         Mab/xexApoCK5lb640M6LL6s46RGTjBryLh2gmEA0o4NpAFc5SrBR5EH1yiW1hDIp+Ux
         KpMw==
X-Gm-Message-State: ABuFfojbrCwKHFpuC9zQKt2fQdb6UOMpQIwGpIUyTXGP/xsLT4EtTrk2
        7LbFVC1ENxT0S5VAG0DlF1CtR4E2aYAg
X-Google-Smtp-Source: ACcGV61gfqpFSuyIr4qqAbKGzTlNKLWH6dt6aPWzSlNZ4VAvPqjf1u9eFeYpj1dLiKviQsbUVl3ZpVT+fwNP
X-Received: by 2002:ab0:e03:: with SMTP id g3mr24551977uak.4.1539899467277;
 Thu, 18 Oct 2018 14:51:07 -0700 (PDT)
Date:   Thu, 18 Oct 2018 14:51:01 -0700
In-Reply-To: <CACRpkdY7eaYk81CU8gmHKfWB82_qNJur=c=7SCRuW+BNeL=Oiw@mail.gmail.com>
Message-Id: <20181018215101.169847-1-rajatja@google.com>
Mime-Version: 1.0
References: <CACRpkdY7eaYk81CU8gmHKfWB82_qNJur=c=7SCRuW+BNeL=Oiw@mail.gmail.com>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [PATCH] mmc: sdhci-pci: Try "cd" for card-detect lookup before using NULL
From:   Rajat Jain <rajatja@google.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Cc:     Rajat Jain <rajatja@google.com>, rajatxjain@gmail.com,
        linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dtor@google.com>, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:

The card detect IRQ does not work with modern BIOS (that want
to use DSD to provide the card detect GPIO to the driver).

Details:

(Discussion: https://lkml.org/lkml/2018/9/25/1113)

The mmc core provides the mmc_gpiod_request_cd() API to let host drivers
request the gpio descriptor for the "card detect" (or carrier detect?) pin.
This pin is specified in the ACPI for the SDHC device:

 * Either as a resource using _CRS. This is a method used by legacy BIOS.
   (The driver needs to tell which resource index).

 * Or as a named property ("cd-gpio") in DSD (which may internally point
   to an entry in _CRS). This way, the driver can lookup using a string.
   This is what modern BIOS prefer to use.

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

The SDHCI driver is thus currently broken on a modern BIOS (even if
BIOS provides both _CRS and DSD entries, either of which could be used for
a successful lookup). Ironically, none of these will be used for the
lookup currently because:

* Since the con_id is NULL, acpi_find_gpio() does not find a matching
  entry in DSDT. (The DSDT entry has the property name = "cd-gpio")

* Because ACPI contains DSDT entries, thus acpi_can_fallback_to_crs()
  returns false (because device properties have been populated from
  DSD), thus the _CRS is never used for the lookup.

Fix:

Try "cd" for lookup in the _DSD before falling back to using NULL so
as to try looking up in the _CRS.

I've tested this patch successfully with both Legacy BIOS (that
provide only _CRS method) as well as modern BIOS (that provide both
_CRS and DSD). Also the use of "cd" also appears to be farly consistent
across other users of this API (other MMC host controller drivers).

Signed-off-by: Rajat Jain <rajatja@google.com>
---
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

