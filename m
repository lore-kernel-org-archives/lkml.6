Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2732FC00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBD0720834
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 13:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBD0720834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emlid.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728515AbeJEUce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 16:32:34 -0400
Received: from forward101o.mail.yandex.net ([37.140.190.181]:59124 "EHLO
        forward101o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728118AbeJEUce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 16:32:34 -0400
X-Greylist: delayed 472 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Oct 2018 16:32:33 EDT
Received: from mxback2j.mail.yandex.net (mxback2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10b])
        by forward101o.mail.yandex.net (Yandex) with ESMTP id BD5521344C78
        for <linux-kernel@vger.kernel.org>; Fri,  5 Oct 2018 16:25:57 +0300 (MSK)
Received: from smtp1j.mail.yandex.net (smtp1j.mail.yandex.net [2a02:6b8:0:801::ab])
        by mxback2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id co1NI0EzPp-PvS4WFMn;
        Fri, 05 Oct 2018 16:25:57 +0300
Received: by smtp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 8ThgXb4TTa-PvS8DxiM;
        Fri, 05 Oct 2018 16:25:57 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
To:     linux-kernel@vger.kernel.org
Cc:     Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
Subject: [PATCH v3] Neutis N5 support
Date:   Fri,  5 Oct 2018 16:25:48 +0300
Message-Id: <1538745949-13188-1-git-send-email-aleksandr.aleksandrov@emlid.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch addes Neutis N5 support.
Emlid Neutis N5 is a SoM based on Allwinner H5.
The patch includes device tree file for Dev board
and dtsi file for SoM needs.

Changes from v1: separate dts file: dtsi for SoM
and motherboard dts file that inlcudes dtsi file.

Changes from v2 (5 oct 2018):
- put Maxime Ripard in Cc
- makefile: dtb-$(CONFIG_ARCH_SUNXI) - ordered alphabetically

Aleksandr Aleksandrov (1):
  arm64: new board - Emlid Neutis N5

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 .../sun50i-h5-emlid-neutis-n5-devboard.dts         | 184 +++++++++++++++++++++
 .../dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi   |  96 +++++++++++
 4 files changed, 282 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi

-- 
2.7.4

