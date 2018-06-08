Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id pVTYI9eWGlsTFQAAmS7hNA
	; Fri, 08 Jun 2018 14:46:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7F62A607E4; Fri,  8 Jun 2018 14:46:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 03B29606FA;
	Fri,  8 Jun 2018 14:46:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03B29606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753018AbeFHOqp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 10:46:45 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:45337 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752977AbeFHOqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 10:46:38 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue104 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MD8ge-1fUcYi19jw-00GaGi; Fri, 08 Jun 2018 16:46:20 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Brian King <brking@us.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        Hannes Reinecke <hare@suse.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Wen Xiong <wenxiong@linux.vnet.ibm.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: ipr: fix build on 32-bit architectures
Date: Fri,  8 Jun 2018 16:46:00 +0200
Message-Id: <20180608144617.2900894-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:cCu/TTaTkc4gYbWtM3wDqUVBG45VXopUBxoNoybfEu5S4HjRYaU
 t2FSNBxKtk0zs7tcm5XgKS9tdpY4XHRL+qlJ7R2SouEUZ9jNLl1CAZwF3P46B/mbELpm9nK
 +lb5SLhA5UzaVEJRMemmbeqTBul1NZ07lBqxuYL1jQpRzlFeodCr12xSM+AN+HHijSBbxOC
 wpI9Zzjmka1RUCfW9QKxA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qwLVsRHVGY4=:GEYev9FE7Gj80Cn9Cf/DD+
 pMyev9ooifMju3cpPHlDYXWvT2N/F2z4jMPIw6SjWL3c18WWFgQu5Hdnw3MtBQD59Sm0aysqR
 hOvayT9VmwhWXpR86FXtcKY/DS5+0igptJYJWFdEu0v3vLGlRZAhLboSmsT9gUaRW786Z8PW8
 nc4bHBA8FlwDwQxZ4UfcWAAuObgMCBgtKWew7ezHKQQWJp1v605vpCrApDYMzW2LlynlDJWDF
 uVhEBYbGPyV2oASN5q6h4/XF7yOIuBn7/K5FVG83fscQBeGfNVaFRaTnoIbZWiJQHganB48Y/
 cGbjp34memPx+b1t4BxcARXkvCx+S3fiGG+QsqThU1a8UHUNLLx4hjrRWGN2Cscuvp6a/+wkj
 JGZnHbLuIGGzhvPbMJYdxtlKjN0LKqh7ycu51aJZteVbLTFNwAhM/VwR7OkTPkhZ8upYAjMgg
 5qkak0FO5YQocU10YP7SWTRixeVJkGC5DjvhTrpP1LPzvO4hOA3l0WDMslkZhjOckVmUKQcyi
 oODScBuwcv6LlS1mDcigppDS3baRZzZFoQJIr3hgLY1DOtE5BF1W/vBw+2CEULEXN+LaJpGS0
 QdXp8HE6POT8cMYMoeDVQ1wuc0RiVTA53wUC59gDV0h7CUPyWq/kknrwGeP0wKx5uUv9XscGv
 DRoh/34WnAN+k1I/yS0IP+Mu//OLH4BxIG6RY+RtuYIDu04VV//YiDShKq/0FM+I1dxk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replacing writeq() with writeq_relaxed() doesn't work on many architectures,
as that variant is not available in general:

net/Makefile:24: CC cannot link executables. Skipping bpfilter.
drivers/scsi/ipr.c: In function 'ipr_mask_and_clear_interrupts':
drivers/scsi/ipr.c:767:3: error: implicit declaration of function 'writeq_relaxed'; did you mean 'writew_relaxed'? [-Werror=implicit-function-declaration]
   writeq_relaxed(~0, ioa_cfg->regs.set_interrupt_mask_reg);
   ^~~~~~~~~~~~~~
   writew_relaxed

The other issue here is that the patch eliminated the wrong barrier.
As per a long discussion that followed Sinan's original patch submission,
the conclusion was that drivers should generally assume that the barrier
implied by writel() is sufficient for ordering DMA, so this reverts his
change and instead removes the extraneous wmb() before it, which is no
longer needed on any architecture now.

Fixes: 0109a4f2e02d ("scsi: ipr: Eliminate duplicate barriers on weakly-ordered archs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/ipr.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/ipr.c b/drivers/scsi/ipr.c
index 865c07dc11ea..d2f67a41fcdd 100644
--- a/drivers/scsi/ipr.c
+++ b/drivers/scsi/ipr.c
@@ -760,13 +760,12 @@ static void ipr_mask_and_clear_interrupts(struct ipr_ioa_cfg *ioa_cfg,
 		ioa_cfg->hrrq[i].allow_interrupts = 0;
 		spin_unlock(&ioa_cfg->hrrq[i]._lock);
 	}
-	wmb();
 
 	/* Set interrupt mask to stop all new interrupts */
 	if (ioa_cfg->sis64)
-		writeq_relaxed(~0, ioa_cfg->regs.set_interrupt_mask_reg);
+		writeq(~0, ioa_cfg->regs.set_interrupt_mask_reg);
 	else
-		writel_relaxed(~0, ioa_cfg->regs.set_interrupt_mask_reg);
+		writel(~0, ioa_cfg->regs.set_interrupt_mask_reg);
 
 	/* Clear any pending interrupts */
 	if (ioa_cfg->sis64)
@@ -8401,10 +8400,9 @@ static int ipr_reset_enable_ioa(struct ipr_cmnd *ipr_cmd)
 		ioa_cfg->hrrq[i].allow_interrupts = 1;
 		spin_unlock(&ioa_cfg->hrrq[i]._lock);
 	}
-	wmb();
 	if (ioa_cfg->sis64) {
 		/* Set the adapter to the correct endian mode. */
-		writel_relaxed(IPR_ENDIAN_SWAP_KEY,
+		writel(IPR_ENDIAN_SWAP_KEY,
 			       ioa_cfg->regs.endian_swap_reg);
 		int_reg = readl(ioa_cfg->regs.endian_swap_reg);
 	}
-- 
2.9.0
