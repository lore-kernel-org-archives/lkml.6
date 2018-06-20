Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118BEC1B0F1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9482083D
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 01:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LmEPEG48"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC9482083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753745AbeFTBMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 21:12:20 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:55464 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbeFTBMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 21:12:15 -0400
Received: by mail-qt0-f202.google.com with SMTP id f8-v6so1331489qtj.22
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 18:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=yMylWXdP5ayrVOQ6gauwzPUGocJd8etjj9E8ShmP7+E=;
        b=LmEPEG48n+g+29/Cm1cTZ29jmfcE8FI13suq+222qM75K24rzRFUTAbCNIZZi5XFWW
         oZR0jzdA5T5uK0ppg4RqyjVgThMUnfl42qDsnWAJ98kwK5RAktYB/ByAzFMXlpx6jRi0
         /o6xYxVqnyADF1CtyI9GFSoMp4t30r8P1bOawtFyBTRVs1/LrKP7kL/HKTO9DXYdBH4k
         vWhRE+g/PJyhTCn5plO/rNCZMLFU8z6a65T5DVothWQgJ2gMoqqJWTUFarym+A2gQefc
         nanONgmmMts1Qe64PVpWh0IoJJSiaBm2imsDBPE9LGFxuF6udP1/HE6AnS5Lfk8hT+zD
         H25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=yMylWXdP5ayrVOQ6gauwzPUGocJd8etjj9E8ShmP7+E=;
        b=o+npfojgr6pVlyKzCjkUnLfnQLhjenp133Jifcm5spPf1aTYhJF9bO/3vNKW1Sgv/0
         nbD//W1eGOIabHePiHysJ0vTGjMFulizNQhc3GxzwDGOmYxWzMA+yE3lI5HVBOZnoTNs
         gtm2iVEkBhw/KKTjbTqcJV6WL3gkCYO26gH04DJEIPScmDhnaN/kZ69qQ2XZP8z53m35
         7Jf8x4BqR4eFyNs3siusInBQN5hPA5m1k0sEEG78cRsBQcvA3C9u6RzoHQy3jWNfDBbC
         TuwNT1n8S/6V7SbqiGV8KukQ9gYfrT7JnYlMHjUFR8wC1qJDSJoVuYftSzL8+KxM5rys
         o3Rw==
X-Gm-Message-State: APt69E1/het3rZGPrs82VUmvYy/nl3t2CxO4x24ZGNERF3PE7Or77Usu
        4jfvHxpL8eT2bYPv9yignkNz8m0u13BA
X-Google-Smtp-Source: ADUXVKIeumELY4BuspW1OCoZeJqkG+FMVoPe9vNxVmT3/48sTIWRVuD1lxnNAT0Lbgjzzdk6ypIQSvfzCa9m
MIME-Version: 1.0
X-Received: by 2002:a0c:c384:: with SMTP id o4-v6mr10545750qvi.51.1529457134692;
 Tue, 19 Jun 2018 18:12:14 -0700 (PDT)
Date:   Tue, 19 Jun 2018 18:12:06 -0700
In-Reply-To: <20180619221651.GH33049@bhelgaas-glaptop.roam.corp.google.com>
Message-Id: <20180620011210.254601-1-rajatja@google.com>
References: <20180619221651.GH33049@bhelgaas-glaptop.roam.corp.google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v3 1/5] PCI/AER: Define and allocate aer_stats structure for
 AER capable devices
From:   Rajat Jain <rajatja@google.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jes Sorensen <jsorensen@fb.com>,
        Kyle McMartin <jkkm@fb.com>, rajatxjain@gmail.com,
        helgaas@kernel.org
Cc:     Rajat Jain <rajatja@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a structure to hold the AER statistics. There are 2 groups
of statistics: dev_* counters that are to be collected for all AER
capable devices and rootport_* counters that are collected for all
(AER capable) rootports only. Allocate and free this structure when
device is added or released (thus counters survive the lifetime of the
device).

Signed-off-by: Rajat Jain <rajatja@google.com>
---
v3: Merge everything in aer.c

 drivers/pci/pcie/aer.c | 60 ++++++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c    |  1 +
 include/linux/pci.h    |  3 +++
 3 files changed, 64 insertions(+)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e88386af28..f9fa994b6c33 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -33,6 +33,9 @@
 #define AER_ERROR_SOURCES_MAX		100
 #define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
 
