Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521804880-2-3369810320402295795
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
    t=1521804879; b=N8sDRuoI96JSJ1KG4cUfAhGZoXJ634oO7fCaKmnELPtJOgW
    hmt4bi1+QCSG5/om29YYtMq4tr5u6z9HBRxJmPdvb6tuLOI9BgHvFszbKy+LxEtD
    UijGT1wGaxEKbDs1c4PvbgKkfPYaZe7+oRQdaZzAe6wrQY9CWJMvvNaIJGueK4dU
    UahjrFKhq6mGIIYJkDhGlk1iB47vDFPR3x+1GDY5Ug0qTiQoSv17qsB+47KVHjtl
    IjaQlaySz0kGhLhkesnVLU82htyfa51U4aEBUrYNclWKg4ba2CBqc5FjYE0pdlyX
    bSZxjPX6scUdvC6kJqINzp5jI89aizMQ/ktpuAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804879; bh=gTdPMX8F6zwaryIJ65s8DJNprF
    mnvi1iMELWl/KFQQo=; b=l0oX+wM/5OsRbVMI5cykXybx4WNquzKIYyETEllVYK
    BOx2IeR3yhjmY0bd4WvkWFShCjipwHkVgZGNTnstywF8UkCiaMDz67ZOdKagpEfR
    LM14AHO3RTkiEJBkbWAKuhcJEWBQSNTsaQde9aHw4ocoo8XK3ot+lgF8uo2edlMc
    UUiTGJra57/mpEmF+wCua/F/BbyXuFCf7vKKCqI2DQ++IozHb0/ZR2XJK0jY+Vna
    rbut+RfNAIJvGoXLKCz6RYbB510RZZZAiWpmTu839KWM0rRiYE+62PX9VbnwuI+A
    hLdpz5uUvZJ0VE1af5+nNqSVWi0ul/w+awe5urH8CbfQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
        id S1754959AbeCWKFW (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:05:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39618 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754935AbeCWKFU (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:05:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 026/177] spi: dw: Disable clock after unregistering the host
Date: Fri, 23 Mar 2018 10:52:34 +0100
Message-Id: <20180323094206.346537936@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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
@@ -115,8 +115,8 @@ static int dw_spi_mmio_remove(struct pla
 {
 	struct dw_spi_mmio *dwsmmio = platform_get_drvdata(pdev);
 
-	clk_disable_unprepare(dwsmmio->clk);
 	dw_spi_remove_host(&dwsmmio->dws);
+	clk_disable_unprepare(dwsmmio->clk);
 
 	return 0;
 }
