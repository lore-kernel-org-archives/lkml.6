Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A42C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92F4F2255D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 23:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="utL5JIwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F4F2255D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933835AbeFUXsp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 19:48:45 -0400
Received: from mail-qt0-f202.google.com ([209.85.216.202]:38444 "EHLO
        mail-qt0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932734AbeFUXsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 19:48:41 -0400
Received: by mail-qt0-f202.google.com with SMTP id v14-v6so1164101qto.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 16:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=UTo0MP31NcmRnoDiyi7jcuy8B7/IsyEAnIrtr4qanCM=;
        b=utL5JIwMhgltwmRwSCvuL0drNH1wtImMZ0JlT7W1Fx3KlJ/gZxwE7HAZ0g/TxR6vWa
         jvC+yBWnKES4RzUd0Zfdvd5j0fqwfiYr6ev5SoXkPYFqkr7zfVflR3IiwZ/JUZsxzhyH
         7i5+nc9+0nzyhZ7FbvUmnwmZx2/x4UqhUo2KsLk695KGAB5qgVT1sHx5Q72DGIdJFd8b
         QRTQpA+ebY3iH7ZGCCuyyKySEK2QGQNcthADT6DEo75zDTyPf+wkGebowT2hA4nJgsU/
         Smmo4B+wYknczc0wpT1kHeed9/Sym8SJsAG8XVT1B7I/icRvGp+JiyzTPa0Ln1I4H4bY
         1iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=UTo0MP31NcmRnoDiyi7jcuy8B7/IsyEAnIrtr4qanCM=;
        b=LIs3egX5gbV3aFgfyoz7QlzP3fMvY3W+FmEtmxZFuqto45iBaObB0EP/ZtFl6Cdmss
         TR5CVXqtZUzQ7UxfidiuoBSFRuPOft825iYYFbxHTh9/4iL1L6vOH+kgN5xpUHBH2H2H
         W+8VFoTLGMC3VfSLc8pyf/syM6Nl0tOo+Guwz6Au8W6ImOlc+jPiFe1ariiU2J7GHTyA
         ath+9ShWSkzYa2hHT6ZOZdmLlhPfPAznDpQmM2uZ59gFYqZVDsMuxK6fI5bw0Dmj4tNC
         ZT/g9JQel/lktcVbTu7s89eOE/Z1alFzHy4Hh0EtKcXKd4z+hC5kbdbdwOKua/bInRwM
         eOOA==
X-Gm-Message-State: APt69E1p4/uG87ILiWmohA3J8y/syHeNF4xJJuF0PAr2szz/y/BRPu30
        Q00zIERJa7oJh35ma5ZABXpPZmGw5DNl
X-Google-Smtp-Source: ADUXVKKjFOxzR1X3TPeZTdE91ZXsh6xPQrrbqLJlFXDo7tCdA8VKnWb1ByOookZQnJ8FIBtFLijxtzsjAsV2
MIME-Version: 1.0
X-Received: by 2002:a0c:8839:: with SMTP id 54-v6mr14593094qvl.24.1529624920464;
 Thu, 21 Jun 2018 16:48:40 -0700 (PDT)
Date:   Thu, 21 Jun 2018 16:48:26 -0700
In-Reply-To: <20180621234829.224566-1-rajatja@google.com>
Message-Id: <20180621234829.224566-2-rajatja@google.com>
References: <20180621234829.224566-1-rajatja@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH 1/4] PCI: Move pci_aer_init() and pci_no_aer() declarations to drivers/pci/pci.h
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

Since these functions are unsed only internally, move them to the PCI
internal header file. Also, no one cares about return value of
pci_aer_init(), so make it void.

Signed-off-by: Rajat Jain <rajatja@google.com>
---
 drivers/pci/pci.h      | 8 ++++++++
 drivers/pci/pcie/aer.c | 4 ++--
 include/linux/pci.h    | 4 ----
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index c358e7a07f3f..9a1af85aca77 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -452,4 +452,12 @@ static inline int devm_of_pci_get_host_bridge_resources(struct device *dev,
 }
 #endif
 
+#ifdef CONFIG_PCIEAER
+void pci_no_aer(void);
+void pci_aer_init(struct pci_dev *dev);
+#else
+static inline void pci_no_aer(void) { }
+static inline int pci_aer_init(struct pci_dev *d) { return -ENODEV; }
+#endif
+
 #endif /* DRIVERS_PCI_H */
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index a2e88386af28..11482669b93b 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -402,10 +402,10 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 	return 0;
 }
 
-int pci_aer_init(struct pci_dev *dev)
+void pci_aer_init(struct pci_dev *dev)
 {
 	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
-	return pci_cleanup_aer_error_status_regs(dev);
+	pci_cleanup_aer_error_status_regs(dev);
 }
 
 #define AER_AGENT_RECEIVER		0
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 340029b2fb38..b4ffea05c999 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1468,13 +1468,9 @@ static inline bool pcie_aspm_support_enabled(void) { return false; }
 #endif
 
 #ifdef CONFIG_PCIEAER
-void pci_no_aer(void);
 bool pci_aer_available(void);
-int pci_aer_init(struct pci_dev *dev);
 #else
-static inline void pci_no_aer(void) { }
 static inline bool pci_aer_available(void) { return false; }
-static inline int pci_aer_init(struct pci_dev *d) { return -ENODEV; }
 #endif
 
 #ifdef CONFIG_PCIE_ECRC
-- 
2.18.0.rc2.346.g013aa6912e-goog

