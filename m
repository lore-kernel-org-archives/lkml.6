Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751391AbeBWLIa (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 06:08:30 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:3883 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750910AbeBWLI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 06:08:28 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>, <robh+dt@kernel.org>
CC: <linux@armlinux.org.uk>, <mark.rutland@arm.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@linaro.org>,
        <arnaud.pouliquen@st.com>
Subject: [PATCH] dt-bindings: iio: adc: sd-modulator: fix io-channel-cells
Date: Fri, 23 Feb 2018 12:07:21 +0100
Message-ID: <1519384041-23782-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG7NODE2.st.com (10.75.127.20) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-23_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

io-channel-cells should be <0> since sigma delta modulator exports only
one channel, as described in ../iio/iio-bindings.txt "IIO providers"
section. Only the phandle is necessary for IIO consumers in this case.

Fixes: af11143757b7 ("IIO: Add DT bindings for sigma delta adc modulator")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
index e9ebb8a..ba24ca7 100644
--- a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
+++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
@@ -3,11 +3,11 @@ Device-Tree bindings for sigma delta modulator
 Required properties:
 - compatible: should be "ads1201", "sd-modulator". "sd-modulator" can be use
 	as a generic SD modulator if modulator not specified in compatible list.
-- #io-channel-cells = <1>: See the IIO bindings section "IIO consumers".
+- #io-channel-cells = <0>: See the IIO bindings section "IIO consumers".
 
 Example node:
 
 	ads1202: adc@0 {
 		compatible = "sd-modulator";
-		#io-channel-cells = <1>;
+		#io-channel-cells = <0>;
 	};
-- 
1.9.1
