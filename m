Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80521C64EB1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4507C20881
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 18:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0FH03X4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4507C20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726319AbeLHSUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 13:20:06 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41978 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbeLHSUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 13:20:06 -0500
Received: by mail-qk1-f193.google.com with SMTP id 189so4360368qkj.8;
        Sat, 08 Dec 2018 10:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pb5uQWFFFhTWBdj4Lj9guEHC24NQvxxLHMGux6Q4I9s=;
        b=k0FH03X4EXowAQYU06J0y7ZyFON1ONhKLSxX6hYOa+5Be/s0LLOw91JBSdexkj0sXB
         MpIpm9zN9Juu1wtPfX7+q0uHI8Uz55PC53sSsoTJJ5YpLOSQRoAklTteA5d3J4XyqIHO
         35ovCWJjw5T2PuZn62gPQcPkNwRUCGhPRR+WR3vTF4lFE7D12eKvAMZi9wvPWxXsTh96
         O4VNgovIOI52lEcttl3xmjQ8yWmN6Cg3BI/PVXwCkoRMkvgsqJ7QFAM+LHzlkYZd7i/2
         lK+GpQJbLHRtgp20UcInXY2Uv7hXrpsYfWjAcA5ZZsZ1ahNiguqdCMx2rDCKtZfCddrt
         5Ulg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pb5uQWFFFhTWBdj4Lj9guEHC24NQvxxLHMGux6Q4I9s=;
        b=YzxulJwnDnQfyHsiNp0p7IoCgwVoMKx628IS/24TAolL115pehCXzTsoBfH4/JdMWg
         mvlTwyPdx1Y3GjydbOm79jmtva8QaUhabgQZPLQYZAWBCS7zHF+ccAZMQNe95Yo0CCGP
         knLi29GuP++qnM4mmu44HKPrP4Wqxqbnts4CvhNf2GsOeUQJ6xBxNMHjwwms6UBbfNRu
         YOuXwZDX6NRve4aUHN9W5ksTOqT7zwabXVVYf1LHu3S5z5Cl/YEcLSN0ELi+6g2boiO/
         RjtkWxSV/UJ8Zy4J40v//aWHp5jkRGsxP1RheHf7g7KSW33k7YlBhY/ikNF+F27eQW/R
         fyCA==
X-Gm-Message-State: AA+aEWbGJToSrgjL6nxCXsa20GVUhvlnSIC+x1sjltBPo8ozS35gNQag
        55UyOyohYPnN/qw7619Owfk=
X-Google-Smtp-Source: AFSGD/Uw3SEy3npugnk2LJbL37gtMEDcU58aRR+7Nr0V0PQKn2Rz1k2Plj9gxCaU+kVU6sIRJHggHA==
X-Received: by 2002:ae9:de44:: with SMTP id s65mr6093040qkf.55.1544293204824;
        Sat, 08 Dec 2018 10:20:04 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id l13sm4777120qkh.45.2018.12.08.10.20.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Dec 2018 10:20:04 -0800 (PST)
Date:   Sat, 8 Dec 2018 16:19:59 -0200
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH 3/3] staging: iio: ad5933: add binding doc for ad5933
Message-ID: <348cbe2abbe256b66ed830bd1abb9fc50bf4d10e.1544292845.git.marcelo.schmitt1@gmail.com>
References: <cover.1544292845.git.marcelo.schmitt1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1544292845.git.marcelo.schmitt1@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a devicetree documentation for the ad5933 and ad5934 impedance
converter, network analyzer.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Gabriel Capella <gabriel@capella.pro>
Co-Developed-by: Gabriel Capella <gabriel@capella.pro>
---
 .../iio/impedance-analyzer/ad5933.txt         | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt

diff --git a/Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt b/Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt
new file mode 100644
index 000000000000..5ff38728ff91
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt
@@ -0,0 +1,26 @@
+Analog Devices AD5933/AD5934 Impedance Converter, Network Analyzer
+
+https://www.analog.com/media/en/technical-documentation/data-sheets/AD5933.pdf
+https://www.analog.com/media/en/technical-documentation/data-sheets/AD5934.pdf
+
+Required properties:
+ - compatible : should be one of
+		"adi,ad5933"
+		"adi,ad5934"
+ - reg : the I2C address.
+ - vdd-supply : The regulator supply for DVDD, AVDD1 and AVDD2 when they
+   are connected together.
+
+Optional properties:
+- clocks : external clock reference.
+- clock-names : must be "mclk" if clocks is set.
+
+Example for a I2C device node:
+
+	impedance-analyzer@0d {
+		compatible = "adi,adxl345";
+		reg = <0x0d>;
+		vdd-supply = <&vdd_supply>;
+		clocks = <&ref_clk>;
+		clock-names = "mclk";
+	};
-- 
2.17.1

