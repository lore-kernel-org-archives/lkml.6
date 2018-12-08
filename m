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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C16CC64EB1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:47:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E17F2082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="tWzBnSi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E17F2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbeLHQrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 11:47:00 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33250 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbeLHQq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 11:46:58 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so6585202wrr.0;
        Sat, 08 Dec 2018 08:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=umYSWlSr7sstay9sv45lhSgivwtvIUtFs8hUY3ac4fM=;
        b=tWzBnSi3wl1J8eqTMR4/I38FweFSShrhpxW+/yfm5L2QM3pXYDUDagepaTjvoeQZkC
         ZuJMX90RP/iRxlOoUUuWGFDupwlIqXQ9zAZo65vpvam4U7KUvzLlzVaf/OSub4B/syRa
         kO+YjA1CUokD5SFGuHI9iWxI+wG0Pi4eRim5ajdqqpBNRCJIyZkUrsl8uAbkBDVlucva
         UMv2g9kTCZ0Mtj9FgcUjJ07log8ib7F3f3xSj8fnQsWK5xg/7bE6NFUDAE9m6nIVRp1G
         nf20/jKZtJsXqHpmZzb7vTpcNPQkGbWI8LAeaxLu19s9fNhwoiBCN8vhSPJfUCpRbLJ2
         l0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=umYSWlSr7sstay9sv45lhSgivwtvIUtFs8hUY3ac4fM=;
        b=in9Ru857exgu8j/9abIk3NJtHenKkDXXvd9lJX0Kiincgqux5xZapha2lBiGainwhr
         7j7EqHhsIWK+zbCOW3ZyDVmv3WMB4qNv6Wk6CYgTV5c1TbXBf3eHYlVE2PtvmzSn02Il
         WRvQ60LbR9H1P7iqGdZtgdkHkvD38CrlmxSC6eXrz7+Wt/Z3ZF6vikoPxW8WHw6S6YEw
         kXp7SsYIfxYRKzlARqg04dfzimO3sVy0vkOvlHWN0oeaGbQ6Ycqox9wYZnqOSDlU9/9H
         GQgyM6PWNyQVSWAUZR78GwT9FA8BEm1iXMQ75bS2a0MHeoG1lyQ1dRoPR4rlzhQ4Awzq
         d1xA==
X-Gm-Message-State: AA+aEWY7NQPtfFybF5TfoCSigJA8Utcqgr5PHJw0toYvumNuH4kAUBcm
        njPu1xv/6ll8qiJKvDj68YE=
X-Google-Smtp-Source: AFSGD/U8uEnraJG8lnAFH542hqH/Tao0IDQKw2aqJJhA+wb971UT84yAz13K1mA9R+UKx2yEbPa5KA==
X-Received: by 2002:adf:82a8:: with SMTP id 37mr4682505wrc.252.1544287616667;
        Sat, 08 Dec 2018 08:46:56 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id c9sm11100690wmh.27.2018.12.08.08.46.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 08:46:55 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/3] ARM: dts: meson6: add the APB2 bus
Date:   Sat,  8 Dec 2018 17:45:51 +0100
Message-Id: <20181208164555.26527-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
References: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Mali GPU and the DVB demulator are located in the APB2 bus. Describe
this bus so we can add devices to it.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson6.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/meson6.dtsi b/arch/arm/boot/dts/meson6.dtsi
index ca978ab952cd..65585255910a 100644
--- a/arch/arm/boot/dts/meson6.dtsi
+++ b/arch/arm/boot/dts/meson6.dtsi
@@ -70,6 +70,14 @@
 		};
 	};
 
+	apb2: bus@d0000000 {
+		compatible = "simple-bus";
+		reg = <0xd0000000 0x40000>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x0 0xd0000000 0x40000>;
+	};
+
 	xtal: xtal-clk {
 		compatible = "fixed-clock";
 		clock-frequency = <24000000>;
-- 
2.19.2

