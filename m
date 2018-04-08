Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753111AbeDHUTq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:19:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752932AbeDHUSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:18:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C58121841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180408201837.571969005@goodmis.org>
User-Agent: quilt/0.63-1
Date: Sun, 08 Apr 2018 16:17:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
        Scott Wood <swood@redhat.com>,
        Tim Tianyang Chen <tianyang.chen@oracle.com>
Subject: [for-next][PATCH 22/23] ktest.pl: Use run_command to execute sending mail
References: <20180408201708.346970379@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0022-ktest.pl-Use-run_command-to-execute-sending-mail.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Instead of open coding system() call, use run_command which will log the
sending of email as well.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index ac6750bb5942..f487f91ccf03 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -4135,12 +4135,12 @@ sub set_test_option {
 
 sub _mailx_send {
     my ($subject, $message) = @_;
-    system("$mail_path/$mailer -s \'$subject\' $mailto <<< \'$message\'");
+    run_command "$mail_path/$mailer -s \'$subject\' $mailto <<< \'$message\'";
 }
 
 sub _sendmail_send {
     my ($subject, $message) = @_;
-    system("echo -e \"Subject: $subject\n\n$message\" | $mail_path/sendmail -t $mailto");
+    run_command "echo \'Subject: $subject\n\n$message\' | $mail_path/sendmail -t $mailto";
 }
 
 sub find_mailer {
-- 
2.16.3
