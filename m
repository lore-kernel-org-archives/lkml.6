Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACEA7C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34D1A20867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SeNbAB9K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D1A20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbeIZBXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:23:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42753 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeIZBXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:23:19 -0400
Received: by mail-wr1-f65.google.com with SMTP id b11-v6so8297354wru.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 12:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6arBzP+ZUwIvik0d1fYOuR3O32ZbncTasFKCWMu12kc=;
        b=SeNbAB9KFiyNk/CujtoeH4aPT1nUoEwQmoJc45JkfeqfEUgAP3ZKiIbqbewsFHXLeP
         wnDF7ww6yLaMqqqUPYjKWlN4bS5KP75tAq91n/jE0b5b3c1W6ApOY1hUzIv+oyQP/svW
         SJEunrmPWxjmmaU1CMsqoV2iEpCzf7cXYGXm7M0cgX2cQb7cZVzifGAOjtqXsZYIydEu
         CKq0yHSp+O8k+OLpqkQhgqB5jYZosQRzBmQ6Cv13oXvLhawG7+HEggOrxXYxfCaa0n25
         /MhZ2wQcxt6vJM9y4XveAsuAxxUpsYRRJIaj2BbvsiLB3sgF5qX9JY0NOUI5akXny08o
         bfvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6arBzP+ZUwIvik0d1fYOuR3O32ZbncTasFKCWMu12kc=;
        b=AJ9KSuOmpIx0kTPt5pCwEoUBFn0zBN8muja3AtM6WAmmDIL8Sb+bpko8frAr7+XFI5
         dypx8wY60YKxnQMrf5JNGxYnRG1Ofu2ugryvz1fSsJ8KG4m1U6NEmFwi3/lKwWnCLyHk
         WybyWHjuWM1ahy4l6rVmkoQ9jIRS23Vgq/j+9rzd9IkW77Ip/lXzMJ6ZqvPZ7fFFD9S1
         mQQPF5Tt4vIwIQ3tmcl1HTnFELuI2IjSa5+30lAPV1G6Sj5VtyPdaOj0407IePsE0Bv5
         wuBifr8Eu0MJeZmM8T4tvWzDzEB4oa/xTJFTUe479zX0BXioSZnUzxVQc9GLU54TUX8+
         Zkpg==
X-Gm-Message-State: ABuFfoiPRmliSWndOm4YrNCCBdYZ88Z5KnJzNN6RPOTZAcnRu62TQGBf
        /vb9bqAXxz00Qiot2uubN8Y=
X-Google-Smtp-Source: ACcGV61JFt2IFJDWaz7K+qEHEEh2GsM8VtD+4GgaAff/ifItFIpeYojsYsplzN7YNvXZwYsbE04eEQ==
X-Received: by 2002:adf:ac13:: with SMTP id v19-v6mr2240421wrc.135.1537902857768;
        Tue, 25 Sep 2018 12:14:17 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id 11-v6sm1154339wrb.95.2018.09.25.12.14.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 12:14:17 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH v2] staging: rtl8188eu: Simplify memcmp logical checks
Date:   Tue, 25 Sep 2018 12:13:26 -0700
Message-Id: <20180925191325.4257-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180921002221.14424-1-natechancellor@gmail.com>
References: <20180921002221.14424-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang generates a warning when it sees a logical not followed by a
conditional operator like ==, >, or < because it thinks that the logical
not should be applied to the whole statement:

drivers/staging/rtl8188eu/core/rtw_ieee80211.c:293:8: warning: logical
not is only applied to the left hand side of this comparison
[-Wlogical-not-parentheses]

It assumes the author might have made a mistake in their logic:

if (!a == b) -> if (!(a == b))

Sometimes that is the case; other times, it's just a super convoluted
way of saying 'if (a)' when b = 0:

if (!1 == 0) -> if (0 == 0) -> if (true)

Alternatively:

