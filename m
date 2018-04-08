Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753151AbeDHUUN (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 16:20:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:34122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752921AbeDHUSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 16:18:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C77F2183D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Message-Id: <20180408201836.933998448@goodmis.org>
User-Agent: quilt/0.63-1
Date: Sun, 08 Apr 2018 16:17:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: "John Warthog9 Hawley" <warthog9@kernel.org>,
        Scott Wood <swood@redhat.com>,
        Tim Tianyang Chen <tianyang.chen@oracle.com>
Subject: [for-next][PATCH 20/23] ktest.pl: Kill test if mailer is not supported
References: <20180408201708.346970379@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=0020-ktest.pl-Kill-test-if-mailer-is-not-supported.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If the user specifies a MAILTO, but the MAILER is not supported, then
kill the test.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/testing/ktest/ktest.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/ktest/ktest.pl b/tools/testing/ktest/ktest.pl
index 637545bd9e98..3400a23e6a41 100755
--- a/tools/testing/ktest/ktest.pl
+++ b/tools/testing/ktest/ktest.pl
@@ -4168,7 +4168,7 @@ sub send_email {
 	}
         if ($mailer eq "mail" || $mailer eq "mailx"){ _mailx_send(@_);}
         elsif ($mailer eq "sendmail" ) { _sendmail_send(@_);}
-        else { doprint "\nYour mailer: $mailer is not supported.\n" }
+        else { die "\nYour mailer: $mailer is not supported.\n" }
     }
 }
 
-- 
2.16.3
