Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753390AbeE1NyO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:54:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:33036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162769AbeE1Kla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:41:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Srinath Mannam <srinath.mannam@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>, Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.14 010/496] mmc: sdhci-iproc: remove hard coded mmc cap 1.8v
Date: Mon, 28 May 2018 11:56:35 +0200
Message-Id: <20180528100319.977216553@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Srinath Mannam <srinath.mannam@broadcom.com>

commit 4c94238f37af87a2165c3fb491b4a8b50e90649c upstream.

Remove hard coded mmc cap 1.8v from platform data as it is board specific.
The 1.8v DDR mmc caps can be enabled using DTS property for those
boards that support it.

Fixes: b17b4ab8ce38 ("mmc: sdhci-iproc: define MMC caps in platform data")
Signed-off-by: Srinath Mannam <srinath.mannam@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Cc: stable@vger.kernel.org # v4.8+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-iproc.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -206,7 +206,6 @@ static const struct sdhci_iproc_data ipr
 	.caps1 = SDHCI_DRIVER_TYPE_C |
 		 SDHCI_DRIVER_TYPE_D |
 		 SDHCI_SUPPORT_DDR50,
-	.mmc_caps = MMC_CAP_1_8V_DDR,
 };
 
 static const struct sdhci_pltfm_data sdhci_bcm2835_pltfm_data = {
