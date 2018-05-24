Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161504-2-1644093678057503348
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
    1527161503; b=m9rX98vOXgZ8JLTq4gwZLlgccinghEDbsJ6EL8EjXCU+jM20h6
    9A9O00MH/0OUzvpOVAYGx6GRmCedgDmlIR+c/TXsFGJuJ0pMtImWUIdrWuFVjFpx
    CRm72FYs/XuQV7fnJnsjnvSNYH4nRzrKMgYyK00QqmQYQ4ge8jk6izoH6kFNOBrk
    vd6XczoT5gHfBAjMuODs/Owke6VtqlLtFD5RneUo4QdCv/WAJzgltEch6cLokv1v
    UJgC7m6YutV9WztxFTq5XEL4R6QTcxQUr5rWrYe14bmhwcSpDjrtSehvL6uzA5ec
    kP/DCd1GBSE6PyYpa1YP8VQHk5gXxoTA6lVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161503; bh=JyEHtIABPWjf5f9vtolMW4GbunwG2P
    M1gi2LPv2kAdQ=; b=BIIMXkIcWTJmOt/d0RMvUYzQJVDT6NS1uzddvE1Ms/0F4l
    FTNYYLcdyAAr8nBSbF9lVjHrBVGnw2FyOCEWZRafUVfDKyYm+d2y5RkPXV49xiAs
    +Au+REPqaqlWou3LXGbukgZ+gNyjrtThkOZ+59RplNRNoF9ByuajVEdxSlO0y2rm
    iebuJUc8dwaOLje7MmplXv5HGU4L27kpC6eliM3GtwMs+NHvLbfnD2JUdTF6oviw
    ReGpH0lENbRak6rGqB2UFsomSK11rXEJ/8vo7uQ753Wyu+0PVxHhfmgVrclJYGFQ
    HmVxBUfMiRs4xDJqgQmZYgLeJdklxRdVynxpSwUQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Zt6/xEbt x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=Zt6/xEbt x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfBzQj9E2gnw7B6RkERHSx/l/QW9wxztH+lt/bI+Kovp9E/ZmhJlRaXc+7Dcms7cPQYyQtp7PNJPjOKqBRVlhQsB90Nd+BmFgMEIAKEc40kBIFXRhAOdM
    hY7nZW3qSbWWZCEtRubYhfSLGhthtPG6nYqu6Wunm6IwPfM8izEWknQWbh5e7mZKC2B0tBnGAAvS0gEvrXf/nEf9LtLxO6NuqTG+xiZsHhOECuhz1Td9sowH
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=H2TRg8_dVisN_HRLu8kA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967429AbeEXLb3 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:31:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:43934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967129AbeEXJu5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:50:57 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 91/96] serial: fsl_lpuart: Fix out-of-bounds access through DT alias
Date: Thu, 24 May 2018 11:39:14 +0200
Message-Id: <20180524093610.997169040@linuxfoundation.org>
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

[ Upstream commit ffab87fdecc655cc676f8be8dd1a2c5e22bd6d47 ]

The lpuart_ports[] array is indexed using a value derived from the
"serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Fixes: c9e2e946fb0ba5d2 ("tty: serial: add Freescale lpuart driver support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/fsl_lpuart.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1902,6 +1902,10 @@ static int lpuart_probe(struct platform_
 		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
 		return ret;
 	}
+	if (ret >= ARRAY_SIZE(lpuart_ports)) {
+		dev_err(&pdev->dev, "serial%d out of range\n", ret);
+		return -EINVAL;
+	}
 	sport->port.line = ret;
 	sport->lpuart32 = of_device_is_compatible(np, "fsl,ls1021a-lpuart");
 
