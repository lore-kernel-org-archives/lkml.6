Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id HkMRDT44GFsdZAAAmS7hNA
	; Wed, 06 Jun 2018 19:39:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8C8776089E; Wed,  6 Jun 2018 19:39:49 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjJwSDTo"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DF11E6074D;
	Wed,  6 Jun 2018 19:39:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DF11E6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752720AbeFFTjq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 15:39:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:53485 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752339AbeFFTjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 15:39:45 -0400
Received: by mail-wm0-f68.google.com with SMTP id x6-v6so13559089wmc.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 12:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=JsoumrurWROYwPouUJKCgxM1w0ObMU2zRAdzyDcHkXk=;
        b=XjJwSDTotPOl0AmO/eDE+tSh1Gmbw2ZLAl6RTosgrs0X8DDKKmrb52n0wrUDydtAgv
         wgzZmDotvZY09UWM4e5BzBod++Pw2g3uw4rjvAufl6a1c5orKhnRlYDI7EH0K0O67Gjx
         GVKsGXNIeWN8bm3xRTVqdbrPayu69VttlHDlxpLWQ9ClJ5ulaz4tCxF+ee4QVpBB6XW5
         3EYP23Q7QSsetdC6f8OQgG/1hHtshJzo0ska8CEZBZyd7HHFPaeJ7zGTfYThwaCJH7OL
         D68EUd9JNLwaZ1TYx2NaATdCY7InaA09U/SJyug3BI1hCYI/WrpjQ8HAUMJd4cRY9vdr
         uF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=JsoumrurWROYwPouUJKCgxM1w0ObMU2zRAdzyDcHkXk=;
        b=i9nrkIWujvc+ER2eniDInIyqud0yuUPDDqIcd+MuuUGoL6BuQZ827XxJjsgjXIjMur
         XIby0xrftddVD567Y3J5MtJb805cIrXPS5fM7DEsDM38sdq27vUBOWbb6kyhRgzCmQnd
         eXQbmMe9+q7gci8i+TlZ1PL0GnnfcIg9moQ9pELrd3XnaT8a+JHMUa0oDvexzi70vvzq
         n7qsZznSVLeRSxwjUSxAdTOh+NioqhaZm5BWe4wT7gYeyT+igv3sX/iApkySjzTGyAaS
         tl+dJbK5OmuFeToacCMU3K2AOfw3aDbIi4L+NojjriSKqAPiSyUeH7YZ9UTaNZ8BU4jO
         X5/A==
X-Gm-Message-State: APt69E2N4qhXbu/+culbcox6xjRtgU0vrk1ISa6IKZDWJPZIz+N4Cm7h
        uw/AxawM/eC7vEGUAaxnRlg=
X-Google-Smtp-Source: ADUXVKLNRQnwJ3bJ/aI6RjuBxlt9jAr9REjp89RYqBBEHvvMHDJw9OdGKl/THPLbYxEv3OxHQNBy4Q==
X-Received: by 2002:a1c:f214:: with SMTP id s20-v6mr2713029wmc.29.1528313983853;
        Wed, 06 Jun 2018 12:39:43 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id t13-v6sm20132513wro.62.2018.06.06.12.39.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 12:39:43 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 24A9210C2B80; Wed,  6 Jun 2018 21:39:42 +0200 (CEST)
From: Mathieu Malaterre <malat@debian.org>
To: Tejun Heo <tj@kernel.org>
Cc: Mathieu Malaterre <malat@debian.org>,
        Christoph Lameter <cl@linux.com>,
        Dennis Zhou <dennisszhou@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] percpu_counter: `percpu_counter_read_positive' should not return negative number
Date: Wed,  6 Jun 2018 21:39:40 +0200
Message-Id: <20180606193940.16126-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since function `percpu_counter_add' may result in a signed integer overflow
the result stored in `fbc->count' could be negative. Make sure that
function `percpu_counter_read_positive' does not return a negative number
in this case. This will match behavior when CONFIG_SMP=y.

Detected wth CONFIG_UBSAN=y

