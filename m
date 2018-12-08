Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC34C64EB1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F16820868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PUZhfgZG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F16820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbeLHQrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 11:47:22 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34527 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbeLHQrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 11:47:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id y185so3434619wmd.1;
        Sat, 08 Dec 2018 08:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vndz/d0CP33O+x4SSHWTZOylTcs/OCN5J/IErAS6H/8=;
        b=PUZhfgZGIVoPm+BzbYmYL3AztnD8QwldUuAAj83hKhP6bDEMk8TGFaGKE5O3fmTVwS
         mwrx1VKPPShy1gz3RMlTNmgAKT8IQFv8012jWYXpBkgc1vjKAVCMykZ690BSAzLyrQXn
         lakUdBcX/ECAKdrnzJsnRbL7L4XVg5h5xKvy0kT+eaXnJjLVuGLmrW0Le8m9P4rp6ISP
         KLrXYzPdXggaiWiezySWQkX7oTwiZ+XWxk52/Bz9skez2NhAd/vUIXzRUcqbIi2P4Fxb
         r691IdSKwLW70nJxXHNo3qNPyGi4THPiWNaSblxxnc5xnCl4tWKG9TgGQR9t22Y5Aias
         zRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vndz/d0CP33O+x4SSHWTZOylTcs/OCN5J/IErAS6H/8=;
        b=SISpn8IeN1H37oILQYuZ2CKLXeekE8NQoQhylJCxmzL0mMZLZGoP/OgujkQ/gxF42V
         k6MfltEojcmv4/kGnRulSVYRJEAjAY0bdDiNZBEjrsSWnijUWaMCgiLAw5LIGhr1CjLs
         YzkQgZXXIBKulj3eTk3OFsih7OymhGN6RPj1+ZPBWvaFjw4d6YhLGz5MDXugEZ7yfEe4
         LADlYJCOnq/oOaiq6S/6cPYXAmg+ucywnjjVOBIaPTS7Yutx6vzB3X+pYsbWJlnnIsVm
         FXb1ElK9csirbDPMhxsr0gWKDr9K0kGq9a1p0lvQQI4SagFn1P+5U/iDiKMXw/Gv3Yjt
         Gc0w==
X-Gm-Message-State: AA+aEWb5wRF2sJsJ1Bnc0ZzJjcw3GQlYK5cN+NOwQuHrIhPXuau/atY8
        LcnB3/TWqoAo/WAcyCJDDLQ=
X-Google-Smtp-Source: AFSGD/XTgWPhX/Yno7KYrn/Mslne4z3CSHnACjKUq4lEhuPs9zR7rqubPNxp+uT8i57pjd9JfK2Row==
X-Received: by 2002:a1c:1286:: with SMTP id 128mr5868786wms.70.1544287618931;
        Sat, 08 Dec 2018 08:46:58 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id c9sm11100690wmh.27.2018.12.08.08.46.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 08:46:58 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/3] ARM: dts: meson8: add the APB bus
Date:   Sat,  8 Dec 2018 17:45:53 +0100
Message-Id: <20181208164555.26527-5-martin.blumenstingl@googlemail.com>
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
in the APB bus. Describe this bus so we can add devices to it.

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

