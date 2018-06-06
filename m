Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 3i6zICI5GFtHaAAAmS7hNA
	; Wed, 06 Jun 2018 19:42:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 80C56608BA; Wed,  6 Jun 2018 19:42:40 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMQ2LGCS"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id E0F97608BF;
	Wed,  6 Jun 2018 19:42:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E0F97608BF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752656AbeFFTmh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 15:42:37 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36222 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752193AbeFFTmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 15:42:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id v131-v6so14222064wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jun 2018 12:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6SGdZx92oNd3YIFsxTGFVyPKnIH99jNr0SeD9U8bliw=;
        b=ZMQ2LGCSmr/LYzP/FJrJNpCIadLXQVBZal/tzmyu3GFT12pZajXdA8yQw9nrGkjD0x
         42MhnuKiOKiys66/364AiG4ri2KZGvevuKG39AvoTyghy+tftZRfKf/2itAiNcelCUI0
         HuRMyAEr4E2A1k/gnafD4yX8+dd1EhGhtSV7+13tYPYoSC+boiTgYo3bSx5DCTGVdJM9
         BY78SoJlhmdB/rgauDGwBPwGlGWsqSOfLcBG3IJzgZl4heAFO/vdOFzWmfgWLQ4kIgWs
         Tt1jlMOtFkwiQ26Sc95F/Sw24luIMIuWA3nkKT/abKIP7iRUK3t9O7t5IbjL0I0jP5JV
         MORQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=6SGdZx92oNd3YIFsxTGFVyPKnIH99jNr0SeD9U8bliw=;
        b=R9aLv7bUd6jAeVAZt7QVms0Xu7kuvgqL81MJmubID3yfbyb6WeJm62rRGOPOIEV43S
         qPlAB+EuPaLYo0wlHpiIgmFETeUGCEuPFSTT+V5o3GH3zrkCD5qlCPop2VJitxsst4vm
         sEsNmFglAMs1TKrQnepKpFJ+VUKpIsYtSodifCD+PAKDUiyxNKPzrEuDgHe4OpNCUnC6
         VgfaiVi/Qfk/DEh0tWw5fbg9loRQUwj63aaahVOgagEEGM2OWLOTckT3Blh5kmY6kZMW
         x6SgEvszrBwspfAKY+8BTKmbhE2B5PTHTfy3vJvkFDzwi1D0EWR+g6xxER1uZprKmZZW
         FVQA==
X-Gm-Message-State: APt69E0guNaSrlDUVKBt3UhyoH3Ap2P29yytWeO7wcpI4cYjRJMWHiRe
        D9d9XuYV8C5nKWyPnwfhqWU=
X-Google-Smtp-Source: ADUXVKLxW1NVoQZGt3NiLE60fycAs+6MFUexQ5Bt6anb9yJZP5IJu/L202SoryQ0BJJNO0aB59/YtA==
X-Received: by 2002:a1c:448b:: with SMTP id r133-v6mr2499328wma.55.1528314155147;
        Wed, 06 Jun 2018 12:42:35 -0700 (PDT)
Received: from macbookpro.malat.net (bru31-1-78-225-226-121.fbx.proxad.net. [78.225.226.121])
        by smtp.gmail.com with ESMTPSA id b16-v6sm14743265wrm.15.2018.06.06.12.42.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Jun 2018 12:42:34 -0700 (PDT)
Received: by macbookpro.malat.net (Postfix, from userid 1000)
        id 98FEC10C2B80; Wed,  6 Jun 2018 21:42:33 +0200 (CEST)
From: Mathieu Malaterre <malat@debian.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mathieu Malaterre <malat@debian.org>,
        Babu Moger <babu.moger@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kernel/watchdog: add missing prototypes for weak functions
Date: Wed,  6 Jun 2018 21:42:32 +0200
Message-Id: <20180606194232.17653-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit 73ce0511c436 ("kernel/watchdog.c: move hardlockup detector to
separate file") two new functions were added ‘watchdog_nmi_enable’ and
‘watchdog_nmi_disable’ the functions were changed from static to weak.
In which case expose the function declarations in header file.

Silence the following gcc warnings:

  kernel/watchdog.c:109:12: warning: no previous prototype for ‘watchdog_nmi_enable’ [-Wmissing-prototypes]
  kernel/watchdog.c:115:13: warning: no previous prototype for ‘watchdog_nmi_disable’ [-Wmissing-prototypes]

Cc: Babu Moger <babu.moger@oracle.com>
Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 include/linux/nmi.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index b8d868d23e79..50d143995338 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -113,6 +113,8 @@ static inline int hardlockup_detector_perf_init(void) { return 0; }
 void watchdog_nmi_stop(void);
 void watchdog_nmi_start(void);
 int watchdog_nmi_probe(void);
+int watchdog_nmi_enable(unsigned int cpu);
+void watchdog_nmi_disable(unsigned int cpu);
 
 /**
  * touch_nmi_watchdog - restart NMI watchdog timeout.
-- 
2.11.0
