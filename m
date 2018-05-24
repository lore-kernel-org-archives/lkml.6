Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161507-2-8869318669375003429
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
    1527161506; b=leSkYzJOanWw+YV15ffFyQ3kpYi/cdwAE0ts17PqzMQZe8O5ie
    hKrpX+KCyR8FYWbc0n7+kyS7p16wV/FLDzyxzDiFJKg2/ZrQNgNDQSwbmyjwi7t4
    NdESSzAodhPA3nUaxVzE4lB2Xfs+1aR0n6rcjLc+2l4F2Jk4QF+hpLQVU7a35TwB
    Go39oSA9TN9Pec++SyQAsq8nidFM900d3xQlSllMgP66j4vCAy2YQFAVtjvdtwvZ
    aHnCDq2RyjULZ1+g1xtCB25S6xNOsPf44ZeG3G/6/4uqfMVAa/lEDBFUZmMQ6vSA
    jOMHFM5H1uw8EHiLDHB3gewvOBALrzo5eDDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161506; bh=YjqrNFeq2vlHkHOLKAKudokGT22WAH
    rMLbUwwzu12rA=; b=Ed1WaeUTdS8cV3xSp0E7Ttzv/ffhZQv6Lv2/wZIZo5tocw
    /xG0VARaruolLTaNSC4bIqfVKTLp2aO0TkHPnmHUphVDAbI6afXLAUdygWZ+5WJ7
    FPiNiefpKT9JMi2AqVKXyvouxjSnbbGbYRarUgn5IgyP4dF+RjXgqAPOPP9ZajuH
    7bxnyQeWvGz8u2lq5YG6AzOmG2Nj2sMP5zuqRwaWpXF258ff5AlIdYdq9wCM5Ne3
    NzcXfwA4W4sO3MFDRK+uOcAPcyiCc044GbMBq6NlfTthjxSv6NIGLKDesW4t6+8O
    dqsLG7fYwEKggCWfZHzG+4uwZ+kEzc7ShkTB7V1A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=jyVgl2xu x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=jyVgl2xu x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfBT3qLZsIvv0yIZpL7L9Ally3tw6FEnltvMUc5KWxBByoFHgiTUH1XHHHMdlpUjeg0kdKVps2+ATtaHumeLmYI4S1GO5kvxK0DhV+tYqtHhnDe/dLWAi
    qkxIH9Y/WWhAWhVr07sHDP6e0jgwva3fdYoDKoA893DqzctJa7X/JjARy+rE8LQHiCqn4EunhAPzX+uo4587IrNWbAO1IYcq9JTA2e32WSpG23PXSyGfvAE1
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=ao7VijfDgrWXSWN4ZT4A:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967268AbeEXJus (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:50:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:42996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967238AbeEXJuq (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:50:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 88/96] serial: samsung: Fix out-of-bounds access through serial port index
Date: Thu, 24 May 2018 11:39:11 +0200
Message-Id: <20180524093610.647235627@linuxfoundation.org>
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
@@ -1813,6 +1813,10 @@ static int s3c24xx_serial_probe(struct p
 
 	dbg("s3c24xx_serial_probe(%p) %d\n", pdev, index);
 
+	if (index >= ARRAY_SIZE(s3c24xx_serial_ports)) {
+		dev_err(&pdev->dev, "serial%d out of range\n", index);
+		return -EINVAL;
+	}
 	ourport = &s3c24xx_serial_ports[index];
 
 	ourport->drv_data = s3c24xx_get_driver_data(pdev);
