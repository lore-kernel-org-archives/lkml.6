Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC0EC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EFE12086A
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUBW/cVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EFE12086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730093AbeKQJJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:09:15 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42643 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbeKQJJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:09:15 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so7760694pga.9;
        Fri, 16 Nov 2018 14:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Lb55zmtPsOStDQONz//CdF2ciI5pvqLHci40avVw6SQ=;
        b=kUBW/cVZj5lNthq8EInJ6Xpmz3GuYqU+0jJEONP5aA3Eg0tvjO3g9dRAI4sIqtE5lY
         TaTInVky6tV5wXH6sDGqGFHfEBWa5XrJeZArsxENU+FxP07sk/m2Hmv3LRJxfBwPKR4S
         btlDb9MzI4Rrh4gFqgvVHgqUq7h7kzOR1rkFpgW47jLoAnquXgELtmiQNUoAd1WOCkh7
         0zOCQkVbmVAmhTPGS1pu6ettwN43FlWC/8U7Z8vu1X048HeOLspvDS3Z+37QKOuPA1sU
         VqpMZDqETZ/AVTQ18md+VAb+2Td0wuoRk0JKXPsCqsv/uaZjS6/WUOGWTrPzTjqmUx4a
         bCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Lb55zmtPsOStDQONz//CdF2ciI5pvqLHci40avVw6SQ=;
        b=X0FjjFKfoBA7iX+ChZIxtI7afzx2ryQVyXwuvzjHW2vQZcwrNjeiN7Ivh2gdDKYqss
         QvaGTuRJpkvqZ85DhyKn13nYiXK4lnv09pkacuPVTLMcWK7Y6xHcwFKZz93qJR8b8C4C
         NsX5RpGxwiaRY9gv3LE8KcZvTXLBnwpn/LeLadXxuRPdobR0Z2kvOSTCy88covqhhqfs
         /6/D4erdWvcey16+C/CXRUpgjc0XvAOgQJmGFm/MtAzOxztPBdZzGj+3MqWqiJRtAlOo
         qr1FAxN1DasJglNCP5vwIRYMBrRg/YRpM1nG1TxfmWMEvqQNoJxkHttiUS0mHc0TmxWv
         UmSQ==
X-Gm-Message-State: AGRZ1gJGzdL1ZcqROCsldw5guklpaoUOoLWbbqf0rrf5a+2b4zZ4TKgh
        qKP6JZ+o0GxuNT6WocA+csJ9jwX5
X-Google-Smtp-Source: AJdET5cQFKJ2K9FHffL4cC22JUMm2Kj7JbT6aDB2qCvvFjFjzrUJs72D0hcURWvF7BEAdmt1GrSCAA==
X-Received: by 2002:a65:434d:: with SMTP id k13mr11760462pgq.269.1542408897891;
        Fri, 16 Nov 2018 14:54:57 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net (igp-prod-emp-gw.vpn.broadcom.com. [192.19.223.250])
        by smtp.gmail.com with ESMTPSA id j64-v6sm1555855pfc.43.2018.11.16.14.54.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 14:54:57 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     will.deacon@arm.com, linux-arm-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH] perf: tests: Disable breakpoint tests on ARM (32-bit)
Date:   Fri, 16 Nov 2018 14:53:07 -0800
Message-Id: <20181116225309.13938-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

breakpoint tests on the ARM 32-bit kernel are broken in several ways.

The breakpoint length requested does not necessarily match whether the
function address has the Thumb bit (bit 0) set or not, and this does
matter to the ARM kernel hw_breakpoint infrastructure. See [1] for
background.

[1]: https://lkml.org/lkml/2018/11/15/205

As Will indicated, the overflow handling would require single-stepping
which is not supported at the moment. Just disable those tests for the
ARM 32-bit platforms.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 tools/perf/tests/bp_signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index a467615c5a0e..3b5471ea2331 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -296,7 +296,7 @@ bool test__bp_signal_is_supported(void)
  * instruction breakpoint using the perf event interface.
  * Once it's there we can release this.
  */
-#if defined(__powerpc__) || defined(__s390x__)
+#if defined(__powerpc__) || defined(__s390x__) || defined(__arm__)
 	return false;
 #else
 	return true;
-- 
2.17.1

