Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C0DC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0386E2146D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="LGL0O4vy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0386E2146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933511AbeFUQCg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 12:02:36 -0400
Received: from smtprelay6.synopsys.com ([198.182.37.59]:57292 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933391AbeFUQBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 12:01:49 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 885E21E170A;
        Thu, 21 Jun 2018 18:01:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1529596907; bh=XOCYeUyW98bjjY0F5fCPdrO54tJh8S0NYg88GBSZZZ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=LGL0O4vyVImvI/zzqDd8X18jWHlGGCfTani8uiVOEW6cGTh9WBZjgp06iFT9KbDAa
         7tQobM4ADEupKu4H2LOUdDH3UGmy2a4uidgid26P5xZJP7plut8iS41XZo6b8sxN/B
         s7p7uWjH1eYg7tsDNcwKVZp2ao1BxXPlaZOV38AGur512mE0DEAubzylPleefRgIrF
         vnr2zf5TyoJ3qLMnFlanYiWOHRd6TStgLK31aDKYYY2u28a4aNfFUUgzN0Iu1uWqcw
         o6RhBL8orF/LmdSRB/Yh3UE/DQo0Wu6CGS13Kj3vW4APamSAJIskoO47IDx93NnfBe
         InYWJBWAQ9bIA==
Received: from pt02.synopsys.com (pt02.internal.synopsys.com [10.107.23.240])
        by mailhost.synopsys.com (Postfix) with ESMTP id B06B03B39;
        Thu, 21 Jun 2018 09:01:46 -0700 (PDT)
Received: from UbuntuMate-64Bits.internal.synopsys.com (gustavo-e7480.internal.synopsys.com [10.107.25.102])
        by pt02.synopsys.com (Postfix) with ESMTP id 5D00C3D13C;
        Thu, 21 Jun 2018 17:01:44 +0100 (WEST)
From:   Gustavo Pimentel <gustavo.pimentel@synopsys.com>
To:     bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        Joao.Pinto@synopsys.com, jingoohan1@gmail.com, kishon@ti.com,
        adouglas@cadence.com, jesper.nilsson@axis.com,
        shawn.lin@rock-chips.com
Cc:     linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: [PATCH v6 10/11] tools: PCI: Add MSI-X support
Date:   Thu, 21 Jun 2018 17:01:35 +0100
Message-Id: <67e6549e9d872b53406aeec86bdd78d6d29e036d.1529595907.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1529595907.git.gustavo.pimentel@synopsys.com>
References: <cover.1529595907.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1529595907.git.gustavo.pimentel@synopsys.com>
References: <cover.1529595907.git.gustavo.pimentel@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MSI-X support to pcitest tool.

Modify pcitest.sh script to accommodate MSI-X interrupt tests.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
Change v1->v2:
 - Allow IRQ type driver reconfiguring in runtime, follwing Kishon's
suggestion.
Change v2->v3:
 - Nothing changed, just to follow the patch set version.
Change v3->v4:
 - Rebased to Lorenzo's master branch v4.18-rc1.
Change v4->v5:
 - Nothing changed, just to follow the patch set version.
Change v5->v6:
 - Moved PCITEST_MSIX ioctl entry to patch #8.
 - Moved PCITEST_SET_IRQTYPE and PCITEST_GET_IRQTYPE ioctl entries
to patch #9.

 tools/pci/pcitest.c  | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 tools/pci/pcitest.sh | 15 +++++++++++++++
 2 files changed, 65 insertions(+), 1 deletion(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 9074b47..af146bb 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -31,12 +31,17 @@
 #define BILLION 1E9
 
 static char *result[] = { "NOT OKAY", "OKAY" };
+static char *irq[] = { "LEGACY", "MSI", "MSI-X" };
 
 struct pci_test {
 	char		*device;
 	char		barnum;
 	bool		legacyirq;
 	unsigned int	msinum;
+	unsigned int	msixnum;
+	int		irqtype;
+	bool		set_irqtype;
+	bool		get_irqtype;
 	bool		read;
 	bool		write;
 	bool		copy;
@@ -65,6 +70,24 @@ static int run_test(struct pci_test *test)
 			fprintf(stdout, "%s\n", result[ret]);
 	}
 
+	if (test->set_irqtype) {
+		ret = ioctl(fd, PCITEST_SET_IRQTYPE, test->irqtype);
+		fprintf(stdout, "SET IRQ TYPE TO %s:\t\t", irq[test->irqtype]);
+		if (ret < 0)
+			fprintf(stdout, "FAILED\n");
+		else
+			fprintf(stdout, "%s\n", result[ret]);
+	}
+
+	if (test->get_irqtype) {
+		ret = ioctl(fd, PCITEST_GET_IRQTYPE);
+		fprintf(stdout, "GET IRQ TYPE:\t\t");
+		if (ret < 0)
+			fprintf(stdout, "FAILED\n");
+		else
+			fprintf(stdout, "%s\n", irq[ret]);
+	}
+
 	if (test->legacyirq) {
 		ret = ioctl(fd, PCITEST_LEGACY_IRQ, 0);
 		fprintf(stdout, "LEGACY IRQ:\t");
@@ -83,6 +106,15 @@ static int run_test(struct pci_test *test)
 			fprintf(stdout, "%s\n", result[ret]);
 	}
 
+	if (test->msixnum > 0 && test->msixnum <= 2048) {
+		ret = ioctl(fd, PCITEST_MSIX, test->msixnum);
+		fprintf(stdout, "MSI-X%d:\t\t", test->msixnum);
+		if (ret < 0)
+			fprintf(stdout, "TEST FAILED\n");
+		else
+			fprintf(stdout, "%s\n", result[ret]);
+	}
+
 	if (test->write) {
 		ret = ioctl(fd, PCITEST_WRITE, test->size);
 		fprintf(stdout, "WRITE (%7ld bytes):\t\t", test->size);
@@ -133,7 +165,7 @@ int main(int argc, char **argv)
 	/* set default endpoint device */
 	test->device = "/dev/pci-endpoint-test.0";
 
-	while ((c = getopt(argc, argv, "D:b:m:lrwcs:")) != EOF)
+	while ((c = getopt(argc, argv, "D:b:m:x:i:Ilrwcs:")) != EOF)
 	switch (c) {
 	case 'D':
 		test->device = optarg;
@@ -151,6 +183,20 @@ int main(int argc, char **argv)
 		if (test->msinum < 1 || test->msinum > 32)
 			goto usage;
 		continue;
+	case 'x':
+		test->msixnum = atoi(optarg);
+		if (test->msixnum < 1 || test->msixnum > 2048)
+			goto usage;
+		continue;
+	case 'i':
+		test->irqtype = atoi(optarg);
+		if (test->irqtype < 0 || test->irqtype > 2)
+			goto usage;
+		test->set_irqtype = true;
+		continue;
+	case 'I':
+		test->get_irqtype = true;
+		continue;
 	case 'r':
 		test->read = true;
 		continue;
@@ -173,6 +219,9 @@ int main(int argc, char **argv)
 			"\t-D <dev>		PCI endpoint test device {default: /dev/pci-endpoint-test.0}\n"
 			"\t-b <bar num>		BAR test (bar number between 0..5)\n"
 			"\t-m <msi num>		MSI test (msi number between 1..32)\n"
+			"\t-x <msix num>	\tMSI-X test (msix number between 1..2048)\n"
+			"\t-i <irq type>	\tSet IRQ type (0 - Legacy, 1 - MSI, 2 - MSI-X)\n"
+			"\t-I			Get current IRQ type configured\n"
 			"\t-l			Legacy IRQ test\n"
 			"\t-r			Read buffer test\n"
 			"\t-w			Write buffer test\n"
diff --git a/tools/pci/pcitest.sh b/tools/pci/pcitest.sh
index 77e8c85..75ed48f 100644
--- a/tools/pci/pcitest.sh
+++ b/tools/pci/pcitest.sh
@@ -16,7 +16,10 @@ echo
 echo "Interrupt tests"
 echo
 
+pcitest -i 0
 pcitest -l
+
+pcitest -i 1
 msi=1
 
 while [ $msi -lt 33 ]
@@ -26,9 +29,21 @@ do
 done
 echo
 
+pcitest -i 2
+msix=1
+
+while [ $msix -lt 2049 ]
+do
+        pcitest -x $msix
+        msix=`expr $msix + 1`
+done
+echo
+
 echo "Read Tests"
 echo
 
+pcitest -i 1
+
 pcitest -r -s 1
 pcitest -r -s 1024
 pcitest -r -s 1025
-- 
2.7.4


