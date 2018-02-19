Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753072AbeBSPGB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:06:01 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:19664 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752834AbeBSPFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:05:45 -0500
From: Olivier Moysan <olivier.moysan@st.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <robh@kernel.org>, <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <kernel@stlinux.com>, <linux-kernel@vger.kernel.org>,
        <olivier.moysan@st.com>
CC: <arnaud.pouliquen@st.com>, <benjamin.gaignard@st.com>
Subject: [RFC PATCH 1/3] ASoC: stm32: Add S/PDIF to SAI bindings
Date: Mon, 19 Feb 2018 16:00:35 +0100
Message-ID: <1519052437-24011-2-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519052437-24011-1-git-send-email-olivier.moysan@st.com>
References: <1519052437-24011-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-19_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add S/PDIF IEC6958 protocol support to STM32 SAI bindings.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
---
 Documentation/devicetree/bindings/sound/st,stm32-sai.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
index b1acc1a..f301cdf 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
+++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
@@ -45,6 +45,12 @@ SAI subnodes Optional properties:
 	This property sets SAI sub-block as slave of another SAI sub-block.
 	Must contain the phandle and index of the sai sub-block providing
 	the synchronization.
+  - st,iec60958: support S/PDIF IEC6958 protocol for playback
+	IEC60958 protocol is not available for capture.
+	By default, custom protocol is assumed, meaning that protocol is
+	configured according to protocol defined in related DAI link node,
+	such as i2s, left justified, right justified, dsp and pdm protocols.
+	Note: ac97 protocol is not supported by SAI driver
 
 The device node should contain one 'port' child node with one child 'endpoint'
 node, according to the bindings defined in Documentation/devicetree/bindings/
-- 
1.9.1
