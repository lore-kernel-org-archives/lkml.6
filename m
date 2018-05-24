Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161560-2-17294363073263742399
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
    1527161560; b=XmAM5oF8wWxMj//C8mvyBAC6XiDGLbxb3JmC3GkFXVU/8ULvAa
    WDzIut/8woz8lKplYQxo//bb1ozCWa5K2qZDkP4yR2mjexwVuEO8ii+82q0Z2aXf
    F84uU6OfZefY7Y4Kn2rs0FaV01bN9Mssofie0otjexabEKgB4NjcZ+I8GkK3IcUX
    1C3hVwAslaGqE+P4ZbZIIRxp0NRK2jgQV60SViKCVueIXUYO0aD7DJkkzzQ6fwNL
    GG6mzSRJffmlCxrl1tCSlU/ye8MRrzkc3AKbRo4Zq5Czzi+vIM0FScmuz/nlR4ui
    2mn+AXCwDh+xlHbiS/C6uhK70A0nBYVy7P6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161560; bh=zaDiC9t7H2akeu/GtVUHMsTFDJ0grd
    AQNDbu56IXEd8=; b=Xu4C2MEMqIr0GdHop1se1evA3C6JBqNwRnAhUGnjUXwVPo
    NTs5xhSwLxK/ZkKhETCLipdOH4W8FyqIlzTRh9Nqq7qlCp8UoMXQ/ahKNSLI1yhv
    vyce+jRLBW8ouoPdKyeEWp/BRk0ZM3N5y/J8iv3hiaZMnAwo+7RGpN7+uVy0sRh/
    3eeONjTHbCsi4zgHzP9z1l5tlVSDCxXZTtYAyud7hU+t7x/R5KYg1m83y8+JEMC1
    Ls+Ra2JLb6RjoG1ZMafHyvzOds9EPVDqhSdSJTf/+F0jZs5Xn+niVTNksULoI/mB
    RPEpC2HL2oYjel3XAJu1WB75gXdFbZkAY6SR1wKw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=FsDIz357 x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=FsDIz357 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfLyA3rPLrvCthSvVC08uVj2kS69mLU8HHauyNOwNmmgfeI4+yg8vzxnEYr/XZCi38xIGrX0BwGsK7jhNxJTVVTMOVMcUJ1RzJwTP2JNObsZ9IDOCrIyp
    aUCGeIFJ8IEVIA+jh/qnQpeNmdFH3a+KtOLMlV6F8pbkSFeXh8s7oPG49AfHa1dm0UPBPI7DO1pQtctYEmgBKY0W50f7Iuc4JQX/MxkT7noWjlmepkSQa5b/
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=Am4ss40yAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=Qdp0uvsemHcvBnbyieQA:9
    a=QEXdDO2ut3YA:10 a=lf-hbUz_c89dky27wAWH:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968899AbeEXLcX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:32:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967612AbeEXJun (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:50:43 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Michal Simek <michal.simek@xilinx.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 87/96] serial: xuartps: Fix out-of-bounds access through DT alias
Date: Thu, 24 May 2018 11:39:10 +0200
Message-Id: <20180524093610.542857764@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1106,7 +1106,7 @@ static struct uart_port *cdns_uart_get_p
 	struct uart_port *port;
 
 	/* Try the given port id if failed use default method */
-	if (cdns_uart_port[id].mapbase != 0) {
+	if (id < CDNS_UART_NR_PORTS && cdns_uart_port[id].mapbase != 0) {
 		/* Find the next unused port */
 		for (id = 0; id < CDNS_UART_NR_PORTS; id++)
 			if (cdns_uart_port[id].mapbase == 0)
