Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-977995-1521799687-2-3056307634285914353
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
    t=1521799686; b=ryx4lYGU+K7nXvt3NrpMPYR2RMjpPbj5QQ1NGNxZOMfaMR8
    0rkAl6nPJ64nktXZON+tehWiUO0U03CIWLbyrsdZjpJwLn3j3lfGe71tWlVIJLJX
    tQ4tTIRroF/pzScDEYLmw+HLmMZa2cwE3oCEfM2rhtXIFUqAXQRjdqMwHpN1FErY
    3tlxa2wGNxf3mjy0iSK9+Qv+ozf8Gu3G0vfcX92kl0r61pxaOsz61UNg34p/Acy/
    3s4b/aq2B/Wlb3JJ3PySHqhhSDLCcm+3Rb3vShh9yup+zjmEbae6Tcyqf4zWrfkC
    lcaO8C4k5CYJ0zqgs9mkfAH4F9HPh1t+XimM7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521799686; bh=sP65NP6kwu3hSdk4qAv8uuQ2+O
    WwOULWg0HFFJgdC/0=; b=LLPVmwqqsPiNCMbFJFnavwD1tVIxSfqoazT2KBV7Xq
    QuFd6dT3eyDe4tyaUVLltEGG+DZQLD/Q9dI5RrgrLDBDXMzaO7UfvBbuO1RdmgSn
    gvxl3ABQj4nBFjNK9SBXO6jEuMVbYB7itcSWe0tBJKReoA7rGzBQ+/hHLM/C8RRZ
    FzOs3rlSczgAEFXGOGuBaLNp+As/VkkmBTeVTK3b0sl9qy/Q0gB5FQ10dg/LUXdv
    1fS35N7zsu1Qg9f2jW+ASa3q6w8CZpwzlxxUVTlKE614pnafN/XOO835V+9Qya/W
    ZNqobbO2Kj68Y6TOohPqipu1igBRrzwkVKZzrVVTsm+g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
        id S1755421AbeCWKIB (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:08:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41496 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755403AbeCWKH6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:07:58 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 087/177] gpio: gpio-wcove: fix GPIO IRQ status mask
Date: Fri, 23 Mar 2018 10:53:35 +0100
Message-Id: <20180323094209.131355136@linuxfoundation.org>
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

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


[ Upstream commit 881ebd229f4a5ea88f269c1225245e50db9ba303 ]

According to Whiskey Cove PMIC spec, bit 7 of GPIOIRQ0_REG belongs to
battery IO. So we should skip this bit when checking for GPIO IRQ pending
status. Otherwise, wcove_gpio_irq_handler() might go into the infinite
loop until IRQ "pending" status becomes 0. This patch fixes this issue.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-wcove.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/gpio/gpio-wcove.c
+++ b/drivers/gpio/gpio-wcove.c
@@ -51,6 +51,8 @@
 #define GROUP1_NR_IRQS		6
 #define IRQ_MASK_BASE		0x4e19
 #define IRQ_STATUS_BASE		0x4e0b
+#define GPIO_IRQ0_MASK		GENMASK(6, 0)
+#define GPIO_IRQ1_MASK		GENMASK(5, 0)
 #define UPDATE_IRQ_TYPE		BIT(0)
 #define UPDATE_IRQ_MASK		BIT(1)
 
@@ -310,7 +312,7 @@ static irqreturn_t wcove_gpio_irq_handle
 		return IRQ_NONE;
 	}
 
-	pending = p[0] | (p[1] << 8);
+	pending = (p[0] & GPIO_IRQ0_MASK) | ((p[1] & GPIO_IRQ1_MASK) << 7);
 	if (!pending)
 		return IRQ_NONE;
 
@@ -334,7 +336,7 @@ static irqreturn_t wcove_gpio_irq_handle
 			break;
 		}
 
-		pending = p[0] | (p[1] << 8);
+		pending = (p[0] & GPIO_IRQ0_MASK) | ((p[1] & GPIO_IRQ1_MASK) << 7);
 	}
 
 	return IRQ_HANDLED;
