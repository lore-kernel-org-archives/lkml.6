Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527158455-2-18227548333078718279
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527158454; b=CVvkTY6jYVcCxozIuxOIFegAtxFyuClXFaELocguq6B2S1O5Dz
    Ts3a2iDJsrRYWFO9Uk9oBy45kAZA7rCDkBpOKw11uJ/Wk0PHLHJikoQ+Tln0AuQs
    hsxQX45aC+EomLWBEHfJ9mBxhRpt2RRzGpqUuAULQnYo+nQeC3Fs0iHulyn9ktC9
    hKmHxThn/9u8zGaN5QSpzE2Itw2TCatp9IXsKe1PA7xUt3mJjhnIisj9o60rC9m3
    acE+gEtyal5okwUZd72SiNjzdzh71N3muet4oJDt+58htJ71zH6QKt0PHVIy7chI
    zCRVvmQziibXliDyE/LTwO2ZAxWTubuUhRog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527158454; bh=2/CO5jRaGlqHPbwDelDBvIyy8Vz3FI
    0lrNfIprdVdms=; b=gubRXjXeqFAQcPusDIjPpqJqyaPFKzP6PgHJNOe3a5GB4x
    1zG7HtVqJHq7wXpms+oP8qqmUuSNpEhxmq8HCTEN5Orh9iNHGCOY/AIuXz7GcLXw
    bAm96YkFjmOdgWi/HsJru2xO2g9sqFqIkxNxrjiGfeiod54V+byJy50YaDeZJlA7
    jNYCFkDnNOSTQKsbvt44CEtlOhvPUxIftFxudqJSW2AeM22OQvYU812cMdpaM4Bq
    e3UvAhqd4r8Ibnc/8giV3KWyAZX/QvHj9Fdaw+Aw17p7g03uoS7fdMj6bXb4bP7t
    le35XgzRc8WHAYhJMRUvRGU7DYApEChqmNnaK/VA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=1i7JZNki x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=1i7JZNki x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHZQ4thnL/iLDnfEpRnaeMq/2r2jdLQ5Ik7ZEXa0zQMtdk7mrWmr1BQD2rRyRRZWlkjt8K/BLNZSehi3cOKlbdzsKJFtZkLLDeAe9JMR6VA2z8+o+aWS
    FULeGOez12QzWQluZrTsoixFPMrEzmDjtp+Rqlng4OFCMhQdO6sJTZ6yCu4eVDkPvzIVZkKBoMm0VQpJQcjIpebDi+QoyjZT6ijGgP31FJo/8FAkqnxGrXhv
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=Am4ss40yAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=Qdp0uvsemHcvBnbyieQA:9
    a=QEXdDO2ut3YA:10 a=lf-hbUz_c89dky27wAWH:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030715AbeEXJ7G (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:59:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:39664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030419AbeEXJ7D (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:59:03 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michal Simek <michal.simek@xilinx.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 150/165] serial: xuartps: Fix out-of-bounds access through DT alias
Date: Thu, 24 May 2018 11:39:16 +0200
Message-Id: <20180524093628.149787831@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit e7d75e18d0fc3f7193b65282b651f980c778d935 ]

The cdns_uart_port[] array is indexed using a value derived from the
"serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Fixes: 928e9263492069ee ("tty: xuartps: Initialize ports according to aliases")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/xilinx_uartps.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1115,7 +1115,7 @@ static struct uart_port *cdns_uart_get_p
 	struct uart_port *port;
 
 	/* Try the given port id if failed use default method */
-	if (cdns_uart_port[id].mapbase != 0) {
+	if (id < CDNS_UART_NR_PORTS && cdns_uart_port[id].mapbase != 0) {
 		/* Find the next unused port */
 		for (id = 0; id < CDNS_UART_NR_PORTS; id++)
 			if (cdns_uart_port[id].mapbase == 0)
