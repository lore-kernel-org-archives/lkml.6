Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E523C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163432184A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 15:42:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cPvxVP7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbfB0PmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 10:42:09 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33875 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbfB0PmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 10:42:08 -0500
Received: by mail-pf1-f195.google.com with SMTP id u9so8199109pfn.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 07:42:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJNugc1NTgYYdb5UViX76gCmsQvatL4KiSDmwNGbPGU=;
        b=cPvxVP7uSagRtRNC11x6kh1FFac8bvNKj/8ainmTINUJ//2VXdwJZ2zsG4Zvo94A7S
         PEIQn3gEGXsv96XZjLAbkPLtllnNCFoTYfqvuC9VZTA1Q7PjrqJ6q14+dL2VJKJKlXlo
         95+ijkf8PljDaRqjPwe515EbfmbBPSy5VA+jGy5OqjW/bTtW23GIxzfhUgUftRJH8twV
         ALJHajNuGkR7HZFz1GGfe+krJiX76QOC/rmMvLBTrJNoDjJeCkTduRf0q5bBzvhdjPZy
         jHzQCiV8n1JtTZW0YXWN+DcDCqlJLsFebQ8TLJgTxjm06T+pf9w+kjMoLnzE5QT4i5vf
         OQSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJNugc1NTgYYdb5UViX76gCmsQvatL4KiSDmwNGbPGU=;
        b=Jrl8klPhiKT5alWXD8j3LYOqL0vpHCJDc8b9vefcvN3PiNj/4nWWbcpAKFfNhx8R+L
         HD+GMhC05jFh6wzJ730iZGtUZKkytushrVnHE16rIQzZz4NxMkuHKdEN1TX83el/tuSB
         /b/4KWgQcg8Bi9qLf0Uj4ZcL1W7XEtifZhLJicqw7ry15jrCWlipeylJVQB5ujFVJn+u
         GiqPpZmc3h4iPDUZ9vNjHCC6yjcLFpj+6P17WJd1itkWZNRpzulDCoTiwete40gRp5M8
         +yQwDhmkCmWAdR1OPrmjpwTM2OChMreHN8hvY0qPxsLOfMOEHA7yzaZVa3CNEz4CHrOI
         TCMQ==
X-Gm-Message-State: AHQUAua2vRTm16OqZZg4Ck2shWYVfO9i0L69pXr77gDmpdxFMO5vWM0A
        /fnDu6JQblMK4czaikRo+JaXkRvr7nROag==
X-Google-Smtp-Source: AHgI3IbAnl//3EWoam7U7tIwP3NaOaKIff04avQK09am3GET25aC2L9oGJ/gwy/Oe6CoORsAq9Op6g==
X-Received: by 2002:a65:4784:: with SMTP id e4mr3527753pgs.12.1551282127674;
        Wed, 27 Feb 2019 07:42:07 -0800 (PST)
Received: from localhost.localdomain ([49.207.50.127])
        by smtp.googlemail.com with ESMTPSA id 23sm32904982pft.187.2019.02.27.07.42.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 27 Feb 2019 07:42:06 -0800 (PST)
From:   Prashanth Kumar KR <prashanthkr8@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Prashanth Kumar KR <prashanthkr8@gmail.com>
Subject: [PATCH] staging: rtl8712: fix indentation issues
Date:   Wed, 27 Feb 2019 21:11:55 +0530
Message-Id: <20190227154155.10770-1-prashanthkr8@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix indentation warnings reported by checkpatch

Signed-off-by: Prashanth Kumar KR <prashanthkr8@gmail.com>
---
 drivers/staging/rtl8712/ieee80211.c    | 3 ++-
 drivers/staging/rtl8712/rtl871x_recv.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/ieee80211.c b/drivers/staging/rtl8712/ieee80211.c
index 2eae11dd6b42..4cca7390c8ef 100644
--- a/drivers/staging/rtl8712/ieee80211.c
+++ b/drivers/staging/rtl8712/ieee80211.c
@@ -238,7 +238,8 @@ unsigned char *r8712_get_wpa_ie(unsigned char *pie, uint *wpa_ie_len, int limit)
 	return NULL;
 }
 
-unsigned char *r8712_get_wpa2_ie(unsigned char *pie, uint *rsn_ie_len, int limit)
+unsigned char *r8712_get_wpa2_ie(unsigned char *pie, uint *rsn_ie_len,
+				 int limit)
 {
 	return r8712_get_ie(pie, _WPA2_IE_ID_, rsn_ie_len, limit);
 }
diff --git a/drivers/staging/rtl8712/rtl871x_recv.c b/drivers/staging/rtl8712/rtl871x_recv.c
index 0271ccf25f25..28f736913292 100644
--- a/drivers/staging/rtl8712/rtl871x_recv.c
+++ b/drivers/staging/rtl8712/rtl871x_recv.c
@@ -404,7 +404,7 @@ static sint ap2sta_data_frame(struct _adapter *adapter,
 		if (bmcast)
 			*psta = r8712_get_bcmc_stainfo(adapter);
 		else
-		       *psta = r8712_get_stainfo(pstapriv, pattrib->bssid);
+			*psta = r8712_get_stainfo(pstapriv, pattrib->bssid);
 		if (*psta == NULL)
 			return _FAIL;
 	} else if (check_fwstate(pmlmepriv, WIFI_MP_STATE) &&
-- 
2.20.1

