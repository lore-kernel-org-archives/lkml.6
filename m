Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-604752-1520349395-2-11063526031496814451
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520349395; b=dlDTFtT/nJ6WEwnWvF5Fa+KAytJi6S6xjRhqfg7w3jwGQwW
    YDr4uIszBu6DlZtty7zeZmdZ0SpV9ufoydQzyUzTwqUOb0BE3etYV338K/bXj7W1
    naupa0EM2DKx+/um4EsLfhxX7m5bISjlKMmzdJOnAjHkifylVtmrvmoLtZMd+bn1
    4uFyiNSgsJa1E6S2tnoN+cUeGMQrdfTk+Itu6MKiFMiZGniCndrwRunA95uz4qIk
    9EYSI/QGlFW9vdUvy7jjOd4gsaWEcEu4Z2DhEeVKp7YyB9lwjmY2ldoI+dDB0/ZW
    IEPqrKHE9b5hOl/EZWAsTN4nb1RXLWFtSv8WLfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1520349395; bh=39V42TPWWaK8DtE93Inbmc21Gm
    Or1xG8DSaUk/S1tAg=; b=PtazOVDtJHuRsO6EeS63FZrXKLYOqLI+seQCE9A052
    sCRxvv2lWol3U8+10I05Mv4yEm4GsaTqfrL5xX2jYbZE0ADmsqAtqfPXNvS57ivx
    LpaSXqlLNsnfDjyZ6Y1ARE7wtVTBlKvpeeZ31GtFDgYwpsezx2PEoR0gFeg2xvNJ
    wwf8OBspIVZs3HM/BA5fds9PIjcMUiBSjK/+j77hNJ/cJ6hr0Rxqcny2v7Z7EHZ/
    A48b5PvotMsMs+OTfFh2387MCUWWvzLC0vQgXxm53MgpLueZvA6crDoh8Hk4vsI0
    S6AaOWsi/s2tB8Q1D/DCWl4i4j9lXZQhtz71/CaEjEAA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VrNsQ3pJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AfvR4kV0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=VrNsQ3pJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=AfvR4kV0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753291AbeCFPQc (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 10:16:32 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40536 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753065AbeCFPQb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Mar 2018 10:16:31 -0500
X-Google-Smtp-Source: AG47ELsFcZqwoyP5aoG7GubrNWSGrtr8mmXuE9APV7aKSUF1nNzckPeJeSk/gpkPA/YqziYA+mHLTA==
From: Leon Yu <chianglungyu@gmail.com>
To: Jessica Yu <jeyu@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc: Leon Yu <chianglungyu@gmail.com>, stable@vger.kernel.org
Subject: [PATCH resend] module: propagate error in modules_open()
Date: Tue,  6 Mar 2018 23:16:24 +0800
Message-Id: <20180306151624.24196-1-chianglungyu@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

otherwise kernel can oops later in seq_release() due to dereferencing null
file->private_data which is only set if seq_open() succeeds.

BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
IP: seq_release+0xc/0x30
Call Trace:
 close_pdeo+0x37/0xd0
 proc_reg_release+0x5d/0x60
 __fput+0x9d/0x1d0
 ____fput+0x9/0x10
 task_work_run+0x75/0x90
 do_exit+0x252/0xa00
 do_group_exit+0x36/0xb0
 SyS_exit_group+0xf/0x10

Fixes: 516fb7f2e73d ("/proc/module: use the same logic as /proc/kallsyms for address exposure")
Cc: Jessica Yu <jeyu@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable@vger.kernel.org # 4.15+
Signed-off-by: Leon Yu <chianglungyu@gmail.com>
---
 kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index ad2d420024f6..e42764acedb4 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -4228,7 +4228,7 @@ static int modules_open(struct inode *inode, struct file *file)
 		m->private = kallsyms_show_value() ? NULL : (void *)8ul;
 	}
 
-	return 0;
+	return err;
 }
 
 static const struct file_operations proc_modules_operations = {
--
2.16.2
