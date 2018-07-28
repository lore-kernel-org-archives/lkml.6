Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB7DC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6238E2089E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 23:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PACld3af"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6238E2089E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbeG2Ab2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 20:31:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41869 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731476AbeG2Ab0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 20:31:26 -0400
Received: by mail-wr1-f67.google.com with SMTP id j5-v6so8705368wrr.8
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 16:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XsEOM3WYlBborInlGr0m9vtOOwA+QgE79gd6EbFytIg=;
        b=PACld3afLU1BkQrpJ9s9hrDB6feyJjq+lSKWNkIe78120VnSgofCxWWkEeZbphn1bG
         a9aPFPHksi6ELOcuuofW/0+OCr4dLgeKulm76LW5F9fn6xeHPeVGgT/wPpB49uE2Jcpt
         DLUckG1Pn2ojtzqwyYljIR8rj6cDpAC8U1GpqZsNDBvrJ52Boyuomi5skaYZsn5uxOJs
         6DDTAHFdYI9qVdDaIa0j9qmG8BYeX6zvwpROSv22XwskGvkZdgZORJXEdqrqN6cF7vCQ
         cZW4iw8MIqU53o3JXMtcPvDnUA2e7XZkZ8aSg+EMKgyQIftCg5SeivVcatxGdRehDqZV
         bdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XsEOM3WYlBborInlGr0m9vtOOwA+QgE79gd6EbFytIg=;
        b=KivFcPqLQoDXLDXKi3EzWlEcFahzHNAqbOjLGQ3cybsFch2iaBiAuYPhDz3FGU4zZA
         bDmuPed4ZWTODrtEwCDg9h3GTPfxLI1XxGSZzKlwbyPIojIV+n5KOf3/f4borLCtYKbz
         Fl5sCAM+5VAlO6GuikqmbSJJVIFfOMKq4Bo03TonK99aVYYS2os5iXh7EmXOShOatcdt
         CSSX8qvYuIgOnkMr4LI+sUa+Lq1nX/ZzglzAL7mDqgdy13ZC7r+gNHcHYr7d5joJCI4R
         hm1ITkikzAqn9Lbi3Ci8NmvvzCfhbQom/AL1sA79M4lTWei3JWOzG8u49EemMCVMrTQF
         pBHA==
X-Gm-Message-State: AOUpUlGWoU0twSsapY7HgGaUh1+jJ/HT1IgYaEUaN70IjQXE+ldGISBc
        K+Z0LuyqKWXZMYGflXJWJga2gv4T
X-Google-Smtp-Source: AAOMgpeZs4gxyDIQtUDk5Y5gCl5Ms/0Mw3FhkGhsJB8wxFjrW3grJ4lnIW6TJyNxw5qdT1WooNNHZA==
X-Received: by 2002:adf:bb08:: with SMTP id r8-v6mr10510208wrg.244.1532818996995;
        Sat, 28 Jul 2018 16:03:16 -0700 (PDT)
Received: from localhost.localdomain (host81-158-116-187.range81-158.btcentralplus.com. [81.158.116.187])
        by smtp.gmail.com with ESMTPSA id m207-v6sm11490569wma.31.2018.07.28.16.03.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 28 Jul 2018 16:03:16 -0700 (PDT)
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: [PATCH 08/12] staging:rtl8192u: Remove unused constants - Style
Date:   Sun, 29 Jul 2018 00:03:00 +0100
Message-Id: <20180728230300.19732-9-johnfwhitmore@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180728230300.19732-1-johnfwhitmore@gmail.com>
References: <20180728230300.19732-1-johnfwhitmore@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove defined constants from code, since they are never actually
used in code. This is a simple coding style change which should have
no impact on runtime code execution.

Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
---
 drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
index 17b676b0ed8b..810d81addcf6 100644
--- a/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
+++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_Qos.h
@@ -2,13 +2,6 @@
 #ifndef __INC_QOS_TYPE_H
 #define __INC_QOS_TYPE_H
 
-#define	MAX_WMMELE_LENGTH	64
-
-#define AC_PARAM_SIZE	4
-#define WMM_PARAM_ELE_BODY_LEN	18
-
-#define WMM_PARAM_ELEMENT_SIZE	(8 + (4 * AC_PARAM_SIZE))
-
 //
 // ACI/AIFSN Field.
 // Ref: WMM spec 2.2.2: WME Parameter Element, p.12.
-- 
2.18.0

