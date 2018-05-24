Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1874556-1527163474-2-7681245976030380516
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
    1527163473; b=IOVCLVTaFI9MFK9Kv7pCFl3XuCjUqmuEGEGXKPB/8E7AP7i6Ag
    v0CIqZDZzWL1kXFs8wJRvdVn1ahFpyBcUhhai+0WJ+TauTJDph6Iox0216giLA7B
    foVSLq3vIiSNnu2RgY3ExaNCWQVUhsQaAh235igxnxHMd615nQ8QffcCYpNu+nju
    XTNEXEEm2Oz0Ze6g8CbJThwBsOOOiA25EIipb9IBwfr2+Ll+vSnqXGyVdvNxLjwz
    G0dAOrhQi3k9MsOKIAAB3hOv7Icn5/QMfAacQe5CZ5uLvq47Jn2pjQKq5Z4qH9xV
    xoo29grAU7gcKcbnnyGgAl6oSEWAiVKZlEzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163473; bh=RYGipbmIkgrkCTdh4Ugbau9ehNt4/y
    hUSi3pkQ1tmX0=; b=ACmi0VSaWqUOwuiFlklo7gE2kOCsMWIl0DigqXFrYB+aWl
    UuomtZ56cUVMXWBsvoe5BOGtGaouPFU6c/P7QRjN8yVUUJX0L6xkfeWdhzYPB0BP
    aMRLqF3VG7tyJy/zIXQGSsD+vWWTB7ZiIYROC7rrsQcHLv9E+ortsgi+yFME1ZAD
    70ISC9m/F7OVAoEGKoYBqqoEfltCbkB71XXopv9GV5sg/oX9hcHg/71kRz2t04uJ
    19ydc4jGOfNku7EbuM5pgMH80AFqjh40DbWBCohJjMN+I2Za59uIC4uonbBt0IAA
    m1A6KoYkoFskPPCfYq/X4lgp7ZeoOy12npefoQEw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=xthYBsjn x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=xthYBsjn x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfHqYC+HGpCYQv6KzYv4cIHc4Olkk6VJdoss7Lp5FZ8uWeq4wrjs0ceULtcPH86pk/oTAfRY+ORhnNRQeGQ8Donyy7fB3CvRK15a3AejXdWlf/GGs7D2j
    PMbgz8Nask5mjXLpEMDoa5nvFQmjlkMbYk+cO91ErvAY43TtSO9TiHSn8d6efG2xrh8YOCF6MJa3l2xwTYShNlBiqCRq6ynBs2mQTyVi8coNkApkA8qzVnbh
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=8p-MuYL56OAA:10
    a=VUJBJC2UJ8kA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=s47jRAohAAAA:8
    a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=TDQuQJ2OXxYTQ_uShOsA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Kj7115exjCjJ0w_vcVhc:22 a=y1Q9-5lHfBjTkpIzbSAN:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969623AbeEXMDC (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:03:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966230AbeEXJoi (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:44:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Slava Kardakov <ojab@ojab.ru>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 12/92] r8169: fix powering up RTL8168h
Date: Thu, 24 May 2018 11:37:49 +0200
Message-Id: <20180524093200.379368994@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093159.286472249@linuxfoundation.org>
References: <20180524093159.286472249@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 3148dedfe79e422f448a10250d3e2cdf8b7ee617 ]

Since commit a92a08499b1f "r8169: improve runtime pm in general and
suspend unused ports" interfaces w/o link are runtime-suspended after
10s. On systems where drivers take longer to load this can lead to the
situation that the interface is runtime-suspended already when it's
initially brought up.
This shouldn't be a problem because rtl_open() resumes MAC/PHY.
However with at least one chip version the interface doesn't properly
come up, as reported here:
https://bugzilla.kernel.org/show_bug.cgi?id=199549

The vendor driver uses a delay to give certain chip versions some
time to resume before starting the PHY configuration. So let's do
the same. I don't know which chip versions may be affected,
therefore apply this delay always.

This patch was reported to fix the issue for RTL8168h.
I was able to reproduce the issue on an Asus H310I-Plus which also
uses a RTL8168h. Also in my case the patch fixed the issue.

Reported-by: Slava Kardakov <ojab@ojab.ru>
Tested-by: Slava Kardakov <ojab@ojab.ru>
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/realtek/r8169.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/realtek/r8169.c
+++ b/drivers/net/ethernet/realtek/r8169.c
@@ -4832,6 +4832,9 @@ static void rtl_pll_power_down(struct rt
 static void rtl_pll_power_up(struct rtl8169_private *tp)
 {
 	rtl_generic_op(tp, tp->pll_power_ops.up);
+
+	/* give MAC/PHY some time to resume */
+	msleep(20);
 }
 
 static void rtl_init_pll_power_ops(struct rtl8169_private *tp)
