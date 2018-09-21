Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 567C4C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A482321479
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:37:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVYmHMBh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A482321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390985AbeIUX11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 19:27:27 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39798 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390180AbeIUX11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 19:27:27 -0400
Received: by mail-wm1-f65.google.com with SMTP id q8-v6so4133916wmq.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 10:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3WaRCeTavRdCrBPmdVBNSrZv2RzOK3qF0HcqkxChA6U=;
        b=EVYmHMBhHn+apvft+i20jHzdcmbpXf9BiUZPiiqfmliGV/Gzk6SERZEHcUmqKezD7S
         K2adYRA9ijur6lUf0HXLFm9PIOWuOCOvxLRuRD+W43ic51FDTsnEiZ6guUY5X3pq2p8+
         FZfQ9B9UU6FgdCYTthgfYGfDAYavv/7fo9NuZV4hPk/McFXr3VEhNXQpkHM9f5kuJ3Oj
         tLUILcNAbhBo3JTlruWVD65mDUj6OJXxUY1GSlifipfG65Qw1jz/S+olhkY0x9qt92JR
         APldxpTK9ojSCYqGFzPkJ7vd/Ud5PMPDs1unmpLIkGvZxa+7t0BHrjjMfagNb/g96LL/
         2PIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3WaRCeTavRdCrBPmdVBNSrZv2RzOK3qF0HcqkxChA6U=;
        b=YJgL+0WdbItSNRGO9WAWtYo/xmQUonrlA6ywRA4WtO/pUmWNI4p7zSATpgkxZOuI09
         y6hldx5/nIf5ttq1rV/vsKYNgKBA+SIhSI/9z7Gi0YhJ/Ks0cAEOiyz3AVfwmbtF6yuc
         4RVphdu1MFuXoi/jyDDLoETsF6JIw+LEHhK0/rvamuUTgY5FOxgCq8+4KZj2eIAbDaIa
         Y3SEHa06uwwYDo2fSAZ0gP+gUFucA0gi2zUdaXhS+t9hnVrPJYY383xz4O25UGbYqBbP
         oqBKgB50wqu8fHkm1OaupeTuEq3oSNC+WNA7Gtk5DhMKnMBMDcK4C6/oRKTynlD33RdT
         /tFA==
X-Gm-Message-State: ABuFfoj8Fz3J8Kl7LjDPZ+Q27Opc89yElyh6kaFynOPgl+2rmD5EJVq3
        77uEpHm4CgekmTXW8TEUgwY=
X-Google-Smtp-Source: ANB0Vdb9Mw0jbwMaP0XagADrlb7L8boodJM2vIRabP60jldzC0Zlp7qXfpMHagXvz4qQeVRwyw976Q==
X-Received: by 2002:a1c:7015:: with SMTP id l21-v6mr8146042wmc.81.1537551450758;
        Fri, 21 Sep 2018 10:37:30 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id s2-v6sm33231645wrn.83.2018.09.21.10.37.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 10:37:30 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] staging: rtl8188eu: Remove unnecessary parentheses
Date:   Fri, 21 Sep 2018 10:37:23 -0700
Message-Id: <20180921173723.13148-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns when multiple pairs of parentheses are used for a single
conditional statement.

drivers/staging/rtl8188eu/core/rtw_pwrctrl.c:295:21: warning: equality
comparison with extraneous parentheses [-Wparentheses-equality]
        if ((pwrpriv->rpwm == pslv)) {
             ~~~~~~~~~~~~~~^~~~~~~
drivers/staging/rtl8188eu/core/rtw_pwrctrl.c:295:21: note: remove
extraneous parentheses around the comparison to silence this warning
        if ((pwrpriv->rpwm == pslv)) {
            ~              ^      ~
drivers/staging/rtl8188eu/core/rtw_pwrctrl.c:295:21: note: use '=' to
turn this equality comparison into an assignment
        if ((pwrpriv->rpwm == pslv)) {
                           ^~
                           =
drivers/staging/rtl8188eu/hal/odm.c:1062:27: warning: equality
comparison with extraneous parentheses [-Wparentheses-equality]
        if ((pregpriv->wifi_spec == 1))/*  (pmlmeinfo->HT_enable == 0))
*/
             ~~~~~~~~~~~~~~~~~~~~^~~~
drivers/staging/rtl8188eu/hal/odm.c:1062:27: note: remove extraneous
parentheses around the comparison to silence this warning
        if ((pregpriv->wifi_spec == 1))/*  (pmlmeinfo->HT_enable == 0))
*/
            ~                    ^   ~
drivers/staging/rtl8188eu/hal/odm.c:1062:27: note: use '=' to turn this
equality comparison into an assignment
        if ((pregpriv->wifi_spec == 1))/*  (pmlmeinfo->HT_enable == 0))
*/
                                 ^~
                                 =

Link: https://github.com/ClangBuiltLinux/linux/issues/163
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_pwrctrl.c | 2 +-
 drivers/staging/rtl8188eu/hal/odm.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c b/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
index 5ab6fc22a156..a3d3e9eb133c 100644
--- a/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8188eu/core/rtw_pwrctrl.c
@@ -292,7 +292,7 @@ void rtw_set_rpwm(struct adapter *padapter, u8 pslv)
 			pslv = PS_STATE_S3;
 	}
 
-	if ((pwrpriv->rpwm == pslv)) {
+	if (pwrpriv->rpwm == pslv) {
 		RT_TRACE(_module_rtl871x_pwrctrl_c_, _drv_err_,
 			 ("%s: Already set rpwm[0x%02X], new=0x%02X!\n", __func__, pwrpriv->rpwm, pslv));
 		return;
diff --git a/drivers/staging/rtl8188eu/hal/odm.c b/drivers/staging/rtl8188eu/hal/odm.c
index 48738f94cf88..5a0c38ecb15e 100644
--- a/drivers/staging/rtl8188eu/hal/odm.c
+++ b/drivers/staging/rtl8188eu/hal/odm.c
@@ -1059,7 +1059,7 @@ void odm_EdcaTurboCheckCE(struct odm_dm_struct *pDM_Odm)
 	struct mlme_ext_priv	*pmlmeext = &(Adapter->mlmeextpriv);
 	struct mlme_ext_info	*pmlmeinfo = &(pmlmeext->mlmext_info);
 
-	if ((pregpriv->wifi_spec == 1))/*  (pmlmeinfo->HT_enable == 0)) */
+	if (pregpriv->wifi_spec == 1) /*  (pmlmeinfo->HT_enable == 0)) */
 		goto dm_CheckEdcaTurbo_EXIT;
 
 	if (pmlmeinfo->assoc_AP_vendor >=  HT_IOT_PEER_MAX)
-- 
2.19.0

