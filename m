Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1923497-1521568650-2-14866741890947820657
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enro, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521568649; b=KVqCkRsZ9sD4AeyZLMCTPiRgv9n/pHnTWDJBCZHmnQ16vNC
    L1vkXbjKy0ylqgHqt96zr+iZ3RyPnp4N2UoJnWZPJKhBAz+DbIzYGaUZdcuELv2S
    0ywuZryQxuKRkpwwFI9L0kTIvSKJ8LHuCiUrUE5RXq9wuJKixyoJNz60HKVPEbRE
    P0HUMPCZZpKRvLiIG+tbCJkYxsUS3C8X2VqVsH/HBT9WzYnEPusYD/tftFQ7dry8
    odkbZ4PluJvIPjrToCm9FsHvS3lgTVHq+f80kWizCOalG1fn2HsL4P1kKsDUhlPR
    hOQZvgB8TtLzJxMOnzOQ1uSWm4r6fKQHqUSMKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1521568649;
    bh=XbOcHcclQrHN8LPH5EaCg9d1nubgSFCtFMnmkuTl6/s=; b=JqaHzpSNL9DR
    tE2/jvVhHZe7d/qx9yGu2wVOcuQvYttQuNz8uIJ9SH0Em7W9qPyRPUJ/EKkT9hrS
    kBQMaD9QYsbTLObuDriCQDugyqkLHgrSYzxN7NOUChwx5JidzyZ0I9WF/ytpjbde
    RMksCcIvNKU6eISKXyQ6hZZB5XwtdDU4zA0SLntSwRrM1o208tqNymuhNzfzP/dT
    ldSF64rm+iVY/d2EBKqBJOAULD7GovNyoHZluQXxvQ0BCLUicrJIPp/qIWX68H4J
    XNRmi1+UJwD4eTpuxEa9b8/g9a29RxIOtYb4Vfz7iR5Smgqo7Lb5U4Q4GBz6tpF4
    hZKXBnApyg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=IXMDf9DK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IjZbxV3Q;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=chromium.org header.i=@chromium.org header.b=IXMDf9DK x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=chromium.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=IjZbxV3Q;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=chromium.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751557AbeCTR51 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 13:57:27 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:45496 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbeCTR5V (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 20 Mar 2018 13:57:21 -0400
X-Google-Smtp-Source: AG47ELug7r7xqjGbUzqqdSi4u3aBRlStVfho+s2hLFk1RFNMTc2vpJp9R+m8D0PAJox7IXGzyMRKRQ==
From: Daniel Kurtz <djkurtz@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Cc: adurbin@chromium.org, linux-kernel@vger.kernel.org,
        Daniel Kurtz <djkurtz@chromium.org>,
        Jiri Slaby <jslaby@suse.com>,
        linux-serial@vger.kernel.org (open list:SERIAL DRIVERS)
Subject: [PATCH v2 1/2] serial: sh-sci: Remove __initdata attribute for struct 'port_cfg'
Date: Tue, 20 Mar 2018 11:57:11 -0600
Message-Id: <20180320175712.201572-2-djkurtz@chromium.org>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
In-Reply-To: <20180320175712.201572-1-djkurtz@chromium.org>
References: <20180320175712.201572-1-djkurtz@chromium.org>
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit dd076cffb8cd ("serial: sh-sci: Fix init data attribute for struct
'port_cfg'") properly removed the __init attribute, and changed it to
__initdata.

The __init function early_console_setup() takes the address of global
port_cfg and assigns it to a field in another global, sci_ports:

static int __init early_console_setup(struct earlycon_device *device,
      int type)
{
...
port_cfg.type = type;
sci_ports[0].cfg = &port_cfg;
...
}

port_cfg, however, is now in __initdata:
static struct plat_sci_port port_cfg __initdata;

... but sci_ports is not:
static struct sci_port sci_ports[SCI_NPORTS];

Thus, there is a non-__initdata variable containing the address of a
__initdata struct.

Fix this section type conflict by just removing the __initdata attribute.

Fixes: dd076cffb8cd ("serial: sh-sci: Fix init data attribute for struct 'port_cfg'")
Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 drivers/tty/serial/sh-sci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 44adf9db38f8..ff4e1012ed76 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3277,7 +3277,7 @@ early_platform_init_buffer("earlyprintk", &sci_driver,
 			   early_serial_buf, ARRAY_SIZE(early_serial_buf));
 #endif
 #ifdef CONFIG_SERIAL_SH_SCI_EARLYCON
-static struct plat_sci_port port_cfg __initdata;
+static struct plat_sci_port port_cfg;
 
 static int __init early_console_setup(struct earlycon_device *device,
 				      int type)
-- 
2.16.2.804.g6dcf76e118-goog

