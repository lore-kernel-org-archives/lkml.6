Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DCE2C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A6D120855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 15:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f/B8lxKG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730985AbfBAPog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:44:36 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37392 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730971AbfBAPoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 10:44:32 -0500
Received: by mail-pl1-f196.google.com with SMTP id b5so3400176plr.4;
        Fri, 01 Feb 2019 07:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3akgdL2DmA0+jzPMu5JU1LzkndcOsqm5p8ILU9GiPhs=;
        b=f/B8lxKGf9EkPKJ0PXB3RzPfUgV1dAUXYClws3ojKATTwA0Dv395uHOX9zimMfZ1Tb
         gJqXbnRP1uFHc6sdZUVrVnWXKTTmk+QXwQxiz9fmwtcgYp9AK78PyT0Fl8zzGxR4oXum
         St4l5/ZYu93mBvgMEwpd1IG0ut64O6po7CT9q5PYpr9FY1dUa4Kjw5yl9kOyrKealhEf
         8STNyR2lF4FdOBwnevVvvz6HopkSvCE1MCgeAc7SETmAAruHnLIsZAoEFVQ1cQ8GN+o5
         UafjajnRribRj0/FxjqWOlj0lXtX82MPXSpsEOq+hhiYC59o/TCm6gAsl7OnpbuTctKC
         KQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3akgdL2DmA0+jzPMu5JU1LzkndcOsqm5p8ILU9GiPhs=;
        b=jTJVyTR76NxxFBewIur6wUifMaOfb0SS8LPC1EoQjGO9p5O47g+nysD2PgN8TpJUim
         bHjbU3Dp2cbWCvrTTh7iBzCVgvtbTPAQPalAAgXt5+GicqSD45QpKQZHSetdwS+vc5z9
         nDbwuoFkzOP4iq/hVPtfBFbHk9843CsbQjwZztfKUv7ORspESX+UuaICsCm527uV8ww+
         yt5DirVf4liVyzHySwn9uUAbFOb1NE+4EcoSaZpCma51xAdY7YFq7eAxWwH3AkoQ/8Fu
         n/DTT+m0XpTC0LC46BsgEzPgTXMIZSfO0zstFLu2l/vMp5VC1BzGGA+Opa6iKE9n2DMh
         ukiA==
X-Gm-Message-State: AJcUukf1fK5Gc3crCGbHci3G51KsDs0uBKoEOXfm8FFxLUitsaGigCFS
        4FEmkim+3K1rUas4g1lbYHkPLpnH8KA=
X-Google-Smtp-Source: ALg8bN5JQ07YKUR+EYb8c6ggPBgOfQyZRDNrlE9m6Kh43+aCTzkr+YxHluNf/70xPh+KkTvWnP+QEg==
X-Received: by 2002:a17:902:a03:: with SMTP id 3mr40389185plo.112.1549035872312;
        Fri, 01 Feb 2019 07:44:32 -0800 (PST)
Received: from localhost.localdomain ([49.206.15.111])
        by smtp.gmail.com with ESMTPSA id z9sm25886959pfd.99.2019.02.01.07.44.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:44:31 -0800 (PST)
From:   Deepa Dinamani <deepa.kernel@gmail.com>
To:     davem@davemloft.net, linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org
Subject: [PATCH net-next v4 01/12] selftests: add missing include unistd
Date:   Fri,  1 Feb 2019 07:43:45 -0800
Message-Id: <20190201154356.15536-2-deepa.kernel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201154356.15536-1-deepa.kernel@gmail.com>
References: <20190201154356.15536-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compiling rxtimestamp.c generates error messages due to
non-existing declaration for write() library call.

Add missing unistd.h include to provide the declaration and
silence the error.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
---
 tools/testing/selftests/networking/timestamping/rxtimestamp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/networking/timestamping/rxtimestamp.c b/tools/testing/selftests/networking/timestamping/rxtimestamp.c
index dd4162fc0419..6dee9e636a95 100644
--- a/tools/testing/selftests/networking/timestamping/rxtimestamp.c
+++ b/tools/testing/selftests/networking/timestamping/rxtimestamp.c
@@ -5,6 +5,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <unistd.h>
 
 #include <sys/time.h>
 #include <sys/socket.h>
-- 
2.17.1

