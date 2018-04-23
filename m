Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-962895-1524477112-2-10973310142107297736
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524477111; b=oqnW1V+LsYf3bwaJ+EzVq5UaQnpvGSjz41j2VkZB9reoX+ZNz7
    meCfIzjgKMLKhGbN4egL7cMEZLnKkG6+Z4/efb63PP401LpVIhYHy8EGkm0esW0W
    lPjyVDxO8OeB8ZTTjp9baC8wYsx8QoKy5lASnmqCM3hzdo+oJ3YtflK6gfDgXxpK
    71hjmK8IvtONLazmmPGnA2xcq2VPSXdqJomoLhNnWA+vN1lZ53b/F1HApUlK1t1y
    LzjiU2ZopWAPzdV6P4PkOJ4zacPssc2gLpyjRQrHk6NmFGqL0heZzc5jy7WOLxdm
    q7Sm/7PPsWA0Zrl5kRmy0GO8KlUNsWeFbInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:in-reply-to:references:sender:list-id;
    s=fm2; t=1524477111; bh=qnGnfYAHTj2iLqDWgfTXjm2sU/45J/PmRyWV2VX
    PSiM=; b=IUCeEYqR7YU6206tw1TLiAPQWP3fBylDihlSawXBJ08rIbvoj/F22kP
    KKX9SmYDmdZbnwXb0/c+GfmhQiQAXMoXHiDeOWe15UeKPN3eFDvmja7smC7PUGj4
    5gdBdqv4hERsu5AS+5F1co4RBk86FNCWqeyQYgHvnqInRs69O3V+hRhQXFbBRBG5
    uo69jtMiv5CmBrLfQqZDWH5OOu/hpR2/2NrNJeWBeFjfw0aZ85eGyb6FCUr1FSbw
    4JmgmTpYGMZuiF38YfVpuJNTHr1dQdLQ+hwijOZPbeOuvpBsje1bqMMOfvxYc/ii
    SQF1bSCdwsLwepsPfwx2hRi/5i5/g0w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b=bDEoKHkn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TqMBYowp;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b=bDEoKHkn x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=TqMBYowp;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-75 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGMQB/WfExZRzp0UWUgGKWX+UM7VwejZICQEMZSsxKIqlSGv2jg80AQ1J5wKTdUA3CX2D6dKEi8Hg+LRqIlvhE+fqVJdASPH1uuRpJK8c589UgXPMLkS
    PnZmWkdCoNwSmH6ao4GfB9aBrA97n1OWWpSJHfc0dHAzWfduNACQcgPAW3e23ny+8ls7ekciG27Iy764yAa0es4O8SqyDQicPlZbwyw9piiLSMdBlTx/siTy
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=Am4ss40yAAAA:8
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=GGMxdigxDEUha3WJNjcA:9 a=x8gzFH9gYPwA:10
    a=lf-hbUz_c89dky27wAWH:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754380AbeDWJvr (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 05:51:47 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33263 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754671AbeDWJvL (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Apr 2018 05:51:11 -0400
X-Google-Smtp-Source: AIpwx49wowhP5AyeBtJ63kXt1LxJixW7wJws/QcS5Urk/qTWG8whC/p8gQNSSLFUGMKE2Wx0vp8VCQ==
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>, geert+renesas@glider.be
Cc: Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 4/4] serial: uartps: Remove static port array
Date: Mon, 23 Apr 2018 11:51:03 +0200
Message-Id: <f8baf0f2dae274bb1ee7662373fca43803651eb1.1524477059.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1524477059.git.michal.simek@xilinx.com>
References: <cover.1524477059.git.michal.simek@xilinx.com>
In-Reply-To: <cover.1524477059.git.michal.simek@xilinx.com>
References: <cover.1524477059.git.michal.simek@xilinx.com>
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Allocate uart port structure dynamically.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Alan Cox <alan@linux.intel.com>
---

 drivers/tty/serial/xilinx_uartps.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index f7d527a1c532..0fc9de20843c 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1097,8 +1097,6 @@ static const struct uart_ops cdns_uart_ops = {
 #endif
 };
 
-static struct uart_port cdns_uart_port[CDNS_UART_NR_PORTS];
-
 #ifdef CONFIG_SERIAL_XILINX_PS_UART_CONSOLE
 /**
  * cdns_uart_console_wait_tx - Wait for the TX to be full
@@ -1438,6 +1436,9 @@ static int cdns_uart_probe(struct platform_device *pdev)
 			GFP_KERNEL);
 	if (!cdns_uart_data)
 		return -ENOMEM;
+	port = devm_kzalloc(&pdev->dev, sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return -ENOMEM;
 
 	match = of_match_node(cdns_uart_of_match, pdev->dev.of_node);
 	if (match && match->data) {
@@ -1503,16 +1504,7 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	if (id < 0)
 		id = 0;
 
-	/* Try the given port id if failed use default method */
-	if (id < CDNS_UART_NR_PORTS && cdns_uart_port[id].mapbase != 0) {
-		/* Find the next unused port */
-		for (id = 0; id < CDNS_UART_NR_PORTS; id++)
-			if (cdns_uart_port[id].mapbase == 0)
-				break;
-	}
-
-	port = &cdns_uart_port[id];
-	if (!port || id >= CDNS_UART_NR_PORTS) {
+	if (id >= CDNS_UART_NR_PORTS) {
 		dev_err(&pdev->dev, "Cannot get uart_port structure\n");
 		rc = -ENODEV;
 		goto err_out_notif_unreg;
-- 
2.17.0

