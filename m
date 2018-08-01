Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F025BC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9DC208AD
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:58:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvTL087S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9DC208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbeHATpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:45:21 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51168 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbeHATpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:45:20 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so7982793wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 10:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=o3hXE5duZZNWugj4jbhtjsAlcXg5B/WkCFlYY8k2hYQ=;
        b=jvTL087Spu1TbXw3S100sxtbOGuG7wMePgJ9GQ/OYriAORiMLtPjI3SW1EK5pbOg7Q
         Pb8OEQsxRrk8avClXNqsWH5LvREWE3NmTqMW8KPy6qxHCqBtMB12py9/98zC/olsAAIF
         oFRClWOAqxJQDbstIw48Bxp9jdKaIoNE/9HjJqx0tF9tqzJ09YuYGKHG0cvQL081/lzd
         TAzyqdpU4utgYewwZWUQ4Wmz37bRPoQ8gjBnkFOCejpFwj08DO3q2WkmNYZMwq6gL+Ei
         uuVVex+lTNa/Yu9ACRKrMZcfatwg7pm7MjOGb+aMH4reV6FdaUVkZmIByhUdldbGRxtl
         YGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=o3hXE5duZZNWugj4jbhtjsAlcXg5B/WkCFlYY8k2hYQ=;
        b=CCgdCK4tbqnGppCM/cbPJMiaG6VIlN0X1mThWfnryiNotCuK7GTbFY3poPVn57M7oC
         UODvvsd9NlarqI0vkx8LFGLSFS7EQdqUS1LQfSKCLuAkTmUU1y3omEnMvNU/EeNUecDk
         xLsbo9YrwEo42O3vKSztoHSprSNA+oLYbkDMhKbbDtSd5k5XLrB9QOZ7yPqV8zSvTwDi
         gpk7/KFKuBzbieCFr1VHJFmJJ3NwZ7hxop42IaF9An1OwIiY3Va2ZdzmGMFwnuruT9zi
         Hvl1qJzlzoTZTpYVgk+mjd6zHbHS5VnAHTxKs1NeIIlNMf4rktHHyO38giCwfDFxf9hL
         GohQ==
X-Gm-Message-State: AOUpUlEiI+oCo6T8Oho+UvemTEk44xEFg9STAVI0dPFAo07i/GMwPnrt
        VmfxModKZDGQKJQSt2eZyJI=
X-Google-Smtp-Source: AAOMgpeo1z1QUx91REdlt7+TmYpqhrKE9I5CQ1hp4xZit4NsFj/EO+r13Qut1hXENKgtcvh48nX2xQ==
X-Received: by 2002:a1c:3b05:: with SMTP id i5-v6mr3607727wma.57.1533146307011;
        Wed, 01 Aug 2018 10:58:27 -0700 (PDT)
Received: from gmail.com (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id p14-v6sm16833733wru.0.2018.08.01.10.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 10:58:26 -0700 (PDT)
Date:   Wed, 1 Aug 2018 19:58:15 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Martin Sebor <msebor@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will.deacon@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Rientjes <rientjes@google.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 2/2] auxdisplay: panel: avoid gcc 8's Wstringop-truncation
 warning
Message-ID: <20180801175815.GA25489@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let gcc know it is not meant to be NUL-terminated by annotating with
the new __nonstring variable attribute; and remove the comment since it
conveys the same information.

Cc: Willy Tarreau <w@1wt.eu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Martin Sebor <msebor@gmail.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 drivers/auxdisplay/panel.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/auxdisplay/panel.c b/drivers/auxdisplay/panel.c
index 3b25a643058c..21b9b2f2470a 100644
--- a/drivers/auxdisplay/panel.c
+++ b/drivers/auxdisplay/panel.c
@@ -155,10 +155,9 @@ struct logical_input {
 			int release_data;
 		} std;
 		struct {	/* valid when type == INPUT_TYPE_KBD */
-			/* strings can be non null-terminated */
-			char press_str[sizeof(void *) + sizeof(int)];
-			char repeat_str[sizeof(void *) + sizeof(int)];
-			char release_str[sizeof(void *) + sizeof(int)];
+			char press_str[sizeof(void *) + sizeof(int)] __nonstring;
+			char repeat_str[sizeof(void *) + sizeof(int)] __nonstring;
+			char release_str[sizeof(void *) + sizeof(int)] __nonstring;
 		} kbd;
 	} u;
 };
-- 
2.17.1

