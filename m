Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA219ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 815282151B
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nm4g6iVu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 815282151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732424AbeISUL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:11:27 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:40362 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732354AbeISULZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:11:25 -0400
Received: by mail-qt0-f196.google.com with SMTP id h4-v6so5264354qtj.7;
        Wed, 19 Sep 2018 07:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5CAdxzfQRZkTFemiYjkqqIoF4GDpAHDHcjK2CfrXn5w=;
        b=Nm4g6iVu/HPpeihXVQQUggUndDSvf1d8DqMliRztGdJxzt3BqX5MFZACkRsb7vBnG+
         CnwzVF+IrIoBfgo8czUC4zOvxopSZgaTOG6w+rwoXhTwqOKOZgv+fO8yFaGRYK4wBVxl
         28RiaIAwWaJKisoqPOs0me+DA0SOQmc+7G9FtN+vkk9SZaarw47HKzhb6QWg+chaow2F
         mLj1/x/6XA9HppzhU+cI1tX3EeYxesow+/Zmi9rHp2kAoF9hrs/nnfuD3G+gRz648Uho
         zJnGAWweXEwtpstiCNHhvKdovFwM9cBRiXHXIKYjSVVmdInYYDi2Vlar70GXVl4VThYw
         M1Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5CAdxzfQRZkTFemiYjkqqIoF4GDpAHDHcjK2CfrXn5w=;
        b=BrV65sppGKS77vd+KQYRA28qyLqWctLrls/wpLMFKcfE/BPpumW14iMgNU3GNtuSzF
         /N5wKcJK3aWOmdF+Sol5sqvsVu6P5cS2vjPiBp60ODxS9zUIqcT7hv6Dzsrw9iTFRx/J
         mQyEfBAV7PUpvgYkJs2Mzbhkj/SpU+mXpPP8130cvxbAidWkOj7mXGpi0K4NJDzQqNWI
         0SgFtY9apLkglHNyXvgcOMG3m8EM14/Ln3ri0oF080ihh9hw5XXcgDCxvn1tIwWj2b3r
         irnDuwRWMLxQgrzQmoF32VHVUaUUe1LEtSLAhiaEGbWLyUNX6M5kF6BYXhZuL4Wo5gzo
         nLAg==
X-Gm-Message-State: APzg51CcnTIABAS57J52Y/MgiTTplch41eZCjg4sbzZDMS+/cb7ywMjQ
        VVVOk4741MdbNEUzJ09mJrFIfTVT
X-Google-Smtp-Source: ANB0VdbPw9AEiedEG+dEAsF8Nr3fkirVuMrQ4adwENEbxm4DnwQACoDGpvrEDMoZlSmbPNqvQX/R8Q==
X-Received: by 2002:ac8:198c:: with SMTP id u12-v6mr25220283qtj.86.1537367592915;
        Wed, 19 Sep 2018 07:33:12 -0700 (PDT)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id 17-v6sm2104051qkf.74.2018.09.19.07.33.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 07:33:12 -0700 (PDT)
From:   Jim Quinlan <jim2101024@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 09/12] MIPS: BMIPS: enable PCI
Date:   Wed, 19 Sep 2018 10:32:04 -0400
Message-Id: <1537367527-20773-10-git-send-email-jim2101024@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
References: <1537367527-20773-1-git-send-email-jim2101024@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the Kconfig hooks to enable the Broadcom STB PCIe root complex
driver for Broadcom MIPS systems.

Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
---
 arch/mips/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3551199..a15c0da 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -220,6 +220,9 @@ config BMIPS_GENERIC
 	select BOOT_RAW
 	select NO_EXCEPT_FILL
 	select USE_OF
+	select HW_HAS_PCI
+	select PCI_DRIVERS_GENERIC
+	select PCI
 	select CEVT_R4K
 	select CSRC_R4K
 	select SYNC_R4K
-- 
1.9.0.138.g2de3478

