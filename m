Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D71AC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E681B2082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:47:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="EADkc+hD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E681B2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbeLHQrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 11:47:01 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38737 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726206AbeLHQq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 11:46:59 -0500
Received: by mail-wr1-f65.google.com with SMTP id v13so6546916wrw.5;
        Sat, 08 Dec 2018 08:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1p+sohtf5jrUJp2H5mL48UiI2Qzr6hi8YtOOpDvGfZc=;
        b=EADkc+hDTXi2/FipORPTeaAjS/bdPbWuSIZAutntqYHBGlzbMXY5JS3vTpLVjXZi2J
         FOrxgSMHIKWz6v8nDpKIZuFM3M00rgku10gdLcM7Dm/OGmt+O3+XizoGUf5CRpvFZ1qr
         0wRbzpFGoGb3p5scuvrFH6WvIqTMwDt1e8/rbXxh/udVtnqac1vpoqGmQUO7Jnovf7/n
         fFeLxfSbKWaMKX1PYWU2xV/xklsSJ5qeo66PWslK6gCzZW96AKniVjZh6c3gYbclfldk
         7+G0WIn8rOcXFf/Y0FFG+fmezUA0tr/cKH/dg2EAtuvDwNW2+9UNftAtfoWftGQPXgI6
         OZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1p+sohtf5jrUJp2H5mL48UiI2Qzr6hi8YtOOpDvGfZc=;
        b=D2C8dpJ+58ISWzlMUXvJ0D7ZluF1I/9LQkq32Us2Gih8m+Ld+U7LRpdZqBTU386WpS
         fafj2eztUW2s8ON6PYizvi2k3K1qJWcjYpL+QrDkg00ccnh4fB4rYIHN1u4I3JsLhfyx
         fykZr0OxBAtJ2m+28rYiIx44+v8EsOGC7siGuMzNnEzLY64otPVtD1rvVE/PVoPR8IsP
         f1bJICF7fGXaVU1cPWqgymhgtZmyAziDDrcBIY8oCkO6kYSpjRUE+R2fY6o77Y52FTgk
         eaZU7xD3jrmdhvNBDhcCOYqiGpRDuhOO0B2RwptqfpHu5ZaWGUq+WjaBUpXrAvRM0qxy
         8r5w==
X-Gm-Message-State: AA+aEWbdxOZ6FhtGvFtzfYS8Vf8iq06XP6PNt0wQlE9oA+4fpodEPDu2
        oxBGRcxxGE5+VRdH1qxmbkTndW6B
X-Google-Smtp-Source: AFSGD/XYI1mUQp9bBLX2yFDj+vJndJgR28t+Y3rYHO9mkF9yJR7VBtMPt69Xmidy4zR2qBXHA2b2fw==
X-Received: by 2002:a05:6000:1287:: with SMTP id f7mr5284042wrx.302.1544287617728;
        Sat, 08 Dec 2018 08:46:57 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id c9sm11100690wmh.27.2018.12.08.08.46.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 08:46:57 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/3] ARM: dts: meson8: add the ABP bus
Date:   Sat,  8 Dec 2018 17:45:52 +0100
Message-Id: <20181208164555.26527-4-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
References: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various peripherals (Mali GPU, NAND controller, VPU, etc.) are located
in the ABP bus. Describe this bus so we can add devices to it.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/meson8.dtsi b/arch/arm/boot/dts/meson8.dtsi
index e5cd325d7ea8..3fd8260eba92 100644
--- a/arch/arm/boot/dts/meson8.dtsi
+++ b/arch/arm/boot/dts/meson8.dtsi
@@ -201,6 +201,14 @@
 			no-map;
 		};
 	};
+
+	apb: bus@d0000000 {
+		compatible = "simple-bus";
+		reg = <0xd0000000 0x200000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0xd0000000 0x200000>;
+	};
 }; /* end of / */
 
 &aobus {
-- 
2.19.2

