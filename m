Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752830AbeBEJqU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 04:46:20 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:53665 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752606AbeBEJqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 04:46:07 -0500
From: Philippe Cornu <philippe.cornu@st.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Andrzej Hajda <a.hajda@samsung.com>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe Cornu <philippe.cornu@st.com>,
        "Benjamin Gaignard" <benjamin.gaignard@linaro.org>,
        Vincent Abriou <vincent.abriou@st.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Subject: [PATCH v1 1/2] dt-bindings/display/panel: otm8009a: Add optional power-supply property
Date: Mon, 5 Feb 2018 10:45:31 +0100
Message-ID: <20180205094532.23547-2-philippe.cornu@st.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180205094532.23547-1-philippe.cornu@st.com>
References: <20180205094532.23547-1-philippe.cornu@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.32]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-05_02:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some boards use a dedicated voltage regulator for this panel.
Add & document this related optional power-supply property.

Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
---
 Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt b/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
index 6862028e7b2e..203b03eefb68 100644
--- a/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
+++ b/Documentation/devicetree/bindings/display/panel/orisetech,otm8009a.txt
@@ -9,6 +9,7 @@ Required properties:
 
 Optional properties:
   - reset-gpios: a GPIO spec for the reset pin (active low).
+  - power-supply: phandle of the regulator that provides the supply voltage.
 
 Example:
 &dsi {
@@ -17,5 +18,6 @@ Example:
 		compatible = "orisetech,otm8009a";
 		reg = <0>;
 		reset-gpios = <&gpioh 7 GPIO_ACTIVE_LOW>;
+		power-supply = <&v1v8>;
 	};
 };
-- 
2.15.1
