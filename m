Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527155931-2-14470780350737726895
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527155929; b=IQZvnlUjJM5QGSUgy0IvwRCjaDDbJO8iYE6NoAaDqpc3XpwPe2
    X7hM8QEUUyDMdBiiu1UkkoK2oJ2f9ZSLYviSLDYTB7g4yg7+RxLQ+PqcAJM2GxOP
    vin4sBRFDsINPAVNX8jXyypTj0u8z3DF0vRncVjeLg+3OwdG/d3ojWAmcguFa8kF
    OJxoNaik3/1xDd2UdD31eNiX4h0hvp77xHHl3KKvIBb9Tpd0uxQSDvUseyeOH2zl
    xHX+GwCU2yoArw4cqHZU4rkqbYsh7CZYcjj6SZsBgtRLn1ReSUdjMqziS4wmWT4i
    pFDZiJpobkGuj56X/rF4nRU6DhJcQNqA+W6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155929; bh=x0+a1gLuB/LM+olhzVnHQZJpZY/+WL
    IG5utPga4JajE=; b=cE2yX3U051uSLxoGCTnMoy6NqQiSXrJt6aDgnOrdwG2rPS
    EkIA34cj1+iQsBnatchOy5yGOvyM1psWapq8TmoKyZRE4x1gNYyyZVO3g9sdZohO
    mZEEL+6ZViaz+xUCsU4EEfiY69FYEbUBe1p/7RILqjExLAEenbTJhw85axnSB3Pk
    WF+Wrf0nW34O9Cz3geM+vHWQz5WUbVV03Q7AGgsFajPURWHRRv3GCNP69DsIIPeL
    yg5gqgChdqSN9TJK2tiRAEkXX8aqDLca20bTiL1zzJLn5LFeMzG0dMkN0S97FyvS
    KErZcCZnEkXZtbx/EbryBzrWLjIpeyG+iaQxc48A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=PbtJF1Ds x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=PbtJF1Ds x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfFLDebT9n2p84kltpC1rnzZjU2aYVxH9UDAZsj5AqtKUqRTeoUwU992odrG0rN+dMGgEBLArN1y3o8chDidGcATvkFxOQPtbI0p4HkBaozYfJ626fAlP
    yETGdjoINSIp867FGuAYuLkOkqUNOL7hnryhEFD3vAXBdFmt5Zoe8TlwMLtTzfzQ4TiMIYvftK8ChSFhSpqOivjjEDtgMnwfhTkyOqIfphX6tKOXHT3jsxMp
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=_klxHFPmXKVOew1bc_0A:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030612AbeEXJ6r (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:58:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:38890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030662AbeEXJ6o (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:58:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 153/165] serial: mxs-auart: Fix out-of-bounds access through serial port index
Date: Thu, 24 May 2018 11:39:19 +0200
Message-Id: <20180524093628.266764549@linuxfoundation.org>
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

[ Upstream commit dd345a31bfdec350d2593e6de5964e55c7f19c76 ]

The auart_port[] array is indexed using a value derived from the
"serialN" alias in DT, or from platform data, which may lead to an
out-of-bounds access.

Fix this by adding a range check.

Fixes: 1ea6607d4cdc9179 ("serial: mxs-auart: Allow device tree probing")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/mxs-auart.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -1667,6 +1667,10 @@ static int mxs_auart_probe(struct platfo
 		s->port.line = pdev->id < 0 ? 0 : pdev->id;
 	else if (ret < 0)
 		return ret;
+	if (s->port.line >= ARRAY_SIZE(auart_port)) {
+		dev_err(&pdev->dev, "serial%d out of range\n", s->port.line);
+		return -EINVAL;
+	}
 
 	if (of_id) {
 		pdev->id_entry = of_id->data;
