Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751553AbeEVHfM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 03:35:12 -0400
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:44930 "EHLO
        8.mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751124AbeEVHfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 03:35:10 -0400
From: =?UTF-8?q?S=C3=A9bastien=20Szymanski?=
        <sebastien.szymanski@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>, Stefan Agner <stefan@agner.ch>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        =?UTF-8?q?S=C3=A9bastien=20Szymanski?=
        <sebastien.szymanski@armadeus.com>
Subject: [PATCH v3 2/3] ARM: dts: imx6ull: add operating points
Date: Tue, 22 May 2018 08:28:52 +0200
Message-Id: <20180522062853.24799-2-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
References: <20180522062853.24799-1-sebastien.szymanski@armadeus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 13133622416790672636
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedthedrgedtgddutdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX6ULL has different operating ranges than i.MX6UL so add the
operating points for the i.MX6ULL. A 25mV offset is added to the minimum
allowed values like for the i.MX6UL.

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---

Changes for v3:
 - none

Changes for v2:
 - Fix soc-operating-points voltage for 792MHz and 900MHz

 arch/arm/boot/dts/imx6ull.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ull.dtsi b/arch/arm/boot/dts/imx6ull.dtsi
index 571ddd71cdba..530d5526b890 100644
--- a/arch/arm/boot/dts/imx6ull.dtsi
+++ b/arch/arm/boot/dts/imx6ull.dtsi
@@ -46,6 +46,25 @@
 /* Delete UART8 in AIPS-1 (i.MX6UL specific) */
 /delete-node/ &uart8;
 
+&cpu0 {
+	operating-points = <
+		/* kHz	uV */
+		900000	1275000
+		792000	1225000
+		528000	1175000
+		396000	1025000
+		198000	950000
+	>;
+	fsl,soc-operating-points = <
+		/* KHz	uV */
+		900000	1175000
+		792000	1175000
+		528000	1175000
+		396000	1175000
+		198000	1175000
+	>;
+};
+
 / {
 	soc {
 		aips3: aips-bus@2200000 {
-- 
2.16.1
