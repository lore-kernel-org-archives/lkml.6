Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753046AbeDHUWx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:22:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752623AbeDHUSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:18:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36E2E21849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180408201834.120756604@goodmis.org>
User-Agent: quilt/0.63-1
Date: Sun, 08 Apr 2018 16:17:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
        Scott Wood <swood@redhat.com>,
        Tim Tianyang Chen <tianyang.chen@oracle.com>
Subject: [for-next][PATCH 06/23] ktest: Set do_not_reboot=y for CONFIG_BISECT_TYPE=build
References: <20180408201708.346970379@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0006-ktest-Set-do_not_reboot-y-for-CONFIG_BISECT_TYPE-bui.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Scott Wood <swood@redhat.com>

Currently setting do_not_reboot is triggered by simple builds and bisect
builds, but not config bisect builds.

Link: http://lkml.kernel.org/r/20170717001630.10518-3-swood@redhat.com

Signed-off-by: Scott Wood <swood@redhat.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 80091dfbce4b..f597f9b4e8d5 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -1400,7 +1400,8 @@ sub do_not_reboot {
 
     return $test_type eq "build" || $no_reboot ||
 	($test_type eq "patchcheck" && $opt{"PATCHCHECK_TYPE[$i]"} eq "build") ||
-	($test_type eq "bisect" && $opt{"BISECT_TYPE[$i]"} eq "build");
+	($test_type eq "bisect" && $opt{"BISECT_TYPE[$i]"} eq "build") ||
+	($test_type eq "config_bisect" && $opt{"CONFIG_BISECT_TYPE[$i]"} eq "build");
 }
 
 sub dodie {
-- 
2.16.3
