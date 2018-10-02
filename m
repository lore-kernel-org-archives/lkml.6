Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C561C64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D35F2098A
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 14:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OnpS0aGO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D35F2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbeJBVWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:22:16 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33362 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeJBVWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:22:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id s4-v6so1752535plp.0;
        Tue, 02 Oct 2018 07:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y36XYKkez6p4T37YSXThy/rGPtDxwLlvwG+ZmFEWQ88=;
        b=OnpS0aGOZVqHkFjFp0EEJ4aencGU/PLQau1EEUbF3pda0q/W7MTQM9d+nPHT8lTf7j
         oLZW0GwPiB3i3KfSMxtMwvQeiCdSZ9Pnbhj6sUyWX+gWIni7eslc6g6BpPdPOUINGc8Z
         IfGIePiVPN2wGOjI6LdsQ2KIi+YlbZ5jbaU3ovEWAem1p/LtwIBsgjcpbNCCbjgUcOPU
         ZAbC5YURqzFHAXpUI/jyo6Zt60pImhgh7cizhIoCqQH9ZZEn6g05zuXrdMA6xhl/m3Di
         xC4q9gCmDSwZ5Cv58nKhIV0VIapYLSh5A342CN0pC/zTbPVCtMh/nkTY5gqkGiY1EC8l
         yBdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y36XYKkez6p4T37YSXThy/rGPtDxwLlvwG+ZmFEWQ88=;
        b=aUlFxWlDSnX0woySaEzmt3U+lbE5o5shMjjSXEvtm+DPNIGnCPiitaJDyRglt6ghC7
         oKUgi0xdFXmbLERrGplTg9oMyr4LumcGDpyD5qDxopP6j+STO8W4B0V8sA3Flcp7s1mW
         +WZH1EdK5MIvdCsEEs6yUNSPM6914/D5XssqWw7jL7TJmkjt4Q7w1SQqkMI6fK8Dslzv
         NyJNDiUCU1Utb9CUYqiQvz1H8wFANtmkCsc6BZTcVwM02aN0OAXRzROMEdhT3R8nIFfF
         FD3cIXwg+ng7VZASndEZQdaVwAWO4pS+y9z1yFYE+P9LurAyNPAVV4VJUhN8S62Y2fZR
         gSTg==
X-Gm-Message-State: ABuFfojnv/2zyQimKm++A6ZN7EoLERfp6xxMZ3MDSf2VMk1kzHbsXY00
        lBgpyhDCeiS5NdjlZtM/R5s=
X-Google-Smtp-Source: ACcGV62i9JNo43WmIXbk1YhQ4MU9RqnqwCPxoobE3sqV+X1rL4G63Liqxw3LHO/5wun81RV1HOPnAg==
X-Received: by 2002:a17:902:2808:: with SMTP id e8-v6mr9207606plb.327.1538491113671;
        Tue, 02 Oct 2018 07:38:33 -0700 (PDT)
Received: from localhost (104.176.229.35.bc.googleusercontent.com. [35.229.176.104])
        by smtp.gmail.com with ESMTPSA id u21-v6sm18009210pfa.176.2018.10.02.07.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 07:38:33 -0700 (PDT)
From:   Song Qiang <songqiang1304521@gmail.com>
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        himanshujha199640@gmail.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Song Qiang <songqiang1304521@gmail.com>
Subject: [PATCH v3 2/3] dt-bindings: Add PNI RM3100 device tree binding.
Date:   Tue,  2 Oct 2018 22:38:11 +0800
Message-Id: <20181002143812.3661-3-songqiang1304521@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181002143812.3661-1-songqiang1304521@gmail.com>
References: <20180925031724.21399-1-songqiang1304521@gmail.com>
 <20181002143812.3661-1-songqiang1304521@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
---
 .../bindings/iio/magnetometer/pni,rm3100.txt  | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
new file mode 100644
index 000000000000..4677690fc5d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
@@ -0,0 +1,20 @@
+* PNI RM3100 3-axis magnetometer sensor
+
+Required properties:
+
+- compatible : should be "pni,rm3100"
+- reg : the I2C address or SPI chip select number of the sensor.
+
+Optional properties:
+
+- interrupts: data ready (DRDY) from the chip.
+  The interrupts can be triggered on rising edges.
+
+Example:
+
+rm3100: rm3100@20 {
+	compatible = "pni,rm3100";
+	reg = <0x20>;
+	interrupt-parent = <&gpio0>;
+	interrupts = <4 IRQ_TYPE_EDGE_RISING>;
+};
-- 
2.17.1

