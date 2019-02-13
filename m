Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FEAC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A03DF222D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 18:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550083536;
	bh=6S4OiU0zKpNGFIAnvMP5w0B1MY1ppFbV+8aXoTLKC9o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ywWL0tlD4yXNHjw/fyLv8uNFU+jQmMLeoOc/OFBYb2aAAeL1y9WBWcN8cXx5nrbot
	 Ht5HM7UvrLleubhy4HHfvcj3XmftZk23BlGX5oQ0v3WMASC2Xh1xmat6c5m/G0yQ3g
	 FrjrYDdJYOIk8SzxDkbeHSI1YoQrKklBisgg/Ezw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406258AbfBMSpf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 13:45:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:44178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731955AbfBMSpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 13:45:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D156520811;
        Wed, 13 Feb 2019 18:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550083533;
        bh=6S4OiU0zKpNGFIAnvMP5w0B1MY1ppFbV+8aXoTLKC9o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zH+25vTthDcFBkXULcieOBfnZhF8mdE/yzmT3K5+o4Tsh5ldCSb4sy4EaOzNaeZHK
         G7BXlz6HKqPVDzKEwmgYYnwtvhWucqTfhsgTx+3IrZjBIx1jvGyyIKnr9dRrPceueO
         trCqU2R6G6V4RhAfW23h8g9e/nHHtz2yZATTX6DE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        linux-mips@vger.kernel.org
Subject: [PATCH 4.20 24/50] MIPS: Use lower case for addresses in nexys4ddr.dts
Date:   Wed, 13 Feb 2019 19:38:29 +0100
Message-Id: <20190213183657.678458621@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190213183655.747168774@linuxfoundation.org>
References: <20190213183655.747168774@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

commit 047f2d941b8b24cadd6a4a09e606b7f41188ba3e upstream.

DTC introduced an i2c_bus_reg check in v1.4.7, used since Linux v4.20,
which complains about upper case addresses used in the unit name.

nexys4ddr.dts names an I2C device node "ad7420@4B", leading to:

  arch/mips/boot/dts/xilfpga/nexys4ddr.dts:109.16-112.8: Warning
    (i2c_bus_reg): /i2c@10A00000/ad7420@4B: I2C bus unit address format
    error, expected "4b"

Fix this by switching to lower case addresses throughout the file, as is
*mostly* the case in the file already & fairly standard throughout the
tree.

Signed-off-by: Paul Burton <paul.burton@mips.com>
Cc: stable@vger.kernel.org # v4.20+
Cc: linux-mips@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/boot/dts/xilfpga/nexys4ddr.dts |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
+++ b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
@@ -90,11 +90,11 @@
 		interrupts = <0>;
 	};
 
-	axi_i2c: i2c@10A00000 {
+	axi_i2c: i2c@10a00000 {
 	    compatible = "xlnx,xps-iic-2.00.a";
 	    interrupt-parent = <&axi_intc>;
 	    interrupts = <4>;
-	    reg = < 0x10A00000 0x10000 >;
+	    reg = < 0x10a00000 0x10000 >;
 	    clocks = <&ext>;
 	    xlnx,clk-freq = <0x5f5e100>;
 	    xlnx,family = "Artix7";
@@ -106,9 +106,9 @@
 	    #address-cells = <1>;
 	    #size-cells = <0>;
 
-	    ad7420@4B {
+	    ad7420@4b {
 		compatible = "adi,adt7420";
-		reg = <0x4B>;
+		reg = <0x4b>;
 	    };
 	} ;
 };


