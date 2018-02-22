Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-713482-1519321797-2-866166894333976275
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519321797; b=CVpJ4SSTVG4LmRg890mm5ZgQb3URNyKCwu0ddNVLGxRjUm9
    7QgnWofw/KTx3L1VQTM4ogBjSUwrSJrEGg4UasQKHzBzoFNRLGCwh3wrSVZrs7Sf
    1muUw7oVmE68SDAmZKKXzMDjAouX4RVkOVbLs3ucEfT+Ef5sqScESdHv1s81jD4n
    oiPZXJH7p48sCbIuEIIUGvjQh/eDAzbFkTwW21KgPY7rcD92hriQyGPmP7hY3vb5
    ArAjHnqpSnC5foRyaCOPN54psrOgW1iER1e58/s+qP54QxMYl5jOl6lQQIWQ7VHZ
    RZFt1DZoGU+PGBjUhYtUTXilp8+6B6kZ3vJu7iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519321797; bh=3obFTH9qLPtg8DinRB+Tvv4k4q
    9uq40ESBaaPIYWQzA=; b=effTPULgiRu6TpJPFmiD8TjF7NbIruHatGM36uQPMN
    3AjQrpU6rbLetcfpxsgT5agoIPbErC4iqK/mcScgd7rsfjeGt21c+U73hCL9qjcR
    iXHC4z/GiasAaBmVOrmH1g96sphd7OJ9vDwOd1yguAdKaxJxKPPtgWOR0Nj+IVqn
    DhlghFCttLuGiIBnpj/8mbyRuBXAxUjSciqppCXZa+GLSftP15IuADi6RFmD6oFT
    Z3P5JChwwQhN1gKD5JHSN863iljlbbi+dZur/YJGLbBp3x8ioOQ7YwNNVstVlSDs
    yPZIo1Z5Fi0K+B0dPJs4SdGAEGk9a+eYxZbn55zK2aZQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=huawei.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=huawei.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933446AbeBVRtz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 12:49:55 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:54863 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S933441AbeBVRty (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 22 Feb 2018 12:49:54 -0500
From: John Garry <john.garry@huawei.com>
To: <andriy.shevchenko@linux.intel.com>, <gregkh@linuxfoundation.org>,
        <slaby@suse.com>, <p.zabel@pengutronix.de>, <heiko@sntech.de>,
        <ed.blake@sondrel.com>, <jhogan@kernel.org>
CC: <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [RFC PATCH 2/2] serial: 8250_dw: support polling mode
Date: Fri, 23 Feb 2018 02:42:03 +0800
Message-ID: <1519324923-196857-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
References: <1519324923-196857-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

It would be useful to make this driver support some
8250-compatible devices which have no interrupt line.

For these, we allow for no interrupt, and will fallback on
polling mode.

Note: the 8250 dt bindings state that "interrupts"
is a required property:
"interrupts : should contain uart interrupt."

But the 8250_of.c driver can live without it. So
this patch is going this way also.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/tty/serial/8250/8250_dw.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 28fbc8f..3154988 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -422,9 +422,10 @@ static int dw8250_probe(struct platform_device *pdev)
 	}
 
 	if (irq < 0) {
-		if (irq != -EPROBE_DEFER)
-			dev_err(dev, "cannot get irq\n");
-		return irq;
+		if (irq == -EPROBE_DEFER)
+			return irq;
+		dev_warn(dev, "cannot get irq, using polling mode\n");
+		irq = 0;
 	}
 
 	spin_lock_init(&p->lock);
-- 
1.9.1

