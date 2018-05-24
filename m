Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1797295-1527159216-2-15228971475123067454
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
    1527159215; b=S/SeGPfbWxnV6UpMeBSO+uZZKvTUhmMjcwz1nBl5l/xTJrXxsY
    qqPavODieNy3verIPOWTlu8zhztO31LKKRE4fV0p9Xz6WppiyWJVi7zaNsh1lDhK
    x1Vlndl7vIwSbdj0HRi295O4epS8mGHc/Z8BoB2UgvkBl6jnf9k4GWNz4LOurlCo
    P2Qc1UjvvX/aWzyIp+JZc35Zfz5nsdssMjlUpM3i6dDK5nA/YspmkJvtBhGeDkGm
    plxbaWp6zfYxH6xDLiaKs9Xq8TTcgk7DcO1PtLKSlwlotVZRHf0c6L7qEz+VO73e
    +UjaDkofcxhpqJTrbZXhox2WTpdUjwBSrNPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159215; bh=qeDW8EWkSQDVK7Cyh4/J9At2sWJ4Y0
    O0gF1gPOin2IY=; b=XCM1ppYApME8/Ie9oHVSkugqh0L7EhFfJ8uWxqIcAM0RIr
    kPJROPPVRWhzuQUX+r+k/F3OSasLHoajcoYfM4D0twS/ybUItSeixiQxLTJYM325
    dhtfoN9Q8jG126SCR/193t0yzUh0sugJFAisVhcj3PWjmGwd3Kz8X8BiIacumLuI
    h8vnCr7vLka4D8k4enAhIGvaqbc0S2xcZEAL/yM43LHiI8AdhKvRGJJJKOW5FuUr
    QUofdm3c6bmWS1gGpbMUc+6ClsmzLTxp0XInrNVPPXB9ZLdjBZSoCdqbdNm1xoDS
    di0BzRO4JCtwLz8ouU9/IF8oCVOxm0WWZEBTbtgg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=eSLEOGdP x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=eSLEOGdP x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfLsTF07eEDeniPZxFzLYwsTBMUtPJnf85sCFHcYEBScta6ih+pCkgbiOpg41ZxdjiZAaUKHEcSLNX8FUUKtF1X0BESGe8U+LRnO4QoOb7G4JR19zoaE1
    RMS2XUN4SVJrJeYSsrjPz5+RgVeHiFV+Cv9mnKg+TtApgXWE4CmIR6NENC9BUq0K0aUfYSTf2ld3k+Dkf7zMAJY4cybJxJazaJq+xgnLJD4AnFn4a7iXVfFg
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=hD80L64hAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=38Mx9yBTMS289Mm5uicA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032233AbeEXKxd (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:53:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:36970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030402AbeEXJ5I (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:57:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 132/165] clk: samsung: exynos7: Fix PLL rates
Date: Thu, 24 May 2018 11:38:58 +0200
Message-Id: <20180524093627.340243027@linuxfoundation.org>
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

[ Upstream commit 7e4db0c2836e892766565965207eee051c8037b9 ]

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
 drivers/clk/samsung/clk-exynos7.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/samsung/clk-exynos7.c
+++ b/drivers/clk/samsung/clk-exynos7.c
@@ -140,7 +140,7 @@ static const struct samsung_div_clock to
 };
 
 static const struct samsung_pll_rate_table pll1460x_24mhz_tbl[] __initconst = {
-	PLL_36XX_RATE(491520000, 20, 1, 0, 31457),
+	PLL_36XX_RATE(491519897, 20, 1, 0, 31457),
 	{},
 };
 
