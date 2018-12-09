Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E178C67838
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CBA2081C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 22:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fredlawl-com.20150623.gappssmtp.com header.i=@fredlawl-com.20150623.gappssmtp.com header.b="xxShai0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36CBA2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fredlawl.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbeLIWqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 17:46:40 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38865 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeLIWqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 17:46:39 -0500
Received: by mail-oi1-f196.google.com with SMTP id a77so7552196oii.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Dec 2018 14:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=guAieEX3tnWHuuM1l8KzNMGuDYrTMkG1L3tUfFzs1SM=;
        b=xxShai0KajxFgh0/VSCAlsn3fDuzfhHfpfoD40ifgx/381jEBgNQBcpK/t6kViJTcQ
         TP4gKm2asshj+a97qW77hB9To4ksVun+et79b4r6DBGl768mqN+fz3sMlBGT2c67f4o6
         0NEjCNZ/t+KuZek23xwHl4XgmH26fIQnaAZIzZT6rPwprQp8+rf+bNpYaf7Xm0ZwMdbQ
         TMtQeYJ73U0P1rCENmo6mnZP8QojmHR6KsfjdkgDSlj/Lg/boklpNo4hvLhPdMhPxW7z
         V5eDNMb+K9l9Odt/rPzsyhnlDDghT+w+cuqB0m1eFfLa6d9J6I0VTxDhnzauBr5H+A8g
         wksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=guAieEX3tnWHuuM1l8KzNMGuDYrTMkG1L3tUfFzs1SM=;
        b=QLF+X0xzzOJYSoAWQVP1HU3dzbtIfol4H/21bArmcJnWkngErXu3Pqcnk12Y0W76eB
         DW6Intz1Dz612vph5f7SjA2OtitvQuy0BOg3hrsX3DJ5EcqbX60hd4TlWQmTZ8HLgSPR
         e4R99ShrkJs4JmLYE/JVM7Nu2d+RId0Kwst2XKeTDNAUxULeFbHq+qYWlipOOvbVyOOu
         aKFh8mvURGnfzSf1WtEMH8LW7NSY+fwZtQR/Eh5gFSrQLDlVaac7n5X3il3Sc7vJwggb
         0P8lJFmH2q41IRe7ZOhX9y+AsLa6F7+9S49FHSChItVIO+4lB9bDIu/qyWQF4zOrQuFu
         aElg==
X-Gm-Message-State: AA+aEWanlIzCx9drvlPf29KjqnMrvFMq0XkPL6avBh04SzUxWYQy8Jqw
        yxp226gJvQV51v383kIYxFHGxg==
X-Google-Smtp-Source: AFSGD/WubISG1uQFa6RUJfFbxT0euSoeTyWtixN6znufigZydWaf0gAyZCVkz7cMa8Rs2wwxSTSUpA==
X-Received: by 2002:aca:d64d:: with SMTP id n74mr5931462oig.199.1544395598444;
        Sun, 09 Dec 2018 14:46:38 -0800 (PST)
Received: from ubuntu-fredlawl.attlocal.net ([2600:1702:3be0:4340:e5c0:b776:5e38:6371])
        by smtp.gmail.com with ESMTPSA id c23sm4339179otn.21.2018.12.09.14.46.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Dec 2018 14:46:37 -0800 (PST)
From:   Frederick Lawler <fred@fredlawl.com>
To:     helgaas@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        ptalbert@redhat.com, Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH] PCI/ASPM: Remove unused lists from struct pcie_link_state
Date:   Sun,  9 Dec 2018 16:45:50 -0600
Message-Id: <20181209224550.18931-1-fred@fredlawl.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ASPM does not make use of the children or link LIST_HEADs declared in
struct pcie_link_state and defined in alloc_pcie_link_state(). Therefore,
remove these lists.

No functional change intended.

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 drivers/pci/pcie/aspm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index dcb29cb76dc6..2330ebf6df72 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -53,8 +53,6 @@ struct pcie_link_state {
 	struct pcie_link_state *root;	/* pointer to the root port link */
 	struct pcie_link_state *parent;	/* pointer to the parent Link state */
 	struct list_head sibling;	/* node in link_list */
-	struct list_head children;	/* list of child link states */
-	struct list_head link;		/* node in parent's children list */
 
 	/* ASPM state */
 	u32 aspm_support:7;		/* Supported ASPM state */
@@ -850,8 +848,6 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 		return NULL;
 
 	INIT_LIST_HEAD(&link->sibling);
-	INIT_LIST_HEAD(&link->children);
-	INIT_LIST_HEAD(&link->link);
 	link->pdev = pdev;
 	link->downstream = pci_function_0(pdev->subordinate);
 
@@ -877,7 +873,6 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 
 		link->parent = parent;
 		link->root = link->parent->root;
-		list_add(&link->link, &parent->children);
 	}
 
 	list_add(&link->sibling, &link_list);
@@ -1001,7 +996,6 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 	/* All functions are removed, so just disable ASPM for the link */
 	pcie_config_aspm_link(link, 0);
 	list_del(&link->sibling);
-	list_del(&link->link);
 	/* Clock PM is for endpoint device */
 	free_link_state(link);
 
-- 
2.17.1

