Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527159163-2-5109020127083754633
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
    1527159162; b=QlqzSV/HpJCRQvqoM/d9uo208UtsUb0g9KyMdLyXsCYqzRVXzy
    9cPpveW9yBEAOTuFDZ/1PWwp420BB6Nw/ou4O2WuJ04KhtcJRiY17+R5psgt8G5/
    bkZRZrYcfUy68yY0tQIJat/FkRh4FCUrwjZIk4f9kq4WihKhSVDnfkgMls6lMke2
    MzC2SM0ArpxzpHRi+kb0bud3hRnGNwyUiB7P+QPvTKuf7lHGD1eGXR9pcDeRtGnR
    ysMVvOQKKRW01Q3vTpvV9cgSykQzk3QtGRwm0Xx4gCx3TJ80NMn/pBqJD40lHjLy
    WZgKLgsFC8Zr8wG8q6tj3YBgwQL4CC1hvw3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159162; bh=xh8y+xae2i0t4jcI3p4b0vOhuY46uO
    cKNtCX4FFI3SU=; b=QFxjd+YLK98yQgw4e++ErwmUUMpKzUQrbmbJlo2lG+NfF9
    KAQCUyIGT1vbEs1s2DCDiZqln31vO01t4zPzxjr/h3/4BMYeqkJyxFrW9pHC+7Ic
    nGSJ3q3v4yh8vBsTYLR5xQsxFs17yRB9EdeJMA3gIX7vNvtbJiEz/gvGhEr/Ws84
    eUrKB0KsBnX4+OJRljOqLqxWiX/OP+fGGZX30ZZBNmCNEme1VE7kVLRFtcLfSq/5
    OHPU165N6bjg26v/KkGeHbKuiu8Saxv6VlObrfNru59bSa7XJFFnQTCRjdGXx/aC
    Ov9BeR12lHtXEv+vSQXs0+jk53Z5IvTfVLcPdOOw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=12XVDRMz x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=12XVDRMz x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfJrkRnktrDXigoQJOMhKsuX4axKm7bB7zUwWndebEjh1rXefwstMxoCb5SMfcbAosWip6+Wn5d5Tm7K8iISjpsPi+yHh8uzAfuDGjXgivchoJ2KwpZeR
    AW2V33uaAf+cKFTfV/uu3RPl4WvoQXRWLCjLl3AZqg+1Sy0qPN6hUyacJas6BfJ/bXyPRCF3lyFlFLPyiDnFmJyX4s0HLLQYHCi5gR4ALbgysI/81tJpkMIF
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=hD80L64hAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=-RuleGSg_AdYtJgukIIA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032577AbeEXKwk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:52:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:37178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030435AbeEXJ5S (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:57:18 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 135/165] clk: samsung: exynos5250: Fix PLL rates
Date: Thu, 24 May 2018 11:39:01 +0200
Message-Id: <20180524093627.533138140@linuxfoundation.org>
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

[ Upstream commit 2ac051eeabaa411ef89ae7cd5bb8e60cb41ad780 ]

Rates declared in PLL rate tables should match exactly rates calculated
from PLL coefficients. If that is not the case, rate of the PLL's child clock
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
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/samsung/clk-exynos5250.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -711,13 +711,13 @@ static const struct samsung_pll_rate_tab
 	/* sorted in descending order */
 	/* PLL_36XX_RATE(rate, m, p, s, k) */
 	PLL_36XX_RATE(192000000, 64, 2, 2, 0),
-	PLL_36XX_RATE(180633600, 90, 3, 2, 20762),
+	PLL_36XX_RATE(180633605, 90, 3, 2, 20762),
 	PLL_36XX_RATE(180000000, 90, 3, 2, 0),
 	PLL_36XX_RATE(73728000, 98, 2, 4, 19923),
-	PLL_36XX_RATE(67737600, 90, 2, 4, 20762),
+	PLL_36XX_RATE(67737602, 90, 2, 4, 20762),
 	PLL_36XX_RATE(49152000, 98, 3, 4, 19923),
-	PLL_36XX_RATE(45158400, 90, 3, 4, 20762),
-	PLL_36XX_RATE(32768000, 131, 3, 5, 4719),
+	PLL_36XX_RATE(45158401, 90, 3, 4, 20762),
+	PLL_36XX_RATE(32768001, 131, 3, 5, 4719),
 	{ },
 };
 
