Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527156304-2-13128677951074020828
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
    1527156303; b=TW6/e59KmHsdbeWY6FQbNXJgQyzlEz5GGeVHvpSsjwwIeACfhx
    dPqGMwRF5wCnYn+q9/Q6K3Dr9gy0vRVVlEs2sRnda0bHGrGt1nvBMLHt6LA89xRA
    UgiJMFx91pDCTabowx5xaIs/d5NUh4uiCwWhBpBs1wT6yQVyb7jvB/qO/qWtU/8e
    RmNWMi5ufyfzcljNdgw4xOWm6BeXJIwC3H7HfB60/q8oEYv6IZ3dgWUC0gcZRP7B
    xPxL+k83NOKSGc2qjQtAs0fFPEWwuXaeKigxV1XsE5Ah9jcYXxANf0VRSoYMkUxw
    +yVpiHtf/wUwODmlHzXfRtT9RFQXNrbmJzPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156303; bh=lLpk9yz2fMM3Ete0QNfqPUC3uKW5RN
    WYXYTTglaiaSA=; b=N6W2s339y2kR5N93UMmJHl6cXh4cTdl41YkZUjQkLT/lP6
    4cN6MUDbuyJ64wgmcAFWcmCtPPsBooxYE1IPe51IS30nbKDE9qdlZ33PcbeLhAkG
    z4yaKGwCS1i8EyYSmEmKimGTVqXHL2/JlLBRMwsv8NPZT67yA0XSFG4ONTbdTWsN
    Zj9rCNJGPDQoABIL+l4CVqG8viLSAqH66qBmojZLAbo9u8CiWUrJZYTBMYi4krOv
    pVdNrr63j5cpAm/GZMx/AnBmN5rC7hodqkl7qEXsi/vRTzWAlwyDkkvMU1EKtgpv
    CBBVD2Jw9OXUXkWkfif2KzNJ2A+m1kZmfEbd162w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=z80T/1oe x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=z80T/1oe x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfEs8Arhmzz0I2EfVCbC4kNcJaRyyVJUQjuVpjccLBcthlB0kfsOXjGgFqbLrAJlwRf9skKBbaiZDV24Ozt4UFYFW0kWrXGbNsBm5RtXF8Qiojjz1L+t0
    BfY4jJRV++hOR2ezi83DuBCCHvdzmtqR1RyQDXx1RBP8uLpRAw7Q9sVxRa1k2XXIdt+xnvVa5JfZmbpG0p7TvUlLZI+TvAMNSx3RIzjQDY0CV1xo613Bo1z2
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=BY5PBP3jAAAA:8 a=IpJZQVW2AAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=bDMPh_XEGIa_xzKebcEA:9 a=QEXdDO2ut3YA:10 a=gQW0MTutLl7eKD3OLfcZ:22
    a=IawgGOuG5U0WyFbmm1f5:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031475AbeEXKE5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:04:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031491AbeEXKEw (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:04:52 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yixun Lan <yixun.lan@amlogic.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 132/161] clk: meson: axg: fix the od shift of the sys_pll
Date: Thu, 24 May 2018 11:39:17 +0200
Message-Id: <20180524093034.156085563@linuxfoundation.org>
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

From: Yixun Lan <yixun.lan@amlogic.com>

[ Upstream commit 2fa9b361e500a0e092a9525afbd6a3a363ffa5f0 ]

According to the datasheet, the od shift of sys_pll is actually 16.

Fixes: 78b4af312f91 ('clk: meson-axg: add clock controller drivers')
Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
[fixed commit message]
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/meson/axg.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -151,7 +151,7 @@ static struct meson_clk_pll axg_sys_pll
 	},
 	.od = {
 		.reg_off = HHI_SYS_PLL_CNTL,
-		.shift   = 10,
+		.shift   = 16,
 		.width   = 2,
 	},
 	.rate_table = sys_pll_rate_table,
