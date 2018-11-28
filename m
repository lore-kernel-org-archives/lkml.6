Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D682DC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FDA2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 23:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=mailprotect.be header.i=@mailprotect.be header.b="rDkxqF4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96FDA2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeK2KtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 05:49:11 -0500
Received: from com-out001.mailprotect.be ([83.217.72.83]:37601 "EHLO
        com-out001.mailprotect.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeK2Krc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 05:47:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mailprotect.be; s=mail; h=Content-Transfer-Encoding:MIME-Version:References
        :In-Reply-To:Message-Id:Date:Subject:Cc:To:From:reply-to:sender:bcc:
        content-type; bh=5bQD3JiyzGAfF21ElgkADOS6gAjHDhzf66Ttiq3fBN8=; b=rDkxqF4mu/P7
        qHrbA/OSTWZKPdzSLi45XcKjhCq6JiIuK+Gvd2a8X0wsSyHdtbTtUdVzw1Sq2ld8ktb72Zfh53Uyo
        ywRXIljrrXHDaGlDu+cg4yID1DMEN3XRAUsqA6ZQ3ZmWzXEvWlzhQCY4JgmvU82RNMgwhf5CPm0Fa
        o918p55aIDHTM3TkFD7c6coswQioXaWuPz8jSYwCDa9uZxCoNKR9ATmapCv3/FLMuSRcf/OiG0dL4
        eFdiN0urvobbfKwuVFPBeCzYNbGHoe6nB0f5K3EQmgaIRsgRTx5gbz/715Gry8v+3xmlUGWpWSio9
        qXhnKNo/iwC2Q7CDPGIBbA==;
Received: from smtp-auth.mailprotect.be ([178.208.39.159])
        by com-mpt-out001.mailprotect.be with esmtp (Exim 4.89)
        (envelope-from <bvanassche@acm.org>)
        id 1gS9Ut-0001zp-M0; Thu, 29 Nov 2018 00:44:00 +0100
Received: from desktop-bart.svl.corp.google.com (unknown [104.133.8.89])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp-auth.mailprotect.be (Postfix) with ESMTPSA id CDCECC11D1;
        Thu, 29 Nov 2018 00:43:45 +0100 (CET)
From:   Bart Van Assche <bvanassche@acm.org>
To:     mingo@redhat.com
Cc:     peterz@infradead.org, tj@kernel.org, johannes.berg@intel.com,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [PATCH 05/27] liblockdep: Rename "trywlock" into "trywrlock"
Date:   Wed, 28 Nov 2018 15:43:03 -0800
Message-Id: <20181128234325.110011-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
In-Reply-To: <20181128234325.110011-1-bvanassche@acm.org>
References: <20181128234325.110011-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: 178.208.39.159
X-SpamExperts-Domain: mailprotect.be
X-SpamExperts-Username: 178.208.39.128/27
Authentication-Results: mailprotect.be; auth=pass smtp.auth=178.208.39.128/27@mailprotect.be
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: SB/global_tokens (0.00344554034175)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5sWicVdUAjpXBkzTFi6T1GV602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO1tLifGj39bI0bcPyaJsYTb/+zriNZuqQk0xRpGwjn+MTR8dtByWYYhgj25jR+mEA3YO
 AtfhCcV13BpIh8lqRXSSiFVwqwU9VgKUrYQ0lqWy1R4Y/B0c8Q4xv05u6AwPEJnlYMKcNBNnQiY+
 p98OAgW+oZYlTFVlVByDQKidUpQ5W65LzJ9B5xaoxsnzHcEvSQ2FxVgE7SkvtWKxkgySOE2kjhgu
 0YGe6DdVaQ5n+Bemb2HFc+ExJjWQCn47xwRrJ0plHa01E8jGn+8g1z+hdVSPFBHqDgFcV/K/0JC/
 wlLzmC/9mJUG+6OxwpRnt0PE8OeYAkx3ZcmLZYF56A5GPA9XM1A/yPl6iMWcd7+6/vdSy3hAYeHz
 PgnCe01lwQ05PIH9dd5mWFG11aWrXb4haDCZB7Q1HjVD0Ab7r04HqHAHo7UbuWzwvM5eRjzlfUYD
 MWFgOK8gW+hazh84oBeMtGEjle0LcSTVPooEuo2QsxqqeJFhJkrr1aJK7UvOHP2rTYGGnpP4nqMn
 MeW/5TOh7Qc6rDn0tTOVcmJwqI8Ju2net8Ds8HhMu8AsuC+XP0IWdayhB1kQ+I8y6YpuqGtfTiiG
 pS+C6BPAIEs8PiiVo3Eb5/RvTF8d3XTJRHNY3vVZhxNfkPQ0eGG0BkZ/0ghVUjHJwcJ3z+7xFrhX
 UzZERlSgGplHcpVCCoX989hgB8R+yBh7zBUvUeRjOaL1uKIL1VKezESUv41ec9githjNloBToLZ7
 cVEadqs94qlCcA4Ke01+c6JkDcz7H36caMoKCvaVn5e6WWqtjkhOipgSzOR38W+bRg5fxDn4+wIw
 bVJopxEVniihuDwEGDcmr6e3OPRbYlY9nUCHbaVm/QxqR0T9axct3O0T01C2EaeX4RftFUPmx5OX
 OghLB1bIHFEUyvZSBLOiL9IUr9yZjpxpruj4ctgzcDoFd+96Xw4QUNtTnej7fWboebFJ8uEic17X
 f8r+dneYot+5bKImOFpTroDTwFDVAXkIbmgC+i0h4F0ikedKEy7bP5gIt23U7fpAnNPfUf6Qdnes
 MUx+DSIG2s9i2bbJaLkYGGkHV1Yj5mlSVnBEn95eECKi3gxjzXac2CJ1/RfPzq2hqot3N/WbfZnz
 ElsvVqMZ/Jjjp7THy2O/g4WKLfoyGyMvo9j/i2ftfgo=
X-Report-Abuse-To: spam@com-mpt-mgt001.mailprotect.be
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch avoids that the following compiler warning is reported while
compiling the lockdep unit tests:

include/liblockdep/rwlock.h: In function 'liblockdep_pthread_rwlock_trywlock':
include/liblockdep/rwlock.h:66:9: warning: implicit declaration of function 'pthread_rwlock_trywlock'; did you mean 'pthread_rwlock_trywrlock'? [-Wimplicit-function-declaration]
  return pthread_rwlock_trywlock(&lock->rwlock) == 0 ? 1 : 0;
         ^~~~~~~~~~~~~~~~~~~~~~~
         pthread_rwlock_trywrlock

Fixes: 5a52c9b480e0 ("liblockdep: Add public headers for pthread_rwlock_t implementation")
Cc: Sasha Levin <sasha.levin@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 tools/lib/lockdep/include/liblockdep/rwlock.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/lockdep/include/liblockdep/rwlock.h b/tools/lib/lockdep/include/liblockdep/rwlock.h
index a96c3bf0fef1..365762e3a1ea 100644
--- a/tools/lib/lockdep/include/liblockdep/rwlock.h
+++ b/tools/lib/lockdep/include/liblockdep/rwlock.h
@@ -60,10 +60,10 @@ static inline int liblockdep_pthread_rwlock_tryrdlock(liblockdep_pthread_rwlock_
 	return pthread_rwlock_tryrdlock(&lock->rwlock) == 0 ? 1 : 0;
 }
 
-static inline int liblockdep_pthread_rwlock_trywlock(liblockdep_pthread_rwlock_t *lock)
+static inline int liblockdep_pthread_rwlock_trywrlock(liblockdep_pthread_rwlock_t *lock)
 {
 	lock_acquire(&lock->dep_map, 0, 1, 0, 1, NULL, (unsigned long)_RET_IP_);
-	return pthread_rwlock_trywlock(&lock->rwlock) == 0 ? 1 : 0;
+	return pthread_rwlock_trywrlock(&lock->rwlock) == 0 ? 1 : 0;
 }
 
 static inline int liblockdep_rwlock_destroy(liblockdep_pthread_rwlock_t *lock)
@@ -79,7 +79,7 @@ static inline int liblockdep_rwlock_destroy(liblockdep_pthread_rwlock_t *lock)
 #define pthread_rwlock_unlock		liblockdep_pthread_rwlock_unlock
 #define pthread_rwlock_wrlock		liblockdep_pthread_rwlock_wrlock
 #define pthread_rwlock_tryrdlock	liblockdep_pthread_rwlock_tryrdlock
-#define pthread_rwlock_trywlock		liblockdep_pthread_rwlock_trywlock
+#define pthread_rwlock_trywrlock	liblockdep_pthread_rwlock_trywrlock
 #define pthread_rwlock_destroy		liblockdep_rwlock_destroy
 
 #endif
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

