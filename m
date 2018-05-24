Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1733193-1527156279-2-5659837331712746772
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
    1527156278; b=hi17sCRxogrBSrRnb8+vCcHdeFl0lyInkp1+eugeRbOAnF+CzP
    BITl3Z/KdKZq6DspoL8ZtRAPHhJgHsi4T9iZksPs8fAOq8LRh8JgSoJqBhLDIb6C
    FivOBRcl9T/ByZxWuLINhLtMfLJOMoelLlUTO/kY1jh4B4QFXxSZsvoPQ3gFeGSN
    9UhbJgibxQruubB+CBVzckECHUY/Bfs165vke6GAuzhXCuGt/JLzVOOLt2i7+DLj
    M20UNuD5j03Y1eAs/dxvLNyySY9STv7BFcY8Ttfbs8Gj9ALlNW+XeuHI+tjj22hQ
    upIgvdePzFbCNQahole0cf7Y+p5FzRaL1j+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527156278; bh=r5WEFr5sKSDExvO8fhpwh4wVl5/ZOj
    hTPjku3xdNmwM=; b=l5stjyxkXkA1lP9Oxn8o4yJGGNXm8SBa7WA3L+y0hCkPg3
    7WvNlFldghhC1ICk4NIuTZ/YNrb/YGM7f3VqZRLuql7CXNmaJM/muZb/eO8mR723
    XoizGai5+BeBsLVHjhiFfXIaG5MQl5qBthtFbX3/MAGfCbxmxCeO4/0g+r6bBCIR
    4lk7K6ED8KG2EnGZkHY6ik05sklB5DbATFLLWUsbH1hbuYm2DhBOoGuOplAHIABL
    5wdwAg/ebwBEIGWDqRjBKPWnSmINCrVw+fZKd5NTuodatDu93k+j1WeJNWrL1aVe
    6/AmhDuD6I3+iMnHC4IIMpaohARGsrzMaWzs8Eng==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=HFnyvBTO x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=HFnyvBTO x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfK4a6bKMXEmcLYM14OLjSzjrE+nuoC5qeODheGtwaoq5tQHjEziaJPgiDAbLfJTaRTW0/RvSDjdILCvGHyXs/R8QtOgPXkiOZ/LDRDRhtk0EbymgyjuN
    RQKz6z2e7AAGId11JRN/t0TrjOnGynXKJGsHFMhgh8BhsqB+/bWrkXwc/8EBNuGkHqfcRq9i/44gaeeQEiUlbm29mHGj8DETQY6sxaIuCxm1p2oWewvA3+yt
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=j-NXPswCAAAA:8 a=m8ToADvmAAAA:8 a=Ikd4Dj_1AAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=RNOMWXZoqlZzpp3PYiAA:9 a=CpAaTgS6MOlt5aeE:21
    a=yYO6URiAGnNbBWEK:21 a=QEXdDO2ut3YA:10 a=UdV-L189IiqUQIgB40x4:22
    a=kCrBFHLFDAq2jDEeoMj9:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031431AbeEXKEa (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:04:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031424AbeEXKE1 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:04:27 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 124/161] clk: tegra: Fix pll_u rate configuration
Date: Thu, 24 May 2018 11:39:09 +0200
Message-Id: <20180524093033.148594719@linuxfoundation.org>
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

From: Marcel Ziswiler <marcel@ziswiler.com>

[ Upstream commit c35b518f9ba06c9de79fb3ff62eed7462d804995 ]

Turns out latest upstream U-Boot does not configure/enable pll_u which
leaves it at some default rate of 500 kHz:

root@apalis-t30:~# cat /sys/kernel/debug/clk/clk_summary | grep pll_u
       pll_u                  3        3        0      500000          0

Of course this won't quite work leading to the following messages:

[    6.559593] usb 2-1: new full-speed USB device number 2 using tegra-
ehci
[   11.759173] usb 2-1: device descriptor read/64, error -110
[   27.119453] usb 2-1: device descriptor read/64, error -110
[   27.389217] usb 2-1: new full-speed USB device number 3 using tegra-
ehci
[   32.559454] usb 2-1: device descriptor read/64, error -110
[   47.929777] usb 2-1: device descriptor read/64, error -110
[   48.049658] usb usb2-port1: attempt power cycle
[   48.759475] usb 2-1: new full-speed USB device number 4 using tegra-
ehci
[   59.349457] usb 2-1: device not accepting address 4, error -110
[   59.509449] usb 2-1: new full-speed USB device number 5 using tegra-
ehci
[   70.069457] usb 2-1: device not accepting address 5, error -110
[   70.079721] usb usb2-port1: unable to enumerate USB device

Fix this by actually allowing the rate also being set from within
the Linux kernel.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/tegra/clk-pll.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/clk/tegra/clk-pll.c
+++ b/drivers/clk/tegra/clk-pll.c
@@ -1151,6 +1151,8 @@ static const struct clk_ops tegra_clk_pl
 	.enable = clk_pllu_enable,
 	.disable = clk_pll_disable,
 	.recalc_rate = clk_pll_recalc_rate,
+	.round_rate = clk_pll_round_rate,
+	.set_rate = clk_pll_set_rate,
 };
 
 static int _pll_fixed_mdiv(struct tegra_clk_pll_params *pll_params,
