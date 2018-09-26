Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38F4C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9687720684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 12:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FqFOdIJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9687720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbeIZSkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 14:40:33 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8707 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbeIZSkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 14:40:32 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5bab7b480001>; Wed, 26 Sep 2018 05:27:52 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 26 Sep 2018 05:27:46 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 26 Sep 2018 05:27:46 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 26 Sep
 2018 12:27:46 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 26 Sep 2018 12:27:46 +0000
Received: from moonraker.nvidia.com (Not Verified[10.21.132.143]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5bab7b400000>; Wed, 26 Sep 2018 05:27:45 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, Jon Hunter <jonathanh@nvidia.com>
Subject: [PATCH 1/5] PM / Domains: Export symbol for genpd_dev_pm_attach_by_name
Date:   Wed, 26 Sep 2018 13:27:34 +0100
Message-ID: <1537964858-30332-2-git-send-email-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537964858-30332-1-git-send-email-jonathanh@nvidia.com>
References: <1537964858-30332-1-git-send-email-jonathanh@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1537964872; bh=1w1JFpmw3dg1UHjssFK9Cip16Tg6vgXkahZhvVTfVP0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=FqFOdIJwfOG4t2aZW/hofstETrf5NITRLFU70HW0Dxo6bO+tSB4pDqbDJ6Xc5rZp6
         cIHjDbgQuH1UiN7/10yxsQT3FLeHhGPjq4uOUdAwdcuwTiUtA5lv9IyFrPZJxL1Pad
         OEzZHbP0lRQEFeXS2jeFHPTLim+KAAHxYcrtWMeEFDWpPucISOJ2/V+5HIkn0cQVGU
         Bs0CXHvDoYHt7+abVFcdHlAjZZBGB0R+vIatSd3IoAsHuaAgWfEYkgLEY1mcY6XKWq
         Z/QsYdchGWBu84FZIjSKldhYVe/S0CAHDYOnwzGDX5v51SK8exC6HmkwrqasW49xIS
         KwZ8dlTh6Pl5g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export the symbol for genpd_dev_pm_attach_by_name() so that drivers
built as modules can call this function.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 drivers/base/power/domain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 4b5714199490..b2bbe0d848d2 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2397,6 +2397,7 @@ struct device *genpd_dev_pm_attach_by_name(struct device *dev, char *name)
 
 	return genpd_dev_pm_attach_by_id(dev, index);
 }
+EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_name);
 
 static const struct of_device_id idle_state_match[] = {
 	{ .compatible = "domain-idle-state", },
-- 
2.7.4

