Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3892947-1523367159-2-5304865363594300203
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
    1523367158; b=S07XNbbuZcAF/mYPhP4/drdau78kkDsso0ZjwTBjY8PfthIPIV
    ESJ/i55gQf+9bs4Td+Sb73KNtT43IsHr3kWob36vfe6VOx2nDs/fVotlMK5LgDzK
    C1MFKjq5BBTrrM9P16ezzEIMrhJaIBihxQif37fIV7nyq1L6ItwrczrhJyCv72HX
    oF2SkdOdVTNnsfStXKt+XJzVnkw+93/+bHIsYz5EWstW+jB1o9leFDvLmFO1B8im
    sor4m55S702bqwmCscPuya1Fw+1PZCSjExZL0LBqkwZeuiSn+BNT7vBrwFnfkt9k
    y1vWiIG2zDodiupDhh7j/qBsTAVj74Ra1zrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523367158; bh=yKmBnpXvLviWgUKKevAnxASUXNC3P2
    d9kw6wKwDde0k=; b=QbP26P/GR9j9elzXWKS3UBlFaFDwbykcOkexhAF2/wCCnj
    EgID9M0770eKISuC3i2yNAtyTkH/gcdOxK5w5c9TxtMarwxqTOUZXSq+sYXuSysY
    SB6xvs9AhoqDWKCISVGKCrjpcH88DtrTwg0LlEB+O+LrhdZ3mBh9uAbuwUH6/ECj
    PZCbhesnhL28GwGqMSMu4/tYMv3hDDzzRQzQP/VJu+toQBlWHEmQ9KRBymrFXRT6
    An7JLqf2S5ftNaUQnkKJUTlVZHzKJ+UeI6pBKX6x2EdLlu+jF3nsPYwYq4TqaFY0
    BmOO7RBjwdbLqz2IwWoFLLelVzYHQoaLr4I8j/JQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b=W6gMVB7v x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lEYC4R6n;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b=W6gMVB7v x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=lEYC4R6n;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP1j5vXS8Iat3acsN1iaeYaFQsMt+oLMKHL2WL8pA8O6a6UQzeBD98kgieLiB34RByXyjo9uuSbvnE/PKm/gbzMp6Wsd6CGfuSZgI6Tc8GnCdWl/0LcS
    bHniJTcAgAslRao68Zgc/uKLnkvED8MerVTqG/5Cfz6Bsow61IE7fBxIkK8rKwtxSEPZnYei8y48TIFjCtFRnNPjwT/x5qgy6wZxOy556v58+yN+wf+/WNG0
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=Am4ss40yAAAA:8
    a=VwQbUJbxAAAA:8 a=KcbSYToX-2gqoFQQYpEA:9 a=x8gzFH9gYPwA:10
    a=lf-hbUz_c89dky27wAWH:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753021AbeDJNcf (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 09:32:35 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55680 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752751AbeDJNce (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Apr 2018 09:32:34 -0400
X-Google-Smtp-Source: AIpwx4946wpJlTOyc02uZwaU4S5BawsqQW2OpRWaX1jMW67fLAyqICPV8lz1H5173smEk59QaopRlQ==
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu,
        devicetree@vger.kernel.org, Rob Herring <robherring2@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: [PATCH] earlycon: Initialize port->uartclk based on clock-frequency property
Date: Tue, 10 Apr 2018 15:32:28 +0200
Message-Id: <f483181cd3a234c2eae7e11b91a1767a0cbb88ed.1523367143.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On DT based platforms when current-speed property is present baudrate
is setup. Also port->uartclk is initialized to bogus BASE_BAUD * 16
value. Drivers like uartps/ns16550 contain logic when baudrate and
uartclk is used for baudrate calculation.

The patch is reading optional clock-frequency property to replace bogus
BASE_BAUD * 16 calculation to have proper baudrate calculation.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

We should add documentation for current-speed, reg-offset, reg-shift,
big-endian, native-endian, reg-io-width and clock-frequency to any
generic location because they are all optional properties for all DT
earlycon drivers through of_setup_earlycon.

---
 drivers/tty/serial/earlycon.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index a24278380fec..eb1f84258c44 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -279,6 +279,10 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
 	if (val)
 		early_console_dev.baud = be32_to_cpu(*val);
 
+	val = of_get_flat_dt_prop(node, "clock-frequency", NULL);
+	if (val)
+		port->uartclk = be32_to_cpu(*val);
+
 	if (options) {
 		early_console_dev.baud = simple_strtoul(options, NULL, 0);
 		strlcpy(early_console_dev.options, options,
-- 
1.9.1

