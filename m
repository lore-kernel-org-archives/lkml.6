Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbeCPMXh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 08:23:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:22172 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbeCPMXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 08:23:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,315,1517904000";
   d="scan'208";a="38536683"
Date: Fri, 16 Mar 2018 20:22:33 +0800
From: kbuild test robot <lkp@intel.com>
To: gabriel.fernandez@st.com
Cc: kbuild-all@01.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, gabriel.fernandez@st.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, gabriel.fernandez.st@gmail.com,
        Loic PALLARDY <loic.pallardy@st.com>,
        benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Michael Turquette <mturquette@baylibre.com>, sboyd@kernel.org
Subject: [RFC PATCH] reset: stm32mp1: stm32_reset_ops can be static
Message-ID: <20180316122233.GA85610@lkp-sb05>
References: <1521045001-30788-3-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521045001-30788-3-git-send-email-gabriel.fernandez@st.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: d05c83341cbc ("reset: stm32mp1: Enable stm32mp1 reset driver")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 reset-stm32mp1.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-stm32mp1.c b/drivers/reset/reset-stm32mp1.c
index 5e25388..ed44604 100644
--- a/drivers/reset/reset-stm32mp1.c
+++ b/drivers/reset/reset-stm32mp1.c
@@ -70,7 +70,7 @@ static int stm32_reset_status(struct reset_controller_dev *rcdev,
 	return !(reg & BIT(offset));
 }
 
-const struct reset_control_ops stm32_reset_ops = {
+static const struct reset_control_ops stm32_reset_ops = {
 	.assert		= stm32_reset_assert,
 	.deassert	= stm32_reset_deassert,
 	.status		= stm32_reset_status,
