Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527156350-2-9756209959790665051
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
    1527156349; b=LVT1gA7orgWuGSPU2kKT97RkhaJMyGVpKLxTB5fMt+4O4M1JqS
    yfZKdcvL9qbz+BnFEr3t7wFDFGFT4InVMLG7WPXBO5Z6cTCv+SvY0IY7XGmjBt9h
    afmWl+6TlNiFbb+3BbcHw25FESmSr1xPz0wliUU4v9i+0dCFeeFLRVDLPKNLtpRH
    0BH4ZsEb/WWijWuaU71I8sMVU233DorrWqRX0k/FF7SmBNhO9Gqqrr3eVlM1Dccy
    maXHtjNR1aq+xUv+TIift7sntiWgYmMEkYuzkrkEOw0YApOWwb2Yiu2TAAv9pSys
    gqaU0BTTjURcagEBhj3aHbkJEhm/oK7dzijQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156349; bh=Leiu5Ll9C8+uhf7pR1VoQHXL5m/9ml
    Gj6qBdhJEvps4=; b=gFeFNiRVKYiG/kbGb7drnX/9l8nh7mQSPt5p5JKAurEDGb
    6fPsbeGi7dvPev8iPQVpfSkM/jnakvv/kqAE0MTaqoUbzhyGJijzZEcmyeMEuUKF
    il3OiVHop92IH3t0W6FO0IaaU+iXyhdvFbS4Qbyknla3a6JRE5TrhHYTpMgqSrLX
    w1DbnOnrlHOsu19DeDbnm3JeONETAsDwlEsbzwdbWDblnL0d3+WwjSfzKYdgGFdn
    4KVkhguxjXrKMCx3pgQLAPhc/Q9Xmi71xT/p8TAB80cl+vxDCWwucagn0+CbVf6S
    LsEyovZjW/wwmZBVXNWKYRGmd0gtl1D0eNoAGk8w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=HCfRq5aF x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=HCfRq5aF x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfDKO2VMxLCcHznUd6pzyP6vtxDJwWMFPrTGAaGLAA2xCTZSHWD3Tl/K3FA47w2GheG7eBkTdcVgqi0HW3+7i2sIT9InTivxB2cvpyWl2Trp66eFm5xud
    +L6yoVkSDJAMOnQfx1D/IzL92SiG0My2+O8+3cEs9coRwIRYAc9fVLVw2kPvyTn7m3tF76GBk9eHhxvEMiZPZeUJV7UEXoqUfRVgisk1/k11RtUcHya4cjUL
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=T0JhKGde1cndCqfcSzYA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031622AbeEXKFr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:05:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030890AbeEXKFi (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:05:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 151/161] serial: fsl_lpuart: Fix out-of-bounds access through DT alias
Date: Thu, 24 May 2018 11:39:36 +0200
Message-Id: <20180524093036.371928666@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2145,6 +2145,10 @@ static int lpuart_probe(struct platform_
 		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
 		return ret;
 	}
+	if (ret >= ARRAY_SIZE(lpuart_ports)) {
+		dev_err(&pdev->dev, "serial%d out of range\n", ret);
+		return -EINVAL;
+	}
 	sport->port.line = ret;
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	sport->port.membase = devm_ioremap_resource(&pdev->dev, res);
