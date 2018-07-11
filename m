Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 744F3C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B865208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 18:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v2rqONuV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B865208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387405AbeGKSWS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 14:22:18 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34914 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbeGKSWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 14:22:18 -0400
Received: by mail-pl0-f68.google.com with SMTP id k1-v6so9507240plt.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 11:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CEZ1FoSaiekmn3kJ50BUocE+MxlrpDOtfRIbZMjFEjU=;
        b=v2rqONuVexqaJcm3tUSixGXWtf+NwFKIub56Bl+Qri0lqxFbiGCuby3CfRJK2PwMAr
         g/s7pOS4MR06LNXMBlGGSS2DywtzdlTSD0gQ3Oo12N1vSEVhBF33B9qwKiNj2j8rkDfK
         XcEwRcORje8FqKA98ENXKDag0rAXK8pkNgphiVJEXNDfQn5c0SzzhWITVrrqojh5Z9ZM
         wrASNP3x4cdz9emKlfBnp8sxSEbdO0bWj4uiu1TyWSA0L69EZxWMS8k2ScQa5pOsJzXO
         RMbvXSfmOXJ3dE9dL/qQMlv+k8e9R+XDAKarXlBguf6cHgKxbT6wxofkHvTRJIfYzTUe
         qPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CEZ1FoSaiekmn3kJ50BUocE+MxlrpDOtfRIbZMjFEjU=;
        b=dKoGtPAOYNJ0vNTOSAmhZ6GlPEJdPKlAVx1EQB4e+5MVgHJ8K0+ZdPqWDbf0ujIvEG
         qV+fVWHg2OpJPaPWQQhyip0pdE/sRWiuxeEJXycMBlfKQ/cmay36pakBNJj36tjMsb0E
         VbjAlCMhCwBUw6jKsrD8qobWelYuNGJoFmiKGy0oqBHqzGAThWfxPYhryVIwY65/4FKT
         RPRZEYjxBo5ETYYqAhHpwjudXukYF8wTSop3+E0iOtppvgJMGsPZKqkhNt0BsKhLG4kd
         fH9Jv4+oIm54dIozgCyyGuDoqDcJWlL5ij55kYTQAveczerPJ4+mQqKLi+gY7UiP6/6N
         AaJA==
X-Gm-Message-State: APt69E3ZanZQv8G9IgeawV1Hrz24sP7IxQy/rXGalF+ipdR8iwJdA75t
        JFv6c941SwOLnvgKuWWYMOwafw==
X-Google-Smtp-Source: AAOMgpc8QUmVPR5czjf09AsEw0RpFxePjf2QRFV4Nqcg1q2ZCg3jLxa2duFYJUkw+DjTtTXxNDBA2g==
X-Received: by 2002:a17:902:9a8a:: with SMTP id w10-v6mr29658232plp.333.1531333007525;
        Wed, 11 Jul 2018 11:16:47 -0700 (PDT)
Received: from localhost ([2620:15c:2c4:201:f5a:7eca:440a:3ead])
        by smtp.gmail.com with ESMTPSA id t21-v6sm9739196pfh.45.2018.07.11.11.16.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 11:16:46 -0700 (PDT)
From:   Eric Dumazet <edumazet@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH] ktime: provide typesafe ktime_to_ns()
Date:   Wed, 11 Jul 2018 11:16:41 -0700
Message-Id: <20180711181641.10369-1-edumazet@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using ktime_to_ns() is nice to help backports to stable kernels.

Having a typesafe function instead of a macro avoid stupid typos
and waste of time tracking these typos.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Willem de Bruijn <willemb@google.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 include/linux/ktime.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/ktime.h b/include/linux/ktime.h
index 5b9fddbaac4166b11121f75a3f3b4db7af1aac4c..b2bb44f87f5a3edb6ee6f179c83fcde42a363fe5 100644
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -93,8 +93,11 @@ static inline ktime_t timeval_to_ktime(struct timeval tv)
 /* Map the ktime_t to timeval conversion to ns_to_timeval function */
 #define ktime_to_timeval(kt)		ns_to_timeval((kt))
 
-/* Convert ktime_t to nanoseconds - NOP in the scalar storage format: */
-#define ktime_to_ns(kt)			(kt)
+/* Convert ktime_t to nanoseconds */
+static inline s64 ktime_to_ns(const ktime_t kt)
+{
+	return kt;
+}
 
 /**
  * ktime_compare - Compares two ktime_t variables for less, greater or equal
-- 
2.18.0.203.gfac676dfb9-goog

