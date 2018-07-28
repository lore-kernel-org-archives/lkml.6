Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B252C6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525CF20842
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPd9Q7uo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 525CF20842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbeG2AbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:31:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36852 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731559AbeG2AbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:31:19 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9-v6so8724911wro.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 16:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1FdxKaBA9biXmuwgATGI2n1vN+fQJCeFueRVKSiXXyU=;
        b=GPd9Q7uo6lSU4HFADsN/GsH6RIq/5UtS3xa+qAxZwa3ARFuGQyUGkYWWVctKuM/Kod
         OOCSz3avypGf8jI14IJzz2HSBqIxeKNVjN+Z+qh8KCvRfTbcMULsg5OCU2aPClIcgzbB
         M/GtvvLFfrMxk1etmPmVpZUzGvkIPk/pw4TvLztBzXmKj190McDqthBGYWXxn246j6c+
         tQoouTieQTq1Wi0QwK60vIdELQp6MD4oe8yVpE6u07LqzIGb/sMlv+myPq8c8zD8hZ1v
         DUXNKrjOGn2VNs0eyQBMc2TayCj2kU4n7YNDZB/ZjwRLAjKN58jea9Whh8FSqaasybLy
         KaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1FdxKaBA9biXmuwgATGI2n1vN+fQJCeFueRVKSiXXyU=;
        b=BxGX0FpDVxWMjhubUh3R61nsHG2ZQgp8CLFajubbBi0yKN36NkiANL6KpXnCbcQVnm
         4wdqZDFlN+NfSMdonraplkioPUvUO36KTal0ameoOAdDO1af5XmQKHb3taNOx6ZFZ2ZM
         XZD2X/+lXzHnErW+JaThfPhOJmQUF2QmSZOsz+bYOOT0Pjtp0e3P89eg/El1GVWa7Wo2
         y1vsgKtQ6fzRTrMMCkeUMJ2DZZVyWPybfYndQV64jgRnHBM0n3EtkH+pSSah9UJaDCJH
         ak+sHhcW23DicrTnHZCPyaiBKJn2V2p/R+ZoguMtOGgWvHSva87FDEUveEhTH4iEj4Ui
         /58A==
X-Gm-Message-State: AOUpUlEzMzNTF59YhjuQDsQ7s18oJ/2yWYuoomYpFq7DIwI6pTKn0hIS
        UK5eASQIEsg3JCgul8yX40kdZnYg
X-Google-Smtp-Source: AAOMgpc8MCkrKZlnM3cWo9XAoifNfGwP7mNslGpdYTtxyMHdVWC5Ga5eA4MyPDG/4sqbQ8gaFhkYDg==
X-Received: by 2002:adf:9d1c:: with SMTP id k28-v6mr627368wre.29.1532818990036;
        Sat, 28 Jul 2018 16:03:10 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id m207-v6sm11490569wma.31.2018.07.28.16.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:03:09 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 03/12] staging:rtl8192u: Rename member variables - Style
Date:   Sun, 29 Jul 2018 00:02:55 +0100
Message-Id: <20180728230300.19732-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180728230300.19732-1-johnfwhitmore@gmail.com>
References: <20180728230300.19732-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename the member variables of union aci_aifsn, which should be named
in lowercase. The only member variable, of this union, which is
actually used is 'acm'.

This are coding style changes which should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 10 +++++-----
 drivers/staging/rtl8192u/r8192U_dm.c             |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 5856bf87c5dc..901b85139d3b 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -14,13 +14,13 @@
 // Ref: WMM spec 2.2.2: WME Parameter Element, p.12.
 //
 union aci_aifsn {
-	u8	charData;
+	u8	char_data;
 
 	struct {
-		u8	AIFSN:4;
-		u8	ACM:1;
-		u8	ACI:2;
-		u8	Reserved:1;
+		u8	aifsn:4;
+		u8	acm:1;
+		u8	aci:2;
+		u8	reserved:1;
 	} f;	// Field
 };
 
diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
index 04c08ca8a0bb..7dc912dd53af 100644
--- a/drivers/staging/rtl8192u/r8192U_dm.c
+++ b/drivers/staging/rtl8192u/r8192U_dm.c
@@ -2338,7 +2338,7 @@ static void dm_check_edca_turbo(
 
 				read_nic_byte(dev, AcmHwCtrl, &AcmCtrl);
 
-				if (pAciAifsn->f.ACM) { /*  ACM bit is 1. */
+				if (pAciAifsn->f.acm) { /*  acm bit is 1. */
 					AcmCtrl |= AcmHw_BeqEn;
 				} else {	/* ACM bit is 0. */
 					AcmCtrl &= (~AcmHw_BeqEn);
-- 
2.18.0

