Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406395-2-7542463220757605788
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524406395; b=LywkHInr5QRUtp7sjVS18Q3B4IaORPntrhLd1Mr94wJZIdmtLx
    1eJuUUWuzE8fJ99AuVifsDIiObeZV+cqGdKTj6AzXnmTP0fy3ETfgHoURIRHLsyd
    c0E3UwH/DrHzSIa8JJRJ0ZeSgoXimcLgU1m9ADtO/ufJgtfRaK+u3E1IDJyRpNd+
    nqBLqgq4BrwHaA8r1tc54Wrp9AZBLCTb7RUrOmNS6iZgVQdwSL60jbGIyCJW0P5Y
    vcaLSCmoTR0xycROo3qsR9Efz37mLVqTuSt1637NZwEmZ10/5fxrIhp+QEDNb0bW
    SSgGGj6cZRfomW+qBJHkyvchlAni3I2hYmtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406395; bh=bYBExM5fKdj9lamSxMhe2y2bUe35ay
    UoLZB/PlIHWs0=; b=d+t+i9dpspLNfxsCCDpl85EOONiICBpQIqHN8Jhri7c978
    a/6GjAd0EZCo3Z2DzIN8Gbwks63PgGlHqiOsyqLikuwBhWR03lr4XTLtfno2xgLI
    QojzZwKx+8nWg6iTYQcCCBcIBzsJglEgWFBr9TNmSksDtk+uGqGqfwEVzT2l606S
    AM0bWdaK3kUXPHd7WrDqfhawdSFU0lzGsmbgJgFUDNd2MEjl3Bx9ieE8gAxixUG9
    VTRD49SPPcKiVqtkQj7AZbbk0L8HOb3weJAKKmNEe+4Ej8uV5gyG2dSFOYSHCsBf
    QNpuj4SZGJbn6EnPqAXkYOE5eM0fRMneDAty3YqA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfNSpFKIZTH2Hi0N+27IPY3O8tr4gA4NTTN0Bs5GU1BMyIW2V8NoutHE9X6zDSDWPpM1h2/lUv2/7V9/tjIID2gp8cS3M//1J+iMjd7dJXYSyPE/TStw/
    g5XHfnjKewBxHixq3XwIUfPj5Qa0s91Rl/6J3fNuFgVVjfvv3IdYvZmupTFDD1Ce6UChR4G4UBrcCoarXQcovaJ0cCP4C9sqRgvUSZUm6qt45le3K0m+Qbm7
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=uP1ucDPQAAAA:8 a=LpQP-O61AAAA:8 a=ag1SF4gXAAAA:8
    a=voKCIwh6ASnYZjJSyTIA:9 a=QEXdDO2ut3YA:10 a=9a9ggB8z3XFZH39hjkD6:22
    a=pioyyrs4ZptJ924tMmac:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756801AbeDVONJ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:13:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55498 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756784AbeDVONH (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:13:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: [PATCH 4.9 51/95] clk: mvebu: armada-38x: add support for 1866MHz variants
Date: Sun, 22 Apr 2018 15:53:20 +0200
Message-Id: <20180422135212.502698628@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
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

From: Ralph Sennhauser <ralph.sennhauser@gmail.com>

commit 9593f4f56cf5d1c443f66660a0c7f01de38f979d upstream.

The Linksys WRT3200ACM CPU is clocked at 1866MHz. Add 1866MHz to the
list of supported CPU frequencies. Also update multiplier and divisor
for the l2clk and ddrclk.

Noticed by the following warning:
[    0.000000] Selected CPU frequency (16) unsupported

Signed-off-by: Ralph Sennhauser <ralph.sennhauser@gmail.com>
Reviewed-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/mvebu/armada-38x.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/drivers/clk/mvebu/armada-38x.c
+++ b/drivers/clk/mvebu/armada-38x.c
@@ -49,7 +49,8 @@ static const u32 armada_38x_cpu_frequenc
 	0, 0, 0, 0,
 	1066 * 1000 * 1000, 0, 0, 0,
 	1332 * 1000 * 1000, 0, 0, 0,
-	1600 * 1000 * 1000,
+	1600 * 1000 * 1000, 0, 0, 0,
+	1866 * 1000 * 1000,
 };
 
 static u32 __init armada_38x_get_cpu_freq(void __iomem *sar)
@@ -79,7 +80,7 @@ static const int armada_38x_cpu_l2_ratio
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
-	{0, 1}, {0, 1}, {0, 1}, {0, 1},
+	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
@@ -90,7 +91,7 @@ static const int armada_38x_cpu_ddr_rati
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{1, 2}, {0, 1}, {0, 1}, {0, 1},
-	{0, 1}, {0, 1}, {0, 1}, {0, 1},
+	{1, 2}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
 	{0, 1}, {0, 1}, {0, 1}, {0, 1},
