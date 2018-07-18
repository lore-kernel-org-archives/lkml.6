Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7375ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CDA320693
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 00:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EFgF+/xi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CDA320693
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731585AbeGRAvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 20:51:02 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:55743 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730063AbeGRAvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 20:51:01 -0400
Received: by mail-yb0-f202.google.com with SMTP id y16-v6so1485191ybk.22
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 17:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=bGNvdnexsXmQKC3skfAzlLhLIVVMREt07kHDGLKDpVo=;
        b=EFgF+/xij5QQqfOtcZfp48YOnhztD7xrDVqQQdFvh9havB/hQFHpbBw+//OvNpORpi
         /NLD3/v8KxikiowAC3oi+wKfv++tu4WG6FM+Ty9CGumxYe3Rtj8nOvVQpBQvMDwtlKUu
         R6IG9quu3/Z3EXmXMCErw5vgXeSHJafTVJK+3tEpZMB9c97EosFkSNd2hjRgCXPwE/tq
         xf/F89J8yu12xMPXYa5ql6HBwrhlt7xRqfY8ONPI7oP6TOd1k0ym+iu3oyWCeehA5E2Q
         Zp5rU8jCVRXRVZB4K5FMb5Niz2rXMQ9CYlgW1DKejUK1xAa1/Gv3KYznWVStVnx3Bvju
         W4/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=bGNvdnexsXmQKC3skfAzlLhLIVVMREt07kHDGLKDpVo=;
        b=qWWvJdgZXuDL2LW+LWT59pdtlYmXegJgXzgc8V+6KG352/8OXYtB3JsteFBc5KnTvz
         +xHoewqGNH6Dr5xIFwhTUMAgaKNkPcePcD89GCACzfsBjZ+J2zvKdz2j2aK4ju2K7dbk
         UxDfqQwTs0HMkkGHhE3f3lxG5ujUO6FPu2JkEPQTkPx0sw0Vdy68JYlmtXAzm+5IcwdF
         WwctG2Vqis+wrkG85J9fZihdLXc3SS6akFXRaMuvmYkQJdexdDsDlrzKNYj8MF+mkX70
         LzF+3MLomx/k10UjRgadgFVN4thRyR8yF9JptXSEzE7cjizi6l/SbdblDJSrBPLZyGAJ
         1qcA==
X-Gm-Message-State: AOUpUlGBmoHFrPIaKo/yMRyUA8fY1btLP7eHPoIuuzGqCwzy5Tzr4bNe
        Bp2MOsjLom0oMmnU3L4cFdOQJuiU
X-Google-Smtp-Source: AAOMgpdZz49V2TFSFqxtWtvUvh2VP2F2BT6sVZacLbuM2WC/FTPdjSn21w8CMPBwAny+ZptdA8d6W9Z3
MIME-Version: 1.0
X-Received: by 2002:a0d:d84d:: with SMTP id a74-v6mr1117457ywe.152.1531872955536;
 Tue, 17 Jul 2018 17:15:55 -0700 (PDT)
Date:   Tue, 17 Jul 2018 17:14:55 -0700
In-Reply-To: <20180718001455.140575-1-rkir@google.com>
Message-Id: <20180718001455.140575-3-rkir@google.com>
References: <20180718001455.140575-1-rkir@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 3/3] tty: Mark goldfish_tty_line_count as const
From:   rkir@google.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, tkjos@google.com,
        Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

The driver never mutates this variable - no benefits of
keeping it mutable.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 drivers/tty/goldfish.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index a9c8ab8a4750..32b77bf54918 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -49,7 +49,7 @@ struct goldfish_tty {
 
 static DEFINE_MUTEX(goldfish_tty_lock);
 static struct tty_driver *goldfish_tty_driver;
-static u32 goldfish_tty_line_count = 8;
+static const u32 goldfish_tty_line_count = 8;
 static u32 goldfish_tty_current_line_count;
 static struct goldfish_tty *goldfish_ttys;
 
-- 
2.18.0.203.gfac676dfb9-goog

