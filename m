Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1061450-1521802837-4-1562710561700055257
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
    t=1521802836; b=MElrbO1YL2FvoqAaMgXYNSWAH8Ayb/17jB8cEyvD2eRj2oc
    TYnPJosRvWoj027ZBum+H95l9LXzyl2/7RkzIUlz9BuP5Of8Ht0eXlPukc73xCyY
    tWXpFD53Q0kdHZRQDwGwY40mTc6DpwTIv6a4pRDb0Nq5BF2Qfm09Rud1PHyTQ1a1
    KOPHPQOSfzGD+xSpDLDEmWsaa2SS2h4OQbCrurQBBUdpvOA4mp2vrhlWAk25Hwa+
    wtIPTQUHWUxIzIWXIQEMfqG0TUfIakWUoMppaqWso3XSYqk5dpxaqf/KejueUBx6
    8X6A7f4gGwlGRvceXW4Dd0tfm4zmO+L08gVtPUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521802836; bh=+/S8TSDQOrT5UgEkCItN+CyGu+
    I2eEqFKqvLe2k2xlc=; b=rUZpFRxHXiLAxSJJmyA2SaB001pH7LY6eisxx7YnEG
    E/3/5z0ljMk4Owb1+u/L/AnRfkH/h7HzE5ipQ4rD/8v2Ws/eXtjc/qtwiUAgMtpM
    sMAdJuOuYJh+k0JtoMJoAs1sWwyqvsBVmw5s8IjAzrbekk3stgWQ2ZmofLGBbVKd
    hXveA95nqjeWGI85iWQVJl2sDIWPA8yQnfavbucvCMTeSD1xbVPMJ33LyBAjcg1k
    TNwLwz1cK22Kffg/IyBvgbZrBmOwFsdeVz01+2O39byq6km/RDzn8RRGlBsZu5BG
    NnRxEfi4CtUw2xU0v/VfLe+fmBzVjnMWV2LRkYY45VyA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
        id S1755612AbeCWK7m (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:59:42 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44356 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933202AbeCWKM3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:12:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 169/177] clk: axi-clkgen: Correctly handle nocount bit in recalc_rate()
Date: Fri, 23 Mar 2018 10:54:57 +0100
Message-Id: <20180323094212.610645709@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
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

From: Lars-Peter Clausen <lars@metafoo.de>


[ Upstream commit 063578dc5f407f67d149133818efabe457daafda ]

If the nocount bit is set the divider is bypassed and the settings for the
divider count should be ignored and a divider value of 1 should be assumed.
Handle this correctly in the driver recalc_rate() callback.

While the driver sets up the part so that the read back dividers values
yield the correct result the power-on reset settings of the part might not
reflect this and hence calling e.g. clk_get_rate() without prior calls to
clk_set_rate() will yield the wrong result.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/clk-axi-clkgen.c |   29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -40,6 +40,10 @@
 #define MMCM_REG_FILTER1	0x4e
 #define MMCM_REG_FILTER2	0x4f
 
+#define MMCM_CLKOUT_NOCOUNT	BIT(6)
+
+#define MMCM_CLK_DIV_NOCOUNT	BIT(12)
+
 struct axi_clkgen {
 	void __iomem *base;
 	struct clk_hw clk_hw;
@@ -315,12 +319,27 @@ static unsigned long axi_clkgen_recalc_r
 	unsigned int reg;
 	unsigned long long tmp;
 
-	axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLKOUT0_1, &reg);
-	dout = (reg & 0x3f) + ((reg >> 6) & 0x3f);
+	axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLKOUT0_2, &reg);
+	if (reg & MMCM_CLKOUT_NOCOUNT) {
+		dout = 1;
+	} else {
+		axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLKOUT0_1, &reg);
+		dout = (reg & 0x3f) + ((reg >> 6) & 0x3f);
+	}
+
 	axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLK_DIV, &reg);
-	d = (reg & 0x3f) + ((reg >> 6) & 0x3f);
-	axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLK_FB1, &reg);
-	m = (reg & 0x3f) + ((reg >> 6) & 0x3f);
+	if (reg & MMCM_CLK_DIV_NOCOUNT)
+		d = 1;
+	else
+		d = (reg & 0x3f) + ((reg >> 6) & 0x3f);
+
+	axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLK_FB2, &reg);
+	if (reg & MMCM_CLKOUT_NOCOUNT) {
+		m = 1;
+	} else {
+		axi_clkgen_mmcm_read(axi_clkgen, MMCM_REG_CLK_FB1, &reg);
+		m = (reg & 0x3f) + ((reg >> 6) & 0x3f);
+	}
 
 	if (d == 0 || dout == 0)
 		return 0;
