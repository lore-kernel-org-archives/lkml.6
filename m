Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2906C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7084A21903
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="kdHcXhxC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390242AbfBROYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:24:54 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43477 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389770AbfBRODx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:03:53 -0500
Received: by mail-ed1-f68.google.com with SMTP id m35so9950590ede.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 06:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=I6Qr3PnJqhUErKNHRtGnpwGVLGbDm4vYaQedao4hHXI=;
        b=kdHcXhxCjuyfL/RsbUdI7m1L2Yqy6Ch6aOf/JLBNnD5HRcGRSlgFnLV7GDHT0+O/ZH
         WwhadtXZC4vVGNOZDuBn55xN7S4uRWX++KyhraFKHbfOfDIpV2BF2i1X1ZZmPSUG4VoF
         AkRhIRakB9igwGHCOjQRaHFAWn158WcLofcO9Bvujyxj6a9Q5/FR2tK/sXcaVtMFDepB
         mzDtU5X9T6XAokc0oVHVyJYLk6aWrjK7mlq7vIRYN+67ZQfflVjoZTlS3hBnJ8v3vCvY
         cUmqgkNmUgZCJM9+9LD/mdkYFxEuSclcXauFOzLsjW1gmke/0ca5/PZRLVfeL0qwR77Y
         7kDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=I6Qr3PnJqhUErKNHRtGnpwGVLGbDm4vYaQedao4hHXI=;
        b=VXRaBq1P/07I8MkF/ffPHhZbo4VPrg34eDUwo0incBoUkpB4KCJ4nWr0EltN0ww/bY
         3Pi5ONiogOciOy+gDjj9rujQbpF5nn4KKvOvZWj398cpTvdxVvSMM0zdgG5IUGTTWDP6
         erNymSgIgHQEj8cxctfbCFF4Y7FDyWGqVKJNtnht6GB2VhfSncF3Vz2hjiVptFqkdUAQ
         SR+5xmtbjq5VwCC4EvFEG7jATZ+Rxesh5xUUIo06sjFiZYSTKAd6zXkFig0FJvkx2Mpt
         iSDUwVPbSs3VrkqrkpbcZEjfqko0Y6nVnJeIy8DmLYZ1o6UNkmAXgi6R2uHCT7gEM6dT
         zKDg==
X-Gm-Message-State: AHQUAuaWD9w2VtBHq+K+ik+ysg29Z5P2FwrwLsdwoVZAiuBUEAvVLn3z
        hNJT0oB9Z9chJ5EBIxCgneXrVA==
X-Google-Smtp-Source: AHgI3IZi9n1v6BYfISfADbqQLufHezmPHIqiJiJUI3/6IPWV+cI2byGpqq/pa18Sn/cvn8B5knGS2w==
X-Received: by 2002:a17:906:ee2:: with SMTP id x2mr16832980eji.202.1550498631380;
        Mon, 18 Feb 2019 06:03:51 -0800 (PST)
Received: from localhost.localdomain (ip-188-118-3-185.reverse.destiny.be. [188.118.3.185])
        by smtp.gmail.com with ESMTPSA id w48sm1421606eda.88.2019.02.18.06.03.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 06:03:50 -0800 (PST)
From:   Patrick Havelange <patrick.havelange@essensium.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc:     Patrick Havelange <patrick.havelange@essensium.com>
Subject: [PATCH 4/8] dt-bindings: iio/counter: ftm-quaddec
Date:   Mon, 18 Feb 2019 15:03:17 +0100
Message-Id: <20190218140321.19166-4-patrick.havelange@essensium.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190218140321.19166-1-patrick.havelange@essensium.com>
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FlexTimer quadrature decoder driver.

Signed-off-by: Patrick Havelange <patrick.havelange@essensium.com>
Reviewed-by: Esben Haabendal <esben@haabendal.dk>
---
 .../bindings/iio/counter/ftm-quaddec.txt       | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt

diff --git a/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt b/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt
new file mode 100644
index 000000000000..4d18cd722074
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/counter/ftm-quaddec.txt
@@ -0,0 +1,18 @@
+FlexTimer Quadrature decoder counter
+
+This driver exposes a simple counter for the quadrature decoder mode.
+
+Required properties:
+- compatible:		Must be "fsl,ftm-quaddec".
+- reg:			Must be set to the memory region of the flextimer.
+
+Optional property:
+- big-endian:		Access the device registers in big-endian mode.
+
+Example:
+		counter0: counter@29d0000 {
+			compatible = "fsl,ftm-quaddec";
+			reg = <0x0 0x29d0000 0x0 0x10000>;
+			big-endian;
+			status = "disabled";
+		};
-- 
2.17.1

