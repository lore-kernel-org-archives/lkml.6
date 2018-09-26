Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E508C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B877121537
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 23:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phpw1qOZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B877121537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbeI0Fix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 01:38:53 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40318 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeI0Fix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 01:38:53 -0400
Received: by mail-wm1-f66.google.com with SMTP id o2-v6so4019130wmh.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 16:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3KaQUP07p+ekdffmHemSDqhApYEmAzBtDlYnYARB+fs=;
        b=phpw1qOZJqkPk6gsocuFrCzVjl7Ue+ElMPiyNfDR/Ga+hrPsdu12KtH2ts9bm8l1+t
         RtKZa83EUvNgbDiNFr8EhEO4lRwiOHb5kow2w4jtccjYIeolTYBu+EgI4qiWIRPrpPZp
         hvzubqUzGEQ9gNlrkm+VrYZ1+RZOQ/IT44QtJM327Z0JSscr3wZKAceWM2bdAQ5bJ96M
         i1E1pqqN1ttuOPs2BrDAevU9YfLtgwggwpFwlyl6+EuKr6mkwFFrinJPbz7Zj1ctFtoY
         vQ5kz7tqEV9tFr3KvKFUnCRNML7Mui7FZMTbyj8LrHifkjBTXB6VQ4xzRh9trade3ErM
         MG4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3KaQUP07p+ekdffmHemSDqhApYEmAzBtDlYnYARB+fs=;
        b=Wk9Nguh35A+LTpylzjkQgpqMoQtG/+8677ZwTNqGIwjBcMI8a5m/KMp+9xJ9anouOX
         5Yqt8PHpcWBQkwgU72YrFsN5elUdbk557OAYTpjzgDC9nvFQavo6xm8FznLQTYZy9XLL
         ROX9I0SU5NXgIR66jnkBnRHhpmeQQ6fk5wKf6na0x+zBsrmh8eoRlAu9EH9ZNe+tTUej
         aoRQxExLrcdfKv2DJ3aiprz9JdfVWsi4blfKoFZqhF1647EmgdTGO4dRdDz0lLSrvM8Z
         hvW/gzDTFyeNxlXnEZ5jikC83PNaOEFPnBgrXoKMCCFcaQQlT141PIBgzAFTTJG861qQ
         4Bxw==
X-Gm-Message-State: ABuFfogb9OFub+A2G8i8X9rNDl3AR09O6kvCzqXrROPnxX1UHH8RfWIw
        4nPa42wk0JhgrdJQRypZzJkNDAF4g7uXhw==
X-Google-Smtp-Source: ACcGV61uHrj3GumxQJsrE8AHvwXSD1KO/s3lCECw4Btvtp9cFGngJztWoAGV4GbU+QblHNLP+LJxdw==
X-Received: by 2002:a1c:7dce:: with SMTP id y197-v6mr6129838wmc.78.1538004212241;
        Wed, 26 Sep 2018 16:23:32 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id r13-v6sm495350wmf.34.2018.09.26.16.23.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Sep 2018 16:23:31 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] staging: rtl8723bs: Mark ACPI table declaration as used
Date:   Wed, 26 Sep 2018 16:20:55 -0700
Message-Id: <20180926232055.31951-1-natechancellor@gmail.com>
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

Mark acpi_ids with the attribute __used, which makes it clear to Clang
that we don't want this warning while not inhibiting Clang's dead code
elimination from removing the unreferenced internal symbol when moving
the data to the globally available symbol with MODULE_DEVICE_TABLE.

$ nm -S drivers/staging/rtl8723bs/os_dep/sdio_intf.o | grep acpi
0000000000000000 0000000000000040 R __mod_acpi__acpi_ids_device_table

Link: https://github.com/ClangBuiltLinux/linux/issues/169
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 6d02904de63f..7c03b69b8ed3 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -22,7 +22,7 @@ static const struct sdio_device_id sdio_ids[] =
 	{ SDIO_DEVICE(0x024c, 0xb723), },
 	{ /* end: all zeroes */				},
 };
-static const struct acpi_device_id acpi_ids[] = {
+static const struct acpi_device_id acpi_ids[] __used = {
 	{"OBDA8723", 0x0000},
 	{}
 };
-- 
2.19.0

