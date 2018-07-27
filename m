Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46CF1C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2EAC20842
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 17:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/PV+Vl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EAC20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389059AbeG0Syd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 14:54:33 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42692 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389008AbeG0Syc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 14:54:32 -0400
Received: by mail-wr1-f67.google.com with SMTP id e7-v6so5788128wrs.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 10:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CzmDmdL4N5sCO0VMfsWHJV/qesX+8Z5c9izK4kehRxM=;
        b=Q/PV+Vl8HVMjP48ZgLoc3ILcwVjObKbrg6bHWtS/wXgAJ6orzX7ltiDmQhqpLGLoP5
         2KkiG5f5mFvhoP/feowvVqs9WPdbZuQzYTWwry+QR2T0HRBG59a7iZm/ssWl46iaacGU
         pwpWYgVn9gXe+nl7gpvqtcYtl3BUgXgI8hbv1OgdhhfzdVl9JuANd/7MxtwzGOSghK0w
         UelcSYnVJR1AGPHj/Lu84pfOJkFPeZ/fQ0t3sMFEb222GY2g55ScDFmy2hlA3lWB3io0
         bHQ9nxN864/oprxxOFtSTz9RWvfEYRTm9K7g1sY816fl+jESXnXgeOBJWCyuVLl4aJhy
         n88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CzmDmdL4N5sCO0VMfsWHJV/qesX+8Z5c9izK4kehRxM=;
        b=n7WygNS/EWFp0A8+coQzP7saismDDoKpKJ0RfWGmMCm2+Co7mZtpVzmZc9q1h/XDvX
         c8/NavdM/vU3ujKm3lIRH4w+TR65A4pMJ2yImZfoGt6A3vSYx/RH+LJeXeKZcD7KTxlP
         aOuS8cvGwjzKDxCPuNBE32EPPf8LaGQ/+zagcYhbK7h+OXyh04LxP15MSLY6do+23+vw
         agBUdEIX15vNmqEzynn0AIykXZ216IP32CbUXDAjX/DSriiVkjSLr07NWi402DLoBdlh
         ehgjVmC8q79Gl3rNP1LgTswMYR5nCMMDWQGGSj8Rn0ZyK4BiANcQxgRz2FewSHYjd1oP
         VQAA==
X-Gm-Message-State: AOUpUlGzag65xQMEXo1uUXUUHQSRJPPJPb26CR6gM7HfmsUWqHZXkIkJ
        /pG+of63cINBvqSPL4VOlZpSOPU91Tk=
X-Google-Smtp-Source: AAOMgpck0or5tIyJQOdaVFwrYAD1YagOomPk8JVy3SGZy42oWAvGithmA5E/GlPGh10E0bEfKMCRdQ==
X-Received: by 2002:adf:f410:: with SMTP id g16-v6mr5628444wro.256.1532712698549;
        Fri, 27 Jul 2018 10:31:38 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id z3-v6sm6000010wru.27.2018.07.27.10.31.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 10:31:37 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 00/20] staging:rtl8192u Header file cleanup - Style
Date:   Fri, 27 Jul 2018 18:31:03 +0100
Message-Id: <20180727173123.27391-1-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coding style cleanup of drivers/staging/rtl8192u/ieee80211/rtl819x_TS.h

The only checkpatch issues which remain are three 'questionable'
comments which extend over the 80 character line limit.

The changes are generally either removal of typedef directives, removal
of unused constants or renaming of CamelCase variable names.

John Whitmore (20):
  staging:rtl8192u: Remove typedef and rename TX_TS_RECORD - Style
  staging:rtl8192u: Rename TsCommonInfo - Style
  staging:rtl8192u: Rename TxCurSeq - Style
  staging:rtl8192u: Rename TxPendingBARecord - Style
  staging:rtl8192u: Rename TxAdmittedBARecord - Style
  staging:rtl8192u: Rename bAddBaReqInProgress - Style
  staging:rtl8192u: Rename bAddBaReqDelayed - Style
  staging:rtl8192u: Rename bUsingBa - Style
  staging:rtl8192u: Rename TsAddBaTimer - Style
  staging:rtl8192u: Remove typedef and rename RX_TS_RECORD - Style
  staging:rtl8192u: Remove commented out code - Style
  staging:rtl8192u: Remove unused timer values - Style
  staging:rtl8192u: Rename RxIndicateSeq - Style
  staging:rtl8192u: Rename RxTimeoutIndicateSeq _Style
  staging:rtl8192u: Rename RxPendingPktList - Style
  staging:rtl8192u: Rename RxPktPendingTimer - Style
  staging:rtl8192u: Rename RxAdmittedBARecord - Style
  staging:rtl8192u: Rename RxLastSeqNum - Style
  staging:rtl8192u: Rename RxLastFragNum - Style
  staging:rtl8192u: Remove blank line - Style

 .../staging/rtl8192u/ieee80211/ieee80211.h    |   8 +-
 .../staging/rtl8192u/ieee80211/ieee80211_rx.c |  80 ++++++------
 .../staging/rtl8192u/ieee80211/ieee80211_tx.c |  14 +-
 .../rtl8192u/ieee80211/rtl819x_BAProc.c       |  88 ++++++-------
 .../staging/rtl8192u/ieee80211/rtl819x_TS.h   |  46 +++----
 .../rtl8192u/ieee80211/rtl819x_TSProc.c       | 120 +++++++++---------
 6 files changed, 176 insertions(+), 180 deletions(-)

-- 
2.18.0

