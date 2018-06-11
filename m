Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Pa9dBw2gHlsDMwAAmS7hNA
	; Mon, 11 Jun 2018 16:15:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A0348607A4; Mon, 11 Jun 2018 16:15:19 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="j89aEuS8"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 712EB601C3;
	Mon, 11 Jun 2018 16:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 712EB601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933283AbeFKQPR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 12:15:17 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:41172 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933242AbeFKQPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 12:15:12 -0400
Received: by mail-pg0-f67.google.com with SMTP id l65-v6so9980122pgl.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 09:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=keqn+229SBus/F711ElacOgKgpQOxHNTPwATX7IzJMw=;
        b=j89aEuS80vWbJaBOEuw3Hkk3oCmefPT1D3djJfDMt80l5ZKzmQX4g3Kxj6Ch2/MMK+
         3P/fkS/fleurKv0/p3ccQ+D+CRxud2Y3YljWmlx27gQrN0ehUQJSA5cSKQ31v4bxn4GQ
         muEJpvjehINNgYl51SwRihzXDn8tHM2Sk8kqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=keqn+229SBus/F711ElacOgKgpQOxHNTPwATX7IzJMw=;
        b=cqpTL3aje+jWGba0SKqGOoYJZQAQvY21kMeWcxvUmzmquQl1zartMLMTbMBPpuMT7W
         MopX4cXbCE4xR69RcSSx+FroUjGw2fPRRHjHjDdG6584m9z13z7/PQOgy/oXfAAssVA+
         J5z8sS46gc8jnmnawsR19Vtz7aklDoVstB+tYZtDi6fXfB8nxnxOznhEh7j2sl8q9WD2
         ST6pYM+LQDO9GXEWbspOb7PYs3KfquE6rt6y0gjxBBGaUfpHdarKvdavlM2uZ5koFMYX
         ifFLUS0fCdc+PGMe1KZYgwPRKb2xS/Vbq986T8FFG3AKqMjtWOoOgDYUczwtjJQIS7ie
         Oj6Q==
X-Gm-Message-State: APt69E02d9rhyEW5vMs1o/5ga5YMT9p6m54pS0NCoEkySOjus97O63n5
        XGhY7dRGFNwZY0g6RDCa4Dj3IA==
X-Google-Smtp-Source: ADUXVKKJPagO9BFn3OWOs2PdYW7aMbRXqWwHebO2MmL8lsBsra9de8/6AJqNqMgG8rDIQJyphVW2XA==
X-Received: by 2002:a63:6ecd:: with SMTP id j196-v6mr15043902pgc.12.1528733711109;
        Mon, 11 Jun 2018 09:15:11 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id y2-v6sm26253136pfk.82.2018.06.11.09.15.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 11 Jun 2018 09:15:10 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: corbet@lwn.net, joe@perches.com
Cc: tom.saeger@oracle.com, changbin.du@intel.com,
        alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: Fix reference to stm.txt
Date: Mon, 11 Jun 2018 10:15:08 -0600
Message-Id: <1528733708-9999-1-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit "1606f8d8e75b trace doc: convert trace/stm.txt to rst format"
changed stm.txt to stm.rst but references to it in other files have not
been modified, something that is corrected in this patch.

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 Documentation/trace/coresight.txt | 2 +-
 Documentation/trace/intel_th.rst  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/trace/coresight.txt b/Documentation/trace/coresight.txt
index 1d74ad0202b6..efbc832146e7 100644
--- a/Documentation/trace/coresight.txt
+++ b/Documentation/trace/coresight.txt
@@ -426,5 +426,5 @@ root@genericarmv8:~#
 Details on how to use the generic STM API can be found here [2].
 
 [1]. Documentation/ABI/testing/sysfs-bus-coresight-devices-stm
-[2]. Documentation/trace/stm.txt
+[2]. Documentation/trace/stm.rst
 [3]. https://github.com/Linaro/perf-opencsd
diff --git a/Documentation/trace/intel_th.rst b/Documentation/trace/intel_th.rst
index 990f13265178..fdb34114ee20 100644
--- a/Documentation/trace/intel_th.rst
+++ b/Documentation/trace/intel_th.rst
@@ -38,7 +38,7 @@ description is at Documentation/ABI/testing/sysfs-bus-intel_th-devices-gth.
 
 STH registers an stm class device, through which it provides interface
 to userspace and kernelspace software trace sources. See
-Documentation/trace/stm.txt for more information on that.
+Documentation/trace/stm.rst for more information on that.
 
 MSU can be configured to collect trace data into a system memory
 buffer, which can later on be read from its device nodes via read() or
@@ -89,7 +89,7 @@ Quick example
 
 	$ echo 1 > /sys/bus/intel_th/devices/0-msc0/active
 
-# .. send data to master 33, see stm.txt for more details ..
+# .. send data to master 33, see stm.rst for more details ..
 # .. wait for traces to pile up ..
 # .. and stop the trace::
 
-- 
2.7.4
