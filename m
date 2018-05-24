Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1835623-1527161718-2-14744007557121679302
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
    1527161717; b=IAkafrr7vJUb2D40+C2G0AjVyZCGm/a1NgHaGwx8SxD2ESAsDH
    W27koiKcMVUpYBoYFzmA8R93ymuvJgGvakF3Qvr8BjNlJivjFb356Alv4eepUZRO
    1SWhFya3LHyKEbPs88umMJKUVecMPYvKYp0F7ib7ucsQ+Bj5UVdIXMr5HEl4kOPM
    rCccG9t2kcChqcgru+9tj6nb8N6ZFNOEv1dnJVYJR3CZ09NCU+XgKs+OO71EwUU2
    l9IPLvx/FjDSKjUMpsijkxjrADvbEk3f4RnDWo7bDsOcYHF7Y3k//AWORKnNXcFE
    AxO2i3T3ADWxrjdm+07BCFsVPz3bCOFZj3aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161717; bh=e4n+Ufo+qimGYc+IDOBc8l4OfJzo2U
    WbEn8i+GzoIig=; b=jfV/HfPpu6eUGKvDjIAwPqppHRrd+7LxTqaRrQ64g/14Pp
    LpGZTTjKGsUXi8qr3kBqkXJp5LsON4wdUDVz5zNZiwlskMbOpmf9MB76gvHFyGqa
    bfV8Z4XUd7D0KcxxSGaeGBvQq5kMor/MmOIp9Hp3ZRxvqDCGPrSXwHdasDSAE9Vc
    LaUHOd3O9oCWJoGL3Mr4Hffn/DNcFBetI3+eWz1PudNYyBYL9u+BvHM7pzWBHCer
    wbr6abwdFTzajFE3MN23Sk0XAL3bVRaiwjKlla1KmNORtF1Ot10wrR32kUmuyTM0
    93ZHech9WIwCIf/Sk9hg83xCBhSNHwejqU1wGCLg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=r5Ql1zS3 x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=r5Ql1zS3 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfORrSQVIwfeQmHtmhRm9b7sAlUDCrzN3ZoPxX++jSFUj8mnEPb1aVheMHc1UK5IZCcQiKtmxwYJNYvhC/vJ+irfP/Sg54eiO8tkm8psZLxZoYcZt4hp/
    jSHqrmN7abhsCHZITvUJ5kxFr+g7rSKYPxQ9l8Ulh/lYhx5b0KFMMwcKHMig9ijTb8+o19tTyXMmX7PbKoQkzMMsz9X5fBJkC3GlOOSBA47uc7+9qecr6rnQ
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=hD80L64hAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=38Mx9yBTMS289Mm5uicA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969071AbeEXLfN (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:35:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967525AbeEXJuK (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:50:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 76/96] clk: samsung: exynos7: Fix PLL rates
Date: Thu, 24 May 2018 11:38:59 +0200
Message-Id: <20180524093609.758870746@linuxfoundation.org>
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
 
