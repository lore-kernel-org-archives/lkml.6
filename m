Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3104079-1519395297-2-18376580456415886643
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES daensv,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519395296; b=TqIU+m8tG54r3+C/qS9ZGtrQ+bfd6aIg0Ywqe+0LG9R0/gB
    Fdb3wzrltltvyspAfye/7Wdw0PKkqd3zBslHx4YE46Gvugbl3vFHyqP9UtTbegRG
    90vUTp8JQr1ZQWf9PnkgtNlKKZ5oPtMXfO3gFdVGWfhgY4MgtQ9xntMRhTWFICf9
    pelp6pJiyIsEXVmtU4IL2yn02lKuaupgWGrpD6JoaazP4eANDD+XOUc14cCSl7MA
    JuiU9/G6b4Qp57nzw/K6e+5/vgwiM5u+0Zz9gULW5LtofcaHxRoMB7YxWbD7qqRd
    w6SOdn5nbG8WX1oEoS9Ifg9hEPB626iTrDqjPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:content-transfer-encoding:sender
    :list-id; s=arctest; t=1519395296; bh=fDceDg6x9Ys8DcLNEAId7Omxbb
    RJQ7MDExW7XymNaB0=; b=qFo1pHjcMUoCDmVXnSzHm9FqpSczzcUKp49NZnnjL/
    PZuOhGqzMTriy/bEi7WKmo1IFgLYIYRt6WCEFv7u5M03Tt6zaBFQQbbWEKdmStEj
    ouNLKVeMY/EGT81qjX3t7+b8FK6hrhuaqcRu6EpQXZswCAa57snpcsLK9A6QV2ep
    NhK52+mAyC9LIJgIgpNyOdaRU+4b/9pg4WFsMIRa4QZZDnn9vJZEfW5x3KaqGArs
    153VC8sKz2Rb3e1G5cvqZAbOa4X5HsFOZ36e+QFTVezm1rjkVwep/55xHJ1HgCRh
    c1TcX5+4bn5Z9MQy2SXq68ZzfVkeOceoLPtddX7VqCLw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=canonical.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=canonical.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751365AbeBWOOy (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 09:14:54 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:51593 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeBWOOx (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Fri, 23 Feb 2018 09:14:53 -0500
From: Colin King <colin.king@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
Subject: [PATCH] serial: mvebu-uart: remove duplicated bit-wise or of STAT_FRM_ERR
Date: Fri, 23 Feb 2018 14:14:51 +0000
Message-Id: <20180223141451.28957-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Bit pattern STAT_FRM_ERR is being bit-wise or'd twice; remove the
redundant 2nd STAT_FRM_ERR

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tty/serial/mvebu-uart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index a100e98259d7..ec3d4e3dab29 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -65,7 +65,7 @@
 #define  STAT_FRM_ERR		BIT(2)
 #define  STAT_PAR_ERR		BIT(1)
 #define  STAT_OVR_ERR		BIT(0)
-#define  STAT_BRK_ERR		(STAT_BRK_DET | STAT_FRM_ERR | STAT_FRM_ERR\
+#define  STAT_BRK_ERR		(STAT_BRK_DET | STAT_FRM_ERR \
 				 | STAT_PAR_ERR | STAT_OVR_ERR)
 
 #define UART_BRDV		0x10
-- 
2.15.1