if (!1 == 0) -> if (!!1) -> if (1)

Simplify these comparisons so that Clang doesn't complain.

Link: https://github.com/ClangBuiltLinux/linux/issues/161
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Fix missing parenthesis in last hunk

 drivers/staging/rtl8188eu/core/rtw_ieee80211.c | 2 +-
 drivers/staging/rtl8188eu/core/rtw_mlme.c      | 2 +-
 drivers/staging/rtl8188eu/core/rtw_recv.c      | 4 ++--
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index 9e5c7e62d26f..20f34d25c369 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -284,7 +284,7 @@ unsigned char *rtw_get_wpa_ie(unsigned char *pie, uint *wpa_ie_len, int limit)
 
 		if (pbuf) {
 			/* check if oui matches... */
-			if (!memcmp((pbuf + 2), wpa_oui_type, sizeof(wpa_oui_type)) == false)
+			if (memcmp((pbuf + 2), wpa_oui_type, sizeof(wpa_oui_type)))
 				goto check_next_ie;
 
 			/* check version... */
diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme.c b/drivers/staging/rtl8188eu/core/rtw_mlme.c
index ef8a7dc4bd34..43d6513484c5 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme.c
@@ -1437,7 +1437,7 @@ static int rtw_check_join_candidate(struct mlme_priv *pmlmepriv
 	/* check ssid, if needed */
 	if (pmlmepriv->assoc_ssid.SsidLength) {
 		if (competitor->network.Ssid.SsidLength != pmlmepriv->assoc_ssid.SsidLength ||
-		    !memcmp(competitor->network.Ssid.Ssid, pmlmepriv->assoc_ssid.Ssid, pmlmepriv->assoc_ssid.SsidLength) == false)
+		    memcmp(competitor->network.Ssid.Ssid, pmlmepriv->assoc_ssid.Ssid, pmlmepriv->assoc_ssid.SsidLength))
 			goto exit;
 	}
 
diff --git a/drivers/staging/rtl8188eu/core/rtw_recv.c b/drivers/staging/rtl8188eu/core/rtw_recv.c
index ab9638d618a9..f3eb63f8cf0b 100644
--- a/drivers/staging/rtl8188eu/core/rtw_recv.c
+++ b/drivers/staging/rtl8188eu/core/rtw_recv.c
@@ -1283,8 +1283,8 @@ static int wlanhdr_to_ethhdr(struct recv_frame *precvframe)
 	psnap_type = ptr+pattrib->hdrlen + pattrib->iv_len+SNAP_SIZE;
 	/* convert hdr + possible LLC headers into Ethernet header */
 	if ((!memcmp(psnap, rtw_rfc1042_header, SNAP_SIZE) &&
-	     (!memcmp(psnap_type, SNAP_ETH_TYPE_IPX, 2) == false) &&
-	     (!memcmp(psnap_type, SNAP_ETH_TYPE_APPLETALK_AARP, 2) == false)) ||
+	     memcmp(psnap_type, SNAP_ETH_TYPE_IPX, 2) &&
+	     memcmp(psnap_type, SNAP_ETH_TYPE_APPLETALK_AARP, 2)) ||
 	     !memcmp(psnap, rtw_bridge_tunnel_header, SNAP_SIZE)) {
 		/* remove RFC1042 or Bridge-Tunnel encapsulation and replace EtherType */
 		bsnaphdr = true;
diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
index fb496ab5a862..53fac22ff621 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -856,7 +856,7 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pframe, u32 packet_len)
 		return _FAIL;
 	}
 
-	if (!memcmp(cur_network->network.MacAddress, pbssid, 6) == false) {
+	if (memcmp(cur_network->network.MacAddress, pbssid, 6)) {
 		DBG_88E("Oops: rtw_check_network_encrypt linked but recv other bssid bcn\n%pM %pM\n",
 			(pbssid), (cur_network->network.MacAddress));
 		return true;
-- 
2.19.0

