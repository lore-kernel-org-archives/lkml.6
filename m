Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753171AbeDHUUh (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:20:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752912AbeDHUSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:18:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A29812183C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180408201836.480136222@goodmis.org>
User-Agent: quilt/0.63-1
Date: Sun, 08 Apr 2018 16:17:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
        Scott Wood <swood@redhat.com>,
        Tim Tianyang Chen <tianyang.chen@oracle.com>
Subject: [for-next][PATCH 18/23] ktest.pl: No need to print no mailer is specified when mailto is not
References: <20180408201708.346970379@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0018-ktest.pl-No-need-to-print-no-mailer-is-specified-whe.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If the user doesn't want to send mail, then don't bother them with output
that says they didn't specify a mailer. That can be annoying.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 30a4c053f98b..07d0a47816e4 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -4135,12 +4135,14 @@ sub _sendmail_send {
 }
 
 sub send_email {
-    if (defined($mailto) && defined($mailer)) {
+    if (defined($mailto)) {
+	if (!defined($mailer)) {
+	    doprint "No email sent: email or mailer not specified in config.\n";
+	    return;
+	}
         if ($mailer eq "mail" || $mailer eq "mailx"){ _mailx_send(@_);}
         elsif ($mailer eq "sendmail" ) { _sendmail_send(@_);}
         else { doprint "\nYour mailer: $mailer is not supported.\n" }
-    } else {
-        print "No email sent: email or mailer not specified in config.\n"
     }
 }
 
-- 
2.16.3
