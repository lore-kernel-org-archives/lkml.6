Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59093C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1293620645
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 10:25:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emlid.com header.i=@emlid.com header.b="fu/pXNDU";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emlid.com header.i=@emlid.com header.b="BZCYEylC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1293620645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emlid.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbeJLR4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:56:41 -0400
Received: from forward106p.mail.yandex.net ([77.88.28.109]:55724 "EHLO
        forward106p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726917AbeJLR4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:56:36 -0400
Received: from mxback9j.mail.yandex.net (mxback9j.mail.yandex.net [IPv6:2a02:6b8:0:1619::112])
        by forward106p.mail.yandex.net (Yandex) with ESMTP id 5F33F2D84C4C;
        Fri, 12 Oct 2018 13:24:38 +0300 (MSK)
Received: from smtp1p.mail.yandex.net (smtp1p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:6])
        by mxback9j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id NzZ8fCjzqH-Ob2u7R7E;
        Fri, 12 Oct 2018 13:24:38 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlid.com; s=mail; t=1539339878;
        bh=g22DJRSm0I8P33w/0DK5PD0Fqya9i+gMMdvEquIKooM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=fu/pXNDUOwj/iwhVo4MnQQeCcvv5SVEsuWjYi23EDSO95n9w1XSHL6u2Y5Ny7EEBS
         q8H8b+QzpwVP1XxIkvor5ucYgCLhDr0zRWBeZOqvUWf13yHx5K+uMbVUaemVGt746x
         l9vgZ5eZIYvWAeqtL2f34fz1JSyOqThwoZZJy4Nw=
Received: by smtp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id u1IFFFPc8s-OZJuplux;
        Fri, 12 Oct 2018 13:24:35 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlid.com; s=mail; t=1539339876;
        bh=g22DJRSm0I8P33w/0DK5PD0Fqya9i+gMMdvEquIKooM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=BZCYEylC2Kltcs5sA/SaOMhZaAmj3EqF/FMo04DvbELhwTn4dVVTKIEvdedlzWtpl
         K3igBDChufq1jO73flop3jG1B4PAiIrc++quvPooMBJKDASvRq88xmjKQ/GaSRs/eh
         LitKcXlF3oySbcaNqSSjtv/NNl8fpoWBtUXXqGGU=
Authentication-Results: smtp1p.mail.yandex.net; dkim=pass header.i=@emlid.com
From:   Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
Cc:     Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 2/2] doc: devicetree: vendor-prefixes: new vendor - Emlid
Date:   Fri, 12 Oct 2018 13:23:59 +0300
Message-Id: <1539339841-22235-3-git-send-email-aleksandr.aleksandrov@emlid.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539339841-22235-1-git-send-email-aleksandr.aleksandrov@emlid.com>
References: <1539012044-29998-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539339841-22235-1-git-send-email-aleksandr.aleksandrov@emlid.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 2c3fc51..2336e44 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -112,6 +112,7 @@ edt	Emerging Display Technologies
 eeti	eGalax_eMPIA Technology Inc
 elan	Elan Microelectronic Corp.
 embest	Shenzhen Embest Technology Co., Ltd.
+emlid	Emlid, Ltd.
 emmicro	EM Microelectronic
 emtrion	emtrion GmbH
 energymicro	Silicon Laboratories (formerly Energy Micro AS)
-- 
2.7.4

