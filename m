Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161486-2-6225890116162442939
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
    1527161485; b=TNNhoPLO7OPPJseTI5V4+IgjITz4veTIbNojfdi+v9ryPh7L+a
    SVcNouWobt+9rMSQLzcFnk1Ll12xQzl7BKnssZAQHj47UEDKo6rFfUcMavZVOoBA
    XqEheAvUtbuJZqNBi7d2ueSxoq+b2dPexkNwaa7114tD3tsE0kMOgfIiZWh+9OvI
    J77N3BzUZYtKg/YyiWaLmTuiMrRNzuQ4HlsLhUuPs1riPSavBOHLeKtP+rPV2Y1G
    Zg9GfB9xSd0D3zlb9qCwfECVtCw1QvN+/xWRbBu50zPhHek+045OclNI8cNoSW9w
    xqIRC1Ocr7Pcz4sEo5E1MsvYlr7GYz2HRLMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161485; bh=m+UuS2BuThKBQR+w6aoTQi6LlhB7gk
    /5umBKg5mOISs=; b=i520m9R1T2S+4nKOhXSJUcY9aAhPAl4fKqNlJuRpmXLxqs
    3wAT7YlIyh2qOy8yEEZSBBksnEc2LQnJkqjAGDgOcTPGwSAQQJg2fj9fmj8m4WnH
    FFOPH3guZAqRpIvdrcNNv7g8cPALV8BPqEjGu+4I929ZRauEu9EEc4237si9g4K+
    OWc7E79sXFVKGoSQ+UQohmJ3phqf+jVBfFA5miopHqCyqKVP3z3CKrEyCbVXU75F
    xuLXi0+FL2K/UODP6UlKj1dWT1+0zqQMOnTACXPGRmuw+M0wCYfbm0CBxqKCXXHk
    7FCt1am+rGO/+u5L7Joti2tz/EZefOkPiOjWRqcQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=ntvgTjaQ x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=ntvgTjaQ x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfOd9gp8sX58zATF1Stn/3TOa47ccZ9Gw2t/AZSDuh7ljzPwbU+b0TX2EsycZQPwzLO+cyRuGJOorAZrHWpG31DW0lBE/0Ovv0i0K0mwf3Yymnpb0baXu
    b2zLCTWqAEABCETiEkvgXIGxb3QjVHgdj7aib0sUYwbbEc9Y6Ou3bToInC+XxZT24jv77//u5KEq9H2J9nxmI5P1rf0wJMETJOG5wptr3s4d7dx3tf6O8RHg
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=_klxHFPmXKVOew1bc_0A:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967284AbeEXJu6 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:50:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:43420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967636AbeEXJuw (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:50:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 89/96] serial: mxs-auart: Fix out-of-bounds access through serial port index
Date: Thu, 24 May 2018 11:39:12 +0200
Message-Id: <20180524093610.701261507@linuxfoundation.org>
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
@@ -1664,6 +1664,10 @@ static int mxs_auart_probe(struct platfo
 		s->port.line = pdev->id < 0 ? 0 : pdev->id;
 	else if (ret < 0)
 		return ret;
+	if (s->port.line >= ARRAY_SIZE(auart_port)) {
+		dev_err(&pdev->dev, "serial%d out of range\n", s->port.line);
+		return -EINVAL;
+	}
 
 	if (of_id) {
 		pdev->id_entry = of_id->data;
