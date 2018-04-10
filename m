Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3875449-1523367217-2-11280157656626770384
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
    1523367216; b=VSmuaIbWDJsj3MlcSH1x5HBgNdwON0/xJ/lP9RmoPjegQlkAIe
    R5bLUzeull1AH18NxzVZJmHaScy8GrQ/36OU6LVC2Gyx0zipvYChsbTZyKvv8T/Q
    8+YLq+gT57EeVk8O1J7IRiuENU/jpE0F9we2oyNxXiIxe1zIY+cVgDBop2+QFHBW
    6kQGU10r6oNbZQL2hGHA2+WzEMi7gdACIqlfrkmnoOn4n5u7eHlUjGrbz6QLj7Uo
    2to/TFT4anHIzIY95OHND7zNwqKXa4r+F8/k28OGNKi3WNH4JCgHghxAM3uRPypH
    uZK2Z6onSRJPnCjDUVtU817R0upThizSBqgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523367216; bh=dXCblIGX9b1Ts30O9U03xYQycNnoRO
    vxAofG84/2ifQ=; b=ar/i1MHkhcbHRJaLUwI2JvxG9WAWqLx5GXxT1nw3AVF2nc
    HJDgtoJtPU/59n+KZw974sNBy5l9LPPl9/xYatBlzxM7jOs1jgjfowK7IGe9h4yT
    EJ74Ig36I0FzTgQ+22PfezbggO29JS04FTA/gN6YIy7QilgV393vtPYSNzK7dQX9
    k01P+i93weBNH5SlFyszhhXSXFpqph9/0Qfz9XiDM0zQ9ZPJcedc/BF8AiUFaIo4
    0VqB9UjGwBDlR67XkxSItOVsSUcxH1DJ9ZAg4xwymxZec1azMoyloJB/Khmxxkgz
    D4KgBT4ItoiCMEXoRWE0e57szW2W1r+3KnXXfRzw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b=a54fHt+G x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hrk/1T0A;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b=a54fHt+G x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=hrk/1T0A;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHJzW95HDfwrGFkT6Mx866V7QaxpRs/559GnOKyxHL5mqD5vMhSOUtmB4v2R3LfFQJCi94/1P7IFSHFdr2ROuiRmHqKJYW7pE+np8fBKB7d6V9+Xpa2Q
    T4Msjm/fKQIC0cwBROPx9VhQCy2KW+KsL25M01Ydb4JoPOLEcF3dkN9MK8cf/2Pb15UeSXAMXNTUiuRkvljCQ2POr8t7SpmtX/XYmTEr5D9qAQrgHpmH00mC
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=Am4ss40yAAAA:8
    a=VwQbUJbxAAAA:8 a=zME09AzrzR2lX3ZMDE4A:9 a=x8gzFH9gYPwA:10
    a=lf-hbUz_c89dky27wAWH:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753239AbeDJNde (ORCPT <rfc822;greg@kroah.com>);
        Tue, 10 Apr 2018 09:33:34 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37328 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752878AbeDJNdd (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Tue, 10 Apr 2018 09:33:33 -0400
X-Google-Smtp-Source: AIpwx487VA6KeqMcExzd7UAlpLLrSU7cB9+7u+6m9Pbw8mUi1Im3w9ySrEkyXnfCT/XdahtQSMHQ7Q==
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] tty: serial: xuartps: Setup early console when uartclk is also passed
Date: Tue, 10 Apr 2018 15:33:30 +0200
Message-Id: <2ef5ac478f8d32bc807ead758eb5d60744a44515.1523367208.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 1.9.1
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
index b9b2bc76bcac..a654cda203c7 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1181,7 +1181,7 @@ static int __init cdns_early_console_setup(struct earlycon_device *device,
 	/* only set baud if specified on command line - otherwise
 	 * assume it has been initialized by a boot loader.
 	 */
-	if (device->baud) {
+	if (port->uartclk && device->baud) {
 		u32 cd = 0, bdiv = 0;
 		u32 mr;
 		int div8;
-- 
1.9.1

