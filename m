Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527161751-2-16053132122379004337
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
    1527161750; b=UXoD2cQYBHT0a8DLOaupE84aNj9VxGSDd2gS5ZhpscknXBnTBs
    4eYcNKFijb2v+3tyHHXObW37lD2GGxVmKX62Lac7f6neEzzchCz8vzUJf8WdT+Dm
    e1dhwGW1YTcv+qQ903lBCRGrAwkYOTga5UpWn1VythB5a4TGoz/hh0SN9W9dUDRS
    G9aIw9A64vIfzS9PbFhddgbIiDkfLhURGoa/yAt77WIZyw2KMca1SM+SZ86JvMu/
    V8F9EK4WaSDzlGnn43m08ZMgL4773p59ITfwKt/nbZ2nus4YLpNXdyrctDhuPNjJ
    EPLXTS/XVvcIuo/TqxqG5hSfYkwbXOt2b05Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527161750; bh=8s6Cn8z8oYwjyun+DK03PPxDb2ugbH
    uep6sV3XsZcK0=; b=VXIiB2xmZz4FrfblK3fVdstoCZTbHw4A4Jrdq+VDCedzQb
    tBcTc6WQ+nVareAU3Xko4hGMhPrAu1il8cYz0oHQOvCTT9bYvcicYllDr3l8uZgr
    xeZOzUElIOvvHdsKnEe8pvbg3kKimHDoR1zB4eizMjGsOOlI5L50tvs/HtZLBjq/
    KgIsAqvptiKuU6JIb3FJiuUwDkY7THVF14eQgWFSlzUkZH14fRYAakpF78hxA8bP
    hDYutyf01HxRB17x8WKkw5gxJdQtRYqRlcGxKFgNA+FhDmmrVOATOxcr3l19mhaD
    8d8fKCPT8IUeXbCvLOP2TfUD6SIcZzufZg2FCt1A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=FppUGY+q x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=FppUGY+q x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfE27/F/1GE1y7V99S5XTCENBkrPCrDDpUG2zj03h9P7yYLaxXcxR0ZYbTU61rSGp4SAIE0E8bcB9v97mLgy0hLNZQJCIV729jlAmbjzimvm7CoJkme91
    yG9asnWY2IvWQCN1TTUNeIAkIxd7k04LDvp/lxRO717+k8EcIGac8s+y+cepAjkMu1BqbTKwaiSWST49BFAG90SJWqyQVfHBx8ea2vWgI85G/9ffjpsmEGid
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=s8YR1HE3AAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=0ZnexwqNl6dV5F-YGXAA:9
    a=QEXdDO2ut3YA:10 a=jGH_LyMDp9YhSvY-UuyI:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967035AbeEXJuC (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:50:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967486AbeEXJty (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:49:54 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 70/96] clk: rockchip: Fix wrong parent for SDMMC phase clock for rk3228
Date: Thu, 24 May 2018 11:38:53 +0200
Message-Id: <20180524093609.422539428@linuxfoundation.org>
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
@@ -369,7 +369,7 @@ static struct rockchip_clk_branch rk3228
 			RK2928_CLKSEL_CON(23), 5, 2, MFLAGS, 0, 6, DFLAGS,
 			RK2928_CLKGATE_CON(2), 15, GFLAGS),
 
-	COMPOSITE(SCLK_SDMMC, "sclk_sdmmc0", mux_mmc_src_p, 0,
+	COMPOSITE(SCLK_SDMMC, "sclk_sdmmc", mux_mmc_src_p, 0,
 			RK2928_CLKSEL_CON(11), 8, 2, MFLAGS, 0, 8, DFLAGS,
 			RK2928_CLKGATE_CON(2), 11, GFLAGS),
 
