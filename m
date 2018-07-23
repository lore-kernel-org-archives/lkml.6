Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E22ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 121D320875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ocq70fPE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 121D320875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388206AbeGWVya (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:54:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33257 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728303AbeGWVx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:53:58 -0400
Received: by mail-wr1-f66.google.com with SMTP id g6-v6so2017352wrp.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V9mCIKX0VYzvVeuZOUIZ9yRaJXtaF5GpmPegfuAEMB8=;
        b=Ocq70fPEId1raX58kbyWVpRhZZwgVB640nbYjrFUf5MkMGFDH/fcMm3PrgLLhEmV61
         oM3wkO8XXRy0+Nlk7dCVTrYkvOL+o0+HFEuXQjljxY5Q9HzAoz9A7L2ZhB9Uawlm4xF7
         5FzUZNaMSKJR4pVgroqWWgGTT6lqjP7xI4+Bzgk1EPSK8k3qPW1tzgyA2gcuEd6abSJ+
         K8T4tm7Igc0RsniSh/y0DxtzNygKiKlp9u+FBH38Q1dhuesxMlajxHr5lMbSW/qY/h/9
         gxufjJqLtrJBmV0yRfeZ2Fdb557xtd+SbZmT+zl/H+DCKszTnFYStre6CfpYyIUdS21q
         Z53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V9mCIKX0VYzvVeuZOUIZ9yRaJXtaF5GpmPegfuAEMB8=;
        b=uL5lC4BMX2DxfARJCLsrNhX69zSKRE6tuZxHJqBRdoG7eg+zAUS8ACT3v/qp5O3NoT
         K377Q8AHH0HRJWzMu1+1y/hDnewZ9hpeRX0lfkKOemC9C3OHdbC4Vx3aRek4VdFNEWj2
         yIQfwSQZoJ2v/E5P3j8y9kPcpa+L4lOqGUdkuD7/esryIDdeHZvd1CvbuQ+CyisxcIEu
         kWtQQvMh74Empgbeydo9QA+SYpD7T3SoAUPKYb7I7opvFlbsi/W+/yyLQpIp30VgzQLZ
         u01Iz+YN8i4R0+cqCvA/CFMKfFG1ngQPCCBvMQo1Qhb0CPDBTmH7xfem4Z5wloKQ6kpk
         KVTg==
X-Gm-Message-State: AOUpUlFxZcGxU5s/ISvSWa8I/M2UAhgYAKuavhBu4txRZwK5VmKyOVqW
        G7xqn0V1n9ZyDMxp+ncv9x8C8d/0
X-Google-Smtp-Source: AAOMgpfo1w0s9qGlbe0TWwK8QOuJf808argIjS26KocR2z4DkJ2ujs2XqTrMo1IGAJ8ciOej/A23ng==
X-Received: by 2002:a5d:540d:: with SMTP id g13-v6mr10192079wrv.4.1532379059161;
        Mon, 23 Jul 2018 13:50:59 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id b123-v6sm14921874wma.24.2018.07.23.13.50.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 13:50:58 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 10/15] staging:rtl8192u: Remove unused structure QOS_TSTREAM - Style
Date:   Mon, 23 Jul 2018 21:50:26 +0100
Message-Id: <20180723205031.19816-11-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723205031.19816-1-johnfwhitmore@gmail.com>
References: <20180723205031.19816-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The structure QOS_TSTREAM is unused in code so has simply been removed.
This change is a coding style change and should have no impact on runtime
code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 6cfae00919c1..7028c9ae888a 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -214,17 +214,6 @@ typedef union _QOS_TCLAS {
 	} TYPE2_8021Q;
 } QOS_TCLAS, *PQOS_TCLAS;
 
-//typedef struct _WMM_TSTREAM{
-//
-//- TSPEC
-//- AC (which to mapping)
-//} WMM_TSTREAM, *PWMM_TSTREAM;
-typedef struct _QOS_TSTREAM {
-	u8			AC;
-	WMM_TSPEC		TSpec;
-	QOS_TCLAS		TClass;
-} QOS_TSTREAM, *PQOS_TSTREAM;
-
 //typedef struct _U_APSD{
 //- TriggerEnable [4]
 //- MaxSPLength
-- 
2.18.0

