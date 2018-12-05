Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFE9C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 906932084C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eqgPYYdc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906932084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbeLERDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:03:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35290 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728222AbeLERDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:03:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id 96so20494356wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 09:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c0fAXjK7WtwNwNfHFkEE0JGYb445E4L0ysb3AhH6CYc=;
        b=eqgPYYdcTv0/CT2W+sz91rQK0jypmQEmW4AMvT098zCm/Y1LYiaRd09G/QqhoWYFwO
         BQ4KAab4vgqtMVvpX+vOVqxanBSsMAQU/nFOYnuAl6o0TT+Trao/59J6C5dTr5ll54Id
         Az6tDahAYduFJEkdORigRe26DYXKvXMGQBneT2yUbWzxmJMnLZJoyErQSWoIQBd2B752
         S7I1GwWeYvXrOOFO3KFgZuxJY/jGPuXUmts1/yunqgdP0O/k33LXN4/jJOVZnMFoG6st
         lZVV1dCqJnHTt5zH+hIe6Yl7F8a1xid3pCfZHYMBcnLyQnHO4DCLF2nqfvc6Daw8u3ky
         5CnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c0fAXjK7WtwNwNfHFkEE0JGYb445E4L0ysb3AhH6CYc=;
        b=DffZiIfueMjy4iLhQ1yh2m58DgFsEo5yHuKjkmI2jzU9BxtxFghOXtrY2AQKKqrSJB
         7Rn4z4I7YMi2NlECsbPZBMWmXeJ46493D84R8hlYVObZqcZcKtQd053bt6oUFxkajhcC
         RBPS19lIF2+hMZi0ir3HANqh+2n+pKVyFR2c/XRANfwHo3A3/nicYdsj+8Uim/dJHmFX
         SWIUkuaNC9eXfVnhhvzGtNhnHkx44A7NnI3DwJ19dalrsytkVCM2AiNOMcpIM+IGUIKl
         ktIFjJVCYG4q8dYKzr3mq2DWkbmivLhuV5BpcRcv/BBdUb0pxFJGrcWZq9s0mEa00QLx
         ojYQ==
X-Gm-Message-State: AA+aEWa2armGuCmnq7+dePmsR4eCRjDW8NRl8kuHfG8+BSVQiJBzTypK
        rqLwg5FxGF9f+KEzfPF+hPE=
X-Google-Smtp-Source: AFSGD/U8+DdLuqVKxPiVwZjRPvMeZuwJOfPRBR8+LleknL5Tfm6yMufVzIHNfQHlnVB8ggpaxhTTJA==
X-Received: by 2002:adf:b592:: with SMTP id c18mr22135754wre.89.1544029390678;
        Wed, 05 Dec 2018 09:03:10 -0800 (PST)
Received: from localhost.localdomain ([2a02:8108:85c0:3a84:1919:ecb4:15a4:d6ba])
        by smtp.gmail.com with ESMTPSA id n127sm7949825wmd.20.2018.12.05.09.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 09:03:10 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 12/12] staging: rtl8188eu: remove unused code in rtw_cmd.c
Date:   Wed,  5 Dec 2018 18:02:47 +0100
Message-Id: <20181205170247.5401-12-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205170247.5401-1-straube.linux@gmail.com>
References: <20181205170247.5401-1-straube.linux@gmail.com>
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

