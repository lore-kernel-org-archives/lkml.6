Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F169C64EBD
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C54720684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 21:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C54720684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbeJCD4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 23:56:44 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:60903 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbeJCD4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 23:56:44 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M738r-1g5Ufb2uUB-008ef4; Tue, 02 Oct 2018 23:11:24 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1M738r-1g5Ufb2uUB-008ef4; Tue, 02 Oct 2018 23:11:24 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] nvmem: hide unused nvmem_find_cell_by_index function
Date:   Tue,  2 Oct 2018 23:11:12 +0200
Message-Id: <20181002211123.2662419-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:TvEE8/YQAixbvqvV6ZGvlneBXw9+k2lvchvHpIiTo9lxGoRSGE1
 K0saL7SNLVS3HcW6k3qDjC+AcNoyd8JMiBTBk0b7clkoMKkJNBu2oJOkU9CcOqLk7q5n28k
 noQTOQjFpAuDTwhLAYvXhAUbGUiXahN9IWyRjdcvW9oQh09zxcb2QDKlnQDRCkQu6RrkHu2
 pHQE6I150MHrNDP8ZEbNA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mwRHanT7PPo=:Mb5caRYx9CuyTh4p1sAFtQ
 D0645J2m69ERVDh9FsvvDV8DoLs/q8lPMv5HugiubLLZIBGtV1eJ6FLEcpk0HM5EoZT0feSC7
 jWgdVnfrrX6Q0N0TwSIsLfnojw/CTAgIu6PbxCX7K4HcVWI9cKrJHietLQpFQT0iYgiWASEPt
 rcGZkHxGP1DUIhFST1lWOvY4DilHd7K5vOpK4jyV7yp4N8shDaC5zFNJ1SHqkQEuREmo++CgC
 JgkNv/imzkf9BjT08F5dDECzNkC/UooKMU6SUpAKkQQfaiEGTkUFdaKNE/7+cS1kvrQeWQdCr
 KunwCqLtl2Cq/r+2YZKKegNTKoAeM18c+TnXwhlbGjYLBg/YjMg5QGHxpqNQVyAlDnp2UPsDS
 2uE5cHzYXl8zIMipeU8AsDUcTnTPDgfWIrLvRK+zqokzv0fMRx6R+9LH7a8xEfuEANnOLTxLC
 OuGUQiiJ+InfzjinHOdJy1Tns8SBBTq5q4sTY+wZu/vmWDVga+VsHw0Eo+hoeaGkdFquTwnqv
 xS2K3fz/4aDzFpWbJh8CV3Rfw7OddF57oACY37St3dt7grB9unU3i1nuO4Uh6lrYrXFtihhHy
 S3ibRFyqJ+TNJdGLGxSkmExIerbfGSIKk4sh7QvcYe6r7LgfPAhk+lTVHE654nPQCgtGFZlQt
 ffvgPz5/A/NaeAg0+LavU5L9ti/oy3taSE8qhmSUAqTceQc3q6KKkuXDr61feVHNdl1M=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nvmem_find_cell_by_index() is only called from inside an #ifdef,
so we get a build warning without CONFIG_OF:

drivers/nvmem/core.c:496:1: error: 'nvmem_find_cell_by_index' defined but not used [-Werror=unused-function]

Move it into the same #ifdef as the caller to avoid the warning.

Fixes: e888d445ac33 ("nvmem: resolve cells from DT at registration time")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/nvmem/core.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index cc815bb2eebd..f99fb74a646e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -492,22 +492,6 @@ static int nvmem_add_cells_from_table(struct nvmem_device *nvmem)
 	return rval;
 }
 
-static struct nvmem_cell *
-nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
-{
-	struct nvmem_cell *cell = NULL;
-	int i = 0;
-
-	mutex_lock(&nvmem_mutex);
-	list_for_each_entry(cell, &nvmem->cells, node) {
-		if (index == i++)
-			break;
-	}
-	mutex_unlock(&nvmem_mutex);
-
-	return cell;
-}
-
 static struct nvmem_cell *
 nvmem_find_cell_by_name(struct nvmem_device *nvmem, const char *cell_id)
 {
@@ -972,6 +956,22 @@ nvmem_cell_get_from_lookup(struct device *dev, const char *con_id)
 }
 
 #if IS_ENABLED(CONFIG_OF)
+static struct nvmem_cell *
+nvmem_find_cell_by_index(struct nvmem_device *nvmem, int index)
+{
+	struct nvmem_cell *cell = NULL;
+	int i = 0;
+
+	mutex_lock(&nvmem_mutex);
+	list_for_each_entry(cell, &nvmem->cells, node) {
+		if (index == i++)
+			break;
+	}
+	mutex_unlock(&nvmem_mutex);
+
+	return cell;
+}
+
 /**
  * of_nvmem_cell_get() - Get a nvmem cell from given device node and cell id
  *
-- 
2.18.0

