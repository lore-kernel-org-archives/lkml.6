Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752562AbeCXNeP (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 09:34:15 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34400 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752543AbeCXNeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 09:34:12 -0400
X-Google-Smtp-Source: AG47ELsxHk93CDR/kLIclCKjJB6Q0jeRdVDKC1Q/FRvJ6MfP7O/etH5WNugZH4F/BTOGFdc4w9n98w==
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: mturquette@baylibre.com, sboyd@kernel.org, afaerber@suse.de,
        robh+dt@kernel.org, mark.rutland@arm.com
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        davem@davemloft.net, mchehab@kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, viresh.kumar@linaro.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, manivannanece23@gmail.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 08/11] clk: actions: Add fixed factor clock support
Date: Sat, 24 Mar 2018 19:01:56 +0530
Message-Id: <20180324133159.4824-9-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180324133159.4824-1-manivannan.sadhasivam@linaro.org>
References: <20180324133159.4824-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Actions Semi fixed factor clock reusing the clk
ops from common clock driver.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/clk/actions/owl-fixed-factor.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 drivers/clk/actions/owl-fixed-factor.h

diff --git a/drivers/clk/actions/owl-fixed-factor.h b/drivers/clk/actions/owl-fixed-factor.h
new file mode 100644
index 000000000000..cc9fe36c0964
--- /dev/null
+++ b/drivers/clk/actions/owl-fixed-factor.h
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// OWL fixed factor clock driver
+//
+// Copyright (c) 2014 Actions Semi Inc.
+// Author: David Liu <liuwei@actions-semi.com>
+//
+// Copyright (c) 2018 Linaro Ltd.
+// Author: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+#ifndef _OWL_FIXED_FACTOR_H_
+#define _OWL_FIXED_FACTOR_H_
+
+#include "owl-common.h"
+
+#define OWL_FIX_FACT(_struct, _name, _parent, _mul, _div, _flags)	\
+	struct clk_fixed_factor _struct = {				\
+		.mult		= _mul,					\
+		.div		= _div,					\
+		.hw.init	= CLK_HW_INIT(_name,			\
+					      _parent,			\
+					      &clk_fixed_factor_ops,	\
+					      _flags),			\
+	}
+
+extern const struct clk_ops clk_fixed_factor_ops;
+
+#endif /* _OWL_FIXED_FACTOR_H_ */
-- 
2.14.1
