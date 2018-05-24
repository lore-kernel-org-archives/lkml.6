Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161666-2-10510082003063097737
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
    1527161666; b=OJzV5er8YVGlBbwfmrcyeC72b66FCb+BiaFmZWrgl1pOVIH4wA
    D8zUIyO1jdIR5TU9YE1CDoIBiuDj0Bxv9LAJ+4xvMBmrA9lOp/e4ZY2dEcNDgpb1
    Fa/lWYHY63Snl+e0M+kiurt+31Oj7ITZSMnQlyAEXI8UFrFy9207twD6h7xwrhji
    nS3OLsw4R9xeRiKUCofDldNFoFj17MrrJy7SAevMvujm8/K7oLU9AJqmd7ZEnsag
    4evMtH5HZFP+40IJMqieZNoRUITsyHp1GvSsocywp1Gzzillmwg9HUjV88w73iO2
    yzAEXjOEhb5DOFfCfN2Xx1RACSnVQqEpEmkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161666; bh=n7xn6EnmBoeGSEfED0ADGibdJJwnAh
    L+NrH9k+E6vBU=; b=PUUcLKvVHCMRqgH3k08chHua0Im9kH/Wt51jDv48ky0aII
    EVQhz3Vlvwy8xRn/QtUkx3QNen/369SIe0ex5OSV2580aI2zxwhWrX/3OaIzr37w
    Fu126HTtFOYmNeNy0nPwuW3pwvmbH1vvnKDKkLYxxffE8L4RuqFybFnEB62QEJ0/
    PncUtpfyr0RpaFEzqqPb6GCbdWdAWQbPDxiTOVy9yukuy8ey0bGn+c9N06cAZNsC
    sUou8EwVyYMh6WNZYGHcArox/o6btPRiu6dznd5ay+OuW2IRaUJfNe+Dl76r4j38
    ZxJ/jmYFePH1Exc5dmMgYv8wqAvxJuKa98QUkUJQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=savv3yKt x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=savv3yKt x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfGe554d/Q304fSKcpM+YehLahMEOUQC2i62hKDRW4kSB0v4HPivNKnOnHkvuYd4psEJau02Zx289uXLKnVpbJAuLV2uL8QZqyz4nJehq86ghkgI7xyR+
    YwWLCTIsTFThuVBSGRe2I0FiYGs37FG00j5Kamr5OjgRT7nDJhhV7ftKUCq3unUzAoDXgIIs1n5xlH5LLfVHMhImFVhYe0KINUwPniSCjBQh18lU+znXQFYt
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=hD80L64hAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=-RuleGSg_AdYtJgukIIA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967574AbeEXLeK (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:34:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967063AbeEXJuY (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:50:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 80/96] clk: samsung: exynos3250: Fix PLL rates
Date: Thu, 24 May 2018 11:39:03 +0200
Message-Id: <20180524093609.970587322@linuxfoundation.org>
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

[ Upstream commit a8321e7887410a2b2e80ab89d1ef7b30562658ea ]

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

In this patch an erroneous P value for 74176002 output frequency is also
corrected.

Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/samsung/clk-exynos3250.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/clk/samsung/clk-exynos3250.c
+++ b/drivers/clk/samsung/clk-exynos3250.c
@@ -698,7 +698,7 @@ static const struct samsung_pll_rate_tab
 	PLL_36XX_RATE(144000000,  96, 2, 3,     0),
 	PLL_36XX_RATE( 96000000, 128, 2, 4,     0),
 	PLL_36XX_RATE( 84000000, 112, 2, 4,     0),
-	PLL_36XX_RATE( 80000004, 106, 2, 4, 43691),
+	PLL_36XX_RATE( 80000003, 106, 2, 4, 43691),
 	PLL_36XX_RATE( 73728000,  98, 2, 4, 19923),
 	PLL_36XX_RATE( 67737598, 270, 3, 5, 62285),
 	PLL_36XX_RATE( 65535999, 174, 2, 5, 49982),
@@ -734,7 +734,7 @@ static const struct samsung_pll_rate_tab
 	PLL_36XX_RATE(148352005,  98, 2, 3, 59070),
 	PLL_36XX_RATE(108000000, 144, 2, 4,     0),
 	PLL_36XX_RATE( 74250000,  99, 2, 4,     0),
-	PLL_36XX_RATE( 74176002,  98, 3, 4, 59070),
+	PLL_36XX_RATE( 74176002,  98, 2, 4, 59070),
 	PLL_36XX_RATE( 54054000, 216, 3, 5, 14156),
 	PLL_36XX_RATE( 54000000, 144, 2, 5,     0),
 	{ /* sentinel */ }