[76404.888450] ================================================================================
[76404.888477] UBSAN: Undefined behaviour in ../include/linux/percpu_counter.h:136:13
[76404.888485] signed integer overflow:
[76404.888490] 9223308017647617321 + 76624449492175 cannot be represented in type 'long long int'
[76404.888501] CPU: 0 PID: 0 Comm: swapper Not tainted 4.17.0+ #50
[76404.888506] Call Trace:
[76404.888523] [dffedd30] [c0478b90] ubsan_epilogue+0x18/0x4c (unreliable)
[76404.888533] [dffedd40] [c0479530] handle_overflow+0xbc/0xdc
[76404.888548] [dffeddc0] [c0439044] cfq_completed_request+0x560/0x1234
[76404.888557] [dffede40] [c03f3fc4] __blk_put_request+0xb0/0x2dc
[76404.888570] [dffede80] [c05a81d0] scsi_end_request+0x19c/0x344
[76404.888579] [dffedeb0] [c05a9954] scsi_io_completion+0x4b4/0x854
[76404.888592] [dffedf10] [c04046b4] blk_done_softirq+0xe4/0x1e0
[76404.888605] [dffedf60] [c07ec1d4] __do_softirq+0x16c/0x5f0
[76404.888617] [dffedfd0] [c0065160] irq_exit+0x110/0x1a8
[76404.888629] [dffedff0] [c001646c] call_do_irq+0x24/0x3c
[76404.888641] [c0cdbe80] [c0009a2c] do_IRQ+0x98/0x1a0
[76404.888649] [c0cdbeb0] [c001b93c] ret_from_except+0x0/0x14
[76404.888659] --- interrupt: 501 at arch_cpu_idle+0x30/0x78
                   LR = arch_cpu_idle+0x30/0x78
[76404.888667] [c0cdbf70] [c0cda000] 0xc0cda000 (unreliable)
[76404.888679] [c0cdbf80] [c00a3844] do_idle+0xc4/0x158
[76404.888687] [c0cdbfb0] [c00a3a90] cpu_startup_entry+0x24/0x28
[76404.888696] [c0cdbfc0] [c097f820] start_kernel+0x47c/0x490
[76404.888703] [c0cdbff0] [00003444] 0x3444
[76404.888708] ================================================================================
[76409.458652] ================================================================================
[76409.458679] UBSAN: Undefined behaviour in ../include/linux/percpu_counter.h:136:13
[76409.458687] signed integer overflow:
[76409.458692] 9223369047059056210 + 76629034867964 cannot be represented in type 'long long int'
[76409.458703] CPU: 0 PID: 0 Comm: swapper Not tainted 4.17.0+ #50
[76409.458708] Call Trace:
[76409.458725] [dffedd30] [c0478b90] ubsan_epilogue+0x18/0x4c (unreliable)
[76409.458736] [dffedd40] [c0479530] handle_overflow+0xbc/0xdc
[76409.458751] [dffeddc0] [c0438e60] cfq_completed_request+0x37c/0x1234
[76409.458759] [dffede40] [c03f3fc4] __blk_put_request+0xb0/0x2dc
[76409.458773] [dffede80] [c05a81d0] scsi_end_request+0x19c/0x344
[76409.458781] [dffedeb0] [c05a9954] scsi_io_completion+0x4b4/0x854
[76409.458794] [dffedf10] [c04046b4] blk_done_softirq+0xe4/0x1e0
[76409.458807] [dffedf60] [c07ec1d4] __do_softirq+0x16c/0x5f0
[76409.458820] [dffedfd0] [c0065160] irq_exit+0x110/0x1a8
[76409.458832] [dffedff0] [c001646c] call_do_irq+0x24/0x3c
[76409.458844] [c0cdbe80] [c0009a2c] do_IRQ+0x98/0x1a0
[76409.458852] [c0cdbeb0] [c001b93c] ret_from_except+0x0/0x14
[76409.458861] --- interrupt: 501 at arch_cpu_idle+0x30/0x78
                   LR = arch_cpu_idle+0x30/0x78
[76409.458870] [c0cdbf70] [c0cda000] 0xc0cda000 (unreliable)
[76409.458882] [c0cdbf80] [c00a3844] do_idle+0xc4/0x158
[76409.458889] [c0cdbfb0] [c00a3a8c] cpu_startup_entry+0x20/0x28
[76409.458899] [c0cdbfc0] [c097f820] start_kernel+0x47c/0x490
[76409.458905] [c0cdbff0] [00003444] 0x3444
[76409.458910] ================================================================================

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 include/linux/percpu_counter.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/linux/percpu_counter.h b/include/linux/percpu_counter.h
index 4f052496cdfd..fd14f629123f 100644
--- a/include/linux/percpu_counter.h
+++ b/include/linux/percpu_counter.h
@@ -133,6 +133,7 @@ static inline void
 percpu_counter_add(struct percpu_counter *fbc, s64 amount)
 {
 	preempt_disable();
+	/* possible signed integer overflow */
 	fbc->count += amount;
 	preempt_enable();
 }
@@ -154,7 +155,10 @@ static inline s64 percpu_counter_read(struct percpu_counter *fbc)
  */
 static inline s64 percpu_counter_read_positive(struct percpu_counter *fbc)
 {
-	return fbc->count;
+	if (fbc->count >= 0)
+		return fbc->count;
+
+	return 0;
 }
 
 static inline s64 percpu_counter_sum_positive(struct percpu_counter *fbc)
-- 
2.11.0
