Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2235763-1523579430-2-2648296300817435293
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523579430; b=W+qBecU3yYVjoe/AIyBTekaEPGI03pKbDFwd7jy3X+8IFONyye
    FzT5y9u05bsgeZNf9wODgZS4UvE986mNGipTOPaoRlPGKt20XjXuKjPICedbShWJ
    0pSQOD8ah6XM9yax+ayTDgM3BvdYg2Wejq6prxV1bqbc7vS5vEX+l4Fgg03EKFMD
    /yVpwi8nAr2EmcPTlDv61V3X14Y/oj94srodkGQ0xFTE1f1Sf7KBf3mWSXUP/WJ1
    QeHEhsYVW1gWYlFiDl/N6P6XGvvVO2eeDQOUO+hHGYbJ/3zJ3zpzXKDLg4o6LgTA
    Ei2RXh6Ed0JPx80ecy89pht7nL9SpiIdXCNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1523579430; bh=1BlayLRfFu+78r5GGrXeh/Qmr0IVrk
    jt4ObWBQ4LbMk=; b=BmUDqZq8Y2NoUvipADrEk8Rn4It048b9cJoUNvm4AZq+FP
    BfMWsOI+LjQT6+WI23k3GTc/9ILW9lEFQ033Fbx4NPaGMVxPJTfpME4goGyUpxph
    NUNv8kZewL+yuwgctEDu93QDrEbUW3ymiHlNfhNUS0DkWKdvD2vsr4R1MjE/WuOV
    aBITVRotWHSuK7llBlb0L+qFO0qJgI8fs6+XYRSexNtzw1GaZOyhnhDc3UjpPgFU
    eNX9pTPFH7KELREmpcixdjtHvCoyTdTnP02OExhChOQWf7e3oWgiq9+YtP++dZ+b
    Rv3iWtQz2ZPkQUQJsVEecdhHt0zTUne8GSfINJYw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=prFBaON8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nNqATpdV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=prFBaON8 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nNqATpdV;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJrF0c9aLV7OCVq+xTc5ECYJyhMZpHmaRtg+4mBoQGEn6jCQYIIw1yOadweYq3uoSxDD4EVeuRsXB1Qs0Uod8ihRUhtjDToKdhaRUYKduJuew3LA6Oa3
    LPSBUU5VaY5QSUgiFUUr+1OvsHs7EMttESGqKFc3Vygkharr+NaGSx2KdL3i7a5G23liwcva3PFeiPqM9q3Wj31wq0TVLaPeSf3+0oMZscyUL5kLbghHAUwm
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=c8hNbdbooHvhgayvCfkA:9
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753734AbeDMAaU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 20:30:20 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42707 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753696AbeDMAaT (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Apr 2018 20:30:19 -0400
X-Google-Smtp-Source: AIpwx49qvx1uoNwsLdhgtcZ2ipL45dnY1M1TCY1mw3ZvItCibh4JjeDoOdeNWW6HTllbGf80kc9XXg==
From: Greg Hackmann <ghackmann@google.com>
To: Adam Wallis <awallis@codeaurora.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Badhri Jagan Sridharan <badhri@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Hackmann <ghackmann@google.com>, stable@vger.kernel.org
Subject: [PATCH] Revert "xhci: plat: Register shutdown for xhci_plat"
Date: Thu, 12 Apr 2018 17:29:51 -0700
Message-Id: <20180413002951.155762-1-ghackmann@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Pixel 2 field testers reported that when they tried to reboot their
phones with some USB devices plugged in, the reboot would get wedged and
eventually trigger watchdog reset.  Once the Pixel kernel team found a
reliable repro case, they narrowed it down to this commit's 4.4.y
backport.  Reverting the change made the issue go away.

This reverts commit b07c12517f2aed0add8ce18146bb426b14099392.

Cc: stable@vger.kernel.org
Signed-off-by: Greg Hackmann <ghackmann@google.com>
---
 drivers/usb/host/xhci-plat.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index df327dcc2bac..ea089fdda611 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -420,7 +420,6 @@ MODULE_DEVICE_TABLE(acpi, usb_xhci_acpi_match);
 static struct platform_driver usb_xhci_driver = {
 	.probe	= xhci_plat_probe,
 	.remove	= xhci_plat_remove,
-	.shutdown	= usb_hcd_platform_shutdown,
 	.driver	= {
 		.name = "xhci-hcd",
 		.pm = &xhci_plat_pm_ops,
-- 
2.17.0.484.g0c8726318c-goog
