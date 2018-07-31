Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93184C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CEF8208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 11:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nu7UILAL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CEF8208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732144AbeGaNOZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:14:25 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54110 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732087AbeGaNOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:14:24 -0400
Received: by mail-wm0-f67.google.com with SMTP id s9-v6so2687136wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 04:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yw3U6maF7HKlLWjLMRz2CAYgBcouoDbnhY2bEOx1Ddc=;
        b=Nu7UILALIh5SN74dwZbjIhhGLKhHFOdJjkPL9lOCwxjvGtQhShku8nGFJAwO8CD7oR
         JOub8MrhFWiA9Polpcr0FPkOa3CX0bPgRpk3KAkZAivmQo87P4fbe6qgqEZuDt6q6zi/
         tyJl+mhm1P/pPC5ObXooaC1vleqYZY9v4c0lLs2WIPKWLfrGxWiTFFNz/Go259Nq5qfk
         gP3baRc5eLtm8ukVBD4l8Sm/j+zmQJ6bHlp0wkoOhZOb1SjEqvSU/MPiQmidQYgKNoGM
         3r7pcF3UFJeak7U8eB9v43t0zWgzyZXLmpHohaDhFy1wANUUTT0bDb7in1SwKklOKydG
         Bvnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yw3U6maF7HKlLWjLMRz2CAYgBcouoDbnhY2bEOx1Ddc=;
        b=kAl9mp/qNJ0yhuqLcwdfXi6zaTRfidcAmGYm0wVPyYnvD6xzJkcHNOgeo6uOcxrSVf
         cIBojgIjyr3ii3iGOJBFqDuuARZMj2pEXySoLCGuQO2cV6Hg0hGQUmxkdME2l7lyN5W1
         zP7zNXVIir8D+gvIlQB8veIuwEFBtbiYlEjAk9H49O4P5/icW1zku9Kexc7rlRZMWWm1
         0fjJoLaVdLpgtp+RdfB3bUPokGaGozHPGLgt6LQdLLj3ACoQVk8VT0eUsLfWnmYmWD/1
         xka2oB4B0G9XuvMWeUTi4eWNBN6UvkzCrgNzMrSXu91Ui5F98+UL9oxPEwMgJtxHzTa4
         V3Lw==
X-Gm-Message-State: AOUpUlGrMZyi31J9Blu8+SLQmiyeNNFm+ri+GxCKTH0BoUMOtp57dxIg
        iIITtBSNWFfXhX8qgiUd42E=
X-Google-Smtp-Source: AAOMgpe6/eTpxtnk5NmHJeTDgqpANCvgMJ/+G2SiVyjtbBJ1mgecvR19qETusY+Wdwv1erUbpkp0XQ==
X-Received: by 2002:a1c:dc89:: with SMTP id t131-v6mr2148139wmg.50.1533036868596;
        Tue, 31 Jul 2018 04:34:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:32db:916d:97a2:c4eb])
        by smtp.gmail.com with ESMTPSA id f17-v6sm16513137wrs.1.2018.07.31.04.34.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Jul 2018 04:34:28 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 2/7] staging: rtl8188eu: fix indentation - style
Date:   Tue, 31 Jul 2018 13:34:10 +0200
Message-Id: <20180731113415.1500-2-straube.linux@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180731113415.1500-1-straube.linux@gmail.com>
References: <20180731113415.1500-1-straube.linux@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix indentation to clear checkpatch warnings.
WARNING: suspect code indent for conditional statements

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 4 ++--
 drivers/staging/rtl8188eu/os_dep/usb_intf.c    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index 4a8124570e6e..19387d87185d 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -142,7 +142,7 @@ static char *translate_scan(struct adapter *padapter,
 		if (ht_cap)
 			snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11bn");
 		else
-		snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11b");
+			snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11b");
 	} else if ((rtw_is_cckrates_included((u8 *)&pnetwork->network.SupportedRates))) {
 		if (ht_cap)
 			snprintf(iwe.u.name, IFNAMSIZ, "IEEE 802.11bgn");
@@ -2299,7 +2299,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 
 				psecuritypriv->dot118021XGrpPrivacy = _WEP40_;
 				if (param->u.crypt.key_len == 13)
-						psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
+					psecuritypriv->dot118021XGrpPrivacy = _WEP104_;
 			} else if (strcmp(param->u.crypt.alg, "TKIP") == 0) {
 				DBG_88E("%s, set group_key, TKIP\n", __func__);
 				psecuritypriv->dot118021XGrpPrivacy = _TKIP_;
diff --git a/drivers/staging/rtl8188eu/os_dep/usb_intf.c b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
index 025cd0f59718..69f04fa0a189 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
@@ -380,7 +380,7 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 	/* 2012-07-11 Move here to prevent the 8723AS-VAU BT auto
 	 * suspend influence */
 	if (usb_autopm_get_interface(pusb_intf) < 0)
-			pr_debug("can't get autopm:\n");
+		pr_debug("can't get autopm:\n");
 
 	/*  alloc dev name after read efuse. */
 	rtw_init_netdev_name(pnetdev, padapter->registrypriv.ifname);
-- 
2.18.0

