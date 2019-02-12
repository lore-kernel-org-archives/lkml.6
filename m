Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08CAC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 717422075B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 14:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="JUhTPCBi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730272AbfBLOYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 09:24:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54847 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729952AbfBLOYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 09:24:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id a62so3161279wmh.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Feb 2019 06:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KAMq1x9B0WCQpzH3RwEBRqWOiCfu+v2gKiAUxijQ3dM=;
        b=JUhTPCBi+rn+Qm4N/lS+K7QJnRqYZdeODJmLzFN4+rfG9u0Qinh0z3PB59we7oqcB7
         bWWu5vZYGiSdfGs4CjdxE+kSj8vb8IApnE1QMMw7ox5gI/fTQSgnbo3E4X0NJQyo1rjf
         B/IYJVeAnD9PVTjToqNJtyaZCMQVVs3RQrCrVai+TzU0ncJLMMkgndfL42juOMm0sVd/
         1f4lgIVeBQRgzMtRD22ikCXOIM+bAjT5yxLIVUqge6EsQY3S/576mg4rmlEeuaOF07Kc
         0WLwZkG8BMu3zELoPKKRCXvzrvbLAcJsW1yDtRLVF1tWKWllo+QPdxPKPUtD8Pt1T6f7
         AZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KAMq1x9B0WCQpzH3RwEBRqWOiCfu+v2gKiAUxijQ3dM=;
        b=O5NyUNS9dnbNsoziyc1KWJ219n2HE/StxlBApKBlnMoGPGXhwS2hUTJw3nN2X8s+6w
         V072cLmWZvw373r4HKaykyUeGQj83tu//bIyI/8sTUl+Y0/BezqxAvTYrhnt4BFUknq6
         Bi7BuTxrw8FRForr+CCoBza+/fLZLAUXSs1oNvehNhJD2kAEgicPEgFDnSWlHW8Gjo03
         x/YIsin9gl/r81uhwOWuMt59ZmrJcTuVBxJd8NQI4OIg/Hp0dlDelcmrgzov8+XDaj1p
         3t1cCYL9fi269XehJLHGhjMaF30b4SY0PcWh2DJvlZsbtj101ligs+eDu1eOBLXydx22
         uncw==
X-Gm-Message-State: AHQUAuZNf7NrRQ6SCu25zO0wvFhYSobCch12g1jbuoqCRR7YcR+y77Fx
        BwBGzXAgR72hNccZamifhE75pg==
X-Google-Smtp-Source: AHgI3IYpgl47wD6nqFYP7LCl82rQFpzOK10BE4EKQELBLfj0rBM/iBzR4WWSXNhm0jvdtzcJ6sPavg==
X-Received: by 2002:a1c:2804:: with SMTP id o4mr3273810wmo.150.1549981471553;
        Tue, 12 Feb 2019 06:24:31 -0800 (PST)
Received: from bender.baylibre.local (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id c139sm4926838wmd.13.2019.02.12.06.24.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Feb 2019 06:24:31 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dts: meson-g12a: Add AO Secure node
Date:   Tue, 12 Feb 2019 15:24:27 +0100
Message-Id: <20190212142427.14478-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212142344.13634-1-narmstrong@baylibre.com>
References: <20190212142344.13634-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the Always-On ao-secure system control registers node,
which is used by the meson-gx-socinfo driver to detect the SoC IDs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
index 3b82a975c663..e247194da126 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
@@ -101,6 +101,12 @@
 			#size-cells = <2>;
 			ranges = <0x0 0x0 0x0 0xff800000 0x0 0x100000>;
 
+			sec_AO: ao-secure@140 {
+				compatible = "amlogic,meson-gx-ao-secure", "syscon";
+				reg = <0x0 0x140 0x0 0x140>;
+				amlogic,has-chip-id;
+			};
+
 			uart_AO: serial@3000 {
 				compatible = "amlogic,meson-gx-uart", "amlogic,meson-ao-uart";
 				reg = <0x0 0x3000 0x0 0x18>;
-- 
2.20.1

