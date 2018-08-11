Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2153EC4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C720B21A05
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 20:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi52UBVY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C720B21A05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeHKXBx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 19:01:53 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42149 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbeHKXBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 19:01:52 -0400
Received: by mail-lj1-f195.google.com with SMTP id f1-v6so9665445ljc.9;
        Sat, 11 Aug 2018 13:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4huk6hz8OJGJGeyOptFEMy41wLoMmzqjFZgblcjpZxI=;
        b=Qi52UBVY69NzqsL13f0DOHbH7481KU5KE6M69RbBd3nXi7ZR641akFLbRfY2cPaEAT
         XWbtvwbiYdXTb4Ob/BEkrV0t0DeSNDzdUJUDBj2GFh+uOMMgnRjdQhcS8MCOg9jogHVR
         EL8ePpxAuykwoWP2o9SW9PfW5jfav7R7YxHENM5cIY8s+XIyWIHydVgFxRnvpNWkV85h
         sXKkToyj25u7ywq9tpyqoQpi5ge+PGE4Z0qAXP6aZPy9LRQrnV/mjwypCChkFOgn8Bci
         xlPUn4zthWGGyC5/hF49rJ2sw42TKogu0XKlBaEGPahcw2F/jqbYAtZaIkGvQ/2F7CRD
         GrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4huk6hz8OJGJGeyOptFEMy41wLoMmzqjFZgblcjpZxI=;
        b=uVSo3+TToUf5sGlPorX9x0ofvJ6QzJn0dzZAEpFBylF2olB2rGqQEx58vf+uMoInR1
         lQH8WUg1iNy8Eh3GOydohrDgPJi9dssH38LE9R7Fv9Tk5buHl/M92kJdMtoCC9D5zRga
         ZDEWXGoPF+fXuuwV71WpgJBQRllRmzKhFlWmScJgh8gjVaWshnOPIIcrkzfm4yqxI2qv
         3jszFkl7zCQpcmPIAp13GMZoOWuLlXSAVHDNdrskZv5XTVGhiLQa45Cwbw1pW2YEy/n+
         1CngEmLEYBoxYYA/MipVgti/hVyNEkZJWYOZ278wMkZOyKKkonPV2mf2rpg2Qy6oOWKU
         Z6gg==
X-Gm-Message-State: AOUpUlFGcw7fg6bbBFJF+K6O1hn54vWSOf6AoPQ6MtsJPOdcKlUhze30
        p+4EhzZ7prf8RfdjG9naMrA=
X-Google-Smtp-Source: AA+uWPzHpzhTgxtLVNJlMpLG0gTUDs3hJ/+AFAE+cIr2dzILeAfKrJUZrg/e4YbFPWUjcpKA1TRy1Q==
X-Received: by 2002:a2e:9c82:: with SMTP id x2-v6mr8312709lji.131.1534019191637;
        Sat, 11 Aug 2018 13:26:31 -0700 (PDT)
Received: from localhost.localdomain (c-2ec2e3af-74736162.cust.telenor.se. [46.194.227.175])
        by smtp.gmail.com with ESMTPSA id d10-v6sm2430353lfk.63.2018.08.11.13.26.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Aug 2018 13:26:30 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] dt-bindings: iio: dac: add bindings for ltc166x
Date:   Sat, 11 Aug 2018 22:02:25 +0200
Message-Id: <20180811200226.28776-2-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.11.0.rc2
In-Reply-To: <20180811200226.28776-1-marcus.folkesson@gmail.com>
References: <20180811200226.28776-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LTC1665/LTC1660 is a 8/10-bit Digital-to-Analog Converter (DAC)
with eight individual channels.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 .../devicetree/bindings/iio/dac/ltc166x.txt         | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/ltc166x.txt

diff --git a/Documentation/devicetree/bindings/iio/dac/ltc166x.txt b/Documentation/devicetree/bindings/iio/dac/ltc166x.txt
new file mode 100644
index 000000000000..c5b5f22d6c64
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/ltc166x.txt
@@ -0,0 +1,21 @@
+* Linear Technology Micropower octal 8-Bit and 10-Bit DACs
+
+Required properties:
+ - compatible: Must be one of the following:
+		"lltc,ltc1660"
+		"lltc,ltc1665"
+ - reg: SPI chip select number for the device
+ - vref-supply: Phandle to the voltage reference supply
+
+Recommended properties:
+ - spi-max-frequency: Definition as per
+	 Documentation/devicetree/bindings/spi/spi-bus.txt.
+	 Max frequency for this chip is 5 MHz.
+
+Example:
+dac@0 {
+	compatible = "lltc,ltc1660";
+	reg = <0>;
+	spi-max-frequency = <5000000>;
+	vref-supply = <&vref_reg>;
+};
-- 
2.11.0.rc2

