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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979BEC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B16B2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R6LWbX+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B16B2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbeIZBnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:43:46 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35506 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbeIZBnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:43:46 -0400
Received: by mail-ot1-f66.google.com with SMTP id j9-v6so25685370otl.2;
        Tue, 25 Sep 2018 12:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2AbTQUKv3pTYS7bOfJ4N+f/lUV/dJeu/kZekRIvspo0=;
        b=R6LWbX+bMkshLIdsnKH1ADbBJPvifPxd4rQI0qzhod9bUKy6OcjyI2iwjxxcngI+ks
         MKYcCGd8NgYkn8ifoDbDXS+QrYQr62R2jMvv85RS05y4MyQnVjvAoqOU7IC3MSWCRxA3
         5G4iQ0sSI6SiffTmEb80eFBGjV3h4fPMtZVS9eZyp+KeY5fKom1AkRAjR1H4Z9z3OMXT
         Um4H+EbG7YymqFxnQo2u+yHP5ol9H4k3XnqdRnwe3uuFZWsWs8F0XThQuQVN2/3ubCqH
         PxitgS/A+yOQ2iAQhv6PYq/iXZ9lFMhczkT7IHikF7c+9/2Lt9GP1YJS3dgOVB9hvvzQ
         8Q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2AbTQUKv3pTYS7bOfJ4N+f/lUV/dJeu/kZekRIvspo0=;
        b=K6Elc8lbSCNuzZfLPZxuimGGW1xuTG4ExdU1lEm1bRVq5csChsp8a0Tw0OQYr9FWdJ
         8/rb0/P2VNFhUWKSOsB+el7covROepeBOZ70ChBcALelw+x18U3doSzvfC47uSGACovk
         0qFSWTzCC1DpdIRfnCeknkSYm4NIZb9oo6HK0meLIVYtUEK8Y7SrbnF0dG/GMjemI1es
         avmdRB5lQnwUMZmedSiA1mIRettN5REZnC8HtpYPyNZX63QYPHVZG3/DDhLQjGK9eZ9u
         uQsuE1LmzFlFnUN8fU5MksTcBlFZD5GVP0x0A7qbIbteqMsqij3E09QcLecWLNlU9bUW
         EOZw==
X-Gm-Message-State: ABuFfoiDlPF9KH3TFDmMp0482ySJM0dbgfErCKD7JGUhzg0r4P6EYLV5
        NGwHb5EKendAlTs0OOFyA1c=
X-Google-Smtp-Source: ACcGV60flRnQjGqf5RvzzJJLLZAsq8xx1ZvXXC2S1jyxMydHNL1afEyb+X9azEqN1RcDDF60KCzuAA==
X-Received: by 2002:a9d:2de5:: with SMTP id g92-v6mr1868377otb.93.1537904077414;
        Tue, 25 Sep 2018 12:34:37 -0700 (PDT)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id q15-v6sm1049193otl.43.2018.09.25.12.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 12:34:36 -0700 (PDT)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
X-Google-Original-From: Stuart Hayes <stuart.hayes@dell.com>
To:     dvhart@infradead.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH 5/5] MAINTAINERS: Update maintainer for dcdbas and dell_rbu
Date:   Tue, 25 Sep 2018 14:34:18 -0500
Message-Id: <20180925193418.28493-6-stuart.hayes@dell.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180925193418.28493-1-stuart.hayes@dell.com>
References: <20180925193418.28493-1-stuart.hayes@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stuart Hayes <stuart.w.hayes@gmail.com>

Assign maintainer for dell_rbu driver, and reassign maintainer of dcdbas
from inactive maintainer (current maintainer is aware of this change--
see https://www.spinics.net/lists/platform-driver-x86/msg16336.html).

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
 MAINTAINERS | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ece30f15777..455b3fe6954e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4188,6 +4188,12 @@ M:	Pali Rohár <pali.rohar@gmail.com>
 S:	Maintained
 F:	drivers/platform/x86/dell-rbtn.*
 
+DELL REMOTE BIOS UPDATE DRIVER
+M:	Stuart Hayes <stuart.w.hayes@gmail.com>	
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/dell_rbu.c
+
 DELL LAPTOP SMM DRIVER
 M:	Pali Rohár <pali.rohar@gmail.com>
 S:	Maintained
@@ -4195,10 +4201,11 @@ F:	drivers/hwmon/dell-smm-hwmon.c
 F:	include/uapi/linux/i8k.h
 
 DELL SYSTEMS MANAGEMENT BASE DRIVER (dcdbas)
-M:	Doug Warzecha <Douglas_Warzecha@dell.com>
+M:	Stuart Hayes <stuart.w.hayes@gmail.com>
+L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/dcdbas.txt
-F:	drivers/firmware/dcdbas.*
+F:	drivers/platform/x86/dcdbas.*
 
 DELL WMI NOTIFICATIONS DRIVER
 M:	Matthew Garrett <mjg59@srcf.ucam.org>
-- 
2.19.0.221.g150f307af

