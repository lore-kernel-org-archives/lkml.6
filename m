Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2951739-1517591854-2-8615126844011963557
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591853; b=Ug0WQZ/s6rvvxseZVCVDnsSGWSwQxHlhc8kgqk4J4vDoA5x
    6YCEAFLW7lJ+gI+7ua98MGV5Hk+dBE+eSSru6bRvuU5rrRLlr1GNZdpSVAJmJAU9
    jeR2HsazLlREzdHRkPjxraFn5gO61TXptHzs3KfSreDIBOynDcsBBrBCXE1wGvVY
    cH8LLZZX0O9l2Z6cf86dDDevXsqrsBgjEGj855ibeex/gauwGabj8A0uKOOOPQAG
    Sz/UW6YmOtmj0ahckmi1aubEax4VftIVrh5YJpkgPBkTeVqiOHso2N6bKkFDuBXG
    HzEcZHgP5ZErND1RBNEv+QIdXmVd0mi8TWp1aIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591853; bh=Jc9y0gnUyTp7kNYhOxkjMpYmRm
    F2o0hR+bnSV71PG2s=; b=tlmHOoavPaDTIN/GmYw2T+mCL1vOg+awBLyYUodAsA
    3W/qgdYtnEdpFPBnmxMPOzmUKnB0FOW56skkq6M+P1zjQVr6FT+xW55DbPl1tYyO
    f45dIu3zCfIZD09RmorpT+Gnjsp6CLfjw3YsUPSkHq0WChwUYwOqBSX5bJMA40Nu
    +1qerzEkeK3KwJg1ZkHXbW/rOCNKNkiaCpOfDCGf3yMW4A1L3eIz7S1Kcto4fSO5
    Xkn9gSQjVP2TNVgZIF+Ey5GRvdKAaMSDVKiY2m7cYZ757OYs7lkJWV6zn7jE5rI3
    Fq/fe9v9EBR4tI1786qqEvXAfxlGjjKFDP5EESyDuNGg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753885AbeBBRRb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:17:31 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:41230 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753695AbeBBRR3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:17:29 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ed Blake <ed.blake@sondrel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4.15 47/55] serial: 8250_dw: Revert "Improve clock rate setting"
Date: Fri,  2 Feb 2018 17:59:05 +0100
Message-Id: <20180202140830.649634918@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140826.117602411@linuxfoundation.org>
References: <20180202140826.117602411@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit c14b65feac9ebed649d6fe79c6b6d64d21d0287d upstream.

The commit

  de9e33bdfa22 ("serial: 8250_dw: Improve clock rate setting")

obviously tries to cure symptoms, and not a root cause.

The root cause is the non-flexible rate calculation inside the
corresponding clock driver. What we need is to provide maximum UART
divisor value to the clock driver to allow it do the job transparently
to the caller.

Since from the initial commit message I have got no clue which clock
driver actually needs to be amended, I leave this exercise to the people
who know better the case.

Moreover, it seems [1] the fix introduced a regression. And possible
even one more [2].

Taking above, revert the commit de9e33bdfa22 for now.

[1]: https://www.spinics.net/lists/linux-serial/msg28872.html
[2]: https://github.com/Dunedan/mbp-2016-linux/issues/29#issuecomment-357583782

Fixes: de9e33bdfa22 ("serial: 8250_dw: Improve clock rate setting")
Cc: Ed Blake <ed.blake@sondrel.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/tty/serial/8250/8250_dw.c |   30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -252,31 +252,25 @@ static void dw8250_set_termios(struct ua
 			       struct ktermios *old)
 {
 	unsigned int baud = tty_termios_baud_rate(termios);
-	unsigned int target_rate, min_rate, max_rate;
 	struct dw8250_data *d = p->private_data;
 	long rate;
-	int i, ret;
+	int ret;
 
 	if (IS_ERR(d->clk) || !old)
 		goto out;
 
-	/* Find a clk rate within +/-1.6% of an integer multiple of baudx16 */
-	target_rate = baud * 16;
-	min_rate = target_rate - (target_rate >> 6);
-	max_rate = target_rate + (target_rate >> 6);
-
-	for (i = 1; i <= UART_DIV_MAX; i++) {
-		rate = clk_round_rate(d->clk, i * target_rate);
-		if (rate >= i * min_rate && rate <= i * max_rate)
-			break;
-	}
-	if (i <= UART_DIV_MAX) {
-		clk_disable_unprepare(d->clk);
+	clk_disable_unprepare(d->clk);
+	rate = clk_round_rate(d->clk, baud * 16);
+	if (rate < 0)
+		ret = rate;
+	else if (rate == 0)
+		ret = -ENOENT;
+	else
 		ret = clk_set_rate(d->clk, rate);
-		clk_prepare_enable(d->clk);
-		if (!ret)
-			p->uartclk = rate;
-	}
+	clk_prepare_enable(d->clk);
+
+	if (!ret)
+		p->uartclk = rate;
 
 out:
 	p->status &= ~UPSTAT_AUTOCTS;
