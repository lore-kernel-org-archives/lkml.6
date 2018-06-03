Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751289AbeFCLD1 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 07:03:27 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:43327 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750983AbeFCLDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 07:03:25 -0400
X-Google-Smtp-Source: ADUXVKLUHlmmA8zAlmnBD90vWl9OkLjPq5ajrsI6o0PjGdiVKuim+wUxI8GAkOw2xnsYnpu3unT5fg==
From: Varsha Rao <rvarsha016@gmail.com>
To: Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <der.herr@hofr.at>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Varsha Rao <rvarsha016@gmail.com>
Subject: [PATCH] message: fusion: Remove extra parentheses
Date: Sun,  3 Jun 2018 16:33:07 +0530
Message-Id: <20180603110307.4080-1-rvarsha016@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To fix clang warning of extraneous parentheses and check patch issue,
remove extra parentheses and replace x == NULL with !x. Following
coccinelle script is used to fix it.

@disable is_null,paren@
expression e;
statement s;
@@
if (
- (e==NULL)
+!e
 )
s

Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
---
 drivers/message/fusion/mptbase.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/message/fusion/mptbase.c b/drivers/message/fusion/mptbase.c
index 51eb1b027963..3fe53b65c5fa 100644
--- a/drivers/message/fusion/mptbase.c
+++ b/drivers/message/fusion/mptbase.c
@@ -335,11 +335,11 @@ static int mpt_remove_dead_ioc_func(void *arg)
 	MPT_ADAPTER *ioc = (MPT_ADAPTER *)arg;
 	struct pci_dev *pdev;
 
-	if ((ioc == NULL))
+	if (!ioc)
 		return -1;
 
 	pdev = ioc->pcidev;
-	if ((pdev == NULL))
+	if (!pdev)
 		return -1;
 
 	pci_stop_and_remove_bus_device_locked(pdev);
-- 
2.17.0
