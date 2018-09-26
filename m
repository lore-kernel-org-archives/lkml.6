Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCB1C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7912620843
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 06:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D/aSQ+Zg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7912620843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727188AbeIZMvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 08:51:15 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41460 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbeIZMvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 08:51:15 -0400
Received: by mail-ed1-f68.google.com with SMTP id f38-v6so860389edd.8;
        Tue, 25 Sep 2018 23:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0NrBlGW63g/c8j9QosRK90oCvMIoSzXsbV8LTC28K7o=;
        b=D/aSQ+Zgbr6Ni7qNPNoXk1vjgSCaWTte2u07Za06wWymqOvRdbjHu3mRmRXlWGpJ8c
         PSFK0d0Rm/V8pzu4zgzxDYPa+zPPP8TraikqhpywVdlnY/T0xfxfbgeUxn6jkCH37GSC
         3zTlqxXl7c2s8d/dEtB/+0rltO5t4QD8gZ2qEaYGx/jUgUT7aGiKH7ITiJ3zcRt3Q7kA
         LbhWQNC+YkZMyEj8G3krh8Bdgcrv46XuZN3MF4GqUn5L/axd1ypQ8geUI023qSOPha78
         NzIxx2uV0M5/tzsNdWvJBkwhywDT4Wj/rYTzUbD8WjzBtF5mmQ+HbZTDGSTTDnonumto
         52kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0NrBlGW63g/c8j9QosRK90oCvMIoSzXsbV8LTC28K7o=;
        b=LBuO4otlC1Q+S4wDED7vE0CPexDfYzWnd1Hm2FpZ3AKQlGTAc+4QVylxDsLMudeGBc
         /5NfRJ5s4zDnBm+tjBqZIhhta7FVbfgzhyOhATvTW0vYsgx9aramgoyduR3oKkBzoh00
         E8OlgYTJ8k8BidXT00stTCz11KyIlUljINt2WQZ+tWbermwjFB6PRhblQV79WOXX9LLA
         jCQ8TTpwvhpDdw8CRPjZcAgVvTsmEqWWbomGZobkbuP8J0atb8zp7ABtH44YL384bTSa
         PIiTDQXdptwj2ek6CNEzKS4FmsKSorSJZ2/r2UT+orDjzBXv/dnBTC7UaUNMu52kmx0N
         wHPw==
X-Gm-Message-State: ABuFfoj2azLqBJNIBf1EJ+NUwFaL1dmNkVhEWeSXh2TvX2vIxJF5e1NT
        nMGEMu23rzVcjq7JLY3pL1U=
X-Google-Smtp-Source: ACcGV63i1gevzojTlC4zU10jiY/Qb39hhPoZ7PvW4sJLNOQJ6IvJ5z4STY6UqcPRyvFqS/ph23JPzw==
X-Received: by 2002:a50:b519:: with SMTP id y25-v6mr7372406edd.24.1537943991692;
        Tue, 25 Sep 2018 23:39:51 -0700 (PDT)
Received: from piling.lan (80-62-116-106-mobile.dk.customer.tdc.net. [80.62.116.106])
        by smtp.gmail.com with ESMTPSA id g20-v6sm6830804edm.36.2018.09.25.23.39.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 23:39:49 -0700 (PDT)
From:   Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To:     robh@kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Zhouyang Jia <jiazhouyang09@gmail.com>,
        linux-mtd@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Cc:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH v3 8/8] dt-binding: mtd: Document gpio-addr-flash
Date:   Wed, 26 Sep 2018 08:39:34 +0200
Message-Id: <20180926063934.9229-1-ricardo.ribalda@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180925204813.GA6450@bogus>
References: <20180925204813.GA6450@bogus>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for gpio-addr-flash. This binding allow creating
flash devices that are paged using GPIOs.

Cc: devicetree@vger.kernel.org
Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---

Changelog v3: 

- Changes suggested by Rob Herring (Thanks!)
  - Add gpio description
  - Improve partition

 .../bindings/mtd/gpio-addr-flash.txt          | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt

diff --git a/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt b/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
new file mode 100644
index 000000000000..5006a26e1753
--- /dev/null
+++ b/Documentation/devicetree/bindings/mtd/gpio-addr-flash.txt
@@ -0,0 +1,54 @@
+Memory Mapped flash with some address lines addressed using GPIOs
+
+Handle the case where a flash device is mostly addressed using physical
+line and supplemented by GPIOs.  This way you can hook up say a 8MiB flash
+to a 2MiB memory range and use the GPIOs to select a particular range.
+
+ - compatible : "cfi-gpio-addr-flash"
+ - reg : Address range of the mtd chip that is memory mapped, this is,
+   on the previous example 2MiB.
+ - bank-width : Width (in bytes) of the bank.  Equal to the
+   device width times the number of interleaved chips.
+ - gpios: List of GPIO specifiers that will be used to address the MSBs address
+   lines. The order goes from LSB to MSB.
+ - probe-type : (optional) "cfi_probe", "jedec_probe". How the mtd chip
+   is going to be probed. If omitted, assumed to be equal to "cfi_probe".
+ - #address-cells, #size-cells : Must be present if the device has
+   sub-nodes representing partitions (see below).  In this case
+   both #address-cells and #size-cells must be equal to 1.
+
+The device tree may optionally contain sub-nodes describing partitions of the
+address space. Check partition.txt for more details.
+
+Example:
+
+	flash@300000 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "cfi-gpio-addr-flash";
+		bank-width = <2>;
+		reg = < 0x00300000 0x00200000 >;
+		gpios = <&gpio_0 3 0>, <&gpio_0 4 0>;
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				reg = < 0x0 0x200000 >;
+				label = "Golden Bitstream";
+			};
+			partition@200000 {
+				reg = < 0x200000 0x200000 >;
+				label = "User Bitstream";
+			};
+			partition@400000 {
+				reg = < 0x400000 0x200000 >;
+				label = "V4L Controls";
+			};
+			partition@600000 {
+				reg = < 0x600000 0x200000 >;
+				label = "Production Data";
+			};
+		}
+	} ;
-- 
2.19.0

