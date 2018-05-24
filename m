Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527155422-2-12152536984755569757
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
    1527155422; b=LkKV/57ZDlzJeFj/hHaWol0EapNZpVqRQEGg1XM1btR3YJaf9y
    ZKOvtM5Rt6sohM5Ts1ZLgcZ2JInkbAs1OKr/mVGMWAsN/V2uXHEF1jO9BJ98YjDF
    vyqZ4I1QCslmsPPXECT/npk1/OPVV5oOpCvOZtW1WqIulWrHgseiIXp61UeeDGRk
    ZsEETYujtjkve5bzxfEl7AkPzqnkjzHSQgo4c1H/TzHG01m9LJlJypNMbU2OnstT
    MQeHbJnNmDUHwsxEGT1sV56Ixnr7GjUh2i98n8h9O/PbmWiGU3ZofQfD5cKOFHsS
    dJWh0d05AdPVJZm62GYYluv45O/9MAyw6Xsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155422; bh=zZY68KeG1vH3XHlMEAdKM57GONRHmH
    dGPvih1CR10I4=; b=BleubylI5taDyJz3YpS6EVRl4uPHHZyfYMxhaqPo6wacgt
    h1+6lSsynv3vclVztOEbej7BhcSpfxBfvPiDioyijEI3wFyJ9z+YZPO8YK5qpKqp
    /2SgerxW3wNgSXGb5ZVHUr6720NRX+8bSrvs1FrfovVdJRM7RpIi5XqUKXk2IAw8
    f8eIW9141D1Qi5qqF9wtnmcFi9g2uLCu37ZOZwWBpvlTx97rmzCxsx+KlWIs0UX4
    IunNnWFZnyA/5pFAv5LUvSvBmvo1dyvU2z5t0iqcWkTqsKtSS0d08U3+P5OdN1nH
    5NI6KEKs0qdIlwdM6EE8lKKGxOnJyxJ8q/AuTRuA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=X/jG3D+v x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=X/jG3D+v x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfLM+l6w1pP34KcSfnqj6mUa//YEAeCikxiF2j8TZxrLn/cs6pDuRX55Yfw4AkmRcNb+vySDGcw+bPQfljgpBJvvFLEZeJxbsRJXKiBXUBGCUImImf4Q5
    DbnPTxs2yrq0tgbMBxNYQ7Oug82xULR8Amp40trMX2RiKQHPK/6kFoM5YqYCw15z1KBqWD0Ih+pgTrGDus2C4lh9Ktny2nqLjJBunRo6MoEykIkd5103O0m7
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=hD80L64hAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=-RuleGSg_AdYtJgukIIA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967556AbeEXJuT (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:50:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:41130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967553AbeEXJuQ (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:50:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 78/96] clk: samsung: exynos5433: Fix PLL rates
Date: Thu, 24 May 2018 11:39:01 +0200
Message-Id: <20180524093609.860368100@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
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
@@ -751,12 +751,12 @@ static const struct samsung_pll_rate_tab
 /* AUD_PLL */
 static const struct samsung_pll_rate_table exynos5443_aud_pll_rates[] __initconst = {
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
