Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7238DC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C043208A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 08:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="S/fWnvX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C043208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbeLJId7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 03:33:59 -0500
Received: from smtprelay.synopsys.com ([198.182.60.111]:55896 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeLJId6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 03:33:58 -0500
Received: from mailhost.synopsys.com (mailhost3.synopsys.com [10.12.238.238])
        by smtprelay.synopsys.com (Postfix) with ESMTP id 75E4410C0ACD;
        Mon, 10 Dec 2018 00:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1544430838; bh=5q+ynvF0TSnTidDyZhzqa6eoCZKSSla1DNvQpWaILZA=;
        h=From:To:Cc:Subject:Date:From;
        b=S/fWnvX8VrlVFVPeI61zdc5CJr6ZtVn1L6dkVeHeaIKGHtGauGli/yqt/FL3kElSr
         pIJGs8pZbJJAYqR5PqiTuBFNkKm0Kbc5yXKgratKh0rGJ0elsi20yufLlvd0fiKBf+
         3TCQ09Iw5Gr1CCYYbbMv+gI67WOK4L+S6/Mwqy/9IXaTruw13H/CJKvLEN0/4l1aXw
         kplyYj6ifMg6LFb8XC1rLl4+WNZ98mhWU8p8kJElKqTgeeVay8cJJFPdXgTwztJvLp
         i2vL5dS0A0iu0HYFyJEKpAz0s1XFHYT7Y2ZUiwhFmAon0QcRBEJshOgpy8u32BHQys
         yHHdqotrGdejQ==
Received: from ru20arcgnu1.internal.synopsys.com (ru20arcgnu1.internal.synopsys.com [10.121.9.48])
        by mailhost.synopsys.com (Postfix) with ESMTP id 71FC93D6B;
        Mon, 10 Dec 2018 00:33:56 -0800 (PST)
From:   Alexey Brodkin <alexey.brodkin@synopsys.com>
To:     stable@vger.kernel.org
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>
Subject: [PATCH] ARC: [zebu] Remove CONFIG_INITRAMFS_SOURCE from defconfigs
Date:   Mon, 10 Dec 2018 11:33:49 +0300
Message-Id: <20181210083349.35728-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zebu boards were added in v4.9 and then renamed to "haps" in v4.10.

Thus backporting
commit 64234961c145 (ARC: configs: Remove CONFIG_INITRAMFS_SOURCE from defconfigs)
we missed "zebu" defconfigs in v4.9.

Note this is only applicable to "linux-4.9.y"!

Spotted by KerneCI, see [1].

[1] https://storage.kernelci.org/stable/linux-4.9.y/v4.9.144/arc/zebu_hs_smp_defconfig/build.log

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kevin Hilman <khilman@baylibre.com>
---
 arch/arc/configs/zebu_hs_defconfig     | 1 -
 arch/arc/configs/zebu_hs_smp_defconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arc/configs/zebu_hs_defconfig b/arch/arc/configs/zebu_hs_defconfig
index 9f6166be7145..3346829b02bb 100644
--- a/arch/arc/configs/zebu_hs_defconfig
+++ b/arch/arc/configs/zebu_hs_defconfig
@@ -11,7 +11,6 @@ CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_INITRAMFS_SOURCE="../../arc_initramfs_hs/"
 CONFIG_EXPERT=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_COMPAT_BRK is not set
diff --git a/arch/arc/configs/zebu_hs_smp_defconfig b/arch/arc/configs/zebu_hs_smp_defconfig
index 44e9693f4257..4471f9c37d7e 100644
--- a/arch/arc/configs/zebu_hs_smp_defconfig
+++ b/arch/arc/configs/zebu_hs_smp_defconfig
@@ -11,7 +11,6 @@ CONFIG_NAMESPACES=y
 # CONFIG_UTS_NS is not set
 # CONFIG_PID_NS is not set
 CONFIG_BLK_DEV_INITRD=y
-CONFIG_INITRAMFS_SOURCE="../../arc_initramfs_hs/"
 CONFIG_EMBEDDED=y
 CONFIG_PERF_EVENTS=y
 # CONFIG_VM_EVENT_COUNTERS is not set
-- 
2.16.2

