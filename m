Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804402-2-3486820852140900416
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
    t=1521804401; b=A3Mw2rgv1enxwqZq+BEqz6zE+N2wG9CWP5zRLjcO0GSvcdi
    7fghiLnCaEfYJZ8b8RZvNImRM8mStt3H6Jt2SCK06DVexoRt9WRz6vt8EFM2wJF9
    YezJBd89Bu7M54vBZKA7nrZU/n4dPfDIsGYoXK09qNDHbdCJEBBAd3H9W6YdQdMQ
    6H5qTkq03yyK5HM4tojzbw0X8o2iWgeCn+cJmXYQJNgH8yx8bNAgQ+RtM8acBdCD
    Iw9MiTv+RYuENNbsg7uBomtCmfCiodc3wA4BwP8hCKb4dG2i8WPp0fbqM8Qn62u6
    bErGtbm3vEN5XZFf1/k4oRtqluVCfBYf9dUKTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804401; bh=gIEA1qQ+LxtR7ULVwdyncygG7M
    g+8vbZUK3pH4vIGD8=; b=G532aQcJGrduA7RGDy6S+BET0u4GKo1pXQlXshdvnx
    fC2h10/EN2NPU7qHgyekaJnkKEXPqovVbDse+NvV56ij7xctgla1fW5738GcPrXm
    ouxX7DEEJlqPAg9K5O1iaMAA5qS+F0hxYnlH3XMiTDygxxaAbqrWgMw3mmKG9csm
    nBbkAbIiljKxe+VBJ3O2FdoOsYxRTDZixzhqHzLu1/vOuziUeJVO1V6AzFLl4yz4
    PrWCuOTb33I3sAr5Y/F29fQ/xGPYvYs4Zxt5Trnvo0z/vdJimToURzryEwodYlDA
    HScwn7u2jBX2UH9OkKW0sw4GWDhqOwO/4cbOuQok+a1A==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
        id S932421AbeCWKHQ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:07:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41144 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932395AbeCWKHP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:07:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kuppuswamy Sathyanarayanan
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 057/177] gpio: gpio-wcove: fix irq pending status bit width
Date: Fri, 23 Mar 2018 10:53:05 +0100
Message-Id: <20180323094207.861957137@linuxfoundation.org>
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


[ Upstream commit 7c2d176fe3f8dce632b948f79c7e89916ffe2c70 ]

Whiskey cove PMIC has three GPIO banks with total number of 13 GPIO
pins. But when checking for the pending status, for_each_set_bit() uses
bit width of 7 and hence it only checks the status for first 7 GPIO pins
missing to check/clear the status of rest of the GPIO pins. This patch
fixes this issue.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-wcove.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpio/gpio-wcove.c
+++ b/drivers/gpio/gpio-wcove.c
@@ -318,7 +318,7 @@ static irqreturn_t wcove_gpio_irq_handle
 	while (pending) {
 		/* One iteration is for all pending bits */
 		for_each_set_bit(gpio, (const unsigned long *)&pending,
-						 GROUP0_NR_IRQS) {
+						 WCOVE_GPIO_NUM) {
 			offset = (gpio > GROUP0_NR_IRQS) ? 1 : 0;
 			mask = (offset == 1) ? BIT(gpio - GROUP0_NR_IRQS) :
 								BIT(gpio);
