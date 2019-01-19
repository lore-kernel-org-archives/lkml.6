Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EB5C61CE3
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E66D02086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 00:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="ECJqMrzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730260AbfASAM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 19:12:56 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41334 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730202AbfASAMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 19:12:51 -0500
Received: by mail-qt1-f193.google.com with SMTP id l12so17183465qtf.8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jan 2019 16:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SAuIFgVpW37RZZ1WH4D7tVeEC8yoaQHwn0FsTHDsXEs=;
        b=ECJqMrzUAW/ndBvP11sS46URJwX1QvujnyWdZI69fhkT6satXKdTPZ4WUiCeRDSkkG
         wkRLC2z8w4W2DEurvNQXcph+xmMhuxp40ygyE80IRKfQ3SXI3guWbIts2YhDajq7g656
         4ukDrkfUHtYTu1q7bm4qVDMiNdhTVryCF4Ip96gothQLowxoPUfa/m/mI0TTISDRPx1Z
         WsXSsPyELkj8WCp1tm5ugwQ5ZADXq35l4ZqoBTwg1SpJ6e3GxRo24EAU7MUKr5rLx322
         t6Rket1CWFZdiS7QybX6K/DeOm8Dj7mE8fZU+wuL0FwgQVasbPNuULKgWhZhQ8VSKdx0
         zX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SAuIFgVpW37RZZ1WH4D7tVeEC8yoaQHwn0FsTHDsXEs=;
        b=ued3HYAP0Rsxk6fBCRBC4glSZy1B6yhpMyw2OkLaTEwIRuaS7cKWXzBBrGYRztCkGQ
         caEAMvyDiIyCiRY6XcZZWOMzjrzMJq6gJRf/WHsDgrxhBkH5zsU5NzBWJnw0fJfHPgoX
         p+nYva2UU9BJEOk3TYITpztYYfQknWwLpZd3Uce5Jq+bd7AJHiGlSYZdH6d+Cg7JySSY
         1sqQcwr8+ajcAOsPjCimT39/lRW86R0GkfcwobZV+Trhv1/N9Rp17I7Jj9H1froHH+LV
         mngSotlDGuHFeBjWrgjtF/+CZJgq3Ebzu2zbj4aVcPLWPse/Z5zBBZ35TzVygh4/Wk6g
         rWKA==
X-Gm-Message-State: AJcUukcms146UHuOjh4q6EJty1a2WJkqHGF7jhmtT7m8fK/NuKl8w4Cm
        ChENEt8ze7Xvn96CUyT8vVkAVQ==
X-Google-Smtp-Source: ALg8bN6QwjUGkSVfULEAAzxvC1V1wF6ljlvFkdOn+LEsqG6UkWw+NgCm+fjYZYL606ccTNHjQEVbFA==
X-Received: by 2002:ac8:6606:: with SMTP id c6mr18011899qtp.376.1547856770822;
        Fri, 18 Jan 2019 16:12:50 -0800 (PST)
Received: from localhost.localdomain ([64.125.109.186])
        by smtp.gmail.com with ESMTPSA id m14sm41140501qka.21.2019.01.18.16.12.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 16:12:50 -0800 (PST)
From:   Tycho Andersen <tycho@tycho.ws>
To:     Shuah Khan <shuah@kernel.org>, Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tycho Andersen <tycho@tycho.ws>
Subject: [PATCH 3/6] selftest: include stdio.h in kselftest.h
Date:   Fri, 18 Jan 2019 17:12:14 -0700
Message-Id: <20190119001217.12660-4-tycho@tycho.ws>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190119001217.12660-1-tycho@tycho.ws>
References: <20190119001217.12660-1-tycho@tycho.ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While playing around with a way to skip the seccomp get_metadata test, I
noticed that this header uses printf() without defining it, leading to,

../kselftest.h: In function ‘ksft_print_header’:
../kselftest.h:61:3: warning: implicit declaration of function ‘printf’ [-Wimplicit-function-declaration]
   printf("TAP version 13\n");
   ^~~~~~
../kselftest.h:61:3: warning: incompatible implicit declaration of built-in function ‘printf’
../kselftest.h:61:3: note: include ‘<stdio.h>’ or provide a declaration of ‘printf’

if user code doesn't also use printf.

Signed-off-by: Tycho Andersen <tycho@tycho.ws>
---
 tools/testing/selftests/kselftest.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index a3edb2c8e43d..47e1d995c182 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -13,6 +13,7 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <stdarg.h>
+#include <stdio.h>
 
 /* define kselftest exit codes */
 #define KSFT_PASS  0
-- 
2.19.1

