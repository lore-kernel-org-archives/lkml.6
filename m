Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2228745-1525961646-2-11609200175269030832
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525961646; b=AsyXMyMhfE2M/6/nNLxBWtgRUbXu7+/c39hag4qeoHUOrgpsu+
    ap/YN5TbU6GlNTRjU0wZcO1vitx2i/CUXNw+VfeknrpaE4FtfDrTFRUi2ucbNWjm
    VCMlxCmGhoQexdyURtsAzrfO/Wo3uky9//mYcfAIspztKGe48jiO8QsLblPChmKN
    N9Le/Nqg56I41Lj9/IV9MbtgAMBHMOAe5zVJY7uy1AVhsvrLTCeI1OjhhGGlkdGG
    NNACEr7DhvHI+aNv+XUh9bMb56i4XgIDPtTdlQda9kPMRD+/l25X7C7lM4K97/Lv
    A4u6uXaOwxO00qGMFtxtzKX7OSyriVUVrg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1525961646; bh=NOOqiYEJvU2BvYGpFkX6IMHrkVjQp1
    6HBNbl0UL/oRA=; b=nxvv/kFNjf15ZoJt5jLXhcQi0G0aTXzJP8jzoRKxM/V5W0
    cFdyBARMQXdVXhptph3F6A4S5y2WAh7e+jqMljVh3JbvsA/t0dfQCpHBIWWaZQi6
    2bkhFUgW7UkB3v8qwEhwuz/0bW+FdUwBS5vdDXjjKj/VSjnQV83piHdVcSEiJoe5
    M5pxuShScvLpTczou/A84EfkVHpM7BrOJmH9nx0t9FldLYlizV8+FgnFR45p0KUd
    t2YP/s4CDM25K0+XyHtorAf8O/q1rhygvsEtx8VxlrYLv3WLRpW7pPe1320pxT2P
    zU+zDQZE15CSrxYTol7TJ5PHqjSuj7QEmSnOsDnA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=renesas.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=renesas.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=renesas.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=renesas.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJMwpRpkxWHOlchRyYS3slCxy39Eu59oOr3nF4jz3/+x7hazMS0OHvu1c7zB6B9IByEIotY38p1SqG9xMBdG8R26G7yyt8ibcjL2Fb/zj7KOC25dA+/J
    yOccFlF4gQgtvpNk692na9k95XDFk/Vrubqoh7qK0tKOs/WosS+ICArzL66HRIKcaARTJtdRggvuP7PnjeQ5K+yii+IDUj01BtbNNjKL7KhD2CPYrsREILj7
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=yC-0_ovQAAAA:8
    a=VwQbUJbxAAAA:8 a=9xpCGcTiIBmaMevBej8A:9 a=x8gzFH9gYPwA:10
    a=QsnFDINu91a9xkgZirup:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935420AbeEJOOE (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 10:14:04 -0400
Received: from relmlor4.renesas.com ([210.160.252.174]:7521 "EHLO
        relmlie3.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934609AbeEJOOD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 10 May 2018 10:14:03 -0400
X-IronPort-AV: E=Sophos;i="5.49,385,1520866800";
   d="scan'208";a="279165654"
From: Phil Edworthy <phil.edworthy@renesas.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>,
        Joshua Scott <joshua.scott@alliedtelesis.co.nz>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stefan Potyra <Stefan.Potyra@elektrobit.com>,
        Ed Blake <ed.blake@sondrel.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH] serial: 8250_dw: Fix runtime PM handling
Date: Thu, 10 May 2018 15:13:56 +0100
Message-Id: <1525961636-6359-1-git-send-email-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When using kgdb, you get an abort when accessing the UART registers.
This is because the driver has already entered runtime PM and so turned
off the bus clock needed to access the registers.

To fix this, set the capability indicating Runtime PM is active while idle.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/tty/serial/8250/8250_dw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 0529b5c..aff04f1 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -576,6 +576,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (!data->skip_autocfg)
 		dw8250_setup_port(p);
 
+#ifdef CONFIG_PM
+	uart.capabilities |= UART_CAP_RPM;
+#endif
+
 	/* If we have a valid fifosize, try hooking up DMA */
 	if (p->fifosize) {
 		data->dma.rxconf.src_maxburst = p->fifosize / 4;
-- 
2.7.4

