Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751434AbeFCNVa (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 09:21:30 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:35124 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751057AbeFCNV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 09:21:29 -0400
X-Google-Smtp-Source: ADUXVKKOSEqkfYcwXDlLFWQ9jwoLHczEu1LwBcqnFEciA6AvV/Ep7gRtT1rkQv2RrSpu465ZvkiSVQ==
From: Varsha Rao <rvarsha016@gmail.com>
To: Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani
        <suganath-prabu.subramani@broadcom.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Nicholas Mc Guire <der.herr@hofr.at>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Varsha Rao <rvarsha016@gmail.com>
Subject: [PATCH 1/3] message: fusion: Remove extra parentheses
Date: Sun,  3 Jun 2018 18:51:11 +0530
Message-Id: <1c55749fab44ec35bbc3b4035edd380485b42435.1528031458.git.rvarsha016@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1528031458.git.rvarsha016@gmail.com>
References: <cover.1528031458.git.rvarsha016@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To fix clang warning of extraneous parentheses and check patch issue,
remove extra parentheses and replace x == NULL with !x. Following
coccinele script is used to fix it.

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
