Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A0DC71130
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2929520652
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 11:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emlid.com header.i=@emlid.com header.b="Q0Fl3cn3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=emlid.com header.i=@emlid.com header.b="a6T1qAtH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2929520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emlid.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbeJOTfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 15:35:23 -0400
Received: from forward104j.mail.yandex.net ([5.45.198.247]:47682 "EHLO
        forward104j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726591AbeJOTfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 15:35:22 -0400
Received: from mxback6j.mail.yandex.net (mxback6j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10f])
        by forward104j.mail.yandex.net (Yandex) with ESMTP id 9187B44FD1;
        Mon, 15 Oct 2018 14:50:24 +0300 (MSK)
Received: from smtp3p.mail.yandex.net (smtp3p.mail.yandex.net [2a02:6b8:0:1472:2741:0:8b6:8])
        by mxback6j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 7A9xjzIrGG-oNDm3F4T;
        Mon, 15 Oct 2018 14:50:24 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlid.com; s=mail; t=1539604224;
        bh=yKt37R/DOocoHmUwW4kStzPpcVHpEMEqFPFnPtiMmHg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=Q0Fl3cn3Gx2p2vNyygDSMcHhmKoGTc05x1XGWMRk8xqL67pslIqedvn923FEW5PqB
         k6wWRzHZn7m9fDQTXfNyroswbvN3+GtdWfotbI36dvX93ywZrT5Z5kLnLfokw40md8
         dyMyNp2RCIfRKZ37u5a8XSQOMKQmnmWjVaCAmLT4=
Received: by smtp3p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id q72Y4XcU2b-oLx0knVv;
        Mon, 15 Oct 2018 14:50:21 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlid.com; s=mail; t=1539604221;
        bh=yKt37R/DOocoHmUwW4kStzPpcVHpEMEqFPFnPtiMmHg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        b=a6T1qAtHOdnnPHBm3Wbil3NvXpjcUQafBkFnsmA8N0CMtUCZ2+iF1mM0Fc5X5ohoN
         UAeFPz9trs+E5NPKyuSz0pZYxFHHUkEyLpRGl3dlX208DQipReHExWJP8MBzByZgHN
         rU2wbXP4/N9rb0IBvY0EbPZ6ekENj56lz1zyD/yU=
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 1/2] dt-bindings: vendor-prefix: new vendor - Emlid
Date:   Mon, 15 Oct 2018 14:49:49 +0300
Message-Id: <1539604192-17561-2-git-send-email-aleksandr.aleksandrov@emlid.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539604192-17561-1-git-send-email-aleksandr.aleksandrov@emlid.com>
References: <1539339841-22235-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539604192-17561-1-git-send-email-aleksandr.aleksandrov@emlid.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor Emlid Ltd to vendor-prefixes.txt

Acked-by: Rob Herring <robh@kernel.org>
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

