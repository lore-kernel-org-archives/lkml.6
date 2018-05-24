Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527156427-2-6085164278440880963
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
    1527156426; b=ZHQE1cy7Vk4O0LRaxIVPrLpYgK8f91BZaBJr4BT2gxi5wIPeTF
    /7eEKwvSaIoTOm7tM3AWfm4Z+MW16NcH97h+gNrJrZtjuC561um1TAzRPfxqgtKn
    70jMXIPdbh9kaKbGdWCSABzInDhI8SgOcafb4ik1/Rte73RitdfZGgsKuoNpVVgB
    S61OAppiXjnbZkZDbPY2tN0tcaj3Gd+Eqa8LCUCcNFVeAh5R+0OG7bMBSDlbK20R
    lHv8c1/3rjvmsRA1tNPnYDsH1oiu1KANH6+vlt9hnK/ujczlF/91+anQ5myIXahR
    l8TH1VWmnRNZN4ADyp0pkQvILw11rnocTeOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156426; bh=TdrnXz92aM6E5pJ6P94hk+8IfH4Hj0
    2W5PP1Oyncm6s=; b=GZS2WcokJr86ZRbvrS+mjwFQuKwVQCzhID3AYGi6MsXTBB
    q+oZxMU8k1H9m6OpdgTQ2mAaCCVhUbHO2ZjbKam59Ketq8rsKIkSuKNNcz8V9xAg
    hwlrXP82hv8v+/hvCFc+s8bUjhAjTeZy2/BLkD5BueH643VnRVeb2LZZHjvmEe4a
    ZuRo9Dx/DTVbshYe77zZceLhTl2puaJ8WwB0g7+otM8M8LdmqySkMvlO3pCugkoA
    8GXJHTp08unbKctE4M3E6NCjemHw4U5+XxHEI9nhIfJXaqLvQdWb5Vyl6JbkkDPV
    tpEfUF41XF8y58quH85Lg8cYQlW7MQWdkSfJzpiQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Mspgdgh7 x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=Mspgdgh7 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfGPs42BxjB+uwoxKlwm/xAYAlRY75heOMy9xcWxf5W2b1hHP86YZfLGxqCtVGTaZ3cIMlJTmQXVHl6/nO+JuSZNmsVzKL6TC6915ZwtMr/W27dZ7nxDw
    GSrXxpY/2BgIALb2YbkAkqcoUodsV4HGBmVDOxgFYsiJsbH8pUSKqOx6WczwGxOObTXZ4yIOL/lDJuymZSUb+JXGDufh6pRMHXJ1t8kqdzCYZikVsUNJRQro
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=IpJZQVW2AAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=vLQbGN4KbvzYxg86oCQA:9
    a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031500AbeEXKGv (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:06:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:54170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031535AbeEXKEy (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:04:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 133/161] clk: meson: axg: add the fractional part of the fixed_pll
Date: Thu, 24 May 2018 11:39:18 +0200
Message-Id: <20180524093034.278560986@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 6b71aceceb09918daf37a40a1221077599040be3 ]

The fixed_pll also has a fractional part. On axg s400 board, without
this parameter, the calculated rate is off by ~8Mhz (0,4%). The fixed_pll
being the root of the peripheral clock tree, this error is propagated to
the rest of the clocks

Adding the definition of the parameter fixes the problem

Fixes: 78b4af312f91 ("clk: meson-axg: add clock controller drivers")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/meson/axg.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -129,6 +129,11 @@ static struct meson_clk_pll axg_fixed_pl
 		.shift   = 16,
 		.width   = 2,
 	},
+	.frac = {
+		.reg_off = HHI_MPLL_CNTL2,
+		.shift   = 0,
+		.width   = 12,
+	},
 	.lock = &meson_clk_lock,
 	.hw.init = &(struct clk_init_data){
 		.name = "fixed_pll",
