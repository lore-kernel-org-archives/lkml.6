Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933421AbeCMMMD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:12:03 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:55341 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932659AbeCMMMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:12:01 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>,
        Thierry Reding <treding@nvidia.com>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mailbox: tegra: relax TEGRA_HSP_MBOX Kconfig dependencies
Date: Tue, 13 Mar 2018 13:11:43 +0100
Message-Id: <20180313121154.2715591-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:55bKbO9KTwwGRebdIoTAYBtHTs81GxsiNW/tiWZXVLJL7UxeU97
 UhZ80ts8dYrO06DH4tPO9TUHzLhyAYLKV1AJYmL9uP0knePbM/YPs5+GVtKCsImdM2biMG7
 mHHrntDKs0qftx3vl+REIdjAaPIytHbNRHExZMHSc1Gc2WL8I34yuJXIpWVJybjVEiz5/a0
 Piuzk7FLE9rpFAbhmFuiw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NiVmr7X4Vp8=:wc8GSLGoA1zxPMPK6rMVYS
 eq3bTktFH3BWEsp7/nmSeuDLtNcdHy2aky3pSyq+OsTlTfZVkMBug/Fn80GWrzjQM7jLZm005
 UPAoIJ20RNAfUidvXOZGQUOaTxiF59HB6R0UOFcb6h8tppHAcKyeaPTl84YmDDXiyWzqCbKNF
 Zb0dp2GMmXcWJKWWFj9/LMxmeTgFbWDTfI8QTqK2rKKQYjpJVwFKxVyGNf++h2gGeHboQZmlF
 0Qr0jBDF+sAuGfJQsXs9jZ5Mur1ktESPXmA4Wu7ItQgSN6JN/hGeDavWEMdXaUI8016Gg/HZC
 Ed5yXmBywP3bafnqGKBzgi6URJeCp2mppnI4LAB3fW+lbCik3NTxXW0qoTZivPa5sMnp7PH9y
 GQwPXYY1hv+G67HaZCqAaPadRhRR2ZMGiFCx2NzW75ciN2C8CUEzt1f/IoEHIUF5xzVzepJYo
 v5x5p4eCsaaQIm+N62FgUWVAdhvkOX/oHETNxy8NnbZQnqWymAFD2dX3qMN3/tosAxvZNlRqc
 tJ8XO7t217p0uuz/CViCATt7VSE525TDXUAIhz6ou9ThiEzY8g6s6WR+IYankV2YD21EZKV1I
 JhSKD3d5UiEc+EUBboEXQiDstYHryrkrI8ogvt5sXHpzxnQY1Ful/7WmUKDo8XAKMx58x9BPd
 ocL3Cmt3/VP/VBFwavhchf+fP8UbfOzafIzVMn3c/kwzpXgnjMxp5NMKIpz5AGKzKeWeDUtk0
 urMWJEBoIWGMivRyJXsXKxUz1EJHLssReURs6Q==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the addition of the ARCH_TEGRA_194_SOC driver, we get a new Kconfig warning:

warning: (ARCH_TEGRA_186_SOC && ARCH_TEGRA_194_SOC) selects TEGRA_HSP_MBOX which has unmet direct dependencies (MAILBOX && ARCH_TEGRA_186_SOC)

It looks like the dependency is a bit too strict here, allowing the driver to
be built for any Tegra chip avoids the problem.

Fixes: 6f9ed07fde03 ("soc/tegra: Add Tegra194 SoC configuration option")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mailbox/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index ba2f1525f4ee..7c24900554a7 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -134,7 +134,7 @@ config QCOM_APCS_IPC
 
 config TEGRA_HSP_MBOX
 	bool "Tegra HSP (Hardware Synchronization Primitives) Driver"
-	depends on ARCH_TEGRA_186_SOC
+	depends on ARCH_TEGRA
 	help
 	  The Tegra HSP driver is used for the interprocessor communication
 	  between different remote processors and host processors on Tegra186
-- 
2.9.0
