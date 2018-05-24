Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527161756-2-1977602904106293843
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
    1527161755; b=SKQFqoau1BhsDTv6R0Un97JnIh7J60FnoyixcMn74kAhuP+LIZ
    lWfWqEcpfdOfKJuXUkAwkaT5Dz/T28M7uc4E0tc+9aLQeoznpFxlJAZ7LrSzN9u7
    TcSyvx8GrT8LPavwkrXPVGKmKHWy6BDhwqJ9nATX2pmye/FluzdqShrWjes6cKMh
    TywcWddX5Jewx3Uf47kdIAJRrB3z2Tl5du0aXxhxsl/S77Xc4jJY34pbnkW6FMch
    Pk3QZbJ9giLOgvtk5WBgLJ2IrF7Kd8sAz512JiVl5R212lPrqN8KFtk6zZj5rFyc
    JN1UtuJRf43VgvCrJ29J6/a0CJ0NEI56OWOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161755; bh=1sGIykLM9AzyP/9HBtSlkZ7xtNgQ3Q
    caNKhOBRs/pC4=; b=LL3aEQD6Txb8Mo/xLcpcnuVgUGkkkWdYX9XLrtUeps7sWq
    ftMrJREyumaH0ofsYd3wR9dhKuo7SFdbkkifJnNBlOAuIbNJzsRjgoTQZgjDGyW/
    C5RbjccyKmUAsKSRNEdD38yS00/uz1U3N7+2DYkJSn7YtXJh6wk526Y32p99VS+C
    Fa43qU2rkxiq/TuQNXMDFKgzSHC8kuQGe1bsxhoj6aXhqVqHRt4vKZg0OLNhdkaG
    td7q1Rng5os53h020hv9iXMvkgoGfqeuU6QIRLFcUka5B7c/ZOhWLLDu9bhF7wrO
    9onG/ML7Z2NmH0ZAHIJQxJQtHI1/WRBT85pB0LPA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Rx4KQdxF x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=Rx4KQdxF x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfLVvCP4cLMxNEQHaOuPZ9za5aZc5mDrTuLloU8/OdaBnSAJ77djjrfZu2LXVe4YZw5d+YScwZE5vdDQ7tKWKoe+sQ7hFEv7Ye+6oyX/d85Qt/W61Og7y
    NQnBBsk0rcuU9AfKNSxCdDYUV2ItU7rTcZzNTsmgX6Mx600vhZB+VIMOs7HWcFGGuNcLeVN4tDR2A+lEIuVG/Rxg2b03ME4lQfVBQEBxBMyk4fzkUWt+9aQt
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=hD80L64hAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=WinGGc6PCWDRWg6FmoYA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967513AbeEXJuA (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:50:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:39506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967462AbeEXJtx (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:49:53 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 69/96] ASoC: samsung: i2s: Ensure the RCLK rate is properly determined
Date: Thu, 24 May 2018 11:38:52 +0200
Message-Id: <20180524093609.372400913@linuxfoundation.org>
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

From: Sylwester Nawrocki <s.nawrocki@samsung.com>

[ Upstream commit 647d04f8e07afc7c3b7a42b3ee01a8b28db29631 ]

If the RCLK mux clock configuration is specified in DT and no set_sysclk()
callback is used in the sound card driver the sclk_srcrate field will remain
set to 0, leading to an incorrect PSR divider setting.
To fix this the frequency value is retrieved from the CLK_I2S_RCLK_SRC clock,
so the actual RCLK mux selection is taken into account.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/samsung/i2s.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -642,8 +642,12 @@ static int i2s_set_fmt(struct snd_soc_da
 		tmp |= mod_slave;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFS:
-		/* Set default source clock in Master mode */
-		if (i2s->rclk_srcrate == 0)
+		/*
+		 * Set default source clock in Master mode, only when the
+		 * CLK_I2S_RCLK_SRC clock is not exposed so we ensure any
+		 * clock configuration assigned in DT is not overwritten.
+		 */
+		if (i2s->rclk_srcrate == 0 && i2s->clk_data.clks == NULL)
 			i2s_set_sysclk(dai, SAMSUNG_I2S_RCLKSRC_0,
 							0, SND_SOC_CLOCK_IN);
 		break;
@@ -858,6 +862,11 @@ static int config_setup(struct i2s_dai *
 		return 0;
 
 	if (!(i2s->quirks & QUIRK_NO_MUXPSR)) {
+		struct clk *rclksrc = i2s->clk_table[CLK_I2S_RCLK_SRC];
+
+		if (i2s->rclk_srcrate == 0 && rclksrc && !IS_ERR(rclksrc))
+			i2s->rclk_srcrate = clk_get_rate(rclksrc);
+
 		psr = i2s->rclk_srcrate / i2s->frmclk / rfs;
 		writel(((psr - 1) << 8) | PSR_PSREN, i2s->addr + I2SPSR);
 		dev_dbg(&i2s->pdev->dev,
