Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061C9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00AC20645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emlid.com header.i=@emlid.com header.b="fzdCBvsK";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emlid.com header.i=@emlid.com header.b="rN9x+tNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00AC20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emlid.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeJLR4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:56:13 -0400
Received: from forward104o.mail.yandex.net ([37.140.190.179]:38597 "EHLO
        forward104o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726917AbeJLR4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:56:12 -0400
Received: from mxback7o.mail.yandex.net (mxback7o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::21])
        by forward104o.mail.yandex.net (Yandex) with ESMTP id 162F03D85543;
        Fri, 12 Oct 2018 13:24:27 +0300 (MSK)
Received: from smtp1p.mail.yandex.net (smtp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:6])
        by mxback7o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id uD0sK2Uy0O-OQbaUViV;
        Fri, 12 Oct 2018 13:24:26 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlid.com; s=mail; t=1539339866;
        bh=tqZGYeINaqiE31nsQKS4gLKvC7fYg1hPdp4GIUOMxJk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=fzdCBvsKABNonYE6mD9wiKzgtjjFVjag8PtO+iz4fSx3zSX6AD8axc2ce05n578oD
         smEQwWBcAY9YVPonbGAahcTKDdjjSEuCMXnckh67CESmagvXzjbNRfCK0QvJwLlKI5
         ZunXJTYNv8sfrOT+nUcKO4bqK3RIBqllnytdxtGI=
Received: by smtp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id u1IFFFPc8s-OOJiSjIj;
        Fri, 12 Oct 2018 13:24:24 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlid.com; s=mail; t=1539339864;
        bh=tqZGYeINaqiE31nsQKS4gLKvC7fYg1hPdp4GIUOMxJk=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=rN9x+tNHH6WCpeKYs7xwPJg/GP4f5LVuPiP/Zb0/IIbx9YqG6rI9NRhNJ0Z8pyEjn
         fcO9sWoxFC6EvLuXqCncUbJBpL7UJ/zYQILvCC+9yyQMWYOw5xTw9fhEiGeNgM8gY6
         F/Fzftecdoa+zTbSywJNisxSzFKGYbfRAy3AWDKM=
Authentication-Results: smtp1p.mail.yandex.net; dkim=pass header.i=@emlid.com
From:   Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
Cc:     Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        David Lechner <david@lechnology.com>,
        Thierry Reding <treding@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 0/2] Neutis N5 support
Date:   Fri, 12 Oct 2018 13:23:57 +0300
Message-Id: <1539339841-22235-1-git-send-email-aleksandr.aleksandrov@emlid.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539012044-29998-2-git-send-email-aleksandr.aleksandrov@emlid.com>
References: <1539012044-29998-2-git-send-email-aleksandr.aleksandrov@emlid.com>
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

Aleksandr Aleksandrov (2):
  arm64: dts: allwinner: new board - Emlid Neutis N5
  doc: devicetree: vendor-prefixes: new vendor - Emlid

 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 .../sun50i-h5-emlid-neutis-n5-devboard.dts         | 147 +++++++++++++++++++++
 .../dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi   |  59 +++++++++
 4 files changed, 208 insertions(+)
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5-devboard.dts
 create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h5-emlid-neutis-n5.dtsi

-- 
2.7.4

