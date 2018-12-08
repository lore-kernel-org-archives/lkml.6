Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91052C65BAF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5446F2082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="U+oBnd0C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5446F2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbeLHQrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 11:47:00 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36643 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeLHQq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 11:46:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id u3so6560689wrs.3;
        Sat, 08 Dec 2018 08:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4QoWFYdjwYMC8tWsTDBT1tQNmYukVHcS0fTvruwJ7zY=;
        b=U+oBnd0CrhKfSQMnfdw2hd4TW5z4VvZ8OGRW/GCG+BMTqTHElrff+8v/R4BqmzcLAd
         /nxh22SekA4SKafSWuxH/fXR/dNzxc3kFjmegT1OQmR+dlw50ndgWcIDaMUQcBkFLyz5
         O2TOcsKFa5oMAWSXhn4JLSW9tWrjvh/dipNVJeqlWJNoCpSm9NOERsJf14SMfzxgC3vf
         Apz3DvIBWeYKHGJCPa3nc5Vq/LVr0K/M4EDcewiFdpJYWPndWxV6c1QgCDx4sbui6Zuj
         fXIp/MjqbLSAqYx0DMDSkbp22SK3iacgREnAwRexFeR9aXIepRAn/gUH+x1aE3yM33GI
         Cd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4QoWFYdjwYMC8tWsTDBT1tQNmYukVHcS0fTvruwJ7zY=;
        b=DYmFz/Zf0gtmiIuR8nAPJYPep1UVnVQqiCMdoc43Ee9q7FG2DyzTeY6/H9l/9MY1GK
         w5BUa56DjAsGqhB8jkzerUIhxQ44u/3xcnr3DGgptYToHjZAcv65jyaXxvayyn0PoQNw
         Xqp2JThMXEDpoHUOWpzO5t/HJ/j/n4xNCu1t5QTNdq8xIjYryLkMmDXnU2Rffu0K4mnN
         7gYbO+XjJ+mzeVUAlqch6iB05DEGsgJPNTuFZ4N/+3ifnPkGQzyUmC39c/f05iHpKd5Q
         d6RHf91VDqUiZAbzYKGw+tNe2njPWcQTrQpeYhsqg0jSlQj8icgIzBpVQy2IDZ8NRAf1
         laKA==
X-Gm-Message-State: AA+aEWbyVdn2pgK4Dzr08a8ehnMuyr6dBX+li7arRbEnspeZfRhuC1bb
        MyvJyYOLxerPhGqPonJArrcs0vQZ
X-Google-Smtp-Source: AFSGD/Xnfu5LTM5cPck9zzFRHTAxDzOMOgTVmfs6xzi0HozgAbm/PTKvsHLD5yeN1UBT4If70ODGug==
X-Received: by 2002:a5d:68c3:: with SMTP id p3mr5257378wrw.34.1544287615561;
        Sat, 08 Dec 2018 08:46:55 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id c9sm11100690wmh.27.2018.12.08.08.46.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 08:46:55 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/3] ARM: dts: meson6: add the ABP2 bus
Date:   Sat,  8 Dec 2018 17:45:50 +0100
Message-Id: <20181208164555.26527-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
References: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Mali GPU and the DVB demulator are located in the ABP2 bus. Describe
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

