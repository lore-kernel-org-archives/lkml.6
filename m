Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F8AEC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 04:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F237E2081C
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 04:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="i8ghAZN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F237E2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729065AbeKDNNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 08:13:34 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:42236 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728653AbeKDNNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 08:13:33 -0500
Received: by mail-yw1-f67.google.com with SMTP id l2-v6so2365181ywb.9
        for <linux-kernel@vger.kernel.org>; Sat, 03 Nov 2018 21:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=8DM0Llx3zSLzR4gBis09kYJp6vbs2tBOu64mjKcvCso=;
        b=i8ghAZN2znZieXQO9eF4p4nEDnMML4/1+9KSHi/g18tDYPbHFCChOuv5LGCUx2ql2a
         GzzltXw1n5lGE2yt7OGXDATP0miBV7TK8qMTc3bfKvQtXp1mOCCL9CD2k+L1WaCZHcnc
         Aq+sIQgMdpICiSxTBdME+gEJGGSCqzVO3Q0XDzIoXGYENSLtiNdvzas2YmwzuT1EJH67
         iZBgC2WcAuASbWYz631IwR8OrnxUBMGQTmAqJ6xuk5cW9tY+U7rJhj1Mw2MpNNn1LpOd
         fD6V+gU/7KXd3C0564AZ11cDIZjBtXO7lhu2N28pKwoNIxmuUavkXE9nDwzSkaXpvbVs
         TMPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=8DM0Llx3zSLzR4gBis09kYJp6vbs2tBOu64mjKcvCso=;
        b=s777jSJVTVCycNPiBOmlb1rypXIVknnzGfLCZaJxMfdsyQVg7lBLXNztKHTpK8DN4j
         xKV/PjIf5qYfMrn70nBb+vFU+bdTPe+hqYXZ01BYQ2ISdYi+fh+TdWYeRPFpX6HPaqKz
         hssQXjo+gNIsSjxwUkPp/JpxpXa/zdJci+VchAAM9m3Fc+zM6dQ8Ae3qjqHdl02CoBVT
         5c9ux2appHH8DtYT7ok/L4PnsJnLM6apCcbMgk6n9nz7fU1deUOhfVxj7Nh/PR4qoLbW
         zF/6AFLjOLRbFw9Cv00A0LMmFl4zdzmTTNhMR3X5rI0vCHcxcMZv6dOl6DKhMtU+hz+u
         Mwdg==
X-Gm-Message-State: AGRZ1gJC+WApCBTjqMcSqtOQU/9QdWZPyc5RJvWytn/FB5J1b2n3C9II
        xLDI504VSGne0MCJLgwU2tZS/Q==
X-Google-Smtp-Source: AJdET5eRQHD7VNuX4zGDlZNoEPbDEAc61LqlNC04kmAPNPPDrMyKKcO3c8Z0ZcGNmQSmwXUdNQWdpA==
X-Received: by 2002:a81:6dcb:: with SMTP id i194-v6mr16566676ywc.215.1541304004876;
        Sat, 03 Nov 2018 21:00:04 -0700 (PDT)
Received: from graymalkin (76-230-155-4.lightspeed.rlghnc.sbcglobal.net. [76.230.155.4])
        by smtp.gmail.com with ESMTPSA id k125-v6sm9077467ywd.102.2018.11.03.21.00.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 03 Nov 2018 21:00:04 -0700 (PDT)
From:   Jon Mason <jdmason@kudzu.us>
X-Google-Original-From: Jon Mason <jdm@graymalkin.kudzu.us>
Received: by graymalkin (sSMTP sendmail emulation); Sun, 04 Nov 2018 00:00:02 -0400
Date:   Sun, 4 Nov 2018 00:00:02 -0400
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Subject: [GIT PULL] NTB patches for v4.20
Message-ID: <20181104040002.GA2439@graymalkin.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,
Here are a few NTB patches for v4.20.  Fairly minor changes and bug
fixes.  Please consider pulling them.


Thanks,
Jon

---

The following changes since commit 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d:

  Linux 4.19 (2018-10-22 07:37:37 +0100)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-4.20

for you to fetch changes up to a662315d8ad9e687fe648b6eea9bd35017f565dd:

  ntb: idt: Alter the driver info comments (2018-11-01 10:33:12 -0400)

----------------------------------------------------------------
NTB IDT thermal changes and hook into hwmon, ntb_netdev clean-up of
private struct, and a few bug fixes.

----------------------------------------------------------------
Aaron Sierra (2):
      NTB: transport: Try harder to alloc an aligned MW buffer
      ntb_netdev: Simplify remove with client device drvdata

Dave Jiang (1):
      ntb: intel: fix return value for ndev_vec_mask()

Gustavo A. R. Silva (2):
      NTB: ntb_hw_idt: replace IS_ERR_OR_NULL with regular NULL checks
      ntb: ntb_transport: Mark expected switch fall-throughs

Jon Mason (1):
      ntb_netdev: fix sleep time mismatch

Serge Semin (5):
      ntb: idt: Set PCIe bus address to BARLIMITx
      ntb: idt: Alter temperature read method
      ntb: idt: Add basic hwmon sysfs interface
      ntb: idt: Discard temperature sensor IRQ handler
      ntb: idt: Alter the driver info comments

 drivers/net/ntb_netdev.c           |  30 +---
 drivers/ntb/hw/idt/Kconfig         |   5 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c    | 327 +++++++++++++++++++++++++++++++------
 drivers/ntb/hw/idt/ntb_hw_idt.h    |  87 +++++++++-
 drivers/ntb/hw/intel/ntb_hw_gen1.c |   2 +-
 drivers/ntb/ntb_transport.c        |  88 +++++++---
 6 files changed, 429 insertions(+), 110 deletions(-)
