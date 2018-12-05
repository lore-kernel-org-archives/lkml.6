Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DA9C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4E6620645
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 18:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAf93hQ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E6620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbeLESbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 13:31:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46857 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728288AbeLESb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 13:31:27 -0500
Received: by mail-wr1-f68.google.com with SMTP id l9so20731460wrt.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 10:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c0fAXjK7WtwNwNfHFkEE0JGYb445E4L0ysb3AhH6CYc=;
        b=dAf93hQ1m7gyGqjGjaDNveVceBo9Qepd2Jcsznq/eZpyKlnM6kIzgVT2uPylnePjNT
         h+nrC7EVfPAnepKWmDStKCTEqYyPQjgL7x6xb34VxEnSb2IO10JrwRbduvyrUiE9XAoG
         g3vykwR/ax5JuK6fzKQEOoICzQRBb0RRrLiiTvJ0TXzRhSpa9tjs0A4LoSy5tAV2DqCv
         m4sFQB8DSXWa8/kCX1VPEWPx06/0OHJDJmZTJCni50pbRW7J6ZfJjb6QxwuRKoUnIBSS
         IEsTPLjfnwZjKroSf1bbr+dXmqMWLx5D3DxXBDMDpNglcaQ/6o9IpQIcdIq+aiPHjNo7
         hVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c0fAXjK7WtwNwNfHFkEE0JGYb445E4L0ysb3AhH6CYc=;
        b=dHhqhfPRerK08MRvkbxH7wPsguB4X6o/Rq+tfEfLh4C1YXzTdzgdrQZ/JGLCY1kvKc
         gUcTXw6ARTOjfldw6ScvWNxIE1FLsFMNrgzNmi+2qNdm5/rVi78YOM6AB/8NKfyNyJ+t
         WWxHRF/Poe1ff4ACZiiVNycGvFYa2kl9W8xzbeqOgJMUfP+3fWwRE9xuSY4YMy9hgYRD
         snM562Dvekb44SZQNnqKfwSz50/sm0b5FBXZuQ58d+7pEUxfcM8pm2GpMyz7icSIQfxd
         m0XfU9nkRMn4lYRHiJ6usZ95JBbd2YfArYEz2OnocjuBBf5B9pv3wSj8CuJK0Y8tZ1O6
         8Q9w==
X-Gm-Message-State: AA+aEWbALLekMNVRrUSNv2yxIe0tcvegCzW91m+emowM9XEpRNGX574N
        nSHaVQQ2o8njfFAsryqHVLI=
X-Google-Smtp-Source: AFSGD/VkuBaQ5oL70hcz54gVdAiIxyqhIRE+zRcoYcd26J1NLhv7FAd9xlmdJ5CU+US08XOntolqNA==
X-Received: by 2002:adf:9246:: with SMTP id 64mr24101791wrj.130.1544034685340;
        Wed, 05 Dec 2018 10:31:25 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id a18sm27860998wrp.13.2018.12.05.10.31.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 10:31:24 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 12/12] staging: rtl8188eu: remove unused code in rtw_cmd.c
Date:   Wed,  5 Dec 2018 19:31:00 +0100
Message-Id: <20181205183100.16828-12-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205183100.16828-1-straube.linux@gmail.com>
References: <20181205183100.16828-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused/commented code in rtw_cmd.c.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_cmd.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_cmd.c b/drivers/staging/rtl8188eu/core/rtw_cmd.c
index e3e46f7ac834..f9cdd1da8add 100644
--- a/drivers/staging/rtl8188eu/core/rtw_cmd.c
+++ b/drivers/staging/rtl8188eu/core/rtw_cmd.c
@@ -215,8 +215,6 @@ int rtw_cmd_thread(void *context)
 
 	/*  free all cmd_obj resources */
 	while ((pcmd = rtw_dequeue_cmd(&pcmdpriv->cmd_queue))) {
-		/* DBG_88E("%s: leaving... drop cmdcode:%u\n", __func__, pcmd->cmdcode); */
-
 		rtw_free_cmd_obj(pcmd);
 	}
 
@@ -259,7 +257,6 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 
 	init_h2fwcmd_w_parm_no_rsp(ph2c, psurveyPara, _SiteSurvey_CMD_);
 
-	/* psurveyPara->bsslimit = 48; */
 	psurveyPara->scan_mode = pmlmepriv->scan_mode;
 
 	/* prepare ssid list */
@@ -660,9 +657,6 @@ u8 rtw_addbareq_cmd(struct adapter *padapter, u8 tid, u8 *addr)
 
 	init_h2fwcmd_w_parm_no_rsp(ph2c, paddbareq_parm, _AddBAReq_CMD_);
 
-	/* DBG_88E("rtw_addbareq_cmd, tid =%d\n", tid); */
-
-	/* rtw_enqueue_cmd(pcmdpriv, ph2c); */
 	res = rtw_enqueue_cmd(pcmdpriv, ph2c);
 
 exit:
@@ -696,7 +690,6 @@ u8 rtw_dynamic_chk_wk_cmd(struct adapter *padapter)
 
 	init_h2fwcmd_w_parm_no_rsp(ph2c, pdrvextra_cmd_parm, _Set_Drv_Extra_CMD_);
 
-	/* rtw_enqueue_cmd(pcmdpriv, ph2c); */
 	res = rtw_enqueue_cmd(pcmdpriv, ph2c);
 exit:
 	return res;
@@ -862,7 +855,6 @@ static void lps_ctrl_wk_hdl(struct adapter *padapter, u8 lps_ctrl_type)
 		rtw_hal_set_hwreg(padapter, HW_VAR_H2C_FW_JOINBSSRPT, (u8 *)(&mstatus));
 		break;
 	case LPS_CTRL_SPECIAL_PACKET:
-		/* DBG_88E("LPS_CTRL_SPECIAL_PACKET\n"); */
 		pwrpriv->DelayLPSLastTimeStamp = jiffies;
 		LPS_Leave(padapter);
 		break;
@@ -879,7 +871,6 @@ u8 rtw_lps_ctrl_wk_cmd(struct adapter *padapter, u8 lps_ctrl_type, u8 enqueue)
 	struct cmd_obj	*ph2c;
 	struct drvextra_cmd_parm	*pdrvextra_cmd_parm;
 	struct cmd_priv	*pcmdpriv = &padapter->cmdpriv;
-	/* struct pwrctrl_priv *pwrctrlpriv = &padapter->pwrctrlpriv; */
 	u8	res = _SUCCESS;
 
 	if (enqueue) {
@@ -1029,9 +1020,6 @@ static void rtw_chk_hi_queue_hdl(struct adapter *padapter)
 	if (psta_bmc->sleepq_len == 0) {
 		u8 val = 0;
 
-		/* while ((rtw_read32(padapter, 0x414)&0x00ffff00)!= 0) */
-		/* while ((rtw_read32(padapter, 0x414)&0x0000ff00)!= 0) */
-
 		rtw_hal_get_hwreg(padapter, HW_VAR_CHK_HI_QUEUE_EMPTY, &val);
 
 		while (!val) {
-- 
2.19.2

