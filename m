Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FDBC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AAE620663
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 12:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NbQXwQPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbfA2MOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 07:14:55 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38893 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727555AbfA2MOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 07:14:55 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so9267028plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 04:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=q8EQGyN9PszasIW6EBIBlhZcBH+GzZ08zl3SI/IaZis=;
        b=NbQXwQPYyY9cSfxW9wkU0V8b4p8tCLwUeHMHf5QJX565nIkud+4HkopJoahYLAuh/2
         xqHXTcF4FnuVbBDtf9QQUFzwgoqOhF+ehUXGSTa+xpL7BID0Dm5F3qyUjSh/c78rahvF
         U2WusD74yTsyL6WP2Wjo7BpUn9Vy/dWGhU0gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q8EQGyN9PszasIW6EBIBlhZcBH+GzZ08zl3SI/IaZis=;
        b=m5arOfKclfuikMlZ3Joq5/rZV3st7RnlvfxLT7g/1RjwwWjBZEOf9waVMHVNtcnfo3
         8LsSa9nz2hNzCi16ht2CgXy4r/MF5HdTYkNd68xgAgnZpn2ixhoVr2vjm5vQ6Wc/VMhP
         a6XRJQvpnuhpLA7fVEZAGVg2Je8yoN6T3hj7SaM6CgnlepBxFMzpuGBBQIgQnmJGPTfm
         rhMTJsALfMM08sDED9Mwx9UCtV1d++eOchMYX4IXA6WpK8UptdgFjJnM1JOBZezORIy1
         IhLSWJ4lxJbXfiI6lX4XvQQXI9Sf0lDXqdBLMmw4Wyl7nq42dym6q/FHJxEYK8CNWSUT
         Sf7A==
X-Gm-Message-State: AJcUukdiTrZBadMDw8YbkboEsl8j0T47O9Es4GngYk/OhHO8JP0UIFs1
        xs24p2gf7Dgf1slYl/3Th/d6HQ==
X-Google-Smtp-Source: ALg8bN4tehXqChYdSLs8vK39L4tRcGVZ+0mJDW9XPpRE8+YpFwKfVMg4uSNnts21znFbu47SFJhVaQ==
X-Received: by 2002:a17:902:690c:: with SMTP id j12mr25547610plk.206.1548764094343;
        Tue, 29 Jan 2019 04:14:54 -0800 (PST)
Received: from dhcp-10-123-20-72.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id g136sm48689876pfb.154.2019.01.29.04.14.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 04:14:53 -0800 (PST)
From:   Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
To:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu S <suganath-prabu.subramani@broadcom.com>
Subject: [PATCH 0/4] mpt3sas: Add Atlas and Ambrosia device support.
Date:   Tue, 29 Jan 2019 07:14:39 -0500
Message-Id: <1548764083-5781-1-git-send-email-suganath-prabu.subramani@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Posting below patches to include new devices Ambrosia,
Atlas.

* Rename macros for MPI Endpoint device which
is a PCIe switch based on MPI2.
* Added device ID 0x02B1 for NVMe Switch Adapter (Ambrosia).
* Added device ID for the Atlas PCIe Switch management port
(0x00B2). This device is based on MPI2.6 and it exposes
one SES device to accept management commands.

Suganath Prabu S (4):
  mpt3sas: Rename mpi endpoint device ID macro.
  mpt3sas: Add support for NVMe Switch Adapter
  mpt3sas: Add support for ATLAS PCIe switch.
  mpt3sas: Update driver version to 27.102.00.00

 drivers/scsi/mpt3sas/mpi/mpi2_cnfg.h |  3 ++-
 drivers/scsi/mpt3sas/mpt3sas_base.h  |  7 +++++--
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 16 +++++++++++++---
 3 files changed, 20 insertions(+), 6 deletions(-)

Thanks,
Suganath Prabu
-- 
1.8.3.1

