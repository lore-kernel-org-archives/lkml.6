Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 491D1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA3B020852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rwwnJA6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA3B020852
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388327AbeGWXvF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:51:05 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:36142 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388207AbeGWXvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:51:05 -0400
Received: by mail-it0-f74.google.com with SMTP id m185-v6so699930itm.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 15:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=rY92PwetMMJR811lcQ86re3RAm6WYixeOP2SYa6MEWw=;
        b=rwwnJA6oQugW+RENcYTvutu3Xjy1CunpyYsoGEqrCO8dEDrh4vuz0/2dXUvtFNBTvL
         OBZFkeqapMFEPKQpBaYy4jph8fhnxV2lsW+zhFZtUek/SeiTTht6IoB8fkYDVZj4wZtt
         Gega3YdxI/ngymnMrMys6orhtwkRXupE5eZWRzwZqIusBd29CDa6KTJUN6BKrZ2U3KfV
         hlrmHMwPlnvDuEJZRYDC4SlPHYbwITUMjByFz0UtGC03Gi1PHExFulYOn24CTkdfumxG
         9nlHSFE0QDcik8158Nv7WNZoBZgSIUy23XXTLPbKDWIDAAHOWeK7CUYuZmHRXNA+o5Tp
         Gr/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=rY92PwetMMJR811lcQ86re3RAm6WYixeOP2SYa6MEWw=;
        b=CtEGYnE6rn/USTMlx2CwFCMhjOStPuB2U+4cbG+hInBIxagiHcjKmPfhI4XESlos4f
         GRHUQqkZLhAEuz8QPMqGCEAvhBYyCwDFKYifKxOFNTPEqWLEc5rm1OQKGR1TXPcfR1+Q
         7Y9pa+Nw3nuZHTC/4LW9UFjUhmRbc2g3FKjs0Kj+xTXo7SDV43SpLmJMJMINOM8jLBiE
         bNhcLE0rveFDr2/NhErgLuwSG+0Ub18Qj8A8w8ihp5DQwvjdj6myn7wudjKQ/Cd1M1dn
         huJL945zKMLP7VRn9GNr/P6eUUPT4OLj61z2o1y7UM1cE9TEoJrHHurBwUDX7c5YTyAm
         do+g==
X-Gm-Message-State: AOUpUlF4r3EkzAJi/nVe4GOGkVCIQ5WZLCnll2pEbInzn39mgYcVEF2f
        IWbQQAIvR1qk25QNP16VqNONVq4V
X-Google-Smtp-Source: AAOMgpcQdAiT1co7iiC7WOIvU9pZC4FAloxYzVnBzkb5pRDEMHQeJCAm9+GXO1aNNlQ3q+iHM5Ae6/YH
MIME-Version: 1.0
X-Received: by 2002:a24:47ca:: with SMTP id t193-v6mr434109itb.24.1532386059597;
 Mon, 23 Jul 2018 15:47:39 -0700 (PDT)
Date:   Mon, 23 Jul 2018 15:47:26 -0700
Message-Id: <20180723224727.120952-1-rkir@google.com>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Subject: [PATCH 1/2] goldfish: Add missing includes to goldfish.h
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

goldfish.h refers to external symbols such as
dma_addr_t and writel. This causes compilation errors
if this file is included before other header files.

The mentioned symbols are defined in types.h (dma_addr_t)
and io.h (writel).

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 include/linux/goldfish.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/goldfish.h b/include/linux/goldfish.h
index 2835c150c3ff..159b4191f15d 100644
--- a/include/linux/goldfish.h
+++ b/include/linux/goldfish.h
@@ -2,6 +2,9 @@
 #ifndef __LINUX_GOLDFISH_H
 #define __LINUX_GOLDFISH_H
 
+#include <linux/types.h>
+#include <linux/io.h>
+
 /* Helpers for Goldfish virtual platform */
 
 static inline void gf_write_ptr(const void *ptr, void __iomem *portl,
-- 
2.18.0.233.g985f88cf7e-goog

