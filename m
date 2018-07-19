Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0896C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824812084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0sAPYcK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824812084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732018AbeGSRVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 13:21:03 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38065 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731839AbeGSRVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 13:21:03 -0400
Received: by mail-pg1-f194.google.com with SMTP id k3-v6so4249462pgq.5;
        Thu, 19 Jul 2018 09:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=/jlu4MmIdp+EOK5XWMB3wRQZ+hjKKPG5sAGg36rKF2g=;
        b=M0sAPYcKf4JNsRDypz8OYRnfO0uO/H6WX3ZR2exR8zoorYgR+WDAiV/YgBAHFUyDnN
         nwxHM9sisy+YrPyTm2XILmjYljb4gsNZsRe/+oTMR1YvxdcaYOEdVd35TR4XF4DVgZXS
         gQDtsbboNEqlfKKk04hIYa8UQzRKCFTuZTo9VAzgd8+sUJMY9kt5FjLxorjMdt5OqJiZ
         //zF4XtJ7shYLGQb8JdaigrKDbhU9jlxOCHoY8HGVtsIRbvXsw0DIbo9BUTzD8V9mWx8
         +0XuyqC/QF5A3unxPenBrEEgBNSwusZK2iKfuxSZrrk7MyiBld/EDin55IDkObQ1W3R6
         SBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/jlu4MmIdp+EOK5XWMB3wRQZ+hjKKPG5sAGg36rKF2g=;
        b=fRXQbdWzh6tUjDgM4Gi+nvdfOuBVnQu0/rxxY6tc7JmvIkjfJL2nl5hVz30ENYW/eL
         wYe+2IXmzbskeHec9hX42WfblsTk5An8KWgKONby3MlD5GHpkzoSTFlkPQKrKx9GzyVf
         Wg8gm9DUeBdJWBxF8K+2FS6Qy+spx2FGtaVHx6NrF4lmZXD+w6tPpIzmTom7wzgsYHyA
         T4urAClUWg7Nga+o3VT4z3H5dMgSYTotrNjKc7ZRGt/LCvzzkxZGD/r382NsoDtRjN8Y
         VjCtJgdAf8b6EjV9fkfYlTBUdu/GYNXaJoyk7qjAZEZ2sTqY+AcDPBTT3kBYXvA826p/
         QREA==
X-Gm-Message-State: AOUpUlE8CoCmcMWJ6b6OMh/xrGv1Gdod6RlJDr14UKfWENC0tTANi15o
        IPt0gKVtK9MlZP758M4vAwBIri2Ms7NlzQ==
X-Google-Smtp-Source: AAOMgpd0Z3iqpBMpKYrjNnaIPylfY73KQwTOhVsVss0ZrtfLwLIySv5SFEh0vhW20llVpdC2zF+irg==
X-Received: by 2002:a65:4888:: with SMTP id n8-v6mr10860794pgs.149.1532018225095;
        Thu, 19 Jul 2018 09:37:05 -0700 (PDT)
Received: from siddaraj-MOBL.gar.corp.intel.com ([192.55.54.45])
        by smtp.gmail.com with ESMTPSA id 14-v6sm12578525pft.93.2018.07.19.09.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jul 2018 09:37:04 -0700 (PDT)
From:   Siddaraju DH <siddarajudh@gmail.com>
To:     john.stultz@linaro.org
Cc:     tglx@linutronix.de, corbet@lwn.net, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Siddaraju DH <siddarajudh@gmail.com>
Subject: [PATCH] timekeeping.txt: Correct maxCount of n-bit binary counter
Date:   Thu, 19 Jul 2018 22:06:51 +0530
Message-Id: <20180719163651.19360-1-siddarajudh@gmail.com>
X-Mailer: git-send-email 2.15.1.windows.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A n-bit binary counter can count a maximum of 2^n events and the count
value ranges from 0 to (2^n)-1

Signed-off-by: Siddaraju DH <siddarajudh@gmail.com>
---
 Documentation/timers/timekeeping.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/timers/timekeeping.txt b/Documentation/timers/timekeeping.txt
index f3a8cf2..2d1732b 100644
--- a/Documentation/timers/timekeeping.txt
+++ b/Documentation/timers/timekeeping.txt
@@ -27,7 +27,7 @@ a Linux system will eventually read the clock source to determine exactly
 what time it is.
 
 Typically the clock source is a monotonic, atomic counter which will provide
-n bits which count from 0 to 2^(n-1) and then wraps around to 0 and start over.
+n bits which count from 0 to (2^n)-1 and then wraps around to 0 and start over.
 It will ideally NEVER stop ticking as long as the system is running. It
 may stop during system suspend.
 
-- 
2.7.4

