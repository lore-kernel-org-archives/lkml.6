Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BA0C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59480219E2
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 18:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59480219E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932940AbeFUSPb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 14:15:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47411 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932620AbeFUSP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 14:15:29 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fW47B-0001Yn-4d; Thu, 21 Jun 2018 18:15:25 +0000
From:   Colin King <colin.king@canonical.com>
To:     Mario Limonciello <mario.limonciello@dell.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: dell-smbios: make a function and a pointer static
Date:   Thu, 21 Jun 2018 19:15:24 +0100
Message-Id: <20180621181524.30550-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The function dell_smbios_smm_call and pointer platform_device are
local to the source and do not need to be in global scope, so make
them static.

Cleans up sparse warnings:
warning: symbol 'platform_device' was not declared. Should it be static?
warning: symbol 'dell_smbios_smm_call' was not declared. Should it be
static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/platform/x86/dell-smbios-smm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/dell-smbios-smm.c b/drivers/platform/x86/dell-smbios-smm.c
index e9e9da556318..97a90bebc360 100644
--- a/drivers/platform/x86/dell-smbios-smm.c
+++ b/drivers/platform/x86/dell-smbios-smm.c
@@ -24,7 +24,7 @@
 static int da_command_address;
 static int da_command_code;
 static struct calling_interface_buffer *buffer;
-struct platform_device *platform_device;
+static struct platform_device *platform_device;
 static DEFINE_MUTEX(smm_mutex);
 
 static const struct dmi_system_id dell_device_table[] __initconst = {
@@ -82,7 +82,7 @@ static void find_cmd_address(const struct dmi_header *dm, void *dummy)
 	}
 }
 
-int dell_smbios_smm_call(struct calling_interface_buffer *input)
+static int dell_smbios_smm_call(struct calling_interface_buffer *input)
 {
 	struct smi_cmd command;
 	size_t size;
-- 
2.17.0

