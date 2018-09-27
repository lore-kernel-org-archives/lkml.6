Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834E1C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB2F2083A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB2F2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbeI0Ocw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:32:52 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:35350 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726669AbeI0Ocw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:32:52 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8R8ER00027837;
        Thu, 27 Sep 2018 10:15:47 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mqd47pryd-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 27 Sep 2018 10:15:47 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A44B534;
        Thu, 27 Sep 2018 08:15:41 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 591A5245D;
        Thu, 27 Sep 2018 08:15:41 +0000 (GMT)
Received: from SFHDAG6NODE1.st.com (10.75.127.16) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 27 Sep
 2018 10:15:40 +0200
Received: from SFHDAG6NODE1.st.com ([fe80::8d96:4406:44e3:eb27]) by
 SFHDAG6NODE1.st.com ([fe80::8d96:4406:44e3:eb27%20]) with mapi id
 15.00.1347.000; Thu, 27 Sep 2018 10:15:41 +0200
From:   Yannick FERTRE <yannick.fertre@st.com>
To:     Philippe CORNU <philippe.cornu@st.com>,
        Benjamin GAIGNARD <benjamin.gaignard@st.com>,
        "airlied@linux.ie" <airlied@linux.ie>
CC:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm: stm: implement get_scanout_position function
Thread-Topic: [PATCH] drm: stm: implement get_scanout_position function
Thread-Index: AQHUD6lh/FtQB5XoQ0G3N1zp/AXzb6R9OioAgIb5igA=
Date:   Thu, 27 Sep 2018 08:15:41 +0000
Message-ID: <c1148671-4df1-3815-bd62-75541873bad6@st.com>
References: <7441c31c-7427-da4e-c877-6d58b5bd869f@st.com>
In-Reply-To: <7441c31c-7427-da4e-c877-6d58b5bd869f@st.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
x-forwarded-message-id: <7441c31c-7427-da4e-c877-6d58b5bd869f@st.com>
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.46]
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <C72A83ECC11562488A3C13678BC460D7@st.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-27_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by/tested-by: yannick.fertre@st.com

-------- Forwarded Message --------
Subject: [PATCH] drm: stm: implement get_scanout_position function
Date: Fri, 29 Jun 2018 15:01:40 +0200
From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
To: yannick.fertre@st.com, philippe.cornu@st.com, airlied@linux.ie
CC: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
Benjamin Gaignard <benjamin.gaignard@linaro.org>, Benjamin Gaignard
<benjamin.gaignard@st.com>

Hardware allow to read the position in scanout buffer so
we can use this information to make wait of vblank more accurate.

Active area bounds (start, end, total height) have already been
computed and written in ltdc registers, read them and get the
current line position to compute vpos value.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
---
   drivers/gpu/drm/stm/drv.c  |  2 ++
   drivers/gpu/drm/stm/ltdc.c | 45
+++++++++++++++++++++++++++++++++++++++++++++
   drivers/gpu/drm/stm/ltdc.h |  5 +++++
   3 files changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
index 8698e08313e1..ac53383350e3 100644
--- a/drivers/gpu/drm/stm/drv.c
+++ b/drivers/gpu/drm/stm/drv.c
@@ -72,6 +72,8 @@ static struct drm_driver drv_driver = {
   	.gem_prime_vmap = drm_gem_cma_prime_vmap,
   	.gem_prime_vunmap = drm_gem_cma_prime_vunmap,
   	.gem_prime_mmap = drm_gem_cma_prime_mmap,
+	.get_scanout_position = ltdc_crtc_scanoutpos,
+	.get_vblank_timestamp = drm_calc_vbltimestamp_from_scanoutpos,
   };
    static int drv_load(struct drm_device *ddev)
diff --git a/drivers/gpu/drm/stm/ltdc.c b/drivers/gpu/drm/stm/ltdc.c
index d997a6014d6c..05b714673042 100644
--- a/drivers/gpu/drm/stm/ltdc.c
+++ b/drivers/gpu/drm/stm/ltdc.c
@@ -148,6 +148,8 @@
   #define IER_TERRIE	BIT(2)		/* Transfer ERRor Interrupt Enable */
   #define IER_RRIE	BIT(3)		/* Register Reload Interrupt enable */
   +#define CPSR_CYPOS	GENMASK(15, 0)	/* Current Y position */
+
   #define ISR_LIF		BIT(0)		/* Line Interrupt Flag */
   #define ISR_FUIF	BIT(1)		/* Fifo Underrun Interrupt Flag */
   #define ISR_TERRIF	BIT(2)		/* Transfer ERRor Interrupt Flag */
@@ -622,6 +624,49 @@ static void ltdc_crtc_disable_vblank(struct
drm_crtc *crtc)
   	reg_clear(ldev->regs, LTDC_IER, IER_LIE);
   }
   +bool ltdc_crtc_scanoutpos(struct drm_device *ddev, unsigned int pipe,
+			  bool in_vblank_irq, int *vpos, int *hpos,
+			  ktime_t *stime, ktime_t *etime,
+			  const struct drm_display_mode *mode)
+{
+	struct ltdc_device *ldev = ddev->dev_private;
+	int line, vactive_start, vactive_end, vtotal;
+
+	if (stime)
+		*stime = ktime_get();
+
+	/* The active area starts after vsync + front porch and ends
+	 * at vsync + front porc + display size.
+	 * The total height also include back porch.
+	 * We have 3 possible cases to handle:
+	 * - line < vactive_start: vpos = line - vactive_start and will be
+	 * negative
+	 * - vactive_start < line < vactive_end: vpos = line - vactive_start
+	 * and will be positive
+	 * - line > vactive_end: vpos = line - vtotal - vactive_start
+	 * and will negative
+	 *
+	 * Computation for the two first cases are identical so we can
+	 * simplify the code and only test if line > vactive_end
+	 */
+	line = reg_read(ldev->regs, LTDC_CPSR) & CPSR_CYPOS;
+	vactive_start = reg_read(ldev->regs, LTDC_BPCR) & BPCR_AVBP;
+	vactive_end = reg_read(ldev->regs, LTDC_AWCR) & AWCR_AAH;
+	vtotal = reg_read(ldev->regs, LTDC_TWCR) & TWCR_TOTALH;
+
+	if (line > vactive_end)
+		*vpos = line - vtotal - vactive_start;
+	else
+		*vpos = line - vactive_start;
+
+	*hpos = 0;
+
+	if (etime)
+		*etime = ktime_get();
+
+	return true;
+}
+
   static const struct drm_crtc_funcs ltdc_crtc_funcs = {
   	.destroy = drm_crtc_cleanup,
   	.set_config = drm_atomic_helper_set_config,
diff --git a/drivers/gpu/drm/stm/ltdc.h b/drivers/gpu/drm/stm/ltdc.h
index 1e16d6afb0d2..b8c5cc41e17a 100644
--- a/drivers/gpu/drm/stm/ltdc.h
+++ b/drivers/gpu/drm/stm/ltdc.h
@@ -37,6 +37,11 @@ struct ltdc_device {
   	struct fps_info plane_fpsi[LTDC_MAX_LAYER];
   };
   +bool ltdc_crtc_scanoutpos(struct drm_device *dev, unsigned int pipe,
+			  bool in_vblank_irq, int *vpos, int *hpos,
+			  ktime_t *stime, ktime_t *etime,
+			  const struct drm_display_mode *mode);
+
   int ltdc_load(struct drm_device *ddev);
   void ltdc_unload(struct drm_device *ddev);
   -- 2.15.0
