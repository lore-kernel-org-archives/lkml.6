Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660F0C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 115F520652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emlid.com header.i=@emlid.com header.b="INxsP1j/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emlid.com header.i=@emlid.com header.b="GzkHV1aL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 115F520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emlid.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbeJOTfS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:35:18 -0400
Received: from forward101p.mail.yandex.net ([77.88.28.101]:59128 "EHLO
        forward101p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726400AbeJOTfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:35:18 -0400
Received: from mxback15j.mail.yandex.net (mxback15j.mail.yandex.net [IPv6:2a02:6b8:0:1619::91])
        by forward101p.mail.yandex.net (Yandex) with ESMTP id 6CC1E4E83301;
        Mon, 15 Oct 2018 14:50:19 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback15j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id xLdrcaqzQu-oF6CSETC;
        Mon, 15 Oct 2018 14:50:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlid.com; s=mail; t=1539604218;
        bh=yrTtp7+SzaGsLoIFFR0rbaWd9Yqd1B5pSapSf9jkt9o=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=INxsP1j/eUYQ1r4LgXwqcrRIZHgBXzqhqrA4pvnRulwAUOV1ocMlX/RuobzC2pROI
         OqRwKAeXNq7Jr9bZdaAl5efB7IS4pfaADDVBWwtDPBike0XorShy+X6WeguYvN39+2
         KmfetPtOh3RTTtwrt4nexFcEfdiIkiyVtZgqJS58=
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id q72Y4XcU2b-oDx099W0;
        Mon, 15 Oct 2018 14:50:13 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlid.com; s=mail; t=1539604213;
        bh=yrTtp7+SzaGsLoIFFR0rbaWd9Yqd1B5pSapSf9jkt9o=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=GzkHV1aLWTMeuLNv+rkI9mYYXfk4g/6J4t8QjX9Bpawkd669npgwAgHhODIgyTvLJ
         HPBlDWYPEKTBU8jzQy4Ka3ay0VrhW7v262Yr9eYBvDKfM93G6NKVwyqNWAVRd6pE4t
         hC7mt1V6fVJiy4dzV/nrDRUZsklMLUeLUMVYOBsk=
Authentication-Results: smtp3p.mail.yandex.net; dkim=pass header.i=@emlid.com
From:   Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
Cc:     Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        David Lechner <david@lechnology.com>,
        Thierry Reding <treding@nvidia.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 0/2] Neutis N5 support
Date:   Mon, 15 Oct 2018 14:49:48 +0300
Message-Id: <1539604192-17561-1-git-send-email-aleksandr.aleksandrov@emlid.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539339841-22235-2-git-send-email-aleksandr.aleksandrov@emlid.com>
References: <1539339841-22235-2-git-send-email-aleksandr.aleksandrov@emlid.com>
To:     unlisted-recipients:; (no To-header on input)
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
- makefile: dtb-$(CONFIG_ARCH_SUNXI) - ordered alphabetically

Changes from v3 (12 oct 2018):
- fix commit prefix for 1/2 patch
- use an SPDX header instead of the full license text
- compatible: "emlid,neutis-n5" instead of "emlid,emlid-neutis-n5"

Changes from v4 (15 oct 2018):
- fix dt-bindings commit prefix
- update license header for dts files
- make interfaces be alphabetically in devboard dts file

Aleksandr Aleksandrov (2):
  dt-bindings: vendor-prefix: new vendor - Emlid
  arm64: dts: allwinner: new board - Emlid Neutis N5

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 .../sun50i-h5-emlid-neutis-n5-devboard.dts         | 149 +++++++++++++++++++++
 .../dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi   |  61 +++++++++
 4 files changed, 212 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi

-- 
2.7.4

