Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71992C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DA3E2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="mE6en4Ut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DA3E2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731766AbeHWPEU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 11:04:20 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:54348 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbeHWPEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 11:04:20 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 544B110C1AD9;
        Thu, 23 Aug 2018 04:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1535024102; bh=oIdRNGn1hT2cnPBIwPLGiQZnpbxmJgeTyEzzbs8o0aU=;
        h=From:To:Cc:Subject:Date:From;
        b=mE6en4UtRPGnSotFJkoKoGRQ3dq8Oj97X1yeJkpyxzHioGWU3r3GyiD+bcACFqpiQ
         2OW6R2OKttG4iFGuS3k6D1Obe9FitkdN23VTdgxqS2z3uhydXvZz2fbNL2vAVpkk46
         woSAIQwreJvnZarIXlnggQt7aw+VJWtcsbC1OR5YKOTNLYqEWBkJQ87XOw2ratNg+b
         ga6Mcmg3rtVo2nMl9L8Buo1RwGddAQSGA8BTRQqM+3a0YMSuRC/N46U9zKe2HtZnMk
         vL53sffYSCHMo8TnF57Uw7xTgg2ONwK+HlX7pR4CEnKVPuoBNChe+sU0ijnxSayiAi
         0jY5Hyb3bGv9g==
Received: from de02.synopsys.com (de02.internal.synopsys.com [10.225.17.21])
        by mailhost.synopsys.com (Postfix) with ESMTP id 127C438AE;
        Thu, 23 Aug 2018 04:35:02 -0700 (PDT)
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by de02.synopsys.com (Postfix) with ESMTP id 3A1063E6E8;
        Thu, 23 Aug 2018 13:35:01 +0200 (CEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, kishon@ti.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH] tools/pci: Fix compilation warnings
Date:   Thu, 23 Aug 2018 13:34:53 +0200
Message-Id: <b2433aaac6ace7b1b9843b520242d9e9185d3685.1535024080.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix compilation warnings:
 - remove unused variables
 - change function return from int to void, since it's not used

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 tools/pci/pcitest.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 9074b47..8ca1c62 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -23,7 +23,6 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <sys/ioctl.h>
-#include <time.h>
 #include <unistd.h>
 
 #include <linux/pcitest.h>
@@ -43,17 +42,15 @@ struct pci_test {
 	unsigned long	size;
 };
 
-static int run_test(struct pci_test *test)
+static void run_test(struct pci_test *test)
 {
 	long ret;
 	int fd;
-	struct timespec start, end;
-	double time;
 
 	fd = open(test->device, O_RDWR);
 	if (fd < 0) {
 		perror("can't open PCI Endpoint Test device");
-		return fd;
+		return;
 	}
 
 	if (test->barnum >= 0 && test->barnum <= 5) {
-- 
2.7.4

