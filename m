Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C874C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C03CF206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UL65bXic"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03CF206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbeI1Xdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:33:32 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35246 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeI1Xdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:33:32 -0400
Received: by mail-lj1-f195.google.com with SMTP id w4-v6so6546181ljd.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 10:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FvrNmK0AcMIRiibloxyokLQsM+KkzTGMPrbzcQDEiPs=;
        b=UL65bXicEW9B4AvP/NO2dm4SpGGqpyEzBWqtPCvV5mnqLAeOprsI4r+xE5UM0xC+sC
         Hf3KwPTI2AEFQrG9JY1Hk4qbDVqS+1kuwFP0fkLwV7oCkV6ba7Jwsbz0Qy9qbo+zz5Hh
         WPj7AUOv1fWSECxAwEhEi5keoCVTJn9zFkETahskV8qXzWEX7LJO01rbODxeXodfzrs5
         q6TXLdSiR4nHqQUzxt01wUjwyeioznckwpbLKTbV9Lhrn2HmdcA2Vzk/tYUXy4bqcskE
         ERdnkguVEkdGgYwVSGhQ12noMfT0M/njIl6SHtLPuVmTTAMcdBgsPWxR4Dp1FmipttYa
         QHUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FvrNmK0AcMIRiibloxyokLQsM+KkzTGMPrbzcQDEiPs=;
        b=KmwU0zSMQA59ZiumghOrSlA03hIukaIBI+Mflm2UE9DWCwNB7GX11sHwSwBWv6ma88
         Dm0wBnxJdxc2I9H8ztcp3eqWQCZv9Zr7VEMvpmz5gNJb2hg8kH0yCvCRTSSfMtWrRITM
         2buQX06Wes/qH8H7b5ISS8rFcp6iDEp/Ln2SM3pyZd53oEr2HnQsC7qo36gJFJJT8tvw
         hSxlRgk8Bv7U0mMnWlms90VBZz8Duf26vADvmf1HzdS3fM4nIXukJoLw36JR5obBvIbJ
         r4X9ezWg62sXiI7vTDY6MdZmS05hIKCkIkB4B2rWDNCKC3VXBrjLmwAyuBBlsWU0LXLJ
         2XSw==
X-Gm-Message-State: ABuFfogInkQjLwh3UBOa29OxWHfMuWj8Pik9N5mD6W7wMOXlwMJwacrn
        ox1+/ojxCWtKKHz24W2d3Q==
X-Google-Smtp-Source: ACcGV611PYVCvER5FYB1EgcVRQVOrOF0hpUA5lwwcPmOg0uuQYqM2sahCdDj5E/hGpTJQfNU8zzeWw==
X-Received: by 2002:a2e:9cd3:: with SMTP id g19-v6mr4756647ljj.161.1538154528933;
        Fri, 28 Sep 2018 10:08:48 -0700 (PDT)
Received: from localhost.localdomain ([2001:999:51:565d:44e6:f5ff:fe2f:8bf6])
        by smtp.gmail.com with ESMTPSA id g16-v6sm1122244lfj.15.2018.09.28.10.08.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 10:08:48 -0700 (PDT)
From:   Emil Karlson <jekarlson@gmail.com>
To:     Emil Renner Berthing <kernel@esmil.dk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Stefan Adolfsson <sadolfsson@chromium.org>,
        lee.jones@linaro.org, bleung@chromium.org, olof@lixom.net,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Emil Karlson <jekarlson@gmail.com>
Subject: [PATCH] mfd: cros-ec: copy the whole event in get_next_event_xfer
Date:   Fri, 28 Sep 2018 20:08:18 +0300
Message-Id: <20180928170818.32124-1-jekarlson@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <22cc40a7-015b-6038-2093-8cd1ff0c807e@baylibre.com>
References: <22cc40a7-015b-6038-2093-8cd1ff0c807e@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 57e94c8b974db2d83c60e1139c89a70806abbea0 caused cros-ec keyboard events
be truncated on many chromebooks so that Left and Right keys on Column 12 were
always 0. Use ret as memcpy len to fix this.

drivers/platform/chrome/cros_ec_proto.c:509
get_next_event_xfer uses ret from cros_ec_cmd_xfer for memcpy for msg->data len
drivers/platform/chrome/cros_ec_proto.c:445
cros_ec_cmd_xfer gets ret from send_command
drivers/platform/chrome/cros_ec_proto.c:93
send_command gets ret from bus specific xfer_fn
drivers/mfd/cros_ec_spi.c:598
cros_ec_cmd_xfer_spi copies len amount to ec_msg->data and returns len as ret
drivers/mfd/cros_ec_i2c.c:267
cros_ec_cmd_xfer_i2c copies len amount to ec_msg->data and returns len as ret

so msg->data length is always the same as ret.

Fixes: 57e94c8b974d ("mfd: cros-ec: Increase maximum mkbp event size")
Signed-off-by: Emil Karlson <jekarlson@gmail.com>
---
 drivers/platform/chrome/cros_ec_proto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 398393ab5df8..b6fd4838f60f 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -520,7 +520,7 @@ static int get_next_event_xfer(struct cros_ec_device *ec_dev,
 	ret = cros_ec_cmd_xfer(ec_dev, msg);
 	if (ret > 0) {
 		ec_dev->event_size = ret - 1;
-		memcpy(&ec_dev->event_data, msg->data, ec_dev->event_size);
+		memcpy(&ec_dev->event_data, msg->data, ret);
 	}
 
 	return ret;
-- 
2.19.0

