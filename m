Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C869ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295582147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 00:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Re3Fy6d3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295582147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeIQGLz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 02:11:55 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35006 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeIQGLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 02:11:55 -0400
Received: by mail-pg1-f195.google.com with SMTP id 7-v6so6823887pgf.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 17:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=em334lGo4en5GvrQrQFpYWC9DYbtgeRD3RKoNlXT0Ig=;
        b=Re3Fy6d35PpuJ1TwyAbIN+TuOkDgNaYZhHzJ2RoGXz6KZfLppzksOAEnouY3wCA7sN
         aP3B6a+hYuedQEgKklvfZjOyHw5MCdht7rnFhHj+MuP+MbEYwnfct4AdBjANhzAgkkXN
         SSNFXzQUr4vQe0bm4JmUrEQRlaxa+L/U0EWxwDOkM0/rPKS3x0jr08P+QG2GmyzemnuO
         DpoMdrJC1ySCrhgpVlAy+rXJ45MI8xSkiC0o9FjttUG4E8f16EKyQ/mZ3WLcT8Di76St
         iOiSVZzU4+AoEvZxGbJUvHXv+XzlwZisizi7+05Y48QUJOp0WkHyGDri3zlagE0obLzD
         Bo0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=em334lGo4en5GvrQrQFpYWC9DYbtgeRD3RKoNlXT0Ig=;
        b=PcQmcMvhdFwgs+Qx51EbxYUabwPkABE7zLPGqnemZcobvTX3WMyWyf7Cr5UW9yCNR1
         J8fspa0laRiG9JuLv2jHoLR50v6Z8jo7UmngiCIXhRW8xCxH6IccJZvqlEuTsF2THHVJ
         1At+5gRc74GlebHdnJsy2AXnsE9AYwBjEGTMdn/+w0fK7bJCukmVNWhracKZv3+wE/N9
         E+5wJkLKQcqKkmfT/EY8AlHlLm/Lg2K0WcIclJKaUMgzEAcqHxGzQ/w3fnO+8bVgEZXb
         ryS8cDTkI7pscGTa5dDRgOlLgxrmeRDhSUdN10A4KHUY/Qzr40kaF4b7VZTNL4XzLGY1
         I7Tw==
X-Gm-Message-State: APzg51A5xn8jJZdcHw+UYok6zsv/pn5Jiledtxjbj2doYvYwLylwi0I7
        fs64/FNj2vpH72+T9tbFKjw=
X-Google-Smtp-Source: ANB0Vdb2SB8zNspK5OHL16422dsHL/CsGnCX7/XPV3FCjefv4YU646v7/Qrt3r64sX5b5Ot0ng0EEA==
X-Received: by 2002:a63:4f14:: with SMTP id d20-v6mr21206245pgb.121.1537145224055;
        Sun, 16 Sep 2018 17:47:04 -0700 (PDT)
Received: from bbox-2.seo.corp.google.com ([2401:fa00:d:10:affa:813f:5380:6613])
        by smtp.gmail.com with ESMTPSA id w16-v6sm29311503pfi.101.2018.09.16.17.46.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 17:47:02 -0700 (PDT)
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>, linux@armlinux.org.uk
Cc:     steve.capper@linaro.org, will.deacon@arm.com,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel-team@android.com,
        miles.chen@mediatek.com, jian-min.lui@mediatek.com,
        juju.sung@mediatek.com, Minchan Kim <minchan@kernel.org>
Subject: [PATCH v1 0/3] arm: support get_user_pages_fast
Date:   Mon, 17 Sep 2018 09:44:48 +0900
Message-Id: <20180917004451.174527-1-minchan@kernel.org>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently, I got a report get_user_pages_fast helps app's launching time
due to reducing uninterruptible sleep time because it could reduce
mmap_sem lock contentions when app is launching.

To support gupf in ARM-non-LPAE, first patch reorders memory type table
to use 5th bit of the page table.

Second patch introduces L_PTE_SPECIAL for arm so that last patch can
support get_user_pags_fast.

I would greatly appreciate if guys review that I screw up something,
especially, architecture stuffs.

* from RFC
  * Remove CPU_v7M - Catalin
  * define DEV_NONSHARED to SHARED - Catalin
  * https://lkml.kernel.org/r/20180910165011.zcighyuabshsmxjb@armageddon.cambridge.arm.com

Minchan Kim (3):
  arm: mm: reordering memory type table
  arm: mm: introduce L_PTE_SPECIAL
  arm: mm: support get_user_pages_fast

 arch/arm/Kconfig                      |   2 +-
 arch/arm/include/asm/pgtable-2level.h |  22 ++-
 arch/arm/include/asm/pgtable-3level.h |   6 -
 arch/arm/include/asm/pgtable.h        |  13 ++
 arch/arm/mm/Makefile                  |   6 +
 arch/arm/mm/gup.c                     | 221 ++++++++++++++++++++++++++
 arch/arm/mm/proc-macros.S             |   4 +-
 7 files changed, 259 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/mm/gup.c

-- 
2.19.0.397.gdd90340f6a-goog

