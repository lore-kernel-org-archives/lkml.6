Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EC9C282CC
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 17:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0411B214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 17:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kowAzVX7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfA0RJX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 12:09:23 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39589 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbfA0RJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 12:09:23 -0500
Received: by mail-pg1-f194.google.com with SMTP id w6so6210431pgl.6;
        Sun, 27 Jan 2019 09:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gfABNVDCZWQ5AIJRbgge0ELXUMASzw8Uj9Mv2Ecysqk=;
        b=kowAzVX7xQwvH2NFjdgjnLAq5eNbh4LbRD9n/qirTk3Bw0kuWwj3Mr3692ndfqqszF
         JLkZ8uQgkarvLpUwZjqKFPo01ekF7JshUWxdjvCxqy0WppWTfFE+FY277+2wau1VU0/e
         8iTDDH6wfjln2LxmsVhTLv/EtFS9zpKbLhYZ1WWKN9Ta33ZQqKdnKCWWn7YjVtYYPFWf
         vk3ftxgwCVEH+u8RgMgDlv08fI51LhRUUQGNEAIGUw+SUaa9gKSNCSn45pChgOmPjrQI
         maOMQAnQOZAliOvjzHY6zFeXfNJNSDXE/eCC2iTPIVstA5fAxsEV+WlWZjGL6zqr7Wfm
         gp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gfABNVDCZWQ5AIJRbgge0ELXUMASzw8Uj9Mv2Ecysqk=;
        b=kE8wuxTx6IVYsWW30+Zn1E6guhPzk9Zno9Gaj0bZ126QpgpUAon/WWi161kB9FEGqP
         Pb7AWPujhg8Yfa8WMYOmzg36fMNFhK23Kkj8hAs9BMhD0Km+BcVR/kHb9L80YwoWMO/0
         11IKxI6lTRrRmMhn3OWac4t0dQ9nl7rVRJst/GZb1TgKGiWh1sVKX1GoCk+EDaiXNajt
         HgoUX45aN9OtxXpT7kWzxrwBKD03HrKLZ9KI0q7GRltG2Pm+Ms5gxq3Bgnh8R9otyygv
         04s7lMo2go+GMKJJWGrtX/K2f/USJrPjDNh9OgXI492QDrDDVLyUhUfyj52GzxfT41gc
         Dlhw==
X-Gm-Message-State: AJcUukcG4MyH7XUstLwX0jL6xrq8oOLlt53ET20y82xofycclT90fwTv
        GKK8dU3c2TJ+GNvVefB4uNM=
X-Google-Smtp-Source: ALg8bN7e5TEFUe6mRveMnbo/kFcz56uWWE2fDT0Mw7SLIBn7t0gZ/W667eJf2vBp/VXiAYcGmEudYw==
X-Received: by 2002:a62:4851:: with SMTP id v78mr19003568pfa.97.1548608962062;
        Sun, 27 Jan 2019 09:09:22 -0800 (PST)
Received: from bobby.localdomain ([2601:1c0:5501:37e2::745a])
        by smtp.gmail.com with ESMTPSA id e123sm50263816pgc.58.2019.01.27.09.09.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 09:09:21 -0800 (PST)
Date:   Sun, 27 Jan 2019 09:09:14 -0800
From:   Robert Eshleman <bobbyeshleman@gmail.com>
To:     bobbyeshleman@gmail.com
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] Add device tree binding documentation for MAX44009
Message-ID: <ab7652d06474f951bf764fdc087035554772d147.1548580142.git.bobbyeshleman@gmail.com>
References: <2b847f2b4ed5a94d21c41274395b97eed3ec39dd.1548580142.git.bobbyeshleman@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b847f2b4ed5a94d21c41274395b97eed3ec39dd.1548580142.git.bobbyeshleman@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds device tree documentation for the max44009 ambient light sensor.

Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
---
Changes to v3:
- None

Changes to v2:
- Clean up style

 .../bindings/iio/light/max44009.txt           | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/max44009.txt

diff --git a/Documentation/devicetree/bindings/iio/light/max44009.txt b/Documentation/devicetree/bindings/iio/light/max44009.txt
new file mode 100644
index 000000000000..b287d7732e37
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/max44009.txt
@@ -0,0 +1,25 @@
+* MAX44009 Ambient Light Sensor
+
+Required properties:
+
+- compatible: should be "maxim,max44009"
+- reg: the I2C address of the device (default is <0x4a>)
+
+Optional properties:
+
+- interrupts: interrupt mapping for GPIO IRQ. Should be configured with
+  IRQ_TYPE_EDGE_FALLING.
+
+Refer to interrupt-controller/interrupts.txt for generic interrupt client
+node bindings.
+
+Example:
+
+max44009: max44009@4a {
+	compatible = "maxim,max44009";
+	reg = <0x4a>;
+
+	interrupt-parent = <&gpio1>;
+	interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
+};
+
-- 
2.20.1

