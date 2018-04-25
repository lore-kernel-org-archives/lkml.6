Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751369AbeDYHyN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:54:13 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:62751 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751069AbeDYHyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:54:07 -0400
From: Philippe Cornu <philippe.cornu@st.com>
To: Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH v2 1/2] dt-bindings/display/bridge: sii902x: add optional power supplies
Date: Wed, 25 Apr 2018 09:53:13 +0200
Message-ID: <20180425075314.19137-2-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180425075314.19137-1-philippe.cornu@st.com>
References: <20180425075314.19137-1-philippe.cornu@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.129.5.66]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-25_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add optional power supplies using the description found in
"SiI9022A/SiI9024A HDMI Transmitter Data Sheet (August 2016)".

There is a single 1v2 supply voltage named vcc12 from which cvcc12
(digital core) and avcc12 (TMDS analog) are derived because according
to this data sheet:
"cvcc12 and avcc12 can be derived from the same power source"

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
 Documentation/devicetree/bindings/display/bridge/sii902x.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/sii902x.txt b/Documentation/devicetree/bindings/display/bridge/sii902x.txt
index 56a3e68ccb80..9fb41fc9af51 100644
--- a/Documentation/devicetree/bindings/display/bridge/sii902x.txt
+++ b/Documentation/devicetree/bindings/display/bridge/sii902x.txt
@@ -8,6 +8,8 @@ Optional properties:
 	- interrupts-extended or interrupt-parent + interrupts: describe
 	  the interrupt line used to inform the host about hotplug events.
 	- reset-gpios: OF device-tree gpio specification for RST_N pin.
+	- iovcc-supply: I/O supply voltage (1.8V or 3.3V, host-dependent).
+	- vcc12-supply: TMDS analog & digital core supply voltage (1.2V).
 
 Optional subnodes:
 	- video input: this subnode can contain a video input port node
-- 
2.15.1
