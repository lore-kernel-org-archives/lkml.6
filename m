Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1732752-1527155820-2-709200269975177313
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
    1527155820; b=GP3k8vmoIFycSv5QEL3/seKgdlmnMkazp+Hm/6rMxQISZDcxrM
    InoN29x2rR3AbLjb4eJgZA0ozcYKjlpaeZAtyoxmitUDgqvj2UZT9/TTU3mWFnaJ
    e4NENhIyK12/Llrk38hLY7udt5alcT4k4pE1aLkrqm7qYbH79Qu+cVbNHe9TG+hw
    dTzUM7rs3zLDnOMT4SxRtpxvxiX8uhesqJNuDmp7ygl81zm76N1FIobipC58T5Wn
    PqbI8sHjemyyPckxb9jTD8wPvv2slJVYANnD5+ARq9oUkgbNQUiPmPPhAEPCEDW+
    6Aj/Cyy93BD2P/igbKaq3b2NZlL6EBgA6E8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527155820; bh=xNVF29RCbK+1mgGhrFg0iPv+4TGnKH
    SrJCwqORrOq5k=; b=GEdp44VFvzauZj3kK96R37O2LmR7sSNAh8gL8XoM8RA9Fi
    MPhqJSlshchsJEAfOJxk4a/+DCnk+kDrlzu5EfV8Jd9t/+tkXRkjNCRDy2k4EU5m
    Y6TIpQrVzFBJFPs6Yiqp8C7gpqACV12fbRO54xDpufBf0+yoWewRAHQeViJEZQa/
    fSG2DK7O0FRjid2GJS2Zb/iGx/BfxqeTLlG6OD3sNoTAycHfstzC44avd5eD0r9g
    XQn+Vbqh1AERUplDHQ24iuUL5ewaDrpdVJiBqg4q1zTXe7q+j0FxGR3JZNPJtpD2
    1nhO2Jxj7w87wLNKz0zuZZz3DIfCZeqcGN/+N/xw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=prewTz6H x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=prewTz6H x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfA5WcsGTlGWIRtD/XpkyCf6nu9L/xCSkEbIhPEbQUsC5s+EiA6Ln1GJWba3SSa4N3X/0YZugO8xSvc+N189/zOaRLLoqFrks48qt37lv9HpACud0C1ga
    guLe+OxjcuC5FDSPoOhoLB1hGOxKV9tPOAd9WmGNIov7BjmzfApDHOnHTPtrAO7yZQxn8FNlpF5dFF8K8v9272K7/6hepxyISyMYCqGlfhz6/UNxJ7OEEES3
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=s8YR1HE3AAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=0ZnexwqNl6dV5F-YGXAA:9
    a=QEXdDO2ut3YA:10 a=jGH_LyMDp9YhSvY-UuyI:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030350AbeEXJ4y (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:56:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968452AbeEXJ4v (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:56:51 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 126/165] clk: rockchip: Fix wrong parent for SDMMC phase clock for rk3228
Date: Thu, 24 May 2018 11:38:52 +0200
Message-Id: <20180524093627.101503760@linuxfoundation.org>
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

From: Shawn Lin <shawn.lin@rock-chips.com>

[ Upstream commit 4b0556a441dd37e598887215bc89b49a6ef525b3 ]

commit c420c1e4db22 ("clk: rockchip: Prevent calculating mmc phase
if clock rate is zero") catches one gremlin again for clk-rk3228.c
that the parent of SDMMC phase clock should be sclk_sdmmc0, but not
sclk_sdmmc. However, the naming of the sdmmc clocks varies in the
manual with the card clock having the 0 while the hclk is named
without appended 0. So standardize one one format to prevent
confusion, as there also is only one (non-sdio) mmc controller on
the soc.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/rockchip/clk-rk3228.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/rockchip/clk-rk3228.c
+++ b/drivers/clk/rockchip/clk-rk3228.c
@@ -387,7 +387,7 @@ static struct rockchip_clk_branch rk3228
 			RK2928_CLKSEL_CON(23), 5, 2, MFLAGS, 0, 6, DFLAGS,
 			RK2928_CLKGATE_CON(2), 15, GFLAGS),
 
-	COMPOSITE(SCLK_SDMMC, "sclk_sdmmc0", mux_mmc_src_p, 0,
+	COMPOSITE(SCLK_SDMMC, "sclk_sdmmc", mux_mmc_src_p, 0,
 			RK2928_CLKSEL_CON(11), 8, 2, MFLAGS, 0, 8, DFLAGS,
 			RK2928_CLKGATE_CON(2), 11, GFLAGS),
 
