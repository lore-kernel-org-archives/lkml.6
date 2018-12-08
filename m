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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B564AC04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B75B2082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 16:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="tsS8ijvy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B75B2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbeLHQrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 11:47:05 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34526 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbeLHQrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 11:47:02 -0500
Received: by mail-wm1-f65.google.com with SMTP id y185so3434647wmd.1;
        Sat, 08 Dec 2018 08:47:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PmRVlutu1GKQTk4TzoPyamrkqPJpSphyevQTW/8dC7Q=;
        b=tsS8ijvytCT4xDzUT0mXa+JvPwuBUsT6WOKqtF54YOg+hsBxqjPU3QTIqP5TL6MsxL
         iBfQzae36ZsvMmVkY93BStjxY4qu6SQSeOL3Rr95a/Wr9ER0Ou6XnWpVWlRLMbLX9moE
         KTMHznm5b0lkfvG/g5bgGOPs3v4Sjd/DlAbcnooq5gbkJz7fZ1nwuaI7gKbaWVugX7pX
         w4ItqwJxWoIGQfaIHjb5WWTtNRqval0apQP45NrsCQ4hZEnPnR/9S9EpRSkLHOqMmqM6
         kAgTN1+uZ2SwbQonbFFgh3JxDp85tXLm4brYrZO5U5s2fqML2o+Aofzog5Q+bBnmaI+Y
         iz4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PmRVlutu1GKQTk4TzoPyamrkqPJpSphyevQTW/8dC7Q=;
        b=Y4MtZnzLPpnwy5AVx1PQRWz4huYL2Ff8Hzfm/cSwFUB8RU5PeqrbIRTmgKYdxDzEuA
         WCE8/nDFLlPJOqPzYCY8KI4cHcBL/vxNWVy0i1DqiEhW54hZm/Wmd5RwFE7bLGkMqJ1k
         rgseQ5DQwi8+MSV8owcuUep2gvijvprFBYO9spAuoxZoD7IfBIRVy/9CkcTDtFTv1Jbs
         YXmLkHhnuN8twag4A/DpAbOaPKkimaZ4/nDgEYfikfK9FERFzO0THYXb0TgwYZ8dReZl
         JLlqxx/flEpvYops7dPfzplyWSo88uPla7JK1o4x8Kd+DW+Cmo4sVnrC9vynF237jGJY
         eyrw==
X-Gm-Message-State: AA+aEWa7tQoAnvvJxVoU6W9M/yrYe3cxT7ijrVFhzY0He91DUA91xiq3
        w0xHr8w+orlyZOCpofdE/G4pavIK
X-Google-Smtp-Source: AFSGD/UqYguEGUeNuWgHH/+M6x0dlqFZ1eRnUbdnko3hzoNKo6VaQuJOrkEBgHC0ef/rRgMmv1FcPg==
X-Received: by 2002:a1c:dfc1:: with SMTP id w184mr5323805wmg.2.1544287620189;
        Sat, 08 Dec 2018 08:47:00 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD73FBA00428D5CFFFEB99DB8.dip0.t-ipconnect.de. [2003:dc:d73f:ba00:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id c9sm11100690wmh.27.2018.12.08.08.46.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Dec 2018 08:46:59 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 3/3] ARM: dts: meson8b: add the ABP bus
Date:   Sat,  8 Dec 2018 17:45:54 +0100
Message-Id: <20181208164555.26527-6-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
References: <20181208164555.26527-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various peripherals (Mali GPU, NAND controller, VPU; etc.) are located
in the ABP bus. Describe this bus so we can add devices to it.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm/boot/dts/meson8b.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/meson8b.dtsi b/arch/arm/boot/dts/meson8b.dtsi
index 22d775460767..5d036842c355 100644
--- a/arch/arm/boot/dts/meson8b.dtsi
+++ b/arch/arm/boot/dts/meson8b.dtsi
@@ -178,6 +178,14 @@
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

