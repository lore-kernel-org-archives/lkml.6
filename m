Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC51C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3FA208D5
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E3FA208D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934481AbeGFFwA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:52:00 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33622 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934447AbeGFFv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:51:58 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id DBD72C3C;
        Fri,  6 Jul 2018 05:51:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Turner <mattst88@gmail.com>,
        Sergej Pupykin <ml@sergej.pp.ru>,
        Alexandr Petrenko <petrenkoas83@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.14 12/61] serial: 8250_pci: Remove stalled entries in blacklist
Date:   Fri,  6 Jul 2018 07:46:36 +0200
Message-Id: <20180706054712.801446821@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
References: <20180706054712.332416244@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit 20dcff436e9fcd2e106b0ccc48a52206bc176d70 upstream.

After the commit

  7d8905d06405 ("serial: 8250_pci: Enable device after we check black list")

pure serial multi-port cards, such as CH355, got blacklisted and thus
not being enumerated anymore. Previously, it seems, blacklisting them
was on purpose to shut up pciserial_init_one() about record duplication.

So, remove the entries from blacklist in order to get cards enumerated.

Fixes: 7d8905d06405 ("serial: 8250_pci: Enable device after we check black list")
Reported-by: Matt Turner <mattst88@gmail.com>
Cc: Sergej Pupykin <ml@sergej.pp.ru>
Cc: Alexandr Petrenko <petrenkoas83@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-and-Tested-by: Matt Turner <mattst88@gmail.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/8250/8250_pci.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/tty/serial/8250/8250_pci.c
+++ b/drivers/tty/serial/8250/8250_pci.c
@@ -3345,9 +3345,7 @@ static const struct pci_device_id blackl
 	/* multi-io cards handled by parport_serial */
 	{ PCI_DEVICE(0x4348, 0x7053), }, /* WCH CH353 2S1P */
 	{ PCI_DEVICE(0x4348, 0x5053), }, /* WCH CH353 1S1P */
-	{ PCI_DEVICE(0x4348, 0x7173), }, /* WCH CH355 4S */
 	{ PCI_DEVICE(0x1c00, 0x3250), }, /* WCH CH382 2S1P */
-	{ PCI_DEVICE(0x1c00, 0x3470), }, /* WCH CH384 4S */
 
 	/* Moxa Smartio MUE boards handled by 8250_moxa */
 	{ PCI_VDEVICE(MOXA, 0x1024), },


