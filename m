Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 891A0C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 05:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 503492064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 05:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="XavHgQ0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503492064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbeKAOMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 10:12:20 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:32893 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbeKAOMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 10:12:19 -0400
Received: by mail-pl1-f193.google.com with SMTP id x6-v6so8376070pln.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 22:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ubKhKoPKckBfrs+izWAdzx1As6ZWGpwYQzLemVrm8W4=;
        b=XavHgQ0tiG+sL1Lqmp1jYFSlZW1h9lpV7Qg4z0FuK1KUlMNuCBfwWIAFtb2/5uM86F
         iDXH3hQ5889g5L4+R8RmQiDR7Xcosr9no3JTQnTdgX1mMmgRfMIl6dB51+NcG08Bk0m9
         jtlWAJ8FXZIeXO4ap+EkuVgayi0ycTmUahE1FMe9dNtrHztq74GcqRBNBaofWrJ1Uhcb
         I+yuT5tUKwF78jqCWQpTQslJRvZi2mxjMbH1hqthxjbdHde955aKXpRbMDe2zToaAV5f
         D//QfqC0c6otnf6edI7kVpU99PCsVc7jSv7Qo4ceghjj1Xa9ATNAE6/QSGHMgJOLCb19
         w2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ubKhKoPKckBfrs+izWAdzx1As6ZWGpwYQzLemVrm8W4=;
        b=j+v5vwnIrvkzApE4wXA4klBmUj1i6NVHILfJyzXj58bI/OM0ilvROdMlfy5hWBWNPZ
         VRjDgeuuoFuEewrhryDu3hRLJSlWLgn3buZxQ1v2fVGdhhMvISFNMxvh3ZGPVI+/55MN
         EpuxWpWo9oTDGsMxOKgm0+BjUJR6H/ErX58qO85Rxaa7+8lU78g8l4gyFEp8SC5CRpJd
         Fl0S2Kg6aYgjBfl5yQHNxHivrM1kQX3PtO6haPNoruWvxkxY+yf3fG78gNZHq3OeSGG6
         aXPCm9PGR4TnAbOMA0LJ0HvD9RMRzQlzDhbB9sqez5y3Ht0TztQCG2VUHdgGhA2pv+f7
         vLEw==
X-Gm-Message-State: AGRZ1gKxStFHQYnX/gR49/HFmp9LszMujDXJbvu9FG+Se7L4vj8Bw620
        pbLotBzygd71tJrpSrTIMO0xWw==
X-Google-Smtp-Source: AJdET5cexhv5tYBwfPxqcaSrBk5RsPm6d9IWLTe9sDjZ/dYZYEwyJtA7V6pfYTmNqQNGtQMLcWNlJA==
X-Received: by 2002:a17:902:108a:: with SMTP id c10-v6mr6439201pla.49.1541049056282;
        Wed, 31 Oct 2018 22:10:56 -0700 (PDT)
Received: from anup-ubuntu64.qualcomm.com ([106.51.30.16])
        by smtp.googlemail.com with ESMTPSA id d65-v6sm40439166pfm.100.2018.10.31.22.10.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 22:10:55 -0700 (PDT)
From:   Anup Patel <anup@brainfault.org>
To:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Olof Johansson <olof@lixom.net>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH v2 2/2] RISC-V: defconfig: Enable printk timestamps
Date:   Thu,  1 Nov 2018 10:40:33 +0530
Message-Id: <20181101051033.10089-2-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181101051033.10089-1-anup@brainfault.org>
References: <20181101051033.10089-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The printk timestamps are very useful information to visually see
where kernel is spending time during boot. It also helps us see
the timing of hotplug events at runtime.

This patch enables printk timestamps in RISC-V defconfig so that
we have it enabled by default (similar to other architectures
such as x86_64, arm64, etc).

Signed-off-by: Anup Patel <anup@brainfault.org>
Acked-by: Olof Johansson <olof@lixom.net>
---
 arch/riscv/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 07fa9ea75fea..ef4f15df9adf 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -76,4 +76,5 @@ CONFIG_NFS_V4_1=y
 CONFIG_NFS_V4_2=y
 CONFIG_ROOT_NFS=y
 CONFIG_CRYPTO_USER_API_HASH=y
+CONFIG_PRINTK_TIME=y
 # CONFIG_RCU_TRACE is not set
-- 
2.17.1

