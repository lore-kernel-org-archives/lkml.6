Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-899921-1524473745-2-7970055485607567294
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524473744; b=Ns16EluozIXb3UPlQknp6jjPwQrJ415qCk1wcgjoRyAzLa2pFV
    w1Qjy/2UTlxtI/AJgNyONPTepx7ISD/uWPEsHiPfXjWmyHlQrNAkkwzhqTguzy5Q
    X9OApaIWve3wUUTyeN/UBH3T3mwjpfgUzZCmrT25OkhMqP+Gz7PYFw3LduvQh/2Y
    wSvAHXzOF90ftBUHL5OokVMlcLT0EIpQCBfaZTUf+VtZm8LxMegHhRQkcPtqT0VX
    G3F+YCCSTBM3FFJEP3vmfPKWKeWQQYkrY4HoyIN1gWcSbXUmTlu8vyobCCbVoDmi
    sFoZpII/gnrhmf0c/3ndD6SqjYTIw9wme1Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524473744; bh=OabwlFmv/Xo+xH/DlpJajz0AG8jGZc
    1mkBij8NHSMAc=; b=iIm50SIzhc+mUselIOmf3ozAHbnbmiY+M+4fzTu/TtZTa3
    pjssAoTlUHfwE17ZRoR+3ejTdGslP+h6tz0XBtL1U5ZMEVdw0UKNHmAbXMeQ+r0d
    Ris91p8lIEs+3Wj2JwcpgZoml51OzRTay47cVN5m4CaZ+O4PUfldftPQoofqI7AK
    6BZAnL69F7Atg4oji4lVkrUfdwSRBciqW8IgqiR7HOSetb/wJ69NVchBmPQoymAY
    d9a3/wX25KTNecjWuBWt0RQScnRoYpZf+WSF5KnzPMzwGrB//Cgss/ErpufU2sTy
    uNJJ7ETzhoQEBD+GixdEG/kc/+anjE+S6TNZcifg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b=JaQawK2N x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hr4vqV9I;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b=JaQawK2N x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hr4vqV9I;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfE01tb4C6pHCRIhQK3kb3nA/KtJYmD0Ch9vmR7yUsMmJd8lQi9tLSt3jYchL9to80x7dqNOlU9wUCSW23mVHlmPWy2C0pwU5ZVxuTQEoUy8zziclMalr
    I9wB/jnasxazdnXQUMmuWJipYipYjzEtzGUJkJFHqoz+/wc/f+8XyKBLGo70LEXreQX6YmGGDw3bk13CbXGZE3vDrL0x4yilh+CdvUgxkMwTZXgHFwA7jPDx
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=Am4ss40yAAAA:8
    a=VwQbUJbxAAAA:8 a=zME09AzrzR2lX3ZMDE4A:9 a=x8gzFH9gYPwA:10
    a=lf-hbUz_c89dky27wAWH:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754503AbeDWIz2 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 04:55:28 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33990 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754397AbeDWIz1 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Apr 2018 04:55:27 -0400
X-Google-Smtp-Source: AIpwx49Dmayl2Dzv4J1Eoj96XxF9BvgzQj48+8wY/Ntf4op/9hEg3B/PQ3SH+GhbO+ds+AWNDgud3w==
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH] tty: serial: xuartps: Setup early console when uartclk is also passed
Date: Mon, 23 Apr 2018 10:55:21 +0200
Message-Id: <777dc4f87d27e9db383ef04bd21b8aebbb2b2015.1524473714.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Baudrate calculation depends on requested baudrate and uart clock.
This patch is checking that uartclk is also passed.

The same logic is used 8250_early.c/init_port function.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/tty/serial/xilinx_uartps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 19d370779767..0fc9de20843c 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1142,7 +1142,7 @@ static int __init cdns_early_console_setup(struct earlycon_device *device,
 	/* only set baud if specified on command line - otherwise
 	 * assume it has been initialized by a boot loader.
 	 */
-	if (device->baud) {
+	if (port->uartclk && device->baud) {
 		u32 cd = 0, bdiv = 0;
 		u32 mr;
 		int div8;
-- 
2.17.0

