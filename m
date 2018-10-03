Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482A1C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD9F20684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRHAfYSf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CD9F20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbeJCM05 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:26:57 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40598 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbeJCM05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:26:57 -0400
Received: by mail-pf1-f193.google.com with SMTP id s5-v6so1102861pfj.7;
        Tue, 02 Oct 2018 22:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=a/QAGj2FNSYSE6IRPX20B0x0rP6+rCFqKkUI1OMxS2Y=;
        b=HRHAfYSfjNvdpluR3LOdqaDh9H70aS4T7GKdeGO8gzIRlg+GThKiGNSg11FDPNi+w2
         zbMDWthlFrBOIbPC1F4Y7+G1BQODi3gM8u3GsKbfyRNsC3N++rCnN2Ds2mFPA+/ZdprB
         9LIo0eGLQKMimsm4/3sFKWJiMUlWIDt4pikar9fng+VJeEnBS1KzOLBNfUQtCgfWluK1
         rYy3fwuNqWv/JU56U5n+T02qcRU1plJvBhZuE609yqhVmYvVauCPQRwIC+emp60k32rc
         ozFBNn/VDqIhA8yvq+y7/vwdga17I4kzJuIDN8QLo1lIWZ2uCJK7xV7N9BgUnSTalbtE
         cXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=a/QAGj2FNSYSE6IRPX20B0x0rP6+rCFqKkUI1OMxS2Y=;
        b=hN/pVcYwNYLTjZ+QOdrEiCQsuXCJFs93oPfFP8UWgFUWfWy4CnH4/h3tlA1G3apzoj
         PyHaScXHFBI4OHFUdsQvO/vsHFeCuJk4bmgiR9cmWzochb6g+3eO7Ri/tbANFMEAfdzR
         eELp9blo+nUEI8fu9rWa7e9DeGC54oB0fOyuuC5x7ExVuGHywmPL+aNU+ad7d1DuEdNQ
         yXvsFDR/QvJp06xzx/72rFWkMTR0dA4DoA4ajlhEfvWELl9/EuhrU+kXM+F+2zvHCGZ3
         ZgTjQYczzLZgHl95FLY/WvZ1MPF7Nx3rRvSYxS9s7eS8IPmMxCw68pHrro7/5ZvrP3YL
         DX8A==
X-Gm-Message-State: ABuFfogSYMNVsquOK0frp2x6gkw0KMamtykoY3X4WRAzvVH2aXAvee3n
        i7aO0DuLPlhU/NmMNXAdMb6io6fbYCg=
X-Google-Smtp-Source: ACcGV60tXU4wa7/gMSCwbhVLZ7BY29d7TyIFfXycmRA1zDEzbNaaMGmGIIu8cjVS9yDjvKA5fu1d3Q==
X-Received: by 2002:a62:3995:: with SMTP id u21-v6mr19681963pfj.116.1538545207507;
        Tue, 02 Oct 2018 22:40:07 -0700 (PDT)
Received: from E570.localdomain (c-24-21-68-121.hsd1.or.comcast.net. [24.21.68.121])
        by smtp.gmail.com with ESMTPSA id s80-v6sm510208pfa.114.2018.10.02.22.40.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 22:40:07 -0700 (PDT)
Received: by E570.localdomain (Postfix, from userid 1000)
        id 412021643D0; Tue,  2 Oct 2018 22:40:06 -0700 (PDT)
From:   Lance Roy <ldr709@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        Lance Roy <ldr709@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/16] userfaultfd: Replace spin_is_locked() with lockdep
Date:   Tue,  2 Oct 2018 22:38:56 -0700
Message-Id: <20181003053902.6910-11-ldr709@gmail.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181003053902.6910-1-ldr709@gmail.com>
References: <20181003053902.6910-1-ldr709@gmail.com>
Reply-To: Lance Roy <ldr709@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

lockdep_assert_held() is better suited to checking locking requirements,
since it won't get confused when someone else holds the lock. This is
also a step towards possibly removing spin_is_locked().

Signed-off-by: Lance Roy <ldr709@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: <linux-fsdevel@vger.kernel.org>
---
 fs/userfaultfd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index bfa0ec69f924..a20244ff0027 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -926,7 +926,7 @@ static inline struct userfaultfd_wait_queue *find_userfault_in(
 	wait_queue_entry_t *wq;
 	struct userfaultfd_wait_queue *uwq;
 
-	VM_BUG_ON(!spin_is_locked(&wqh->lock));
+	lockdep_assert_held(&wqh->lock);
 
 	uwq = NULL;
 	if (!waitqueue_active(wqh))
-- 
2.19.0

