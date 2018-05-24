Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527161711-2-9104902822889961647
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
    1527161710; b=Aiuxsm+FoBHktZusw3QIehlq/TejOxPu2opY3V3nJEyT7yKWCK
    djvinblAU8wot2PbBM3MDkarMt74+lPdOCZCPyGjTO4PzMKbOqLyN1g7U4WusjoE
    nYIsIc9Vdq47ONFedV2zDLnW4RNxGWbjMkySzU/1PO/iaS/jGVn8dfF9w+kIP71Z
    a3rr9FcAlVqwA7AJcuYN7u4Uk747RGtnxXCdInyq6S86Xsm8ZC6X74ZC5h6F0V0y
    JNIy8E0WsYKG1K9Hxg5fXXKn3n01BbXyAdAaNY262aBTTchgbzp8cDe60qkne3Qt
    O/OuzTo/C2hP7FjHK2zqVgPk0CoOx5E9NcGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161710; bh=bAKxX6JcAMXercbyJ5OKPBLNPsQAkc
    461/BaiAmsRFA=; b=A+f8gxxqzZuVk0DiCnXF54UTqTxol8v01E8diKM9SsgaQH
    LOpdUXgHD6qzMaFXSBLmmqopRoRs19buGKRv3E/CVJ3r/wIAF94Ztfhco1mwHU+O
    ri3o3S1xClG3A0aaHOp/4Te5TZ14r25kjtAR9s3kT41IIJ6TnaXuhMHtj9jM8Ukr
    LrHmebLK+5NnH+jNWE9l0dzkFabmowKIqwSVuWNM75VS1UTGv7Q/G5IXP4G6Uz1G
    Ao9R3g7JH/MrPjKxTgdZdG78QW3pRVqNtLxJEVRy4bmECqHPgp5dw43rimAFEuMz
    Pst9VbL7HZ+l7g6SVOjaJA5mty5SGCEru76d4w9w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Q1AC9agg x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=Q1AC9agg x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfOi8aRXN/v7T70pFxqfA1Gen7dQzwDegvqfna6E9JhPQe3jZqnF2FqWrmW2l84g+LeG1oJKuw5N9F32+hQQP1+35Djfuj25EnYTdm6+Wp6bvlii2AryR
    XvQxt6c+IuD3zhq56bifStRGnKfDYpe0cp/Z+OclGYDCNaoRoyRuHTXWoxK9+lEacZ8ud1LJStwYcZkI2X5iujC8R+HFjrc23X08WirCsFqyhcdtcB6l/JFQ
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=hD80L64hAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=-RuleGSg_AdYtJgukIIA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967531AbeEXJuL (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:50:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967520AbeEXJuI (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:50:08 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 75/96] clk: samsung: s3c2410: Fix PLL rates
Date: Thu, 24 May 2018 11:38:58 +0200
Message-Id: <20180524093609.719047285@linuxfoundation.org>
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

[ Upstream commit 179db533c08431f509a3823077549773d519358b ]

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
 drivers/clk/samsung/clk-s3c2410.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/clk/samsung/clk-s3c2410.c
+++ b/drivers/clk/samsung/clk-s3c2410.c
@@ -168,7 +168,7 @@ static struct samsung_pll_rate_table pll
 	PLL_35XX_RATE(226000000, 105, 1, 1),
 	PLL_35XX_RATE(210000000, 132, 2, 1),
 	/* 2410 common */
-	PLL_35XX_RATE(203000000, 161, 3, 1),
+	PLL_35XX_RATE(202800000, 161, 3, 1),
 	PLL_35XX_RATE(192000000, 88, 1, 1),
 	PLL_35XX_RATE(186000000, 85, 1, 1),
 	PLL_35XX_RATE(180000000, 82, 1, 1),
@@ -178,18 +178,18 @@ static struct samsung_pll_rate_table pll
 	PLL_35XX_RATE(147000000, 90, 2, 1),
 	PLL_35XX_RATE(135000000, 82, 2, 1),
 	PLL_35XX_RATE(124000000, 116, 1, 2),
-	PLL_35XX_RATE(118000000, 150, 2, 2),
+	PLL_35XX_RATE(118500000, 150, 2, 2),
 	PLL_35XX_RATE(113000000, 105, 1, 2),
-	PLL_35XX_RATE(101000000, 127, 2, 2),
+	PLL_35XX_RATE(101250000, 127, 2, 2),
 	PLL_35XX_RATE(90000000, 112, 2, 2),
-	PLL_35XX_RATE(85000000, 105, 2, 2),
+	PLL_35XX_RATE(84750000, 105, 2, 2),
 	PLL_35XX_RATE(79000000, 71, 1, 2),
-	PLL_35XX_RATE(68000000, 82, 2, 2),
-	PLL_35XX_RATE(56000000, 142, 2, 3),
+	PLL_35XX_RATE(67500000, 82, 2, 2),
+	PLL_35XX_RATE(56250000, 142, 2, 3),
 	PLL_35XX_RATE(48000000, 120, 2, 3),
-	PLL_35XX_RATE(51000000, 161, 3, 3),
+	PLL_35XX_RATE(50700000, 161, 3, 3),
 	PLL_35XX_RATE(45000000, 82, 1, 3),
-	PLL_35XX_RATE(34000000, 82, 2, 3),
+	PLL_35XX_RATE(33750000, 82, 2, 3),
 	{ /* sentinel */ },
 };
 
