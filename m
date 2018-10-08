Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188B1C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A694A20841
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 22:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9r12nyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A694A20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbeJIFfH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 01:35:07 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43951 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJIFfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 01:35:07 -0400
Received: by mail-wr1-f65.google.com with SMTP id n1-v6so22419269wrt.10
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 15:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1NQqaQTT54ej36iZDL5eb7VeTMQ8W2+LS0o1BCa/CKo=;
        b=j9r12nyNv0xJ910ztygRdBrJ3fcSAXVX8ZEfEnZyRpko2BJ8lXXlNQwr2YMhdDUfHD
         kk5C/4n/1+0Ws0U/6uGfR+Ied3GzSvArH3f19GFagdfwud0PW7APCKvMEiQ1D3VzOFqE
         Fbfd+RZ8cWE/w2JRqNwpDfZcOqkWhpbNNlhZlLMO2NJ78vk3lOl6GVi5tzEH/oNmwfqg
         DpLiACpGUc1LpSbOrwpUJvOVnBIyYMAg/tyDOXF2wNxNXjlI0Z+dGLvNm3CbPXzZtah8
         PXWo6dliXnta5WR/BEdldWXx5/EA+7LwXHdqTkXBVfrM4QC9YlxEhQmg9RzdowR1vxAe
         nE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1NQqaQTT54ej36iZDL5eb7VeTMQ8W2+LS0o1BCa/CKo=;
        b=UKQYuGqt0LrKN0o0VTgQsKqO/atBIaMVo8EJq8pYo2IlVY1eRtBfHKLfxmXXai+4ey
         JUen+7oBUb17ru9VIOpWAmX8Ew1zMQwI5/38fPUzeCoCklBZVOYQHT5ViSxHX/UXlodH
         8vyMcTRueNO0w0DX/JgV7rKm2lBLSsunGp9cT961bfmSlcZp8CS40KkJ1Ae5927eo96L
         9h8K2Bfe6ElpRlLvpBHZilMdt0UgCDwbWtb5wQGKi3do6GABnN5VHmCxQfcjXN3LrfP9
         zmA08buRhzkS0lAM+v1bmm7CIQfSvf5t3GiaB5QM/vnOUV2lQJG/WNxjH8L48YIR/hTL
         dSsw==
X-Gm-Message-State: ABuFfohmHprq7EuTc/KvY7nFSx9ckX5D+xvimd+CXV5wOMRVAG4jzHxf
        aFmITgCe1+qeZWhfRlJtEgU=
X-Google-Smtp-Source: ACcGV60eMnHPnE+InuN/CB+0XfT/suc17ZsCq1t9I0agWF71t8iz5DGG4h+P8/oUBQ/4sh9BUw80YA==
X-Received: by 2002:adf:9c93:: with SMTP id d19-v6mr17451097wre.11.1539037272115;
        Mon, 08 Oct 2018 15:21:12 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id y65-v6sm8895210wmg.40.2018.10.08.15.21.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 15:21:11 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Benson Leung <bleung@chromium.org>, Olof Johansson <olof@lixom.net>
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] platform/chrome: chromeos_tbmc - Remove unneeded const
Date:   Mon,  8 Oct 2018 15:20:41 -0700
Message-Id: <20181008222041.7713-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/platform/chrome/chromeos_tbmc.c:102:14: warning: duplicate
'const' declaration specifier [-Wduplicate-decl-specifier]
static const SIMPLE_DEV_PM_OPS(chromeos_tbmc_pm_ops, NULL,
             ^
./include/linux/pm.h:365:56: note: expanded from macro
'SIMPLE_DEV_PM_OPS'
#define SIMPLE_DEV_PM_OPS(name, suspend_fn, resume_fn) \
                                                       ^
1 warning generated.

SIMPLE_DEV_PM_OPS is already declared as const, this one is unnecessary
so remove it.

Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/platform/chrome/chromeos_tbmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/chromeos_tbmc.c b/drivers/platform/chrome/chromeos_tbmc.c
index 1e81f8144c0d..ce259ec9f990 100644
--- a/drivers/platform/chrome/chromeos_tbmc.c
+++ b/drivers/platform/chrome/chromeos_tbmc.c
@@ -99,7 +99,7 @@ static const struct acpi_device_id chromeos_tbmc_acpi_device_ids[] = {
 };
 MODULE_DEVICE_TABLE(acpi, chromeos_tbmc_acpi_device_ids);
 
-static const SIMPLE_DEV_PM_OPS(chromeos_tbmc_pm_ops, NULL,
+static SIMPLE_DEV_PM_OPS(chromeos_tbmc_pm_ops, NULL,
 		chromeos_tbmc_resume);
 
 static struct acpi_driver chromeos_tbmc_driver = {
-- 
2.19.0

