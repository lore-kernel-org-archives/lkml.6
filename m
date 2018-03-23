Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1182439-1521806782-2-8970883990630105855
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
    t=1521806781; b=C1a4la5ikaxOckyZb2XewghFGXr2IoXEaPRGTPOX25X8XBS
    Wc1hmblyVjR6ztgAROXvnCR9GOh4nqGp5uol1SN54JjN/nftwEwnLWEELqKRjiWr
    Q22vOEDM7tcG5JTLVpT4MT9dxmzhA+FVSH+UpbM+QGEGeiOQ7SMteP81JP3eDh0a
    QWhca9VYLeqiXsqNQjsQOjhp0G3ESgytTHrWpszKhi6YUjPYPVYuuL0PPOxhV3z7
    3Y6BOLL8aC2DJP9H1HV+QFfUQ6aSKeLS4TvHIntzQ/MrbgtozdNvK/fyZ0OwaFXi
    o9xqjn4sTYrCMcVLdBifajSWfzkVU8HM8xjy0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521806781; bh=HntS00pjMPRWvUU2GFyhhNoIcG
    ONKNzLo7KZK0Z6BrY=; b=d3E0fn4l0cn7Loc3kk6FwgINKCwmmca+Cbjs0yI7mX
    1BHyrd8mvqQl5qUXv1oRd8YHP2noCqY1bE9LfqnwiBP1LE8oxtPP9KZDQYHZIzNf
    t543yJNoV44XaLIi4GuplLNWKU+lnC6qaW1/Esa3x3QZ/hWU1EGkvns4wSbx1o4n
    DchFZBagYWSa5ZyNeMNLAorX3kmt9Y+BgBFbyKLLlDHobyzQdBLiOAEURr32aKFl
    LqnI+9jd04tdxLErNkTpfoFWZB+miU5dK0NQoXMnuqz2UdgRFygwVY6Fp7bFKzAl
    f7sxYi9kJH/fwYDP95TPDktYA6cuOuxjZDrVAFNHylJQ==
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
        id S1753262AbeCWJ7G (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:59:06 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35948 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752446AbeCWJ7C (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:59:02 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 57/84] clk: use round rate to bail out early in set_rate
Date: Fri, 23 Mar 2018 10:54:11 +0100
Message-Id: <20180323095420.613871629@linuxfoundation.org>
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

From: Jerome Brunet <jbrunet@baylibre.com>


[ Upstream commit ca5e089a32c5ffba6c5101fdabdd6dea18041c34 ]

The current implementation of clk_core_set_rate_nolock() bails out early
if the requested rate is exactly the same as the one set. It should bail
out if the request would not result in a rate a change. This is important
when the rate is not exactly what is requested, which is fairly common
with PLLs.

Ex: provider able to give any rate with steps of 100Hz
 - 1st consumer request 48000Hz and gets it.
 - 2nd consumer request 48010Hz as well. If we were to perform the usual
   mechanism, we would get 48000Hz as well. The clock would not change so
   there is no point performing any checks to make sure the clock can
   change, we know it won't.

This is important to prepare the addition of the clock protection
mechanism

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Tested-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Michael Turquette <mturquette@baylibre.com>
Link: lkml.kernel.org/r/20171201215200.23523-6-jbrunet@baylibre.com
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/clk.c |   25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1642,16 +1642,37 @@ static void clk_change_rate(struct clk_c
 	clk_pm_runtime_put(core);
 }
 
+static unsigned long clk_core_req_round_rate_nolock(struct clk_core *core,
+						     unsigned long req_rate)
+{
+	int ret;
+	struct clk_rate_request req;
+
+	lockdep_assert_held(&prepare_lock);
+
+	if (!core)
+		return 0;
+
+	clk_core_get_boundaries(core, &req.min_rate, &req.max_rate);
+	req.rate = req_rate;
+
+	ret = clk_core_round_rate_nolock(core, &req);
+
+	return ret ? 0 : req.rate;
+}
+
 static int clk_core_set_rate_nolock(struct clk_core *core,
 				    unsigned long req_rate)
 {
 	struct clk_core *top, *fail_clk;
-	unsigned long rate = req_rate;
+	unsigned long rate;
 	int ret = 0;
 
 	if (!core)
 		return 0;
 
+	rate = clk_core_req_round_rate_nolock(core, req_rate);
+
 	/* bail early if nothing to do */
 	if (rate == clk_core_get_rate_nolock(core))
 		return 0;
@@ -1660,7 +1681,7 @@ static int clk_core_set_rate_nolock(stru
 		return -EBUSY;
 
 	/* calculate new rates and get the topmost changed clock */
-	top = clk_calc_new_rates(core, rate);
+	top = clk_calc_new_rates(core, req_rate);
 	if (!top)
 		return -EINVAL;
 
