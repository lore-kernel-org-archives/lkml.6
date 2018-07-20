Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83863ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F7182064D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 19:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F7182064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388514AbeGTUZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 16:25:27 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:44934 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388036AbeGTUZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 16:25:26 -0400
Received: by mail-qt0-f176.google.com with SMTP id b15-v6so11267049qtp.11
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jul 2018 12:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=O8+Y8bW0oRvSU/ywx4comujtorf6PMC/+Bdlx2CHISg=;
        b=D7C/OAIMwTiiKsrdZqtVc5Ezk2HBfNKbv7q1RnLLCFBWWn5pbN6QJ3Cpts6kPbw1QB
         CZG/osy9cY/NgD/SqwVdews+F1EPoG3IrEYBYT6koG00Jl1GcI043EY/k83U/jkY0cf9
         DrgG7ufYcmwbfZH/aBaTRIZY+8qmK3pY/tx5hsUmwnVY6u6r7HaxM0+PsJSR7PbdGlt3
         UK2qewt+UJ2uYP2Q0eIsVZ/pomZiHh9PYt5qAgz2kG0PH/6I+N2GUxq4IQDA9/hP4cZU
         qLNSDfmTNjfdQWXNmIu443JINyi23NjiIJD1nCNR1zyOZpeSwdSGBWQ/hiq8HB8MylEq
         J3vA==
X-Gm-Message-State: AOUpUlGED8jPqzbXVpQ58RYZ/9hgKrYeHMkukHyIwZcxlfW80UKy0uH6
        cEfjcZt7fgZfNpxQ9R7ZzW0yWyHS8nA=
X-Google-Smtp-Source: AAOMgpdbTtryAbI4Ezx+clF3Y4tXfDjnsXcDjr0IvUkqdaoOJVmWsnDo0dW2QiqK0cw3vHB2cyJeKw==
X-Received: by 2002:ac8:709:: with SMTP id g9-v6mr3289854qth.110.1532115344715;
        Fri, 20 Jul 2018 12:35:44 -0700 (PDT)
Received: from laptop.jcline.org.com (cpe-2606-A000-1127-D1-82A4-FE7D-5832-CB87.dyn6.twc.com. [2606:a000:1127:d1:82a4:fe7d:5832:cb87])
        by smtp.gmail.com with ESMTPSA id n24-v6sm2476492qkh.39.2018.07.20.12.35.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 12:35:44 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>
Subject: [PATCH] scripts: Add Python 3 support to tracing/draw_functrace.py
Date:   Fri, 20 Jul 2018 15:35:28 -0400
Message-Id: <20180720193528.1341-1-jcline@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the print function. This maintains Python 2 support and should have
no functional change.

Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 scripts/tracing/draw_functrace.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/tracing/draw_functrace.py b/scripts/tracing/draw_functrace.py
index db40fa04cd51..7d44e796d362 100755
--- a/scripts/tracing/draw_functrace.py
+++ b/scripts/tracing/draw_functrace.py
@@ -20,6 +20,7 @@ Usage:
 	$ scripts/draw_functrace.py < raw_trace_func > draw_functrace
 	Then you have your drawn trace in draw_functrace
 """
+from __future__ import print_function
 
 
 import sys, re
@@ -123,7 +124,7 @@ def main():
 		tree = tree.getParent(caller)
 		tree = tree.calls(callee, calltime)
 
-	print CallTree.ROOT
+	print(CallTree.ROOT)
 
 if __name__ == "__main__":
 	main()
-- 
2.17.1

