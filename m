Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B6AC04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF4120848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="mJuLSldG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF4120848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbeLCRRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:17:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33547 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeLCRRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:17:01 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so13034758wrr.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 09:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xe6dxR2Vde59Kua+p62/ZAkFh7k+BKyeNCE4MaXeE50=;
        b=mJuLSldGAO9/CbJ8V0G/bCDIcD46wesQm1LGPpzYVtxmFzHzFJHS+LEr21j97bNU94
         XfqulbAt3KOVPYfKEiukw9MblLw7QlP1C3MB5/NHrsTBrYZO455Mc0ppRdZ+al3cABN9
         t6BxLKZ50yhk0F4bdFWds5tbs21WP6FT2kma0nbU29CD1eB7wWasIhmLTJhrdMgt//LT
         qddjcUrUJHm3DTV1WnC375HcOiyJUU1Ahx37RN+cmtwwMhocILcHBo68XHJHQnBiQDA8
         yWRd6MomZATRNmY1SJ3dkoGdLkn3piIL/+SqkC/nT9dV89klH8OTxmyZ0rN2Eek0wFOf
         hwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xe6dxR2Vde59Kua+p62/ZAkFh7k+BKyeNCE4MaXeE50=;
        b=KEa6qqhCgbkiI6Z8ZkNWAj0AoGThhp+VVnp6iqEYaRbelG4FHu05f12xS4INhXV4X+
         1nlrsG0FDtcDQUu//5Wu3Xi9u0rtlTktGakc49Q0/yMCFMUq4YuEICYbycCqkjoAPcAj
         fpmXlzfMAfEWL8Ng8fAXyBrP4EIOThxX2iTmXOQHFLm4SX0Rd97KagzQ5wzjGNQZlS1Q
         3oTqgGR9YjbW8WfatCwlXHfPgR/t4w4uys2mgn6isfTr20bAqU4y6BKDdiyarzV2JBDv
         yCVBAGmIjEKHW0qNmw1yECvCygoBekG2Egb9U+G76uot1/WGLcGdFIY0fHkC7KqPKEoZ
         OLnw==
X-Gm-Message-State: AA+aEWY7S+W1MY64l5NjAYcZLryW/TacqNW9cCCr0FFkg5sdpQ69yIqc
        LkWeJGqMgvmJ2YiSdNAzcJJbAbloYtI=
X-Google-Smtp-Source: AFSGD/URCHA/e4IENh4CAOMvOH4+Eaq6ZSkYjwDbPZzNmEpDZyxn2h74s8XOGYOVDShgbFKcHzy4Ng==
X-Received: by 2002:adf:f28d:: with SMTP id k13mr15513177wro.78.1543857417161;
        Mon, 03 Dec 2018 09:16:57 -0800 (PST)
Received: from boomer.local ([2a01:e34:eeb6:4690:106b:bae3:31ed:7561])
        by smtp.googlemail.com with ESMTPSA id h203sm22494889wma.19.2018.12.03.09.16.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 09:16:56 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: clk: meson: add ao controller clock inputs
Date:   Mon,  3 Dec 2018 18:16:38 +0100
Message-Id: <20181203171640.12110-2-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181203171640.12110-1-jbrunet@baylibre.com>
References: <20181203171640.12110-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the clock inputs of amlogic AO clock controller

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---

Stephen,

Since I made some changes here, I did not pick your previous
Reviewed-by tag, in case you did not agree with this version.

Cheers
Jerome

 .../devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt  | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
index 3a880528030e..79511d7bb321 100644
--- a/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
+++ b/Documentation/devicetree/bindings/clock/amlogic,gxbb-aoclkc.txt
@@ -11,6 +11,13 @@ Required Properties:
 	- GXM (S912) : "amlogic,meson-gxm-aoclkc"
 	- AXG (A113D, A113X) : "amlogic,meson-axg-aoclkc"
 	followed by the common "amlogic,meson-gx-aoclkc"
+- clocks: list of clock phandle, one for each entry clock-names.
+- clock-names: should contain the following:
+  * "xtal"     : the platform xtal
+  * "mpeg-clk" : the main clock controller mother clock (aka clk81)
+  * "ext-32k-0"  : external 32kHz reference #0 if any (optional)
+  * "ext-32k-1"  : external 32kHz reference #1 if any (optional - gx only)
+  * "ext-32k-2"  : external 32kHz reference #2 if any (optional - gx only)
 
 - #clock-cells: should be 1.
 
@@ -40,8 +47,9 @@ ao_sysctrl: sys-ctrl@0 {
 		compatible = "amlogic,meson-gxbb-aoclkc", "amlogic,meson-gx-aoclkc";
 		#clock-cells = <1>;
 		#reset-cells = <1>;
+		clocks = <&xtal>, <&clkc CLKID_CLK81>;
+		clock-names = "xtal", "mpeg-clk";
 	};
-};
 
 Example: UART controller node that consumes the clock and reset generated
   by the clock controller:
-- 
2.19.1

