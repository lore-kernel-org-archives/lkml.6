Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 926A8C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5965A2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=opperline.com header.i=@opperline.com header.b="o3950JQX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jBXEReS4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbfAWP1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:27:55 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:52305 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725966AbfAWP1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:27:55 -0500
X-Greylist: delayed 594 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jan 2019 10:27:54 EST
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id DDB48210EC;
        Wed, 23 Jan 2019 10:17:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 23 Jan 2019 10:17:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opperline.com;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=4MQIq4m5mDDy796UE66NFX5ciW
        s6wmlNyOxv/JDv1YA=; b=o3950JQXapjLpYFD99b+/W/YUIzxMZ8LLeS+z5X9Yq
        ueG8YIPgnyPS+/EgIdbU4KfgCApx99X1DXpsRZLbhRowlCq5Cx4mcBrZV7t67c6H
        0dNF4oz9t+sQOaj5ANtudvDbanye9OW1Na47915JRPdMAvKNsmdP4FjozqP49RaR
        pjgex9TCQWFC2BV9nZEI+yLDoBtK4ofQ8xvAMHiSBP7bKNEmDHDiz8QNzMKpBnZM
        sEHtPNqyEWrit3THTY0p5UGFWsIbUORcewGwDMC/PG3qfExvTzZlalZV4eCHv7Qh
        v/LhbGtkEdFsYcB8r7EQ/fY/zolKI5Xp1ZoANDleel5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=4MQIq4m5mDDy796UE
        66NFX5ciWs6wmlNyOxv/JDv1YA=; b=jBXEReS4XMYExHv+MCBBuXzVjNgj8LFOY
        nc15LbbY+NufSivTb1SahIemLOAwyfJVUeOi0yfUH01QPcKz/Ehx1/fe3gbDfVF/
        3daDh5bC0Px2fTRe7iucHQ9SgdlDWn0lzUHANFMEWV8sGjxlo+7o5Amqx38xSKrR
        f0bDhjreSzH+50pbidDYt5gdTArGvHcKyFIEzwZIVyl2cO/KiG1Y9xIMZ6nv3tKz
        qlegYWkjuQS8K6muK06ZCSouuKuaGYDWYdx3hoWgQJbmyotUubzID991d4TcQ2Yc
        PkJompk3guvo+4IXEo//LhsR5nN/d5DVXjWl79VqkteL2Ue72Arpw==
X-ME-Sender: <xms:poVIXN9skuy5Bu8lngb5tp5yZyICA1o7PISUJhxJDAPKg5ET8-o3zQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledriedtgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecufedt
    tdenucenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvg
    hphhgvnhcuofgrrhhtihhnuceolhhotghkfihoohgusehophhpvghrlhhinhgvrdgtohhm
    qeenucfkphepjeefrdehledrheekrddutddtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hlohgtkhifohhougesohhpphgvrhhlihhnvgdrtghomhenucevlhhushhtvghrufhiiigv
    pedt
X-ME-Proxy: <xmx:poVIXF-q4ai4J_o0VvJChyRRc4UHepmHcGHVSO4gdYgJI8WHbB83HA>
    <xmx:poVIXGDRZdryVc-6bpFHCVjaBA2DFew5po727FmpHUyE1biyP8FTMw>
    <xmx:poVIXFxv9cqBe3DRTMT-nZxXe4Jj48qdpSl0qNawaXUc-yhOUBaQ-Q>
    <xmx:p4VIXL0_dhrgnsvUVYedaKMl-11OtneQRHSLeloEaVQp5RGKIqYD8Q>
Received: from localhost (c-73-59-58-100.hsd1.wa.comcast.net [73.59.58.100])
        by mail.messagingengine.com (Postfix) with ESMTPA id 29AB9E49B4;
        Wed, 23 Jan 2019 10:17:58 -0500 (EST)
From:   Stephen Martin <lockwood@opperline.com>
To:     Larry.Finger@lwfinger.net
Cc:     gregkh@linuxfoundation.org, straube.linux@gmail.com,
        santhameena13@gmail.com, bhaskar.kernel@gmail.com,
        lockwood@opperline.com, natechancellor@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtw_ieee80211: fix constant comparison warning
Date:   Wed, 23 Jan 2019 07:17:14 -0800
Message-Id: <20190123151714.6006-1-lockwood@opperline.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed comparison on right side of test warnings.

Signed-off-by: Stephen Martin <lockwood@opperline.com>
---
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index 5c4ff81987bd..8439d0b84a76 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -927,7 +927,7 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 
 	if (pbuf && (wpa_ielen > 0)) {
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s: wpa_ielen: %d", __func__, wpa_ielen));
-		if (_SUCCESS == rtw_parse_wpa_ie(pbuf, wpa_ielen + 2, &group_cipher, &pairwise_cipher, &is8021x)) {
+		if (rtw_parse_wpa_ie(pbuf, wpa_ielen + 2, &group_cipher, &pairwise_cipher, &is8021x) == _SUCCESS) {
 			pnetwork->BcnInfo.pairwise_cipher = pairwise_cipher;
 			pnetwork->BcnInfo.group_cipher = group_cipher;
 			pnetwork->BcnInfo.is_8021x = is8021x;
@@ -940,7 +940,7 @@ static int rtw_get_cipher_info(struct wlan_network *pnetwork)
 
 		if (pbuf && (wpa_ielen > 0)) {
 			RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("get RSN IE\n"));
-			if (_SUCCESS == rtw_parse_wpa2_ie(pbuf, wpa_ielen + 2, &group_cipher, &pairwise_cipher, &is8021x)) {
+			if (rtw_parse_wpa2_ie(pbuf, wpa_ielen + 2, &group_cipher, &pairwise_cipher, &is8021x) == _SUCCESS) {
 				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("get RSN IE  OK!!!\n"));
 				pnetwork->BcnInfo.pairwise_cipher = pairwise_cipher;
 				pnetwork->BcnInfo.group_cipher = group_cipher;
-- 
2.20.1

