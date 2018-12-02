Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D0DC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 16:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EC4E208A3
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 16:57:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9w+fouf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EC4E208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbeLBQ5T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 11:57:19 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37053 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbeLBQ5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 11:57:19 -0500
Received: by mail-qt1-f193.google.com with SMTP id z16so11259441qtq.4;
        Sun, 02 Dec 2018 08:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XuOrIdOrWdJpHvjAxch16kFCeUkFwdVXYlmRt8TRW/0=;
        b=M9w+foufTMjekB5QUDTSZnlFctnBiuNnnwCgxC6sX0hTzrA50ILCwxOarJrpfK5FaK
         +bOFP2ktKInACbJ2VYNphh4lU1Un0+peL7+B6cXsA3ATrbJnSGgQ6Cv+JF43bwkdDS7E
         mz4CGQ81DHW+QMQDMAvm7muHV3Kiojm5/lWOKZgBAGeVbmpTzztzDle6U2bkhgWAfCrj
         dopoPzv/B9RSVeULO4F0b60CDPBnZZcAh+JT/R9Y0yjjeuhn4E6ITc3E+uU1xTxjc50z
         k0+lb7MlxGaQ5UaHR+YXasQczxhFINDFMpoWxT2Zg7/QYHEWrlrQLht0HCdA/3GVkgEE
         9bPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XuOrIdOrWdJpHvjAxch16kFCeUkFwdVXYlmRt8TRW/0=;
        b=Bn6jra1EPoUX80QhVlJB8CFST1qIv6g9Gsixngxtxa+uxxFmHBrsNLGzIbR7ot89lt
         mLLFNFribuy6HnQHDMwVUsP8VPGHbx2XQjmYAroy9XFMSaH3wOavuJ/k+t+jmnpREeRS
         pFhpSoOS+qK/p14gYxp1dQ5WMh+PRnJ1PNSq267YhYk37ijNlBslJ1bDI9yfsAQ0BRbM
         jihCSuLzPMKK/BI3KUc0wLddmcP7WQCXTihYk5IUbPfzjXonjrZsxUimnbJAqRp32IFo
         C3eMa6AcrwYPpTy4XCEZqDxuFGZ0Z0KtwmLVQfCIJMywxjjwQ6DzGqENEOkE7OTpq3qd
         QiHw==
X-Gm-Message-State: AA+aEWbmJMgj/fGmU3QGWyEhHw+cjQPIWWCe0YY67HV28oDOxP2q3y2w
        31ATxk2YOkRXe9cTfsW9oQI=
X-Google-Smtp-Source: AFSGD/VYVcKSJTwcpFcv9DFfFenealG8guzajSeCPASi2IjrQwbxYkqKeEjA42RIEo7R216OVjMUYg==
X-Received: by 2002:ac8:13c5:: with SMTP id i5mr6968516qtj.365.1543769837299;
        Sun, 02 Dec 2018 08:57:17 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id q2sm5026514qkc.68.2018.12.02.08.57.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 02 Dec 2018 08:57:16 -0800 (PST)
Date:   Sun, 2 Dec 2018 14:57:12 -0200
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: [PATCH] staging: iio: ad5933: add binding doc for ad5933
Message-ID: <20181202165712.t6pd6ygq57llf2lr@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a devicetree documentation for the ad5933 and ad5934 impedance
converter, network analyzer.

Co-Developed-by: Gabriel Capella <gabriel@capella.pro>

Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Gabriel Capella <gabriel@capella.pro>
---
 .../iio/impedance-analyzer/ad5933.txt         | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt

diff --git a/Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt b/Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt
new file mode 100644
index 000000000000..d9ae2babf016
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/impedance-analyzer/ad5933.txt
@@ -0,0 +1,23 @@
+Analog Devices AD5933/AD5934 Impedance Converter, Network Analyzer
+
+https://www.analog.com/media/en/technical-documentation/data-sheets/AD5933.pdf
+https://www.analog.com/media/en/technical-documentation/data-sheets/AD5934.pdf
+
+Required properties:
+ - compatible : should be one of
+		"adi,ad5933"
+		"adi,ad5934"
+ - reg : the I2C address
+ - vdd-supply : supply reference for the device.
+
+Optional properties:
+ - vref_mv : default voltage reference.
+ - ext_clk_hz : external master clock for the system.
+
+Example:
+
+	impedance-analyzer@0d {
+		compatible = "adi,ad5933";
+		reg = <0x0d>;
+		vdd-supply = <&vdd_supply>;
+	};
-- 
2.17.1

