Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4104350-1519815222-2-11913981588953430552
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519815221; b=FjZ9UDQfH1zx1W+ey9MbhH4CdV7fcC1cg9gmPMCi66dSFba
    OPNUz1K/uHxT+6ET/24Cj+lq+JbRTv5w80oNaoYCdDeeEBAtYZP29shXFzOohjVg
    nRHlRaXCcEKjA/Veul7UEdkzh1Sq7aSZ06O38b8exhLsMM/ekiUfCyFCz9L6Ez4k
    sB8q6w4hXX4CI8Zp0EQ+ok4DGCPp7X7FXa5aXCgjE/gyTqmRYZNVxGGFjKkY2/wE
    vc3Q9QGMSEw3twL13x2W6jGwv2BglAhKvQEPJ4N0SmXzxXQHzEQY1/AY+z9JKdNk
    xNFEdccM2H7b+3t3VnFeR19E1FtvZQofkeZv2aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1519815221; bh=cS46Rj
    Nc3xLkR+DPB31yzo+H+yuFqwHOp9oSXIXpsLY=; b=Jt++D1W9ppF4KxUC2dvnXs
    BhKN8Oext6cfYrpgduZvuDFc8OiwPxT4xqWKRipYlx/gKvpv2uGHbfJoueHoO4MM
    71aNZnN70dYEH7XIG7wLjkpqrTCVAXWzu6EFloW4+lGq70Vp5x6sypsRsutIlahI
    WKLwBbygqUh4tGWFarxbu+A0Yxbr8QbSUsqf2PnC2GvzxE6dsm91vhwsIYm8rT/r
    cz9ZDrfNaeFIw48nWuWYlyX2q7WnivOCetkbG1WHY9URicc73J29VHm3k6Et2YVY
    5N+FBYfHcfE845qrxglV4tVZHVO/k5W9boh0O6LUQ0I6npLkhM9tSJkgX5VjvCtw
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=st.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=st.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbeB1Kwm convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Wed, 28 Feb 2018 05:52:42 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:5766 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752569AbeB1Kwj (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Feb 2018 05:52:39 -0500
From: Bich HEMON <bich.hemon@st.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "Jiri Slaby" <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH 2/2] serial: stm32: update interrupt initialization
Thread-Topic: [PATCH 2/2] serial: stm32: update interrupt initialization
Thread-Index: AQHTsIIPNbqkuZnI3kumV1A3OSEfog==
Date: Wed, 28 Feb 2018 10:51:17 +0000
Message-ID: <1519815044-22669-3-git-send-email-bich.hemon@st.com>
References: <1519815044-22669-1-git-send-email-bich.hemon@st.com>
In-Reply-To: <1519815044-22669-1-git-send-email-bich.hemon@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-28_06:,,
 signatures=0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

For each port, get each IRQ using its specific name instead of its index.

Signed-off-by: Bich Hemon <bich.hemon@st.com>
---
 drivers/tty/serial/stm32-usart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 0fa735b..5c85cbc 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -680,8 +680,8 @@ static int stm32_init_port(struct stm32_port *stm32port,
 	port->flags	= UPF_BOOT_AUTOCONF;
 	port->ops	= &stm32_uart_ops;
 	port->dev	= &pdev->dev;
-	port->irq	= platform_get_irq(pdev, 0);
-	stm32port->wakeirq = platform_get_irq(pdev, 1);
+	port->irq	= platform_get_irq_byname(pdev, "event");
+	stm32port->wakeirq = platform_get_irq_byname(pdev, "wakeup");
 	stm32port->fifoen = stm32port->info->cfg.has_fifo;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-- 
1.9.1
