Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640D0ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234122082E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 10:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="N0o3gBC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 234122082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeJYSnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 14:43:12 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:53582 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbeJYSnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 14:43:12 -0400
Received: by mail-wm1-f41.google.com with SMTP id l26-v6so926446wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 03:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=kPXFuJ7L8fCgSKYz+vGL38+1/vJOQFBA69cVPW/FI1M=;
        b=N0o3gBC+jjUfdmqltSJ9FGsTCFdXnqPnnNNI26LenLhVbfl4U1v9yVydG2fWPDwXzE
         N17NkeourFU0k2mXZWos5yNLSzh63AxLbWqeAxu9O5enS9q3L1be5fe7lBJ6KLI4VtUA
         2lzt2TQiwqG7XxiRdQXWPwhsqRqokz+QSooEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kPXFuJ7L8fCgSKYz+vGL38+1/vJOQFBA69cVPW/FI1M=;
        b=MHV06WswJIXfqdtdtfkbJ8gVy0os1RcgE0F7faKMbdjwIb6Yhx0mj1KsFsHzx2wSvi
         31Ye1NO/hLIQdhGpe0UY/6g1cPI5y/sPjiQ+kl6g4E2ZyJCHHe2FiAFEV18zFNbCJUpZ
         a8OJGbIMtvVs6XLuL8aLFBVTcKCycpntp5mPBij4ZK3WtEQ4yB0OyhXCB/eRVX/T6+hY
         VRXaaQrlSc6FxZHjQYgCIRV4Jv3Q0gB8wMovd/xZsrgFgEOl99xfC/mztN2kuJcrjREs
         AVgaryK0VLcNyet03rFw65O6NL13+2l4UEag2Z2yAhW7w5aR3yuXvTO1Wwob5y8yOLnx
         jo/w==
X-Gm-Message-State: AGRZ1gJwXFHJNW3V76BSOwCso6ZRnEUPnK6IszIq5koEx7T9LFtVXVva
        DVmoEIDE3wPdOPD8oyoX5FjD76/cZf4=
X-Google-Smtp-Source: AJdET5c7zjzdyPnwYJSnq7IZ0ik/0VdD/bP4bECwR+8d24FUdfpwtPBG7ZXpAQa/lyiUKQNZOAgv+A==
X-Received: by 2002:a1c:b58e:: with SMTP id e136-v6mr1151247wmf.114.1540462267300;
        Thu, 25 Oct 2018 03:11:07 -0700 (PDT)
Received: from dhcp-10-123-74-106.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l11-v6sm5982513wrn.61.2018.10.25.03.11.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 03:11:06 -0700 (PDT)
From:   Suganath Prabu <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 0/2]mpt3sas: Update MPI headers to support Aero controllers.
Date:   Thu, 25 Oct 2018 15:40:47 +0530
Message-Id: <1540462249-9984-1-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updating MPI headers to the latest version 2.6.7 to
 add support to the driver to detect new 3816
 and 3916 chip based controllers.
Seperate out firmware image data from mpi2_ioc.h
to new file mpi2_image.h

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

