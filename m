Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163008AbeE1Kll (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:41:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162987AbeE1Klf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:41:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Corneliu Doban <corneliu.doban@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 4.14 012/496] mmc: sdhci-iproc: add SDHCI_QUIRK2_HOST_OFF_CARD_ON for cygnus
Date: Mon, 28 May 2018 11:56:37 +0200
Message-Id: <20180528100320.069601225@linuxfoundation.org>
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

From: Corneliu Doban <corneliu.doban@broadcom.com>

commit 3de06d5a1f05c11c94cbb68af14dbfa7fb81d78b upstream.

The SDHCI_QUIRK2_HOST_OFF_CARD_ON is needed for the driver to
properly reset the host controller (reset all) on initialization
after exiting deep sleep.

Signed-off-by: Corneliu Doban <corneliu.doban@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Srinath Mannam <srinath.mannam@broadcom.com>
Fixes: c833e92bbb60 ("mmc: sdhci-iproc: support standard byte register accesses")
Cc: stable@vger.kernel.org # v4.10+
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mmc/host/sdhci-iproc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -186,7 +186,7 @@ static const struct sdhci_ops sdhci_ipro
 
 static const struct sdhci_pltfm_data sdhci_iproc_cygnus_pltfm_data = {
 	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
-	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN | SDHCI_QUIRK2_HOST_OFF_CARD_ON,
 	.ops = &sdhci_iproc_32only_ops,
 };
 
