Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527158581-2-14252964782661584897
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
    1527158580; b=XToPAXo2fzEObdHGjebKrock1roFjK+/BtL7gihS6++i4NDag5
    5gKymZYKFKmj39VVIfUWKaRleZOdzZU3PCDKSX9y271Xiz9yJOZS51xqK52bM4jr
    zoRO1x0+etRzEAPPkb3UIEkhJJF7ZULAzxRSJ+sZMTyRcTaflJwoFdu3Vpki1DpV
    scweCoMjwZGeHeJ1B1M/pWJNgh0ZrLGnDpZqAx52LodPL3dWizZy+VKbYK+JcZpc
    VJ2rAHPiY6YjnytCm8rCSbbwYP0v5Xj9927NjNWmCBAw2RDwxCJ+ZHYavJZqWyJ6
    6kOAbzV8mXS34csdo9qWAG/UnUR7OJreK4qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527158580; bh=VGQ6L3EDR/BqCH8CZudbym0SFjzw+T
    3VOUjSdHU+7O8=; b=cQ8vB/5hzI8XwPFcsK9EV7RXV5SD8juRbt0q0e9DK+mDxA
    U9Rq1NKdJLVobALE0qRWnM8RFbcRiQbQeZvrmLjAijTBjfHiMKaE1Tz83+M6OHFx
    hAbB7XofCZ1g6lV/4U5VZpP0/7qh0SvOvEqPgOlXpQ2ilwG5iCTcSgZYhTdKlV9j
    vJcFDekJNtPoqJ43Reygu9w5xJWjo5x45H2TuN1sW6fpt7arUInb7bWaJEB4fquz
    M1pu1fWBVkc7eLrYG9iEziuWVThkw6PklbYAehVEgoEQzcHvgNCCbd/YwPGWvjEH
    aMH/hpdthEdHPG0dmC/wYFIv1YzopR6YocTvkwHQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=CqiQ2nSr x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=CqiQ2nSr x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfF7AZL43mDZ1OrgxG4VJjY5P8jOiVbVPw+e/CB3FGexy6KD6LRAuFBN1vfz/7ChVqD0gWTVVgM8dxR4zCiBACdhPhxXJY8rKphikKc+VSrHd6H8RGtI1
    U+EAuIm/kIVKSCquk2Q7CFLVrMqpgUaEyKr81EVCr6nUPbUq2Bjz73xd3RmOj41P/6pIphOmddY6pBMCJc2j5u5hsYg5sO4vn8DpFe1pm3WkMGSYz8oz5v1H
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=hgDu_Qp9WZrXZK2tmPwA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030606AbeEXJ60 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030466AbeEXJ6W (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:58:22 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 151/165] serial: sh-sci: Fix out-of-bounds access through DT alias
Date: Thu, 24 May 2018 11:39:17 +0200
Message-Id: <20180524093628.187290948@linuxfoundation.org>
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

[ Upstream commit 090fa4b0dccfa3d04e1c5ab0fe4eba16e6713895 ]

The sci_ports[] array is indexed using a value derived from the
"serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Note that the array size is defined by a Kconfig symbol
(CONFIG_SERIAL_SH_SCI_NR_UARTS), so this can even be triggered using a
legitimate DTB.

Fixes: 97ed9790c514066b ("serial: sh-sci: Remove unused platform data capabilities field")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sh-sci.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3076,6 +3076,10 @@ static struct plat_sci_port *sci_parse_d
 		dev_err(&pdev->dev, "failed to get alias id (%d)\n", id);
 		return NULL;
 	}
+	if (id >= ARRAY_SIZE(sci_ports)) {
+		dev_err(&pdev->dev, "serial%d out of range\n", id);
+		return NULL;
+	}
 
 	sp = &sci_ports[id];
 	*dev_id = id;
