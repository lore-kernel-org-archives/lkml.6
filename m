Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182164-1521806603-2-17152087756325166490
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
    t=1521806602; b=mFZLCreXinbhQ103Pml6dBZS5I/eucjBcqbrf9aEnpfnb09
    Oknzq04CYdly19xUJMUQAzSFAts6+QgPD8iWXZwJS7SFaLCuNbfNyxvvZAbidHS4
    5nvwk7iUqd88JoWEraAQRKbJ3Z9ZBCc0KuqDTilT9YWvVwRNaD0E0zi4LIrRLzVJ
    T/919UFQpgBHzMzFDMCzVCemwRkRp6YJGMV+hybCUOmGLvy1xprikun3kE3BV+JD
    yVDlL11i2aKMYG0OIWf7ioLWWpVNmNggrzB5cbZizIq/cHxoHhyM3Jg3kWrBxwHv
    zoXX/cVsqWi7/hg8FuNxWjcRe15gk4QwRtBjy3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806602; bh=1ZXAsCorT0ZIl73tSfYbqLQv5n
    +xb+CMCTSuh1uoSmI=; b=s6z+QuwkmLNjoYh8olawbVeF7u+97w1zrQpkqJhTR2
    gMpSEWFpGcBSX2A/Ih+NcGdtZWAJOQzY8UYVzx3nBZyNKmmbxLKjhS0eax9qy7Ct
    B7/4Hax5iVYi8kk8Ege8XSVhc75hFV77AUVCSvzSM7Acgw7uyKXKrnJ2AFy/ONPD
    DuZ7P4d+fZacoOzlTfGtD5r9CJozwz9rtBHaAonaEhuNy1K8Qmw9844p0jRhZsQl
    QBNYgrK0MW2XSMi6FaKUgxHPzMUKEdnIx69HIRmGyu6+NNdx5OIPx/MzuyK1DdMS
    ++7CxU93WwxKexvg38VZGj5+B+2OJ0Ep38k3Ic6P+Usw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
        id S1753414AbeCWJ7v (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:59:51 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36292 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752769AbeCWJ7t (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:59:49 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Romain Izard <romain.izard.pro@gmail.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 70/84] clk: at91: pmc: Wait for clocks when resuming
Date: Fri, 23 Mar 2018 10:54:24 +0100
Message-Id: <20180323095422.536619470@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
