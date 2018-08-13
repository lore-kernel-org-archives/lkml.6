Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B78C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA6E216B7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 21:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA6E216B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730892AbeHNAk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 20:40:26 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:34929 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbeHNAk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 20:40:26 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Mefpk-1fVRQD2dqq-00OKnk; Mon, 13 Aug 2018 23:55:49 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Caleb Raitto <caraitto@google.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Rakib Mullick <rakib.mullick@gmail.com>,
        Amritha Nambiar <amritha.nambiar@intel.com>,
        Michael Kelley <mhkelley@outlook.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpumask: provide a dummy cpumask_next_wrap
Date:   Mon, 13 Aug 2018 23:55:16 +0200
Message-Id: <20180813215546.3828228-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:GEKQvB0OLegPjxawkU6Q92FCcY/YUHkLkv1i1eZsa730jHhi5oN
 aDs7AI9anXePr+Za1QtTxeSBLSj6wgoFUyR1/w0oqY5NaaH4ljEYIx2KSE2JQwbiMFutDeL
 FTTb8tvL9yt1IQK3pBw2Xy7uO4NputLJBZ8Jb6U0/Y6cA7YTqKCl3yJcA57gBi2+oXKCVyz
 BK8ghIR6yBoHG03R3O45w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:hArcw6AVpbQ=:t6avqwnT3hZNCaXolROhQJ
 3fkbcUHCk8N5ERL9hZxIKvEoiup6aBuZcX45yaw7KkFxEc8R+7T2sQug67x5C9zE0GaG8DX0P
 PdLjUXAulfiUa5igapIU2EgmEHBjeVXEJcJTfOiA8oNHJasMhl3lm6xhKqlGWRyjRIshg052X
 PLRZQtQvUVdpMKK0F4anF0ijZvGe5t2FzGFM4MUP9GS0bjQAYEbBVdCLr2b3flQ2uV8kA0784
 A4JNXplXcwsLgq2ynousoto9f/6fASka1QCX1zlBe8C4/hS49jkvj3VgmanckQxlGrIRz3Ghb
 XI6tuvJtv+5QKWBwk8IU2Zvfk9WBJoXKrmApKXwzJ8ruD+0hh1T7SRk3+ARfXP6oHX5LkL8nk
 6UGSH+DWD2IxcDvkFzHpyDDj1Mm+vSx88ijdPUjVUI1rPFs9jZjGGSvuy+GAh6BfTZWLCodCA
 B3rFuh6F+nzaGHdTDI4iPWSJn0dPKh/4XDkZEKo8KAIUbjMVvHX6FiopvklAEVKaoALp+Dpuc
 nBeq/IQrtX+Q6BCDhWZB2VkeOuigRS/WF/bTRvYSZwTD8fsWbYRSTkzC4TcIuGpofmBGWveKF
 hO+VBHQWERkvjWi1wQ+jXwrFQ8T5Z3aPSXxyfK1wBjgUmtpe5oDeghTcUl0dbbm1ZVwFh0/y9
 zlS03PvlGWnTVkJhc7kGRJjIlBvBcYmzP8q8EOGddAf7WHFGNoaGHJ0A1VKE+Nurg1z4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The virtio_net driver has become the first one to call cpumask_next_wrap()
even if CONFIG_SMP is disabled, leading to a build error:

drivers/net/virtio_net.c: In function 'virtnet_set_affinity':
drivers/net/virtio_net.c:1916:10: error: implicit declaration of function 'cpumask_next_wrap'; did you mean 'cpumask_next_and'? [-Werror=implicit-function-declaration]
    cpu = cpumask_next_wrap(cpu, cpu_online_mask,

Add a stub function along the lines of cpumask_first(), cpumask_next() etc.
I'm not entirely sure what should be returned in this case, but at
least for virtio_net, anything should work.

Fixes: 2ca653d607ce ("virtio_net: Stripe queue affinities across cores.")
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Caleb Raitto <caraitto@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: David S. Miller <davem@davemloft.net>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/cpumask.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index 57f20a0a7794..079ba06309bd 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -159,6 +159,11 @@ static inline unsigned int cpumask_next_and(int n,
 	return n+1;
 }
 
+static inline int cpumask_next_wrap(int n, const struct cpumask *mask, int start, bool wrap)
+{
+	return n;
+}
+
 /* cpu must be a valid cpu, ie 0, so there's no other choice. */
 static inline unsigned int cpumask_any_but(const struct cpumask *mask,
 					   unsigned int cpu)
-- 
2.18.0

