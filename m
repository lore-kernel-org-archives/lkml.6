Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1133089-1521805594-2-3807825967030080548
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
    t=1521805594; b=JUSf2vYU1VsCrKIfSZSEpYkdtY2tZmzxXxuvnDxv/Lmit0n
    47Jzklk0//cPUEOhXTfuKqKexn0gET0tEScsz7zROCB8aUVega1xGNZ7TgCudnov
    fktMcc7alq94pJJVq2qMV+v3gDE41IKaqzyEfcc+8RU01uT2m4dNVbk4qkpEfoTE
    astpQ49HT71Sms3uc/UF6Cf2AHHSxr5OdgzHVKOBFAdze7tEHcarZTkooWbYm9E9
    wZoNA/ttSD3dr9plwdRdRvAfhg48CefNMpG6WyYRyRP6H0PifhQTR9yv+m80dSQK
    ElQq0CJFwgU7iWSuuH5BJDHkLOku7GTu/dBZyyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521805594; bh=cuVbWziXOM3TjgWMPmpm3H+ktx
    u297nFY4scRpIQnjY=; b=IoopChXpKZyKQTOSJIUCkHOuKinzS0nkXbmRQ2QtJX
    AEd0vbtkX4byedQypk5cPVGQW/xGML3CXFRjcdyZUuNdTUUQKJdJhTsta+67xNrI
    /LmIbG84vjVAN0PW9pP7v/PnE12YZX2U14ybLif4RZ0on5/1z24MZv0T4Gk2LUhK
    ty8IaBws8jvkvWvmyaAlo4CRgkmo0pEBkqdEimB3BRUEezxuc06N9KdT2DKAAx7D
    m1Vus97nhF0KzCoArhuz/PW7EfhzpurhI/XNICeaDbTZCbbYMMZvJBBwLnwYqK7W
    VabApfzTIyfW94G9+V4+3YU1So0XRTVIUucJ6PBBDRRw==
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
        id S1754414AbeCWLqP (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:46:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38518 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754324AbeCWKCw (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:02:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Romain Izard <romain.izard.pro@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 61/77] clk: at91: pmc: Wait for clocks when resuming
Date: Fri, 23 Mar 2018 10:54:35 +0100
Message-Id: <20180323094146.375113533@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
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

From: Romain Izard <romain.izard.pro@gmail.com>


[ Upstream commit 960e1c4d93be86d3b118fe22d4edc69e401b28b5 ]

Wait for the syncronization of all clocks when resuming, not only the
UPLL clock. Do not use regmap_read_poll_timeout, as it will call BUG()
when interrupts are masked, which is the case in here.

Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/at91/pmc.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

--- a/drivers/clk/at91/pmc.c
+++ b/drivers/clk/at91/pmc.c
@@ -107,10 +107,20 @@ static int pmc_suspend(void)
 	return 0;
 }
 
+static bool pmc_ready(unsigned int mask)
+{
+	unsigned int status;
+
+	regmap_read(pmcreg, AT91_PMC_SR, &status);
+
+	return ((status & mask) == mask) ? 1 : 0;
+}
+
 static void pmc_resume(void)
 {
-	int i, ret = 0;
+	int i;
 	u32 tmp;
+	u32 mask = AT91_PMC_MCKRDY | AT91_PMC_LOCKA;
 
 	regmap_read(pmcreg, AT91_PMC_MCKR, &tmp);
 	if (pmc_cache.mckr != tmp)
@@ -134,13 +144,11 @@ static void pmc_resume(void)
 			     AT91_PMC_PCR_CMD);
 	}
 
-	if (pmc_cache.uckr & AT91_PMC_UPLLEN) {
-		ret = regmap_read_poll_timeout(pmcreg, AT91_PMC_SR, tmp,
-					       !(tmp & AT91_PMC_LOCKU),
-					       10, 5000);
-		if (ret)
-			pr_crit("USB PLL didn't lock when resuming\n");
-	}
+	if (pmc_cache.uckr & AT91_PMC_UPLLEN)
+		mask |= AT91_PMC_LOCKU;
+
+	while (!pmc_ready(mask))
+		cpu_relax();
 }
 
 static struct syscore_ops pmc_syscore_ops = {
