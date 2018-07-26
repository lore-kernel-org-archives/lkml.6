Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE318C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A171620846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 10:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jh8W5BE0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A171620846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbeGZLqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 07:46:33 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38892 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728792AbeGZLqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 07:46:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id t25-v6so1456701wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 03:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=4D/WBkmTmuX1cf1oTrD2JH1iIO2FhrIAjX2y2A8MPL4=;
        b=jh8W5BE0XycfXJt6trOsplm6UVTizEAvVmEnwgXq40Lb9IjFk/EZPGw7x7zgTTBca5
         ejSyuPFv/q5Xiq6Rr0SOFsVKTBI3t6VC7sEI7J/pcrlrH9P59aV3basYp1H2Fkt3gKNr
         GYNYAH6/iazTUMwj/be2liZpjckKWvEW8l/U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4D/WBkmTmuX1cf1oTrD2JH1iIO2FhrIAjX2y2A8MPL4=;
        b=Rx1Ghodya3nfv8exZUKBVgTZVSBrJXAMJGSlUZVOWl9p5WcBtTVrUvhvhhnc4Nm52M
         Q01udGfkFiGGR85LtTr5O+J+wnwOyaIWhwlygPU+WkEfJmUfBTl0dpVZYLUTflKXPUPW
         66HRSi24cOjC6NhpkuH+wSv3hAUTwIg3WWfvm8Bc8F4rijQTt7G3Nh8P2qwnlb0Z6nsG
         9LOIJwGsbYGBxl+Pz0z7u9XnP2k5HCMZz4DeuQYprMYFV3Sd8GQBNhSv/hGJTLJKE89s
         +LXaUQgxehc9EZa6cQAorIGKFA1tnc5P2MwkTf44Cx4JtnhRsBJYfMvte7j82wpSPfJw
         tCWg==
X-Gm-Message-State: AOUpUlH/kR+7PG/NPCK4hX/cpUqtAOWui363iK/kwaJ+dH7YTL7bH/JZ
        l0+Ue/wc/j+fLXt8gDqQHchAkQ==
X-Google-Smtp-Source: AAOMgpfjUUGb/9USahlFqohoOkgx15beshBCzgkNKJGrEEo1MiDdCoF2G4J63W2RXGwtsaVoCWR0iQ==
X-Received: by 2002:a1c:85cc:: with SMTP id h195-v6mr1128273wmd.110.1532601019045;
        Thu, 26 Jul 2018 03:30:19 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:879a:6cd0:35bd:fbdf:74b5:3f51])
        by smtp.gmail.com with ESMTPSA id l5-v6sm670112wrq.86.2018.07.26.03.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Jul 2018 03:30:18 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rui.zhang@intel.com, edubezval@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add myself as designated reviewer for thermal
Date:   Thu, 26 Jul 2018 12:29:40 +0200
Message-Id: <1532600980-29357-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to participate in the review process effort for the
thermal framework, especially the SoC part.

Instead of capturing emails with message filters, I would like to
humbly add myself as reviewer so I can receive the patches directly in
my INBOX and focus on their review.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0fe4228..1890aad 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14119,6 +14119,7 @@ F:	drivers/media/radio/radio-raremono.c
 THERMAL
 M:	Zhang Rui <rui.zhang@intel.com>
 M:	Eduardo Valentin <edubezval@gmail.com>
+R:	Daniel Lezcano <daniel.lezcano@linaro.org>
 L:	linux-pm@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rzhang/linux.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git
-- 
2.7.4

