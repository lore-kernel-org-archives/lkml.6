Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-906599-1524475684-2-8563152505665747233
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
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524475683; b=vj4n0wtyptYNEvTrtIywfpRjRsTiVqQLXqTUA1LE8cCvyq7Vfu
    BdpAKmg92XEFraZYLFh/31ffCUkz1IqTwEbs2PJsQDTXTQ+6gBvcxHERwZPrwtY/
    dD5Fl4Meldmgc9QDZ2YTGAjNTX/CZJvHqaRBu8MSkMfjq3pyU4yuSSyYJqpnuuWD
    3Ygp0X+nGKBTtpgalGp+Oj73LKZk5lBLR0n22kDRs//zB3s3RkBRd4eZS0OKtkJB
    7cDoJXxdBiCwhNUVlQiv4pF2zgMuoQgPHoC7OtHYjmSzfFWWUKVuDEBwTRbrpuCY
    EJAfSzjui4PKL5BsrZoby8iq1ZP+ScmuKw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1524475683; bh=PFyzkyO3FpQmDzVlLTZWnlr8UjHnI9
    VaOVPECV0Titc=; b=TJril7b0A0t9TgjQodscHlG1Q51BvbJLav/9pW3L6A8Kem
    YHGWz4YZSzvnKt+0lsAJcjVLpVUavY912oRTzIWqyV/YiTVtWYDNSi+zypiydFaK
    loR4BA1fOBpLs2bk7beBXWHvAfF86xOCggnlXOmrRHdoKYNCoUemKUT/GQWG2bkh
    wVcH+L4Q34vWms90yvZNI+7Qb2vx5Y9RA0L8xxqp6CPfzgj8/vHokXOHdQMenhNf
    vUF7ZUoppQavVRVDlh1SI4rjXSbSohu/5iEKG8S8lEqswQBYD+mSIQ+kABigypUd
    COfvuAyqFA0zag6Kg3pRKilNBzMTwkQm15yr6VCA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b=pe/PhJMH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=a3jqPjzu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b=pe/PhJMH x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=xilinx.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=a3jqPjzu;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=xilinx.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCCUAMs0akrE3wA0o0v26Pg4UoygiaH7469+4YzXG0SHep53eexeZkLgx6OZxQmgxZIeQ3DaISF7vdrKO/eVIEw1fZyaxqZQLGNpCYyXQ9bzFvDMC34a
    YSixUPcTKAvU37/8G7iG2iN1CWE66z1bFVxOAJTre9vkasPXZjzJMsQ63MrXFfxL1kr6Wz+fO7BpEC1AynIzoZTWFH35NGuOhA3gSe5pVX6ubCK+8tKePbVu
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=Am4ss40yAAAA:8
    a=VwQbUJbxAAAA:8 a=umaTsKbu6dcAGf_5d3sA:9 a=x8gzFH9gYPwA:10
    a=lf-hbUz_c89dky27wAWH:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754631AbeDWJ16 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 05:27:58 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:41776 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754624AbeDWJ1w (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 23 Apr 2018 05:27:52 -0400
X-Google-Smtp-Source: AIpwx4/6WF4d32fc0RrGZx7kOWF9LMdoEKSUpPC+Adsi2JxWYGINvg/FaQunYFXBlBc/czPVVO32HQ==
From: Michal Simek <michal.simek@xilinx.com>
To: linux-kernel@vger.kernel.org, monstr@monstr.eu,
        devicetree@vger.kernel.org, Rob Herring <robherring2@gmail.com>,
        matt.redfearn@mips.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>
Subject: [RFC. PATCH] earlycon: Remove hardcoded port->uartclk initialization in of_setup_earlycon
Date: Mon, 23 Apr 2018 11:27:50 +0200
Message-Id: <b05e4d329c556357bf7393075c6c1602509eb9c2.1524475668.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There is no reason to initialize uartclk to BASE_BAUD * 16 for DT based
systems.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

It looks like from history that portclk = BASE_BAUD * 16 was setup to
get on calculation on x86 (divisor = 1) but it shouldn't be needed on DT based
system. That's why I think that there is no DT based system which really
requires this line.
---
 drivers/tty/serial/earlycon.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/earlycon.c b/drivers/tty/serial/earlycon.c
index a24278380fec..c12b1edcdd8e 100644
--- a/drivers/tty/serial/earlycon.c
+++ b/drivers/tty/serial/earlycon.c
@@ -244,7 +244,6 @@ int __init of_setup_earlycon(const struct earlycon_id *match,
 		return -ENXIO;
 	}
 	port->mapbase = addr;
-	port->uartclk = BASE_BAUD * 16;
 
 	val = of_get_flat_dt_prop(node, "reg-offset", NULL);
 	if (val)
-- 
2.17.0

