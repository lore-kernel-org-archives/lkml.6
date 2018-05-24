Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527159190-2-7908357511500593598
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527159189; b=nqYHwB9gan41SXgL0eU3gYUZhWxYHXo4Q79u2N3DYWNHWqF3Ho
    obXnqd/RKyhIASiB4lTgT52dbLS8dG44gaYBFhhKhZH/pjWKqkxawDWBpbilelzh
    jaEaAMk3bM4ODMX3eI89nGDdQY8ujj7lGTyzxYFGX1KYrhlWviXJMyCV1cOlXYl5
    qcR9btTzdKe3stj8nUSyeJjY2RaqMa7oo8f1YMIF6N89dkEDzgFw9LL8RSVah6v7
    mHtk9bZZvy1M2MPSfoENSzcBnxVqx0Xme6nBd1M5ERvVOJ3kBQrWLb2+OTFVPH5B
    gy4iFGkxN04V2IIfWNSIM+Q1Xvn+5LFvo1RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159189; bh=LFputgNNM/xntiRntw1tgZ4Zre8xoV
    BM8eIaymLm9Cw=; b=m6GnllQFe/IqYueL0UdUIbp5E+hdpNLp4mLshRCGnI5hPy
    17TKXd5F0HM1jOACDiITysZ/5sQOW8skgYgC038aq3Pym0uhfJ4oNEtlE6D5YTb5
    qDrJIZo24mvqpOcWOBdoDky0jwDnnRjc7KYUYysYeWJO8pdEm8N5ko7vGkOUGZ8W
    CjG4DYS95ot3rgXam0vNTc14QFuYOhSU3TF5TQq3q6DpyhkGCyLjiQv8nzprIl9K
    BaL9bUi6tIO7kSwOkcv/B1o+lXyipG5/vB4N2oY3288wXU+Ult+y7NPPc8JiE8Gh
    WwpthDQCiTn0t+C+i051FlcVeBT8c/R+mv/pjEjA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=VPz66vF+ x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=VPz66vF+ x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKzpVw8TceQM2p8nowWOVYW3tJ9y+GXCGWZsdVyNNCY7V44AErNqcPGVcTaaFVKhFQYSVipfHGcNFqWZzvVjpo0Wkl7sVx6OzAYyufZMRtfSH+hDy05H
    yv+3MYCZgKtfVfaFVkqoxZnFCz6wia2AZpYWBcvfNZazKeyeiJKNyQ4l/gcOsrJMj4/18eGU535i+w8EFxVcJm4DOos8aMckTTlrIHe2m/nds4KW/0/CDVwp
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=hD80L64hAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=-RuleGSg_AdYtJgukIIA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032569AbeEXKwz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:52:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030429AbeEXJ5Q (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:57:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 134/165] clk: samsung: exynos5433: Fix PLL rates
Date: Thu, 24 May 2018 11:39:00 +0200
Message-Id: <20180524093627.488188340@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
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

From: Andrzej Hajda <a.hajda@samsung.com>

[ Upstream commit ab0447845cffc0fd752df2ccd6b4e34006000ce4 ]

Rates declared in PLL rate tables should match exactly rates calculated from
the PLL coefficients. If that is not the case, rate of the PLL's child clock
might be set not as expected. For instance, if in the PLL rates table we have
a 393216000 Hz entry and the real value as returned by the PLL's recalc_rate
callback is 393216003, after setting PLL's clk rate to 393216000 clk_get_rate
will return 393216003. If we now attempt to set rate of a PLL's child divider
clock to 393216000/2 its rate will be 131072001, rather than 196608000.
That is, the divider will be set to 3 instead of 2, because 393216003/2 is
greater than 196608000.

To fix this issue declared rates are changed to exactly match rates generated
by the PLL, as calculated from the P, M, S, K coefficients.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/samsung/clk-exynos5433.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -725,7 +725,7 @@ static const struct samsung_pll_rate_tab
 	PLL_35XX_RATE(800000000U,  400, 6,  1),
 	PLL_35XX_RATE(733000000U,  733, 12, 1),
 	PLL_35XX_RATE(700000000U,  175, 3,  1),
-	PLL_35XX_RATE(667000000U,  222, 4,  1),
+	PLL_35XX_RATE(666000000U,  222, 4,  1),
 	PLL_35XX_RATE(633000000U,  211, 4,  1),
 	PLL_35XX_RATE(600000000U,  500, 5,  2),
 	PLL_35XX_RATE(552000000U,  460, 5,  2),
@@ -753,12 +753,12 @@ static const struct samsung_pll_rate_tab
 /* AUD_PLL */
 static const struct samsung_pll_rate_table exynos5433_aud_pll_rates[] __initconst = {
 	PLL_36XX_RATE(400000000U, 200, 3, 2,      0),
-	PLL_36XX_RATE(393216000U, 197, 3, 2, -25690),
+	PLL_36XX_RATE(393216003U, 197, 3, 2, -25690),
 	PLL_36XX_RATE(384000000U, 128, 2, 2,      0),
-	PLL_36XX_RATE(368640000U, 246, 4, 2, -15729),
-	PLL_36XX_RATE(361507200U, 181, 3, 2, -16148),
-	PLL_36XX_RATE(338688000U, 113, 2, 2,  -6816),
-	PLL_36XX_RATE(294912000U,  98, 1, 3,  19923),
+	PLL_36XX_RATE(368639991U, 246, 4, 2, -15729),
+	PLL_36XX_RATE(361507202U, 181, 3, 2, -16148),
+	PLL_36XX_RATE(338687988U, 113, 2, 2,  -6816),
+	PLL_36XX_RATE(294912002U,  98, 1, 3,  19923),
 	PLL_36XX_RATE(288000000U,  96, 1, 3,      0),
 	PLL_36XX_RATE(252000000U,  84, 1, 3,      0),
 	{ /* sentinel */ }
