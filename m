Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527158516-2-15490166074965317504
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
    1527158516; b=L8OldgHc0H57DlVIm/HVewugI1+X4pWStsPDJSzMVJC8hOECQJ
    0mtpLhO3qaffl4bjr6rRLUUej2e9I6FaGx/MFSYE8dQY/EhqGC/XstE/qmfzQTgW
    7AnRX94imbIrLe8V9lYJdBXGAWsGZuiBhAY9sGxT1qtIEFYH65duXgMdsmwDO+d9
    il0jDWHYSo+A3dyBKF/3zJn1oUbOg9JOPh1kD+XUu71oo7R0ajlWd0Zyb6QZshZl
    l1JBfsgYXiJO+lHEu+5hBuOzGy+daKevTnae3zVqDHOct7ugs5VVkDdvX2E6TwXM
    9LSwH8AULxs9KWj20s+SlETf8sgMmrmXU1Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527158516; bh=Xa6McjbQb/txnn2w9R4AqDCofaonF9
    Lj0YhS4NElCa0=; b=AOCKHuuWPm8SzEWNgaVYMYRUSDRzK4Dw/u3VIAipHtNQSJ
    6RBCkaEiTJCU8244LgiiAwblkIkhHXKP+BozYY0zOAV/SOx713Xmr65P77DhdsJ5
    iBa0YMqigFo/RqnwMzQ6h499KSH7v72KwenKkZSotjeKzKe2osnmydT+0HwMS+eC
    5OSH9vOxdU3N6yGILjys/yuTONPGekwvcTQMwsO1epzjloNkb9FqKbtQXBNRJAnS
    wOHw4uBKIeG9ALDUc32gLax6APc9n2boAmRB3WO6JNA+PLiFiSGBL8xmORFT0be4
    8OE+cmzYrgTDPN/SwdO4+bXd2IqZXIzVGkdjqwZA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=GFBQF8pN x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=GFBQF8pN x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfH3Wc+QgDG+HtCEMQOncdbnDptHkEFEBDjEXFIE2Mts8wfqqepRNF2t6uEjraTkCRM3JMi6kraBClKfv6pwRcdcF0fRTYy42Mw/5mBAO70/BSSrEA/vg
    V+RiWNSI+10iB/1VDjY6q+1aWwrrDFphHpfdNZ/wTfsdgieloXFUlawpOczAlaygxD9VB7tBlaAnSXum7bk5OIyCSc11Y8bjcwoNjYiVlGGHq8fN0x/JFeaL
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=ao7VijfDgrWXSWN4ZT4A:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030663AbeEXJ6p (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:58:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030612AbeEXJ6l (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:58:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 152/165] serial: samsung: Fix out-of-bounds access through serial port index
Date: Thu, 24 May 2018 11:39:18 +0200
Message-Id: <20180524093628.224421697@linuxfoundation.org>
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

[ Upstream commit 49ee23b71877831ac087d6083f6f397dc19c9664 ]

The s3c24xx_serial_ports[] array is indexed using a value derived from
the "serialN" alias in DT, or from an incrementing probe index, which
may lead to an out-of-bounds access.

Fix this by adding a range check.

Note that the array size is defined by a Kconfig symbol
(CONFIG_SERIAL_SAMSUNG_UARTS), so this can even be triggered using
a legitimate DTB or legitimate board code.

Fixes: 13a9f6c64fdc55eb ("serial: samsung: Consider DT alias when probing ports")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/samsung.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1821,6 +1821,10 @@ static int s3c24xx_serial_probe(struct p
 
 	dbg("s3c24xx_serial_probe(%p) %d\n", pdev, index);
 
+	if (index >= ARRAY_SIZE(s3c24xx_serial_ports)) {
+		dev_err(&pdev->dev, "serial%d out of range\n", index);
+		return -EINVAL;
+	}
 	ourport = &s3c24xx_serial_ports[index];
 
 	ourport->drv_data = s3c24xx_get_driver_data(pdev);
