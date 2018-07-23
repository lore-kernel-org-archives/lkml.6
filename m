Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001E1ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFC120875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 20:52:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrQoblpY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACFC120875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388319AbeGWVzC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 17:55:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38424 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388054AbeGWVxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 17:53:47 -0400
Received: by mail-wr1-f66.google.com with SMTP id v14-v6so1997487wro.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 13:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UFekeI44osU5U79EV9VIkAYwZ8wovxZtzV8MfSYG+B8=;
        b=DrQoblpYn56aY46SxqW1EJDYy1gLcpy/VpL4SfPu0qGlIBghGGxFvGK7UdWy4oQrFl
         2PkYbauWGPGBVsFmwVxdoob3GsTlSP5iG27kmElMRgaz2qXxBTOa1FsFhUwY/sNHfSBK
         /jmDsNU3CLNsNVULmDELkX01dDT4E1IRtGX4EuEYqhPZt0WMCHpgpEh0ygc4Dq7JOWoN
         pTa3BqSb7w6N4KGWoENKUdmRbaiMo69CypoNHV9Wi7iaNNTyLUw15DLOXrHODWpEjdwb
         5pK+FEMf5hEL4xf6+LOvBu/EIDY693EBLZp2SL/GsS2wA1/yQR7E51bUoM0nl9kaYnV5
         ACJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UFekeI44osU5U79EV9VIkAYwZ8wovxZtzV8MfSYG+B8=;
        b=NW3tM8CZefafZTtbuPxFOj55FCS+dakReW9Wld52L0HiesGnBAlLPpfEsaceI29t4k
         bhfg6ae2U4zfe8KfQQmPx9O7ppHBOkj9curCSq9UUhJak6Jcox2W0xY7VVgpts2Ifo6A
         m39kE0NGJM2c2rweEdVhYd3zvz+17sAoP8G8w+q97jRs7xcIONc2n2zvfrBrMcc6WoNT
         joffTplRTaneSjqWcmd4TZ2t4J+gpWmOAZhrDXA/29prpC+w9Xs+y+8EkxVEyZ8xviIt
         ysiqf/vmaJxerOWV7IUPar/GLU2T5cpRsFKezXHW7SPLEVM6eqOq0m9f2safn8wCRSmi
         TaVw==
X-Gm-Message-State: AOUpUlHrgsmxSuk68uYYzbtE4UPkRNIPGYxayhaVkYIbbqKXFHGponQS
        yDicmgqkia2QIlrZaRBSsq5vWjq8
X-Google-Smtp-Source: AAOMgpfikILwiXhL2bF/Ik2pIUhpEhc6duLtto3NWZLq8K9bjqOy/ksFcn69I+e2kJo/lv2xPPqNkg==
X-Received: by 2002:a5d:528f:: with SMTP id c15-v6mr9606192wrv.102.1532379048488;
        Mon, 23 Jul 2018 13:50:48 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id b123-v6sm14921874wma.24.2018.07.23.13.50.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 13:50:47 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 03/15] staging:rtl8192u: Remove unused QOS definitions - Style
Date:   Mon, 23 Jul 2018 21:50:19 +0100
Message-Id: <20180723205031.19816-4-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180723205031.19816-1-johnfwhitmore@gmail.com>
References: <20180723205031.19816-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unused QOS related types.

Since definitions are not used simply remove from code. This change is
a coding style change and should not impact runtime execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 .../staging/rtl8192u/ieee80211/rtl819x_Qos.h  | 22 -------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index fb2745da5844..a83abaf3a2ea 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -4,25 +4,6 @@
 
 #define	MAX_WMMELE_LENGTH	64
 
-//
-// QoS mode.
-// enum 0, 1, 2, 4: since we can use the OR(|) operation.
-//
-// QOS_MODE is redefined for enum can't be ++, | under C++ compiler, 2006.05.17, by rcnjko.
-//typedef	enum _QOS_MODE{
-//	QOS_DISABLE		= 0,
-//	QOS_WMM			= 1,
-//	QOS_EDCA			= 2,
-//	QOS_HCCA			= 4,
-//}QOS_MODE,*PQOS_MODE;
-//
-#define QOS_DISABLE		0
-#define QOS_WMM			1
-#define QOS_WMMSA		2
-#define QOS_EDCA		4
-#define QOS_HCCA		8
-#define QOS_WMM_UAPSD		16   //WMM Power Save, 2006-06-14 Isaiah
-
 #define AC_PARAM_SIZE	4
 #define WMM_PARAM_ELE_BODY_LEN	18
 
@@ -506,14 +487,11 @@ typedef struct _BSS_QOS {
 	AC_PARAM		AcParameter[4];
 } BSS_QOS, *PBSS_QOS;
 
-
 //
 // Ref: sQoSCtlLng and QoSCtl definition in 8185 QoS code.
 //#define QoSCtl   ((	(Adapter->bRegQoS) && (Adapter->dot11QoS.QoSMode &(QOS_EDCA|QOS_HCCA))	  )  ?sQoSCtlLng:0)
 //
 #define sQoSCtlLng			2
-#define	QOS_CTRL_LEN(_QosMode)		((_QosMode > QOS_DISABLE) ? sQoSCtlLng : 0)
-
 
 //Added by joseph
 //UP Mapping to AC, using in MgntQuery_SequenceNumber() and maybe for DSCP
-- 
2.18.0

