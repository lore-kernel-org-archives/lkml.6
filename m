Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73402ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AAEF20880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhyBMxXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AAEF20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388233AbeGWVxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:53:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44900 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388158AbeGWVxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:53:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id r16-v6so1969039wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CAC7B/Rx5KlCmpLtTLfSH3wIQ1eZvLn54mE3p9a4m3s=;
        b=nhyBMxXebxXDyW4OtI1uLUGJWOuoggS/N7DK17rz7lRRwElQbUFoC8bfG+Un877RR2
         GtFmfka56OD7qCmnX4S+1sYMB/M2KLevHaZUr4brSi3cdfiKUYejiumLmNNvZoOelA+a
         iqB0sK74I3iiKR3/Ejs+rkM6KKkzgIi0ljCqInRrq4F7u8P+JRPmUDO9lbb7WcqKP4iz
         OWSrazvI3whZOCx/ctc6k/qYxUY9rgpqJFBMe10fKj5ZK6d6VHWDFt/eZHHBrmZBUL+p
         iL738YFnrA5ew+ojrbBRE9PpDBdTYY0CUFTa7knKZvAPZaQzNcp+K9HtI7eOgLH18iuO
         6rHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CAC7B/Rx5KlCmpLtTLfSH3wIQ1eZvLn54mE3p9a4m3s=;
        b=UbgkZf5qR74QPLiJgmN0zWlt4TcF1oBhqfFU2NPLoWgCyooWhdli0i8XDBcS6eHYO5
         K4hdXrh+nwX1YLYWafAHO6yEBP/T6mKW861f13J0JN2qMvPhzx+Nj3VKdOOXi3Fkb8iA
         X2MwqTFezZ0E7TgiA9CPHQI16cGETZ+h5DT+o7K3qks6a6SpxYYg+t/NUSZUCn/t133v
         Myp04Z/E5vaqKCm9CCoPNoXUmpEUx/Ua4ta8tmA/UT3vUQxQr2Gf+JUZncPyYphHWuis
         LEQNh+V7COoRbhasA7DU7S396lviGWk8fWQPK9/xcqezT62Hn867tS/0Q1MnynCz7e8X
         VvgA==
X-Gm-Message-State: AOUpUlEm71kdaJFAAwNJRl5dfdjXobCxxTafH/pc7DLlnzX/415dP6Ys
        65LzjZZsJvv4RWU5GV1HIE03wHJM
X-Google-Smtp-Source: AAOMgpeYPJQOL9As135SrTpIsKNZiYuuzV7+mHl9XNTaw0YVgp3CeZtD1FBzGUlMjZLiYM2iAYuzVg==
X-Received: by 2002:adf:e687:: with SMTP id r7-v6mr10365312wrm.35.1532379047008;
        Mon, 23 Jul 2018 13:50:47 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id b123-v6sm14921874wma.24.2018.07.23.13.50.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 13:50:46 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 02/15] staging:rtl8192u: Remove unused enumerated type ACK_POLICY - Style
Date:   Mon, 23 Jul 2018 21:50:18 +0100
Message-Id: <20180723205031.19816-3-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723205031.19816-1-johnfwhitmore@gmail.com>
References: <20180723205031.19816-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The enumerated type ACK_POLICY is not used in code so it has been removed
from the source code. This is a coding style change and should have no
impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 45ba96a13b13..fb2745da5844 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -26,15 +26,6 @@
 #define AC_PARAM_SIZE	4
 #define WMM_PARAM_ELE_BODY_LEN	18
 
-//
-// QoS ACK Policy Field Values
-// Ref: WMM spec 2.1.6: QoS Control Field, p.10.
-//
-typedef	enum _ACK_POLICY {
-	eAckPlc0_ACK		= 0x00,
-	eAckPlc1_NoACK		= 0x01,
-} ACK_POLICY, *PACK_POLICY;
-
 #define WMM_PARAM_ELEMENT_SIZE	(8+(4*AC_PARAM_SIZE))
 
 //
-- 
2.18.0

