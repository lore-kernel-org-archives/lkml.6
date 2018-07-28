Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0727CC28CF6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 14:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A946B20878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 14:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A946B20878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729032AbeG1QQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 12:16:06 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43617 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728949AbeG1QQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 12:16:06 -0400
Received: by mail-qt0-f194.google.com with SMTP id f18-v6so8016165qtp.10
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 07:49:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rBFdVE2hfAKUkCM4FwuJpgZgNz/b3YNexX/987R+Il0=;
        b=m23ektin38OUN2BJ0pM8xeAGwDYnc1XeSR+/PJsx7lq5pnidg713PQFwyVBf3l23aj
         VR02QwPXFfQlSCgTv0P0o2p8tS5a/my7WAJ5WdpHseyCKORHSVfA9hIasxkFIYuY7vQC
         QJ/lVhfDrtCQW+jhSQKs0/KdZAlcdDUMOBvhpCzB8RfTqlFQAbP/GWEL579Z4Xfv6oYh
         eElIiTH1/NdGrKKsrV12dKBG7YBvK0QLxzkxSpJQphRMb7cH8FJPBxvtMFnMh7l1HupU
         9988xD0DVx8iabCNh2ucGlQkZC8KRALPZwLol1bL3z2Tsvj3j/ScpxWyGYMxs1wS73jP
         nqaw==
X-Gm-Message-State: AOUpUlFESmvQsApfgQmVHRVPszyuWFSh6egzJhWZU+zEpGhb1SSWWJIH
        ccJHlVJkjLJ+ENKAaBTKkhPyEw==
X-Google-Smtp-Source: AAOMgpfi8PKirM6l5smKCGnYj9tzJHU7kUg+ilUeyqmJAOqLJn8+xP81l5JN9MNMB+WhQ+ecjcVY4A==
X-Received: by 2002:a0c:d957:: with SMTP id t23-v6mr9341293qvj.149.1532789360520;
        Sat, 28 Jul 2018 07:49:20 -0700 (PDT)
Received: from laptop.jcline.org (075-177-179-204.res.spectrum.com. [75.177.179.204])
        by smtp.gmail.com with ESMTPSA id v57-v6sm4996328qtc.75.2018.07.28.07.49.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 28 Jul 2018 07:49:19 -0700 (PDT)
From:   Jeremy Cline <jcline@redhat.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Frederic Weisbecker <fweisbec@gmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeremy Cline <jcline@redhat.com>
Subject: [PATCH v2] scripts: Add Python 3 support to tracing/draw_functrace.py
Date:   Sat, 28 Jul 2018 10:48:33 -0400
Message-Id: <20180728144833.6336-1-jcline@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the print function. This maintains Python 2 support and should have
no functional change.

Signed-off-by: Jeremy Cline <jcline@redhat.com>
---

Changes from v1:
  - Drop "from __future__ import print_function" as Python 2 is not long
    for this world and in this case the statement and function behave
    the same way.

 scripts/tracing/draw_functrace.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/tracing/draw_functrace.py b/scripts/tracing/draw_functrace.py
index db40fa04cd51..9b6dd4f36335 100755
--- a/scripts/tracing/draw_functrace.py
+++ b/scripts/tracing/draw_functrace.py
@@ -123,7 +123,7 @@ def main():
 		tree = tree.getParent(caller)
 		tree = tree.calls(callee, calltime)
 
-	print CallTree.ROOT
+	print(CallTree.ROOT)
 
 if __name__ == "__main__":
 	main()
-- 
2.17.1

