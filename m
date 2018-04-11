Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3397032-1523481390-2-1729632510389352688
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523481389; b=kQ320iiEKvwUKcp5/ktr2yvMYixrMtdYyLIW/AEJCg/Lt27lsI
    LbE0lN4Bj9bOCnWvQvMv/C1HcnsVHjcXpBVGwCBYnpdoqbfDFF5yRVaEBw+5cDvc
    EeF+qea/avInY8LHcs6Byof0yD82tdgX0DEsSpk2U/cZPNgT6Kt0PfSVixexvnbd
    dJ3hlNBJVWOmsIAHz4n92ludW7jRK8RvP16m3HyRuO+HO9gPN8cFbDL4THBmyGAv
    seJRCTwJ/qS104MOJTc9+GkKsF/WwIBjzY8eyfpiidvw3j6M2uGFynt1lMIlFZ0F
    T/cofadAhhP14n5D76t6Y5TFe9KbH1BJTzNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481389; bh=7bDhRyToeTEq2kXR7BIxD3oFwxtdI1
    FIYtod7uiszlY=; b=HHmTKih/V0FbmcMIKs+yyhCYwVY6n2pMAGk6LDJPk9kUo6
    QHW35EJJS34cBfq6rsYt0rZ5MmLiGWTSCtSOri8XyOtoJ2pi58NPHlJNPa6JTDag
    Pme4J55Rn0P/hIOZhIDXqTVAJwYSA77TBFkFCd5Nfdq9XoyNYdgMQNuIyCde/+l1
    9q/JaxQ52DLnDWhiMDy4PTCqBP8/Z/zBO3IzM6PLMCdJv+oEsqiMrgrf/J4a4o8l
    awR6FRbzFgFAXjjaTzDCdEUC1BBNQVCE+ZebQFs5EdK8m3+/sxfCHe5A+ydAbtMT
    GXWoeH/eXIW7jiA0zhkwVu6LuO9gdMBo6Fqvns9g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAr34+3tTuyBUkaNVQcN1ev7mvetDTnqKntvJtd3crn+Vz1McJGduTsEGTrtHroKMAUtaHF9am7l0DjMouT8cHOgPNHRg8avBmcc8J4Zr0r5I2m2dT/H
    RVoqvjlJZREyC7I70hCmcIa5cmvAKFjpFssjMHUSGIrFvq3IuDBz9oL6dptAYLRP0jkn7RsTMZrSB9/1ABX8vhNTsYUdA68yjhU5pwzuyXLu46sOHNhpFU69
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=PHq6YzTAAAAA:8 a=ag1SF4gXAAAA:8 a=yMhMjlubAAAA:8 a=QPzaX5DZGYNi95dB0RoA:9
    a=QEXdDO2ut3YA:10 a=ZKzU8r6zoKMcqsNulkmm:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbeDKSkh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:40:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56508 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754623AbeDKSkg (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:40:36 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 065/121] Fix serial console on SNI RM400 machines
Date: Wed, 11 Apr 2018 20:36:08 +0200
Message-Id: <20180411183500.166661866@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>


[ Upstream commit e279e6d98e0cf2c2fe008b3c29042b92f0e17b1d ]

sccnxp driver doesn't get the correct uart clock rate, if CONFIG_HAVE_CLOCK
is disabled. Correct usage of clk API to make it work with/without it.

Fixes: 90efa75f7ab0 (serial: sccnxp: Using CLK API for getting UART clock)

Suggested-by: Russell King - ARM Linux <linux@armlinux.org.uk>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sccnxp.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/drivers/tty/serial/sccnxp.c
+++ b/drivers/tty/serial/sccnxp.c
@@ -884,14 +884,19 @@ static int sccnxp_probe(struct platform_
 
 	clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(clk)) {
-		if (PTR_ERR(clk) == -EPROBE_DEFER) {
-			ret = -EPROBE_DEFER;
+		ret = PTR_ERR(clk);
+		if (ret == -EPROBE_DEFER)
 			goto err_out;
-		}
+		uartclk = 0;
+	} else {
+		clk_prepare_enable(clk);
+		uartclk = clk_get_rate(clk);
+	}
+
+	if (!uartclk) {
 		dev_notice(&pdev->dev, "Using default clock frequency\n");
 		uartclk = s->chip->freq_std;
-	} else
-		uartclk = clk_get_rate(clk);
+	}
 
 	/* Check input frequency */
 	if ((uartclk < s->chip->freq_min) || (uartclk > s->chip->freq_max)) {
