Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25BC5C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 08:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9FF921874
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 08:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dsLtMm0z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbfAEIJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 03:09:22 -0500
Received: from m12-17.163.com ([220.181.12.17]:34094 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbfAEIJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 03:09:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=adeLbmdf0VDov+wRxu
        vPHkFwFZM5XNaa1dYaNPTmoKU=; b=dsLtMm0zhjOyfxNpO1OMUJevqHfSUT5zRx
        Y3oILOtF3Yn5qX1YYfUDHFoarriyDKmc4Sjt5JNgBiYSGHCfdkIeTmWZ4lawgq4A
        JAztEVTOqchLR4yYZ98OcVzbSX9LlNgKeSXyBuFeqM8l4YZVNCWj21zTwrKxqFzr
        h8+c4BwG4=
Received: from localhost.localdomain.localdomain (unknown [36.102.4.74])
        by smtp13 (Coremail) with SMTP id EcCowAAHPHgSZjBcv9QcCQ--.13624S3;
        Sat, 05 Jan 2019 16:08:55 +0800 (CST)
From:   Xiaochun Lee <lixiaochun.2888@163.com>
To:     linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     dan.j.williams@intel.com, zwisler@kernel.org,
        vishal.l.verma@intel.com, dave.jiang@intel.com, rjw@rjwysocki.net,
        lenb@kernel.org, linux-kernel@vger.kernel.org,
        Xiaochun Lee <lixc17@lenovo.com>
Subject: [PATCH] ACPI/nfit: delete the function to_acpi_nfit_desc
Date:   Sat,  5 Jan 2019 16:08:38 +0800
Message-Id: <1546675718-31174-2-git-send-email-lixiaochun.2888@163.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1546675718-31174-1-git-send-email-lixiaochun.2888@163.com>
References: <1546675718-31174-1-git-send-email-lixiaochun.2888@163.com>
X-CM-TRANSID: EcCowAAHPHgSZjBcv9QcCQ--.13624S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar47Kw18KFyDuw4rtw1kXwb_yoW8KF15pF
        1UKwsrA397GrsI9F4vkw4rXr1ayan7AFyI9rWUX343XFs3Cw1kJFn2kF45JrW8ArWvka13
        ZF1vk3WfJF4DArUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bUAp5UUUUU=
X-Originating-IP: [36.102.4.74]
X-CM-SenderInfo: 5ol0xtprfk30aosymmi6rwjhhfrp/1tbiQAYzQFSIY0UXywAAsT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaochun Lee <lixc17@lenovo.com>

The function to_acpi_nfit_desc and function to_acpi_desc
do the same things,delete the function to_acpi_nfit_desc,
and keep the inline function to_acpi_desc.

Signed-off-by: Xiaochun Lee <lixc17@lenovo.com>
---
 drivers/acpi/nfit/core.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 011d3db..8f09410 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -78,12 +78,6 @@ const guid_t *to_nfit_uuid(enum nfit_uuids id)
 }
 EXPORT_SYMBOL(to_nfit_uuid);
 
-static struct acpi_nfit_desc *to_acpi_nfit_desc(
-		struct nvdimm_bus_descriptor *nd_desc)
-{
-	return container_of(nd_desc, struct acpi_nfit_desc, nd_desc);
-}
-
 static struct acpi_device *to_acpi_dev(struct acpi_nfit_desc *acpi_desc)
 {
 	struct nvdimm_bus_descriptor *nd_desc = &acpi_desc->nd_desc;
@@ -419,7 +413,7 @@ static bool payload_dumpable(struct nvdimm *nvdimm, unsigned int func)
 int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 		unsigned int cmd, void *buf, unsigned int buf_len, int *cmd_rc)
 {
-	struct acpi_nfit_desc *acpi_desc = to_acpi_nfit_desc(nd_desc);
+	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 	union acpi_object in_obj, in_buf, *out_obj;
 	const struct nd_cmd_desc *desc = NULL;
@@ -3367,7 +3361,7 @@ int acpi_nfit_init(struct acpi_nfit_desc *acpi_desc, void *data, acpi_size sz)
 
 static int acpi_nfit_flush_probe(struct nvdimm_bus_descriptor *nd_desc)
 {
-	struct acpi_nfit_desc *acpi_desc = to_acpi_nfit_desc(nd_desc);
+	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
 	struct device *dev = acpi_desc->dev;
 
 	/* Bounce the device lock to flush acpi_nfit_add / acpi_nfit_notify */
@@ -3384,7 +3378,7 @@ static int acpi_nfit_flush_probe(struct nvdimm_bus_descriptor *nd_desc)
 static int __acpi_nfit_clear_to_send(struct nvdimm_bus_descriptor *nd_desc,
 		struct nvdimm *nvdimm, unsigned int cmd)
 {
-	struct acpi_nfit_desc *acpi_desc = to_acpi_nfit_desc(nd_desc);
+	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
 
 	if (nvdimm)
 		return 0;
-- 
1.8.3.1


