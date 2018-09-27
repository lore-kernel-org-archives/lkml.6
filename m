Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A6AC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2ED82170E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 22:28:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZ1uogw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2ED82170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbeI1EtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 00:49:09 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36776 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbeI1EtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 00:49:09 -0400
Received: by mail-wr1-f66.google.com with SMTP id l10-v6so4297242wrp.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 15:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yTBXIHltE4t0vT1BdNbfQcRDNDxJHiRQEbIUATmrrU4=;
        b=lZ1uogw6XeE+iMbKuicD9lJIwQQH0bMixk8L1P/sKiKy6ce1Lkd37OSmVb0BTef5Lv
         5n27v4hODuowhWESTVo+MjFPzWf5pQoVIlSTsxkYFen2mRY6FsS+nkKAjFn0Cnq3FSVK
         6olxieBj2VPtiymYNV8bXl1OjSoS0AXwV9MPb60feQEz5yCHKXp2Bb5z00s6Zt/UqHWu
         sNZQSHPmYA9GeA9/BvJbWrtnscHji1RBLU9/+Pt7MGUKpPQ9/5Fu3zD2hLL1QRtW6Xit
         bH3plLG6F8stEEkGDWYGm7HGy+5FzjwyBs6KM+6YxEopYm54UEwsAT4hGdVdPtZGurVF
         DU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yTBXIHltE4t0vT1BdNbfQcRDNDxJHiRQEbIUATmrrU4=;
        b=i3DqJ9ghWUBmBNvf5oZLDLy7Wvch4hcJ3zWUHNw20nNIZ+ctW32vuiH1kZ9FxcEp8F
         MRtpykbbg6d3YSClClazx/g9o/bH0eUzMqYk2F5mHMbu5Vz4AbWM3VBCq/FBVDs4YqQ0
         +ycHH6gEvJCw8IR3LKIj6ODYZ9lqCjupLXdEao1sHLlVWK+Omyz7ANcGabeqcRG252Sb
         7qmJbCOFOWlWS8BvRZTnC+kEKHw+qxs5Xb+spjbAxelLpls45qk9pc0FV/Hh5KMERb7D
         YSQlmICpNjqHwGcSn//wWAfCbJE4WcoU/2RW0ZCbEyhd0ys9ZyRTGojp8YXQi7kcmhEQ
         SSmg==
X-Gm-Message-State: ABuFfogEP5ILpQcr9feVPJwsHgHSsk0TMyIXjXDdZVXY24zly7YJrDVq
        ADqpW4sUy0p5EjlPn2n8gOo=
X-Google-Smtp-Source: ACcGV62mGFZS7WcXLlC4PLCuR05zClJxWyz3K2aHLQBL0ENXtJtQx2ZM0gnQiItj6yLtXrq6e4soFw==
X-Received: by 2002:adf:f391:: with SMTP id m17-v6mr10669292wro.279.1538087317458;
        Thu, 27 Sep 2018 15:28:37 -0700 (PDT)
Received: from localhost.co.uk ([2a01:388:3ce:110::1:5])
        by smtp.gmail.com with ESMTPSA id f69-v6sm232968wmf.34.2018.09.27.15.28.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 15:28:36 -0700 (PDT)
From:   Aymen Qader <qader.aymen@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Aymen Qader <qader.aymen@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: Skip unnecessary field checks
Date:   Thu, 27 Sep 2018 23:28:14 +0100
Message-Id: <20180927222814.11370-1-qader.aymen@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip unnecessary request field checks when the information element
pointer is null.

Signed-off-by: Aymen Qader <qader.aymen@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index bf055935ef65..69c7abc0e3a5 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -1267,13 +1267,12 @@ unsigned int OnAssocReq(struct adapter *padapter, union recv_frame *precv_frame)
 	/*  checking SSID */
 	p = rtw_get_ie(pframe + WLAN_HDR_A3_LEN + ie_offset, _SSID_IE_, &ie_len,
 		pkt_len - WLAN_HDR_A3_LEN - ie_offset);
-	if (p == NULL) {
-		status = _STATS_FAILURE_;
-	}
 
-	if (ie_len == 0) /*  broadcast ssid, however it is not allowed in assocreq */
+	if (!p || ie_len == 0) {
+		/*  broadcast ssid, however it is not allowed in assocreq */
 		status = _STATS_FAILURE_;
-	else {
+		goto OnAssocReqFail;
+	} else {
 		/*  check if ssid match */
 		if (memcmp((void *)(p+2), cur->Ssid.Ssid, cur->Ssid.SsidLength))
 			status = _STATS_FAILURE_;
-- 
2.17.1

