Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B2EC65BA9
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2DA20878
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 03:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tqPKp5jA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC2DA20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbeJCJ7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 05:59:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34122 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbeJCJ7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 05:59:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so960357pfi.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 20:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A8JtHAC5naJL8x4fNKDf/GkWKYU0n8LRslVlKTfoHeI=;
        b=tqPKp5jA79Clg4VZIqXQg3s2E+P5J/oGRzax/CJxZuFCpxgU2xRUiC+Erj/obA9aT2
         rX+9tduecmxu5q0USuyVSrCJjjQp8UfG3Z/iA0e1DZG0par0c8r5KOdgIfYJpAt5W0Y+
         kY8vZ7TehG3+yf7Y9fJuCNk8MplG/5d1Sj7DcUZ8WtSBIvSFbrxX+w4402v1rsGh2yv5
         CrBDCZ1AKZdMilmmOiM6dHp3dFPt96RwaJAyCUVlOLH3ZDrDOWZqgTw9vEOvRmv45620
         vwhGsg1+bUBlYZNLK30EUh/Oi7JtNTpm2SiukiYjSmR13KutmKfonvxiUtb2z1Yel3la
         Nt3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A8JtHAC5naJL8x4fNKDf/GkWKYU0n8LRslVlKTfoHeI=;
        b=Y6ixCJKHx26bYOm3nwO5y+s8SFrKs5EKltGWRhCyHFWuIreORrJmQRoaD0HVuoY6aN
         kgTaFfOZc/7IW3MKEnVW+e28HOgxcy3PvFWcAYrbE/X6gijwvfqAz8TAaJT5S9zxwGDc
         2sc5wZDD1jn6oW4Qmv4pOBBAPYZSAZge0cNFWodaeyUCLx75riXZTcrQWrCsNSS9qYIG
         GD+gTwTz7Pc7AK1lIUYJwJicIsY8zufMgRa2Vv2pe1QH3vkZzQOXeBkXMrzWsMkU7rzF
         +Difwzg9TucRFSwtZ+hfDjNvutnzkiGdj/8z+YK6OtvL4eUvcKuHSC50R5Ctt6TH4tU0
         lvtQ==
X-Gm-Message-State: ABuFfogatRCcvxxJVMO0y7jJfQdpHWrL8tqA9J9ZIwZKHQ6X79jOb46d
        BP8hJ+tjysm7iSA03SXJdHQ=
X-Google-Smtp-Source: ACcGV60Io+NddWjxZE0/ihvgsE/2pO0UrYIB3Q5I3B6OPmkvfx4tIDKraWUwossHggtpfPH6CNYQCQ==
X-Received: by 2002:a62:32c4:: with SMTP id y187-v6mr11625804pfy.4.1538536367018;
        Tue, 02 Oct 2018 20:12:47 -0700 (PDT)
Received: from app09.andestech.com (59-120-53-16.HINET-IP.hinet.net. [59.120.53.16])
        by smtp.gmail.com with ESMTPSA id v23-v6sm21777747pfm.80.2018.10.02.20.12.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 20:12:46 -0700 (PDT)
From:   Zong Li <zongbox@gmail.com>
To:     palmer@sifive.com, aou@eecs.berkeley.edu
Cc:     hch@infradead.org, zong@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zong Li <zongbox@gmail.com>
Subject: [PATCH v4 4/5] RISC-V: Select GENERIC_LIB_UMODDI3 on RV32
Date:   Wed,  3 Oct 2018 11:10:01 +0800
Message-Id: <b87900141b3ee65e639bb8a0278a2acd7fced103.1538535528.git.zongbox@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1538535527.git.zongbox@gmail.com>
References: <cover.1538535527.git.zongbox@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On RV32, it will use the __umoddi3. Select GENERIC_LIB_UMODDI3 to avoid
undefined reference.

Signed-off-by: Zong Li <zong@andestech.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a344980..dc262fa 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -108,6 +108,7 @@ config ARCH_RV32I
 	select GENERIC_LIB_ASHRDI3
 	select GENERIC_LIB_LSHRDI3
 	select GENERIC_LIB_UCMPDI2
+	select GENERIC_LIB_UMODDI3
 
 config ARCH_RV64I
 	bool "RV64I"
-- 
2.7.4

