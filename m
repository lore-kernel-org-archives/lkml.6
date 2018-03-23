Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025519-1521802323-2-8078461389474899940
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521802322; b=fGZ+EwsYLc3TzW+tTqQqx50R8/Zan9q1tdEbLInLL11aejW
    GCTGf7WLDyyeqtvNJP8t7cpARd43ds05q44tp1Nr5oqzGGFRjN1YoOJYxen6Zip+
    LTUDAcEXMMzOkwGuQsibCvXfVKJktVLVmSIPgNBtKqllqPySsJQN7XNHEnu5bc3C
    dSy68qzlu9hM6W9DZ8B8NiwvN0uMndNScXtYWSu/x1PZs5eQoF3+QhgwGKmvFMC0
    7e2zn+X0yFfBE8rbWWJrL50+Og05Tw16USVj91UPG+aVfTw7K3JYFoWjcwox5saE
    Y7QPJUF5vB8AzdNCufcTk7VMKwPZEwoHowp36MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802322; bh=OOCUYZlzgWHc5HdEPWwX0U6MZc
    UpGJr2+QRC7T5aEEw=; b=HKYYcZM6EyWyQX09kYKXevqSEDGoTYCLzed72e7Pps
    O4Lf5ZGqnfvX6ZmDqqCFlmj4B0mSOCflBJopoOrX81fsyUKjcVcch3rJHBn2Nxip
    bm8j3DKeSAPXQpnJmcr71jQKsCzqnhFL0Jr8rjUlDkDGl4NR5F0mnOhN6w4Vewum
    bmbpPy6iGxLc1Iv2EiriWiu5imZ3TV81U3xxrT4C91ALHeczTqzZkXpfUEcCoAo7
    ttcA9zn0IW3HL13qZ1ED9S969blJ0/CGjFvOI+7KKqIYdXhgLSsKmYo0tr3z5XbX
    EcubRivZAqSONT4axEClm+t3EY+XtMI+akHPJNJBVLtg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755994AbeCWKOP (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:14:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45100 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755901AbeCWKOO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:14:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 19/97] spi: dw: Disable clock after unregistering the host
Date: Fri, 23 Mar 2018 10:54:06 +0100
Message-Id: <20180323094158.546147392@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094157.535925724@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Vasut <marex@denx.de>


[ Upstream commit 400c18e3dc86e04ef5afec9b86a8586ca629b9e9 ]

The dw_mmio driver disables the block clock before unregistering
the host. The code unregistering the host may access the SPI block
registers. If register access happens with block clock disabled,
this may lead to a bus hang. Disable the clock after unregistering
the host to prevent such situation.

This bug was observed on Altera Cyclone V SoC.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/spi/spi-dw-mmio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/spi/spi-dw-mmio.c
+++ b/drivers/spi/spi-dw-mmio.c
@@ -120,8 +120,8 @@ static int dw_spi_mmio_remove(struct pla
 {
 	struct dw_spi_mmio *dwsmmio = platform_get_drvdata(pdev);
 
-	clk_disable_unprepare(dwsmmio->clk);
 	dw_spi_remove_host(&dwsmmio->dws);
+	clk_disable_unprepare(dwsmmio->clk);
 
 	return 0;
 }
