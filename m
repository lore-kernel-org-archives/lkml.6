Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527161708-2-9924657946354057773
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
    1527161706; b=iYkIe+/Ty8VCAaDNIMz2PaMMc1RNJHNbJt2F7BN8KgYEL47dS9
    nvblMgHAzNCC/weyw4esnWgdK5bH2+GexIFO4wngs02wH0EC2LPuaowMzvwlDKaJ
    MEc73Wf3DaCBIz2PjZSSn2ndwioDvuRymEh2dCN0ytIVtzjzZxy6FqvaPz3GPlA4
    ZH1p3kKvKqMpGLKgH2M7hD9QHaSkCKvGdBWCX31l/28I4dyIxc4Z5TpbNFqBm5Ub
    bDiTKTSu4QH5Erjd7hTAeT23hMfLBlqlbOzT+dV2uzhC7TgsZbW3rw/ky2Noccae
    8Tiu7RZUgy2I7v/Yqa+ftd0UZb+bR+QoQNeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161706; bh=t0wpvtMRIE/dX6xlA8Zd0t7JDMFUlY
    4KrGhqACa24PM=; b=nxEX0CvTyu4VIIsgUfByfAX8m5oPPjyKyu9zUwEqEkx1xm
    7yz1b0ZKto6hD3iGhXyjATP5y28XPZxeMgpb1X4BZEEieORUV9lt09vb2fyy3GMQ
    dx3VrI1pIbwg/8RjPrDNugo1WBijYGup6rITd+epXYm5aJ3FAfmDsLy22FOr1Q60
    7gANSjECBL4Okm7tzMEOtrnv52hoYgGt7IcUZBT/+vVoVV0ogT1/UtNWiB6zxjgu
    kb1TvMZt4AO4xSov4MWIVMeF7jIUCroYEU/iZ3jfyk0hj5FOtFo53eQItEatFa4W
    G3KQBzCBkVgqB71BEnPg3OEpiRSzr3dN3P9dVPtw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=T4k5XqUb x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=T4k5XqUb x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfF1fvHpT0va8Mu777mKPocAwi4OGO3S2PTKEbRx+Mj9sVCpIY84bxWEggEJNYO4187JjhmfRgkA61pMfDpAtIow2rm83m2GYcTGJhiQjJSF5ZK36tmaM
    PjcFrjGsI8Qf5BN4mmhnFSvz/pPlZ7+SCVLvJqqHPr3D7aQslYS/yDgwHTA65p7AFdxWVvSq9YXHJBAQYkjy2ru/d9TctKHT3SX/PnXx/NiYM/Iiag/MPrW6
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=hD80L64hAAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=38Mx9yBTMS289Mm5uicA:9 a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967542AbeEXJuP (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:50:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967432AbeEXJuN (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:50:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrzej Hajda <a.hajda@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 77/96] clk: samsung: exynos5260: Fix PLL rates
Date: Thu, 24 May 2018 11:39:00 +0200
Message-Id: <20180524093609.812313765@linuxfoundation.org>
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

[ Upstream commit cdb68fbd4e7962be742c4f29475220c5bf28d8a5 ]

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
 drivers/clk/samsung/clk-exynos5260.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/samsung/clk-exynos5260.c
+++ b/drivers/clk/samsung/clk-exynos5260.c
@@ -65,7 +65,7 @@ static const struct samsung_pll_rate_tab
 	PLL_36XX_RATE(480000000, 160, 2, 2, 0),
 	PLL_36XX_RATE(432000000, 144, 2, 2, 0),
 	PLL_36XX_RATE(400000000, 200, 3, 2, 0),
-	PLL_36XX_RATE(394073130, 459, 7, 2, 49282),
+	PLL_36XX_RATE(394073128, 459, 7, 2, 49282),
 	PLL_36XX_RATE(333000000, 111, 2, 2, 0),
 	PLL_36XX_RATE(300000000, 100, 2, 2, 0),
 	PLL_36XX_RATE(266000000, 266, 3, 3, 0),
