Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5943C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD4A2075D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DP38jPdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD4A2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbeJYWgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:36:53 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:42396 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727356AbeJYWgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:36:52 -0400
Received: by mail-wr1-f51.google.com with SMTP id y15-v6so5081078wru.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 07:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VJqgzEaS65550/l+H4wpWYgIrcptsCnwc6PvoGTSdc0=;
        b=DP38jPdjX/47mQLkdIkBY7RBMmRMLMd5LpQPKJux8uHiUq5V1m+FjpDrw4r1Im/z6G
         IncZiQJgOVXO63eOa5jEiw3aUFYk5eLfHbwalTBRIsAuGY4rRtlztklprbAOw5qfoMRv
         JQGCD/0LV5BndcYJWfTosOD1QnhzUaj5oTO4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VJqgzEaS65550/l+H4wpWYgIrcptsCnwc6PvoGTSdc0=;
        b=I/amQ8I07aaNmwHN1ytiL/WHzrifVIkCJ/rBZCvA+4+SO0bl6bD52ms5CcgAxyLEzy
         B5icjyd5LncPIwDtDAc7Ujd2pNzvvLqd/XEI6bDnQY2FS5EXZ4s2B3gFZvyK3i9U8XME
         tVKChoXrdqAX2uw/TwQCOFsMF56+g2TFt+ezAgKNHstBDjFCnQ61MVl+fPmHoz+uNIvp
         l+k+uLm62N6fNB+MgFZcHpLr8BHHhOARK8880ebPEeefhatSouanfAhspbYrV33F4hma
         VaMmumb6+flNYkMKOTSGutz/RQXtpNPyAV/Q531UZgUoINtTXNoGvELnYdJpUJMdGQSh
         xIXQ==
X-Gm-Message-State: AGRZ1gIaKFuaYAPtEt5zkv5W0bkcL4tNX1UlcsXIWqPQujiAHbtmavs5
        7N3lsF+4Oy35dOGuWir+1Iaplr8cLlQ=
X-Google-Smtp-Source: AJdET5er3jPi0/j2TMGuRgFDnw9BT0sMQMDUIvDNWrCaLmwU9YmLJ4QmA1j2+6bqnyAxtp5O09qbzA==
X-Received: by 2002:adf:a591:: with SMTP id g17-v6mr2200370wrc.188.1540476237494;
        Thu, 25 Oct 2018 07:03:57 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id u10-v6sm7313771wrt.59.2018.10.25.07.03.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 07:03:56 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [Resend 0/2] mpt3sas: Add support to Aero controllers.
Date:   Thu, 25 Oct 2018 19:33:39 +0530
Message-Id: <1540476221-14987-1-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1) Updated MPI headers to the latest version 2.6.7.
2) Added support for Aero/Sea controllers.

Suganath Prabu (2):
  mpt3sas: Update MPI headers to support Aero controllers.
  mpt3sas: Add support to Aero PCI IDs.

 drivers/scsi/mpt3sas/mpi/mpi2.h       |  17 +-
 drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h  |  94 +++++--
 drivers/scsi/mpt3sas/mpi/mpi2_image.h | 507 ++++++++++++++++++++++++++++++++++
 drivers/scsi/mpt3sas/mpi/mpi2_init.h  |   2 +-
 drivers/scsi/mpt3sas/mpi/mpi2_ioc.h   | 359 +-----------------------
 drivers/scsi/mpt3sas/mpi/mpi2_pci.h   |  11 +-
 drivers/scsi/mpt3sas/mpi/mpi2_raid.h  |   2 +-
 drivers/scsi/mpt3sas/mpi/mpi2_sas.h   |   2 +-
 drivers/scsi/mpt3sas/mpi/mpi2_tool.h  |  72 ++++-
 drivers/scsi/mpt3sas/mpt3sas_base.h   |   1 +
 drivers/scsi/mpt3sas/mpt3sas_scsih.c  |  26 ++
 11 files changed, 705 insertions(+), 388 deletions(-)
 create mode 100644 drivers/scsi/mpt3sas/mpi/mpi2_image.h

-- 
1.8.3.1

