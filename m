Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D831BECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B7362054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 13:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TF4w5+X6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B7362054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729272AbeJaWW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 18:22:26 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51970 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbeJaWW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 18:22:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id w7-v6so4079316wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 06:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=ZX/ta/8wmqciGfid1DpnpeXw4FmpcA8Ky+azoDlxN4Q=;
        b=TF4w5+X6eQxCqPYceIHCan5YJrPCPPUxKmLkUkLGIrZQfxh1KqnAM8eCwKjZKcRY3l
         JgMcVrnQ7sVGOT66hqax2q6NVU+83ObLQTRE/R3rXgYolsBEq95V74VbFs/os8NXrU3Z
         XeBZoEi+cXEZkt92tWu/mlwS251FfuXxmIjXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZX/ta/8wmqciGfid1DpnpeXw4FmpcA8Ky+azoDlxN4Q=;
        b=LHvxmlBh1KZEXdtbqkrGojZI3eVVuQEh795bVpvaLvIZU9hmFF8iH9scXGwJ0neDM/
         M9c/39NUF1nSxYwYILvOHoIzayFWj33L7S+NSCO7u+WJoyh30hREzw4YR/qUsk+iTm5a
         AnSizuMCP9xbDmJ8CBP/OLu7SaU7jo8MVYvF6H5sA8f6mLhkNbtfYBDC7WDfdlwh/ypP
         PjihFn6+woTCHT5ErwyrnkmX5LkBf+9mMXeFxDQ5Ykt2H71HVLeIHwgKnx1QfsZHBec8
         mnBUWcr+b/UEQk++Cv+c22BL3/Htz2sN9W5ciDMXodGevuakuUzylX9WCS63jswf9c/y
         Pfnw==
X-Gm-Message-State: AGRZ1gJG9565Lhx1cwfcWWhLJWlq40TwUO050J84VuLvR25aOP3iwPZD
        gK5mjMATklMuwzmFilXbe/l1tAIzPQo=
X-Google-Smtp-Source: AJdET5cLgmz1hiK2qbe1zZ7YQEjA8fwb/2oW3rVAoBA91OfyLJtHAf8mkJbAuWPgyLIfRDpSw5qtDQ==
X-Received: by 2002:a1c:b645:: with SMTP id g66-v6mr2467134wmf.25.1540992264029;
        Wed, 31 Oct 2018 06:24:24 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id r16-v6sm25202614wrv.21.2018.10.31.06.24.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 06:24:23 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH v7 0/8] mpt3sas: some bug fixes patches
Date:   Wed, 31 Oct 2018 18:53:31 +0530
Message-Id: <1540992219-20291-1-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V7 Change Set:
Split some patches into multiple small patches
as suggested by Bjorn Helgaas

v6 Change Set:
Incorporated changes as suggested by Andy.
In Patch 1 converted while loop to do while in
function mpt3sas_wait_for_ioc_to_operational().
And in patch 3 removed parentheses.

V5 Change Set:
V5 post has only defect fixes.
We are reworking and incorporating the suggestions from Bjorn.
And after covering tests, we ll be post Hot-Plug Surprise
 removal patches.

V4 Change Set:
Reframe split strings in print statement, to avoid

V3 Change Set:
Simplified function "mpt3sas_base_pci_device_is_available" and
made inline

V2 Change Set:
Replaced mpt3sas_base_pci_device_is_unplugged with
pci_device_is_present.

V1 Chnage Set:
In Patch 0001 - unlock mutex, if active reset is in progress.

Suganath Prabu (8):
  mpt3sas: Added new #define variable IOC_OPERATIONAL_WAIT_COUNT
  mpt3sas: Separate out mpt3sas_wait_for_ioc
  mpt3sas: Refactor mpt3sas_wait_for_ioc function
  mpt3sas: Call sas_remove_host before removing the target devices
  mpt3sas: Fix Sync cache command failure during driver unload
  mpt3sas: Don't modify EEDPTagMode field setting on SAS3.5 HBA devices
  mpt3sas: Fix driver modifying persistent data in Manufacturing page11
  mpt3sas: Bump driver version to 27.100.00.00.

 drivers/scsi/mpt3sas/mpt3sas_base.c      | 73 +++++++++++++------------
 drivers/scsi/mpt3sas/mpt3sas_base.h      |  8 ++-
 drivers/scsi/mpt3sas/mpt3sas_config.c    | 27 ++--------
 drivers/scsi/mpt3sas/mpt3sas_ctl.c       | 21 ++------
 drivers/scsi/mpt3sas/mpt3sas_scsih.c     | 38 ++++++++++++-
 drivers/scsi/mpt3sas/mpt3sas_transport.c | 91 ++++++--------------------------
 6 files changed, 106 insertions(+), 152 deletions(-)

-- 
1.8.3.1

