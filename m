Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B70C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704D72086E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 07:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IojIif3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704D72086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbeIZNOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 09:14:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43605 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbeIZNOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 09:14:07 -0400
Received: by mail-wr1-f68.google.com with SMTP id z14-v6so8263794wrs.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 00:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x9DRnyIwDlxBMFC+cwFwAM8tC4Ew0SnOEbTDpvkAfPo=;
        b=IojIif3hdKPokkfP2Yk44uY36z2Y0sRPoTbTgiB6SKeOlTd531uSYQVPxy5N5Z8cud
         yxttA5Feq3I3JsecWngXay4HBxoj5ZScXx4/arfcWcwMVtAXY37yZgDySSstWQhsnF4r
         suNiLKsdK/ommDMkUv8YizVdJ1aSOdNm5lwxXQriTNgbh0C2wRXEen0OOTSkAX2C3kgz
         P0FRGqtZstvs8qP3YlXu7nrQ0atU6HbeL6803KGiWcssVsEZfmjgemLq7zh8+IM0nGwy
         nExqS9UK/Baf8ymf2+91OtupkKqzbOQfxoLyX2cquWPAP5NKyHeHRHQPWfTzCNzkYtUK
         rL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x9DRnyIwDlxBMFC+cwFwAM8tC4Ew0SnOEbTDpvkAfPo=;
        b=Nvv/VkPIQYTerm7t3QnudhD2mHQF9WGc3uObq+LNGxY2kGolotmzQTemeDs6PdUw8l
         3ZZYx1Z0gREfHvOhfB+MvATLQAPAax81RRpGg0XPDX4z0ZQ6V6uQWseokDnveuCeh5tU
         9TKPDmSLK8Bpqa7LG7HeD+5n9Qc5vYJL1PHGydOidIk35lulkqIexUYBZhJ07m7ghmgq
         rOkBtTAKK/CabeXwNHQHdB/mkcYAM7mxvduKEHYc7JKQ0ArpZ+2Ovbn1MQ8Lt+/ChE7t
         jdFTziD49pyQPXJODD6FSzMbKoX5MPJY3MS5af7t7XguT5sdEfr4EBM2dxsGXZCf4119
         Rnog==
X-Gm-Message-State: ABuFfogemB3YFoSZZ/Mm8mwtAoGze7AoVVELosl43NgtpJOfsd3AozGa
        56x+DP//dotaVZhsaZ04MNw=
X-Google-Smtp-Source: ACcGV62dXZno+k8zjEjTuVBqsYh7cZN6l/lJyGPAcIL73iNOqguiaQ00KnxDKLhN+PXJ/0PqxVx+QA==
X-Received: by 2002:adf:ce0e:: with SMTP id p14-v6mr4031368wrn.118.1537945358658;
        Wed, 26 Sep 2018 00:02:38 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id p9-v6sm3448307wmc.37.2018.09.26.00.02.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 00:02:38 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] staging: rtl8723bs: Mark ACPI table declaration as maybe unused
Date:   Wed, 26 Sep 2018 00:02:09 -0700
Message-Id: <20180926070208.16924-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang emits the following warning:

drivers/staging/rtl8723bs/os_dep/sdio_intf.c:25:36: warning: variable
'acpi_ids' is not needed and will not be emitted
[-Wunneeded-internal-declaration]
static const struct acpi_device_id acpi_ids[] = {
                                   ^
1 warning generated.

Mark the declaration as maybe unused like a few other instances of this
construct in the kernel.

Link: https://github.com/ClangBuiltLinux/linux/issues/169
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 6d02904de63f..3285bf36291b 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -22,7 +22,7 @@ static const struct sdio_device_id sdio_ids[] =
 	{ SDIO_DEVICE(0x024c, 0xb723), },
 	{ /* end: all zeroes */				},
 };
-static const struct acpi_device_id acpi_ids[] = {
+static const struct acpi_device_id acpi_ids[] __maybe_unused = {
 	{"OBDA8723", 0x0000},
 	{}
 };
-- 
2.19.0

