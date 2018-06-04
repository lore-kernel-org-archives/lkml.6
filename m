Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752998AbeFDHBe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:01:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:54058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752969AbeFDHBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:01:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 28/52] ASoC: Intel: sst: remove redundant variable dma_dev_name
Date: Mon,  4 Jun 2018 08:58:23 +0200
Message-Id: <20180604065607.696895370@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065606.532044490@linuxfoundation.org>
References: <20180604065606.532044490@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Colin Ian King <colin.king@canonical.com>

commit 271ef65b5882425d500e969e875c98e47a6b0c86 upstream.

The pointer dma_dev_name is assigned but never read, it is redundant
and can therefore be removed.

Cleans up clang warning:
sound/soc/intel/common/sst-firmware.c:288:3: warning: Value stored to
'dma_dev_name' is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 sound/soc/intel/common/sst-firmware.c |    2 --
 1 file changed, 2 deletions(-)

--- a/sound/soc/intel/common/sst-firmware.c
+++ b/sound/soc/intel/common/sst-firmware.c
@@ -274,7 +274,6 @@ int sst_dma_new(struct sst_dsp *sst)
 	struct sst_pdata *sst_pdata = sst->pdata;
 	struct sst_dma *dma;
 	struct resource mem;
-	const char *dma_dev_name;
 	int ret = 0;
 
 	if (sst->pdata->resindex_dma_base == -1)
@@ -285,7 +284,6 @@ int sst_dma_new(struct sst_dsp *sst)
 	* is attached to the ADSP IP. */
 	switch (sst->pdata->dma_engine) {
 	case SST_DMA_TYPE_DW:
-		dma_dev_name = "dw_dmac";
 		break;
 	default:
 		dev_err(sst->dev, "error: invalid DMA engine %d\n",
