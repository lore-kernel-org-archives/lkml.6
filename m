Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3704313-1519413912-2-6376881853183573004
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519413912; b=EzIsT1hCExHZYnmIkllyIWYb5ShHFZ2XXezGmNyksTjxPt9
    UNGqFAXKPFGnsSuGMmGyHSYwyJjn6yPpJ4GdD6oz/kFRREdBaoYaPGTr/HWR9rYn
    Pew1lCpHiMYawKhleLxpMlO1zT22mvjM6wCWTeMqtRUs6XtLjBVpD5jDWJ11PsyW
    hoxgy7c7XarAqf3S5VPxUUykYEEfP+z7rkIh8B+vfehECabQndqXtx+7nCqOROYL
    CCWnXUyhe1EMG7cIO7bd1xIavmNrFX4zWzUJ6HZfHFjlWCmC5HqDdU4U2Ky3Kh0E
    Rg6f+i7A21D22eTQwXFpsFYV2TLBj5RtINUa6TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519413912; bh=m3QrrjnhjxI2mjVyn9MvuRxe2Y
    +iVhFBTNRYQjE+RLw=; b=ZyMHkgGCYkcH3EUw9/oo+gvUrKKeWz9nPBKUCFYfof
    wRJbUpBm4Z8dEk6TFlKC9TDtCtg3GWFOCi7m8dkgQtKZZ1qxfXL9arm6SD5YghOS
    q55VT00+lr7pM+3Yi58r3flSlEVwf8Dtbg+q9LxViYtmx/0R0NGIlJgHFhj+nBWh
    14ULiRD20EUCeHTVkeUjuxlFoeTuwrozN0T8YbNtlrWCokaDp58LtjOScpboAk3B
    c9OqAPeopZdFV+SUWU6OsZDtenrKg3pCEUyVxhuBEgYbQDOkhQ21xukBaZ8tgNEA
    /Qjqlr/FwpdljPe3QSi9AjRoJlmrrE1Z4BLyYl7lwDVA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935267AbeBWSw7 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:52:59 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:47158 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934921AbeBWSw5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:52:57 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@verizon.com>
Subject: [PATCH 4.14 083/159] gpio: davinci: Assign first bank regs for unbanked case
Date: Fri, 23 Feb 2018 19:26:31 +0100
Message-Id: <20180223170753.622996345@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170743.086611315@linuxfoundation.org>
References: <20180223170743.086611315@linuxfoundation.org>
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

From: Keerthy <j-keerthy@ti.com>


[ Upstream commit 7f8e2a85c1b0bd440ffe87be82c79fdc319e8291 ]

As per the re-design assign the first bank regs for unbanked
irq case. This was missed out in the original patch.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Fixes: b5cf3fd827d2e1 ("gpio: davinci: Redesign driver to accommodate ngpios in one gpio chip")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@verizon.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpio-davinci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpio/gpio-davinci.c
+++ b/drivers/gpio/gpio-davinci.c
@@ -383,7 +383,7 @@ static int gpio_irq_type_unbanked(struct
 	u32 mask;
 
 	d = (struct davinci_gpio_controller *)irq_data_get_irq_handler_data(data);
-	g = (struct davinci_gpio_regs __iomem *)d->regs;
+	g = (struct davinci_gpio_regs __iomem *)d->regs[0];
 	mask = __gpio_mask(data->irq - d->base_irq);
 
 	if (trigger & ~(IRQ_TYPE_EDGE_FALLING | IRQ_TYPE_EDGE_RISING))
