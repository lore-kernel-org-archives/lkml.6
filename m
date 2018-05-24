Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527158491-3-11231686750233954222
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
    1527158490; b=XynGMom+L+7oWmrGBw1+/Swe9ykV9f5Pi3ZjnXtYM9yg8OGPsu
    xQOweCafo1gso2qRScmmcfjYzGgpQToglyofssvmGQjMg5PlCR4mVgFzSoX6Qd2I
    csOOHpoFLVl60LzVbtC0M8CL9EkeHcjWy55IqUf+Pnyb8/vHISYEZqYeeK2efmOi
    z6BLQkdwXPMcqsUsUOrduMBFgvBNfVckUPYV8y/YuVYHLrEpwedCCQ8AY1rXKJBX
    GA3itUG9CKJ1oikWwnnycOoluvBwmJHnZ6dR8UxrohYABV7EGU82Z5fwcNkkZlF0
    YP7mmRX4fPXDfJffRiluTI/SEEt3mDKY64VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527158490; bh=GVB8giei0PsBKSl4yvWce9JFElTOCi
    xlJ0LN1B2Tte8=; b=WdrhjbsCpI0ldKO7TkNHmJ1QQioWR8ZWf/FH9VKWY+8oFa
    c08tiLijFoqUmZEecDBlBjhixYlxus/Ha4vTI+YNeSQU51LtUZc2ULAPVY0cjuJa
    AOjfBYg42nnZ/nZ7ZCwUbp6xZRZDhgMgcgHOpPnYqczw4USvsD5qaxkJ+TBym/Zd
    jLR9TOi6kjZOBRPLNlmvlbTdd2pHvbJe5jr/V3fUt2acU8/IDX23GitstaCugO1I
    5Ux2+7CBlYiaKI6+Gz5VIykU9snYf72aE0ANuSAFfUuwtyEji7TT2XXpPj1ONyn8
    lbrvypEMB/wr+WSv+8BotkL0L2eeSGRfuUemzKUQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=CscCsy2n x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=CscCsy2n x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfOzGjCLBZjFaXyVgp9ollHAE8l1l39gn0OiFT+0SMYpn929VRtsJg+Bno9p/RRWVe1HtJsw8E51uGUdhfkR+FT+ehiJGR3ZbLyo18ywJDGm2rweRi5nB
    ifPadpX0zfCd73JWWwBI3SR9wF758Ea6I3XeLyjKIAne1VnUjMNUvWzkgzyIXG0P1qzhxDJzjgI4PJVneKAZf+PpqQs3yqffa08f/oIs/mKDsprmTS9x1wwf
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=T0JhKGde1cndCqfcSzYA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030744AbeEXKlP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:41:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:39080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030684AbeEXJ6t (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:58:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 155/165] serial: fsl_lpuart: Fix out-of-bounds access through DT alias
Date: Thu, 24 May 2018 11:39:21 +0200
Message-Id: <20180524093628.346140258@linuxfoundation.org>
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
@@ -2151,6 +2151,10 @@ static int lpuart_probe(struct platform_
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
