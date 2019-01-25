Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E564DC282C2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3312218A2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3YV4XDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbfAYRvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 12:51:03 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39817 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbfAYRu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 12:50:58 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so9070064ljh.6;
        Fri, 25 Jan 2019 09:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+CYllznRYt133KTflL22y4PX2RmV6ZawSJvxIL4oFhI=;
        b=B3YV4XDWHgZ3WJWKjy56eilIMuCNkNAe0setxKIu7hH78elM5xmPC9Sc6n9MxnGO9D
         aIu+LLW4aPwsP5n2oB3Fh1EtgE1m0IHO7N2Xj3q1MhjrtnmjxCqHcpaA/NnP10mDNIWB
         niLglWg+YDTQl8gCMvO8mxN1+yD8KLFp+iCQNeC3uq6+FAiRVQTBXYX7j1CTGjeAgMRJ
         3VRZvevDHvvAtoTZe7aIJ5T+XIb+/7SMbGu2hZzZ3aU5is1mbP3HW3/bDzu2qHhZb+r6
         2s6e6AzTfevp3ZZ3UpoDa3B/BoCgORuTsLohhbLqEpQn/WTeHNPH3u+MDLvPPXv03A3B
         pckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+CYllznRYt133KTflL22y4PX2RmV6ZawSJvxIL4oFhI=;
        b=R7v6l9kd7NJhw1n084nlfqbAbLwB6m2n0oJ/9z6iDj26c3X985K1dCR9X82zAPb/k1
         bKAE/H71dULDvWDlxj6WBOrbhijBo5QpRGlfoaFRwlzr2+1ah/5K06pUJYxlE+B9NXxx
         jvLSFsYi77ulgxaQVmEW9C13pYoBaoNScYP/8U96nbIKW1F126PrUQyRlFYoyp6D3vbq
         PO+EOCBUWCdqL/RC1l1v6k2AAOUtEJpwbLxlTmJ5lKFlPLH8fpGtKpJd7g5nSpBEPhTE
         ezdFtN/4bcItImW7SiVEyvatVRblWELbR0zqFdlKPaRB+lShPYmEguJypOvFPub4RgoI
         h5Uw==
X-Gm-Message-State: AJcUukeeQAhh+4ObLM7NXfEw5zjyADp3KuaKlSrjOc6LJKG8k76qlglM
        2h7tepid9kX4D3PHfcxXYrI=
X-Google-Smtp-Source: ALg8bN4ZoDLupjfEqshy8up98rOi636cGtoFBdatp7hFnV7CO27XwPFdkXdw5MOeuLLkp2/uT4xhAw==
X-Received: by 2002:a2e:8951:: with SMTP id b17-v6mr10570925ljk.142.1548438655548;
        Fri, 25 Jan 2019 09:50:55 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:6921:1f1d:2918:d853])
        by smtp.googlemail.com with ESMTPSA id l21-v6sm1575606ljj.48.2019.01.25.09.50.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 09:50:54 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     dmitry.torokhov@gmail.com
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        mchehab+samsung@kernel.org, colyli@suse.de,
        ckeepax@opensource.wolfsonmicro.com, andrew.smirnov@gmail.com,
        arnd@arndb.de, xiaotong.lu@spreadtrum.com, xc-racer2@live.ca,
        pawel.mikolaj.chmiel@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 4/4] dt-bindings: input: Add documentation for gp2a sensor
Date:   Fri, 25 Jan 2019 18:50:45 +0100
Message-Id: <20190125175045.22576-5-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190125175045.22576-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190125175045.22576-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Bakker <xc-racer2@live.ca>

This commit adds documentation for Sharp GP2AP002A00F.
It's Proximity/Opto Sensor connected over i2c.

Signed-off-by: Jonathan Bakker <xc-racer2@live.ca>
Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
 .../bindings/input/sharp,gp2ap002a00f.txt     | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/sharp,gp2ap002a00f.txt

diff --git a/Documentation/devicetree/bindings/input/sharp,gp2ap002a00f.txt b/Documentation/devicetree/bindings/input/sharp,gp2ap002a00f.txt
new file mode 100644
index 000000000000..c524eb7d3d60
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/sharp,gp2ap002a00f.txt
@@ -0,0 +1,29 @@
+* Sharp GP2AP002A00F I2C Proximity/Opto Sensor
+
+Required properties:
+- compatible : Should be "sharp,gp2ap002a00f"
+- reg : The I2C address of the sensor
+- vout-gpio : The gpio connected to the vout pin
+- interrupt-parent : should be the phandle for the interrupt controller
+- interrupts : Interrupt mapping for GPIO IRQ, it should by configured with
+		flags IRQ_TYPE_EDGE_BOTH
+
+Optional properties:
+- wakeup : If the device is capable of waking up the system
+- io-channels : Phandle to an ADC channel connected to the light sensor
+- io-channel-names = "light";
+- poll-interval : Poll interval time in milliseconds, default 500ms
+- light-adc-max : Maximum light value reported, default 4096
+- light-adc-fuzz : Fuzz value for reported light value, default 80
+
+Example:
+
+gp2a@44 {
+	compatible = "sharp,gp2ap002a00f";
+	reg = <0x44>;
+	vout-gpio = <&gph0 2 GPIO_ACTIVE_HIGH>;
+	interrupt-parent = <&gph0>;
+	interrupts = <2 IRQ_TYPE_EDGE_BOTH>;
+	io-channels = <&adc 9>;
+	io-channel-names = "light";
+};
-- 
2.17.1

