Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx48nCTA1LBwfmxX6zPVRqeV5bf3JeLiQcaKClfXna+TX4j7+JJRnRTVeleK4SsaUpmIlxE+b
ARC-Seal: i=1; a=rsa-sha256; t=1523549961; cv=none;
        d=google.com; s=arc-20160816;
        b=riPQt0/bXtBL0sRvezJlOoOyYT80F53+m/HP4k4Rh58TpeWmFogsgbrd31DyTLMI3W
         zsacRXbk9bar6qu9pNDmX88FnVEmNY1s86ZhJjxTUkKEeE87bffr1rWMALp6PjW9V2aY
         34PvcpJsXIPUBHqT3wgiqpsUfX7ep3fQFQ8/lZ0h5bTXVIfSKG7GL33Z0uqjBSNz/0qd
         Mp+BopEVSpVWAbtM5wSNZ0Xchq/bLnimJcD6QRjv8HhruVRPaE3kXF2lokxkwU/Ypcmi
         cU1Rvh8tPizFbdDLwHKGy7qoHTtihTVxQNUvbxO10k6xm0q53KMMBqw6zCEKLy8POCHz
         qf9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=fF3DppEkUSXC00JRrwsI363IKsfIGbG/2m35s2eTat4=;
        b=w+YaVw6uc2ecjtUW82yr+iPFPJEx9CrUeiPqTIi6pOurvXt1ovRekekBrTSQnhobVl
         7Hs6n8d9166CwIIWCXIdguoqxjgT1oR9fP0a0inpeL/05DVyIB75RxOnIStKxfWNv192
         EaTz8+fWhEzy3Mp4OZaPvZQxBcsv7Fs/NSZsrMZqBnC3bs4iTCmlP6gl4ses7Xu+sa8w
         A62+pbkhVhrgSCyEEXnl4K3FTLuw4IOQUxho0/KjuFiQxss/OoDxq9hx9rSnE/ra4Vyz
         lQiCGAsrsFlguZlb5UkrQ+pS2Tbn1cnT0OgtgeSE40T9N9ToUGJ+R+x5L30O5+I4JbDn
         fznw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752470AbeDLQTU convert rfc822-to-8bit (ORCPT
        <rfc822;gregkh@linuxfoundation.org>); Thu, 12 Apr 2018 12:19:20 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:39682 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752437AbeDLQTU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 Apr 2018 12:19:20 -0400
From: Peng Hao <peng.hao2@zte.com.cn>
To: shuah@kernel.org, pbonzini@redhat.com, hofsass@google.com
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH] kvm: selftests: add -std=gnu99 cflags
Date: Fri, 13 Apr 2018 08:36:30 +0800
Message-Id: <1523579790-30773-1-git-send-email-peng.hao2@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-04-13 00:19:20,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-04-13 00:19:00
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-MAIL: mse01.zte.com.cn w3CGJBF4011139
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597557924560402421?=
X-GMAIL-MSGID: =?utf-8?q?1597557924560402421?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

lib/kvm_util.c: In function ‘kvm_memcmp_hva_gva’:
lib/kvm_util.c:332:2: error: ‘for’ loop initial declarations are only allowed in C99 mode

So add -std=gnu99 to CFLAGS

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 tools/testing/selftests/kvm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index dc44de9..1da541e 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -14,7 +14,7 @@ LIBKVM += $(LIBKVM_$(UNAME_M))
 
 INSTALL_HDR_PATH = $(top_srcdir)/usr
 LINUX_HDR_PATH = $(INSTALL_HDR_PATH)/include/
-CFLAGS += -O2 -g -I$(LINUX_HDR_PATH) -Iinclude -I$(<D)
+CFLAGS += -O2 -g -std=gnu99 -I$(LINUX_HDR_PATH) -Iinclude -I$(<D)
 
 # After inclusion, $(OUTPUT) is defined and
 # $(TEST_GEN_PROGS) starts with $(OUTPUT)/
-- 
1.8.3.1

