Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521803715-2-4531783478425171321
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
    t=1521803714; b=jmdYG2P1vB5RHl55bupkmIQTATgGp/jHinq7Y++nAF0AMnH
    LNY2krsqXnPTUlDtjOJb0hyzrr4T25rpWLajHh7FMXaWm0tGDtppX5yAXsDuQl4C
    glly2WvY7tN/lt1wV5xslCTm71nJQwxoMTpfXxpFWQOrwIQynuyumYwyNCLYulhp
    RIv0tUNYBK4eLduxc50xMZ6osPhFqOpgpwQLkQDA2lBdcJ9tQAut2c8sTuh11KGH
    gFrZ1ws7Mgn5FrO3KsGR2PYrgL1Ale5lHWC1Y9e/j3zYVPEEVFM3h6/DlzWDH/+F
    vJhF24mEgypyTYVi4SZipJK70DwSqA1zMbA/Hcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803714; bh=MsYWKBl2xUwXUilwBEGrJxcjgI
    yolWsfw1MhEnPSx7E=; b=QJ7EUYpAoyFU0RUgM0Sm6qogUiRFtzrwZ747/4fFGb
    d4nae2vBqj79525i5L2a7bykgeGIumjdJyEQ6Vm2IStbyESZGMkogVyvOUGXoXCJ
    2VQP4uaeSzS1odh84tHGIa80M2b7g+1EjrbRjC3Nn1tl6nPY5/b9ygTreBwKXfrJ
    jXq8ffYrCZq5QjBli9u/EMlsnGIap+BPZbidP9cZuDYf0KUFryKHx5IuTQn7Ij+M
    aFiqskC9N2J0y3Axr2vEgrJJPd2eWZD7j4AOmdGtWyTMLxUrFGuEA15ERsrywhkC
    ejlUFTVBAQpMhphbJlsTPjAjEfyWCjgJvcu51B+M3TBw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932622AbeCWKKJ (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:10:09 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42396 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932375AbeCWKKH (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:10:07 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Valentin Longchamp <valentin.longchamp@keymile.com>,
        Scott Wood <oss@buserror.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 105/177] soc/fsl/qe: round brg_freq to 1kHz granularity
Date: Fri, 23 Mar 2018 10:53:53 +0100
Message-Id: <20180323094209.916492535@linuxfoundation.org>
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

From: Valentin Longchamp <valentin.longchamp@keymile.com>


[ Upstream commit 2ccf80b7566cc035d903dd0ac5d7ebd25c2c1060 ]

Because of integer computation rounding in u-boot (that sets the QE
brg-frequency DTS prop), the clk value is 99999999 Hz even though it is
100 MHz.

When setting brg clks that are exact divisors of 100 MHz, this small
differnce plays a role and can result in lower clks to be output (for
instance 20 MHz - divide by 5 - results in 16.666 MHz - divide by 6).

This patch fixes that by "forcing" the brg_clk to the nearest kHz when
the difference is below 2 integer rounding errors (i.e. 4).

Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
Signed-off-by: Scott Wood <oss@buserror.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soc/fsl/qe/qe.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -163,11 +163,15 @@ EXPORT_SYMBOL(qe_issue_cmd);
  */
 static unsigned int brg_clk = 0;
 
+#define CLK_GRAN	(1000)
+#define CLK_GRAN_LIMIT	(5)
+
 unsigned int qe_get_brg_clk(void)
 {
 	struct device_node *qe;
 	int size;
 	const u32 *prop;
+	unsigned int mod;
 
 	if (brg_clk)
 		return brg_clk;
@@ -185,6 +189,15 @@ unsigned int qe_get_brg_clk(void)
 
 	of_node_put(qe);
 
+	/* round this if near to a multiple of CLK_GRAN */
+	mod = brg_clk % CLK_GRAN;
+	if (mod) {
+		if (mod < CLK_GRAN_LIMIT)
+			brg_clk -= mod;
+		else if (mod > (CLK_GRAN - CLK_GRAN_LIMIT))
+			brg_clk += CLK_GRAN - mod;
+	}
+
 	return brg_clk;
 }
 EXPORT_SYMBOL(qe_get_brg_clk);