+#define AER_MAX_TYPEOF_CORRECTABLE_ERRS 16	/* as per PCI_ERR_COR_STATUS */
+#define AER_MAX_TYPEOF_UNCORRECTABLE_ERRS 26	/* as per PCI_ERR_UNCOR_STATUS*/
+
 struct aer_err_info {
 	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
 	int error_dev_num;
@@ -76,6 +79,40 @@ struct aer_rpc {
 					 */
 };
 
+/* AER stats for the device */
+struct aer_stats {
+
+	/*
+	 * Fields for all AER capable devices. They indicate the errors
+	 * "as seen by this device". Note that this may mean that if an
+	 * end point is causing problems, the AER counters may increment
+	 * at its link partner (e.g. root port) because the errors will be
+	 * "seen" by the link partner and not the the problematic end point
+	 * itself (which may report all counters as 0 as it never saw any
+	 * problems).
+	 */
+	/* Individual counters for different type of correctable errors */
+	u64 dev_cor_errs[AER_MAX_TYPEOF_CORRECTABLE_ERRS];
+	/* Individual counters for different type of uncorrectable errors */
+	u64 dev_uncor_errs[AER_MAX_TYPEOF_UNCORRECTABLE_ERRS];
+	/* Total number of correctable errors seen by this device */
+	u64 dev_total_cor_errs;
+	/* Total number of fatal uncorrectable errors seen by this device */
+	u64 dev_total_fatal_errs;
+	/* Total number of fatal uncorrectable errors seen by this device */
+	u64 dev_total_nonfatal_errs;
+
+	/*
+	 * Fields for Root ports only, these indicate the total number of
+	 * ERR_COR, ERR_FATAL, and ERR_NONFATAL messages received by the
+	 * rootport, INCLUDING the ones that are generated internally (by
+	 * the rootport itself)
+	 */
+	u64 rootport_total_cor_errs;
+	u64 rootport_total_fatal_errs;
+	u64 rootport_total_nonfatal_errs;
+};
+
 #define AER_LOG_TLP_MASKS		(PCI_ERR_UNC_POISON_TLP|	\
 					PCI_ERR_UNC_ECRC|		\
 					PCI_ERR_UNC_UNSUP|		\
@@ -402,12 +439,35 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 	return 0;
 }
 
+static int pci_aer_stats_init(struct pci_dev *pdev)
+{
+	pdev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
+	if (!pdev->aer_stats) {
+		dev_err(&pdev->dev, "No memory for aer_stats\n");
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+static void pci_aer_stats_exit(struct pci_dev *pdev)
+{
+	kfree(pdev->aer_stats);
+	pdev->aer_stats = NULL;
+}
+
 int pci_aer_init(struct pci_dev *dev)
 {
 	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
+	if (!dev->aer_cap || pci_aer_stats_init(dev))
+		return -EIO;
 	return pci_cleanup_aer_error_status_regs(dev);
 }
 
+void pci_aer_exit(struct pci_dev *dev)
+{
+	pci_aer_stats_exit(dev);
+}
+
 #define AER_AGENT_RECEIVER		0
 #define AER_AGENT_REQUESTER		1
 #define AER_AGENT_COMPLETER		2
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ac876e32de4b..48edd0c9e4bc 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2064,6 +2064,7 @@ static void pci_configure_device(struct pci_dev *dev)
 
 static void pci_release_capabilities(struct pci_dev *dev)
 {
+	pci_aer_exit(dev);
 	pci_vpd_release(dev);
 	pci_iov_release(dev);
 	pci_free_cap_save_buffers(dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 340029b2fb38..8d59c6c19a19 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -299,6 +299,7 @@ struct pci_dev {
 	u8		hdr_type;	/* PCI header type (`multi' flag masked out) */
 #ifdef CONFIG_PCIEAER
 	u16		aer_cap;	/* AER capability offset */
+	struct aer_stats *aer_stats;	/* AER stats for this device */
 #endif
 	u8		pcie_cap;	/* PCIe capability offset */
 	u8		msi_cap;	/* MSI capability offset */
@@ -1471,10 +1472,12 @@ static inline bool pcie_aspm_support_enabled(void) { return false; }
 void pci_no_aer(void);
 bool pci_aer_available(void);
 int pci_aer_init(struct pci_dev *dev);
+void pci_aer_exit(struct pci_dev *dev);
 #else
 static inline void pci_no_aer(void) { }
 static inline bool pci_aer_available(void) { return false; }
 static inline int pci_aer_init(struct pci_dev *d) { return -ENODEV; }
+static inline void pci_aer_exit(struct pci_dev *d) { }
 #endif
 
 #ifdef CONFIG_PCIE_ECRC
-- 
2.18.0.rc1.244.gcf134e6275-goog

