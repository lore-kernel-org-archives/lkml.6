Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753680AbeDJOGc (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:06:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752907AbeDJOGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:06:31 -0400
From: Miroslav Lichvar <mlichvar@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Prarit Bhargava <prarit@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Stephen Boyd <stephen.boyd@linaro.org>
Subject: [PATCH] kselftests: timers: freq-step: Update maximum acceptable precision and errors
Date: Tue, 10 Apr 2018 16:06:30 +0200
Message-Id: <20180410140630.17762-1-mlichvar@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PTI has a significant impact on precision of the MONOTONIC_RAW clock,
which prevents a lot of computers from running the freq-step test.
Increase the maximum acceptable precision for the test to not be skipped
to 500 nanoseconds.

After commit 78b98e3c5a66 ("timekeeping/ntp: Determine the multiplier
directly from NTP tick length") the frequency and time errors should be
much smaller. Reduce the maximum acceptable values for the test to pass
to 0.02 ppm and 50 nanoseconds respectively.

Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Stephen Boyd <stephen.boyd@linaro.org>
Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
---
 tools/testing/selftests/timers/freq-step.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/timers/freq-step.c b/tools/testing/selftests/timers/freq-step.c
index 14a2b77fd012..cd094b49819f 100644
--- a/tools/testing/selftests/timers/freq-step.c
+++ b/tools/testing/selftests/timers/freq-step.c
@@ -29,9 +29,9 @@
 #define SAMPLE_READINGS 10
 #define MEAN_SAMPLE_INTERVAL 0.1
 #define STEP_INTERVAL 1.0
-#define MAX_PRECISION 100e-9
-#define MAX_FREQ_ERROR 10e-6
-#define MAX_STDDEV 1000e-9
+#define MAX_PRECISION 500e-9
+#define MAX_FREQ_ERROR 0.02e-6
+#define MAX_STDDEV 50e-9
 
 #ifndef ADJ_SETOFFSET
   #define ADJ_SETOFFSET 0x0100
-- 
2.14.3
