Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49513C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176C22086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176C22086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeKHIsP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:48:15 -0500
Received: from smtp4-g21.free.fr ([212.27.42.4]:63368 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727068AbeKHIsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:48:15 -0500
Received: from [192.168.1.42] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id AD02F19F4F3;
        Thu,  8 Nov 2018 00:15:22 +0100 (CET)
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Subject: [PATCH v2 0/9] Regenerate arm64 defconfig for current kernel
To:     arm-soc <arm@kernel.org>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Message-ID: <898e79a6-092c-d013-d2bb-f6260e761379@free.fr>
Date:   Wed, 7 Nov 2018 23:39:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello ARM maintainers,

v2: Improve commit message for a few patches

The set of Kconfig options slowly changes with every kernel version.
This patch series regenerates the arm64 defconfig for v4.20
No functional change intended, except adding PINCTRL_MTK_MOORE to
keep PINCTRL_MT7622.

Marc Gonzalez (9):
  arm64: defconfig: Regenerate for v4.20
  arm64: defconfig: Drop ARM_BIG_LITTLE_CPUFREQ
  arm64: defconfig: Drop NF_CONNTRACK_IPV{4,6}
  arm64: defconfig: Drop USB_ULPI_BUS and USB_CHIPIDEA_ULPI
  arm64: defconfig: Replace PINCTRL_MT7622 with PINCTRL_MTK_MOORE
  arm64: defconfig: Drop redundant SND_SOC_ROCKCHIP_I2S
  arm64: defconfig: Drop CRYPTO_DEV_FSL_DPAA2_CAAM
  arm64: defconfig: Change SCSI_UFS_HISI=m
  arm64: defconfig: Drop redundant sound codec options

 arch/arm64/configs/defconfig | 105 +++++++++++++++--------------------
 1 file changed, 46 insertions(+), 59 deletions(-)

-- 
2.17.1
