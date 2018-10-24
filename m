Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D045C46475
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A80EA20832
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 03:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ubkKuQU2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A80EA20832
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbeJXLeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 07:34:19 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36042 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbeJXLeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 07:34:19 -0400
Received: by mail-pg1-f195.google.com with SMTP id l6-v6so1625578pgp.3;
        Tue, 23 Oct 2018 20:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nsuYjcR1EiPlDCJ6JViUW3dlgy89BBd7N5H87xE87CE=;
        b=ubkKuQU2ptxlXeSTDT848h8n7RDmXT9J0x8RR9wqe7y571qSuE/IrY6xfBi1ybOTGt
         syDTlQNrvioVDWgJvJbUFFvUhn/4iYxyB+X07ZVK5rFdlv4Dpnu95nSQUXOzJIDSe+h8
         zyy4EsSJzhYPX+veKAOnQ+UmQaxAzAXTVF84pk1tP5VBri9zORekoj5SKQtYf0GQpvcI
         eEEDcjVTVSdj3iaEgEKhuwB1P/E4CJrWEjTew89zxZa70R/gsPoP+l330fuIuOXAx2+j
         R84QnEMG/Ko50qNOPIEWRaSiO2E/NKe6AZSbHMrziZpA+rBfYGBgqc6nxVEwOUhgmE6q
         4aVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nsuYjcR1EiPlDCJ6JViUW3dlgy89BBd7N5H87xE87CE=;
        b=S0u2SZOzgnrAvXb1fReMptKeaKAvH9bEbMNHoM9+mjnfjWVf8GCrOz9xVLA371C+sy
         uU/As1UvwpU8BwNcm+hTGxyBc1DRN5xSkd+763uyfpPkYoucDMK2UcETd5/aRYcpRozT
         iqSMOPPOQg/5okamZzGtAcwUuBwLBp5hnGr/2a6SHIpHJVKXoHpE7bDath09vPmX0QmC
         o6hdIuaundhQmZ/T8tjtGKz/LoU3cGetcrnvG8BykY0S3ql6/D+Mp4XN/f28J4exxs/V
         hRpni2W0vTErvq2al0+xNeiWNRygS8vYziA/upXqdyXxN4MSY9sOhlTkrkmvxHGlDSRZ
         L7sw==
X-Gm-Message-State: AGRZ1gJhRZxZFSkYeePw4NC2V2i7li/4Y0cZqGwl5gaBLA/ybaK/G9Io
        pMuTQauj0LNdPT2Jv6Pf9g/c5opf
X-Google-Smtp-Source: AJdET5cc0i8uCrPezrM5rd+Nk5MIEcEXua+GqjevguZVp7wx+xPrnyGvuIm7JgiMv+2A8Cl0djEUnQ==
X-Received: by 2002:a65:4981:: with SMTP id r1-v6mr771496pgs.153.1540348590701;
        Tue, 23 Oct 2018 19:36:30 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n17-v6sm3606625pfj.84.2018.10.23.19.36.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 19:36:30 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] hwmon: (ina3221) Check channel status for alarms attribute read
Date:   Tue, 23 Oct 2018 19:36:20 -0700
Message-Id: <20181024023623.4231-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181024023623.4231-1-nicoleotsuka@gmail.com>
References: <20181024023623.4231-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is nothing critically wrong to read these two attributes
without having a is_enabled() check at this point. But reading
the MASK_ENABLE register would clear the CVRF bit according to
the datasheet. So it'd be safer to fence for disabled channels
in order to add pm runtime feature.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog
v1->v2:
 * Returned 0 for alert flags instead of -ENODATA

 drivers/hwmon/ina3221.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/hwmon/ina3221.c b/drivers/hwmon/ina3221.c
index d61688f04594..26cdf3342d80 100644
--- a/drivers/hwmon/ina3221.c
+++ b/drivers/hwmon/ina3221.c
@@ -200,6 +200,12 @@ static int ina3221_read_curr(struct device *dev, u32 attr,
 		return 0;
 	case hwmon_curr_crit_alarm:
 	case hwmon_curr_max_alarm:
+		/* No actual register read if channel is disabled */
+		if (!ina3221_is_enabled(ina, channel)) {
+			/* Return 0 for alert flags */
+			*val = 0;
+			return 0;
+		}
 		ret = regmap_field_read(ina->fields[reg], &regval);
 		if (ret)
 			return ret;
-- 
2.17.1

