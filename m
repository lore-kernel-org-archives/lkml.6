Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD59C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA98205C9
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 15:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emlid.com header.i=@emlid.com header.b="ElJmTGRL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emlid.com header.i=@emlid.com header.b="Ymar5C3j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EA98205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emlid.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJHWdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 18:33:41 -0400
Received: from forward100o.mail.yandex.net ([37.140.190.180]:36705 "EHLO
        forward100o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726348AbeJHWdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 18:33:41 -0400
Received: from mxback7g.mail.yandex.net (mxback7g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by forward100o.mail.yandex.net (Yandex) with ESMTPS id 191C52A2579C;
        Mon,  8 Oct 2018 18:21:25 +0300 (MSK)
Received: from smtp1j.mail.yandex.net (smtp1j.mail.yandex.net [2a02:6b8:0:801::ab])
        by mxback7g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id JM5dJcT3c6-LLCWBKmb;
        Mon, 08 Oct 2018 18:21:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlid.com; s=mail; t=1539012085;
        bh=ni2s433E+X7WXQc5YBCN0/KIBx3dmUinnDxu/LikGZs=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=ElJmTGRLyy+Rb86hB4+fTICivQdHQHk4v/l6h5LsZy/4/hqNyLkdyFoV9dzJW8O2A
         8lGQEBJ6B2JplQXNrk+8UjTny7GnysUFb2n8GsFaH0XlB0ScBUtGG1SuZx6A+OkekA
         +EIjLUAqEFGJQtJnWoiJNCFTS8zZRMRpU5G7B+C4=
Received: by smtp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id wWS1FCxMoH-LJYaV6fH;
        Mon, 08 Oct 2018 18:21:20 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlid.com; s=mail; t=1539012080;
        bh=ni2s433E+X7WXQc5YBCN0/KIBx3dmUinnDxu/LikGZs=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=Ymar5C3jYRBbJFRZPvs21cf/SfHUj89+CPHSm60DAhO4rkxk9Tg5mPBx89PIcxF9l
         xL857DnicExCIdswxLWlAvnPMnTyarMoQSfksN+BGZPrRZOV1wezOmv16bZzoSEE9k
         T+6r8199HR0pP/cCR8OnX/uSg+hYUaDuL5OwiEPQ=
Authentication-Results: smtp1j.mail.yandex.net; dkim=pass header.i=@emlid.com
From:   Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
Cc:     Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        =?UTF-8?q?Noralf=20Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3] Neutis N5 support
Date:   Mon,  8 Oct 2018 18:20:41 +0300
Message-Id: <1539012044-29998-1-git-send-email-aleksandr.aleksandrov@emlid.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538745949-13188-2-git-send-email-aleksandr.aleksandrov@emlid.com>
References: <1538745949-13188-2-git-send-email-aleksandr.aleksandrov@emlid.com>
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

