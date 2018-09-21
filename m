Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DC3C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73FA21570
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hH+2RgOh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B73FA21570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391436AbeIVCD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 22:03:28 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46675 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391328AbeIVCD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 22:03:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id u24-v6so6426002pfn.13;
        Fri, 21 Sep 2018 13:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YuvJRKiLhdLur1IAAqr2McXI180TC+c1UQYaeBdT0+M=;
        b=hH+2RgOhaN6BBx7lEiMfSUI7BsUT/O9U67MqEjbdephSgWZk4gAJZ8jcZLh794VZsJ
         xwXntydhQ3cMJd8vG0aHTmYkw3/SIPWb2iex24PJ395zzXx+yhRWjuvxAqKRMPU5++ww
         b4uykbArUYMK7HZA6CZDK6GCPqk1d+TEfNrrLhWOxETxcbGYtF6iPpp2GVLx+g46xsYA
         2COU9u9KMyqbjPz1F4/UaEiylMkEuW5C9tTffdRzrxGn6oMp+iyEUyITZKAqzl8/Hfg8
         F3SUndFhdnUJfsVEXZJE1KTIwhuT/tMk3KZjp8153SDEZYiADBxEUVAjTZvvi8jceGGg
         dZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YuvJRKiLhdLur1IAAqr2McXI180TC+c1UQYaeBdT0+M=;
        b=bbIoK1LjwkYgR5D8Y43pcfdQHmlDrjBB7aU8NjX0LeBaCU6VUDAyWMdVSB4AWYiWdp
         2rNoi6DKi/ipGY2NGM+ojikLVFrKfHYd25KhSq/NDwigpM8wdNdod6+mHme2l2d1Bnia
         Vj7WfqGcT7D8BVHTUFUkhnayhEANe2dyVbfOyn5uhE7UgPj3oIwiwTSM/jHD5TA9NxUg
         5J+q7aEmAczGL7U8Bp2wloydu6tj5wBm7sUB9DihyE+owIY+yfshNX2BWKHHyqWFaVLz
         ZKMePAZFn1aTNx38l9KUd3vigDSpq3zq5d6/NhtZqfAJCSyFtax2oRtVZJsDBq0UhyDj
         ZYrQ==
X-Gm-Message-State: APzg51BdEt2IVtbI5SFUu42BlbAWNbo7mNaNNrMSGj8LX43jLnYzrqFe
        HNvsFUfp4zUn8La8dLoSU60=
X-Google-Smtp-Source: ANB0VdYd3l1wwns/BTN/lefpuA//kdK22GaVez09qlnWle26HADwz+Q+QglFnAfPKL9enDi2EzUjQQ==
X-Received: by 2002:a63:2150:: with SMTP id s16-v6mr43114943pgm.267.1537560779413;
        Fri, 21 Sep 2018 13:12:59 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 132-v6sm783231pgh.67.2018.09.21.13.12.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 13:12:59 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     jdelvare@suse.com, linux@roeck-us.net, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net
Cc:     afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: hwmon: Add ina3221 documentation
Date:   Fri, 21 Sep 2018 13:12:51 -0700
Message-Id: <20180921201252.12875-2-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180921201252.12875-1-nicoleotsuka@gmail.com>
References: <20180921201252.12875-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Texas Instruments INA3221 is a triple-channel shunt and bus
voltage monitor. This patch adds a DT binding doc for it.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changelog
v1->v2:
 * Dropped channel name properties
 * Added child node definitions.
 * * Added shunt resistor property in the child node
 * * Added status property to indicate connection status
 * * Changed to use child node name as the label of input source

 .../devicetree/bindings/hwmon/ina3221.txt     | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/ina3221.txt

diff --git a/Documentation/devicetree/bindings/hwmon/ina3221.txt b/Documentation/devicetree/bindings/hwmon/ina3221.txt
new file mode 100644
index 000000000000..02a2ffbb7c3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/ina3221.txt
@@ -0,0 +1,38 @@
+ina3221 properties
+
+1) ina3221 node
+  Required properties:
+  - compatible: Must be "ti,ina3221"
+  - reg: I2C address
+
+  = The node contains optional child nodes for three channels =
+  = Each child node describes the information of input source =
+
+  Example:
+
+  ina3221@40 {
+          compatible = "ti,ina3221";
+          reg = <0x40>;
+          [ child node definitions... ]
+  };
+
+2) child nodes
+  The names of child nodes should indicate input source names
+
+  Required properties:
+  - input-id: Must be 1, 2 or 3
+
+  Optional properties:
+  - shunt-resistor: Shunt resistor value in micro-Ohm
+  - status: Should be "disabled" if no input source
+
+  Example:
+
+  input1 {
+          input-id = <0x1>;
+          status = "disabled";
+  };
+  VDD_GPU {
+          input-id = <0x2>;
+          shunt-resistor = <5>;
+  };
-- 
2.17.1

