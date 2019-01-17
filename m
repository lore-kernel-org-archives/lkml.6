Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FE8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:27:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DA9120851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:27:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apjdTVzp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729106AbfAQQ1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:27:33 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37102 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbfAQQ1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:27:33 -0500
Received: by mail-pg1-f194.google.com with SMTP id c25so4665066pgb.4;
        Thu, 17 Jan 2019 08:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:cc:subject:mime-version:content-disposition
         :user-agent;
        bh=+9UZa4gubbzy5gZyM/W6ZF4dGbmRy5L5BvhJE4XaD/E=;
        b=apjdTVzpR70QWWzteyKOz+2oYC+PX99HQ5aHA9RIegu/sTCn/ZhvpAI1OAJRj3Nywb
         f1qC+ecCTT0g3RjOlXizFvfZAOp8f/Pd+qIRmeXbYikizaUReEkmzesFwSRVKVF3MTLK
         uMu4ZgUQIFoGmDd0O91FP1KrhaMqvTbg43ivx0858pWq2shenha+LzKduVWHbG1nrahh
         NGdj7vOxuFo3JrwtOSaDAZXFccBtjMCvnXvo3tVwgKDhqc5MfZ69aRnxoXt6n5i6tUSV
         Ln/kATDXN85VRve0M3CFmHxpt+mwmtNK8+HRt2SUwIJC0irkmYWfEQctvJwGasPfGGmW
         5JJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:mime-version
         :content-disposition:user-agent;
        bh=+9UZa4gubbzy5gZyM/W6ZF4dGbmRy5L5BvhJE4XaD/E=;
        b=mWVyQoXGQBVDkGJakjxCmcJLMWvbb2fpCTUVTM2EjBBkrBznpTkVG0esAl9JzdC9tI
         FwcE7zjM921O/lFu6ds5Mb1Sd2DLXmPF/v4vau3xr5NElxqSqgOUiU+I7oPclulZa02u
         8R7/0tr6UR/MkjEHE6rTwyEZAoUHgCGo9PK40v/E+/I2aAAt4qEAUu1forDsoCxmWRiS
         /LvqqUhlGuhUIFlXppfEnXvgAeEuYqeH+aJ/41DcpNkC7PLq7DIaLQbH8j6yxFKO6KE9
         pdJvP0uoJlYngmPJRn1r+np1hcYVgZcZhLW/jRt0zsfyrvwGm95UFXICG02QJe/PNuxl
         NxoQ==
X-Gm-Message-State: AJcUukdNu2+kzPiiVkZHmSdn8pvm0FoDv8jVvIdYZhOGBMA747LgRc8G
        gEhMiD4TP9Lmja++C9Zj104=
X-Google-Smtp-Source: ALg8bN4KS5I9p+AldBSCLx9Z8Gc6nporHuM9zGKog2K+dcyk17I8Lrr9J70+8h/WOFxNcwngcUlIcg==
X-Received: by 2002:a62:34c6:: with SMTP id b189mr15855225pfa.229.1547742452496;
        Thu, 17 Jan 2019 08:27:32 -0800 (PST)
Received: from sabyasachi ([45.116.191.230])
        by smtp.gmail.com with ESMTPSA id b27sm3423071pfh.113.2019.01.17.08.27.30
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 17 Jan 2019 08:27:31 -0800 (PST)
Message-ID: <5c40acf3.1c69fb81.5b02f.880c@mx.google.com>
X-Google-Original-Message-ID: <20190117162727.GA23575@sabyasachi.linux@gmail.com>
Date:   Thu, 17 Jan 2019 21:57:27 +0530
From:   Sabyasachi Gupta <sabyasachi.linux@gmail.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org
Cc:     jrdr.linux@gmail.com, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, brajeswar.linux@gmail.com
Subject: [PATCH] sh: Remove duplicate header
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove linux/irq.h which is included more than once.

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
---
 arch/sh/boards/mach-dreamcast/irq.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sh/boards/mach-dreamcast/irq.c b/arch/sh/boards/mach-dreamcast/irq.c
index 2789647..69fa91c 100644
--- a/arch/sh/boards/mach-dreamcast/irq.c
+++ b/arch/sh/boards/mach-dreamcast/irq.c
@@ -10,7 +10,6 @@
  */
 #include <linux/irq.h>
 #include <linux/io.h>
-#include <linux/irq.h>
 #include <linux/export.h>
 #include <linux/err.h>
 #include <mach/sysasic.h>
-- 
2.7.4

