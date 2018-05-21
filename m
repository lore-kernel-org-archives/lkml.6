Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1859598-1526967068-2-2959277067587215801
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DATE_IN_PAST_06_12 1.543,
  HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526967067; b=XYH6oG9xBl9mE00Igs1i0VfxHAw7RZKQSYYKiQiYMBoxQMDmda
    b5RnGvTPUSVl0ZCYrbbwLxulshvHPuUrCmsXLGmqj+JRFkuX9yvMkewRdOcGOqJv
    3GpFzeW+lBvK/2XHwR5WRzXKVl4s7slCVuOLbBpjQF6RSVm9RygtoX3lyXjfrgIm
    l26X7NXl4LloiVbr16Xqz8WSYUy7ct2I0RsHsCxuv5uCJJESjb6EK4sWv3OZCRFT
    iPtGXfx8EVWLN0BXFgwWCX3ZidXiyMisN4G53rW1LQD2jxoIsYz0AkyKUBCuVZCf
    hV3c3WI60sh5sr6ARmwYVbm9AUtSKqIxZWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526967067; bh=uZgL9NSp23rojoNnO/jJxx44dTWZaj
    G7eMiGFPw0XIA=; b=M/gKuZOYRmin3eAAn+Zwh+P5hPl3nU9VQSpQ77GF7rG1Oe
    /cx8dbY3RDBktDi4B1KbiIhX3+UYFkz1aNxEebQGnKUsaT1icGYIc2hDkDLz9EdP
    W1pfeDLordvh4NTCWGbmUd9sC5YI/dyHFGtcWchd2pmIbeN2zkdhH1AHqveZrzWa
    Yw9gTFkCtBAEZGkw0DHTcWufAXe2wNwxlvdvXGHC+WHxOrZQ4T+23HZlFD1bLBYB
    BB8q1SHkdAKlHP9YInF7z3JB6f59rxVSrkw8G0LvNbAMjgeiMPrBKpWbUn9D9UiV
    +lIRbLxgu5Rb0in1cMMtvRT0VWngevQ99zLT5zOQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=fgXA2goS x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=fgXA2goS x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfALbfoR2SbL5Jr2PqK7pfbhbQWuDHhPzIZTsM85dsng4qjknQmRR4N/iYf5HSeV01HeuHuscCSYI0e8cudTfdBhP+hNDqAuBLKMGyPA95ZG/xabrO4Ew
    a8czbyqVzuSexXDBHNG0xy+Lp0icbS4zTj+8QUTk42S6gQqonJYYZR74XzEQ8WMiRGXig8tFQmDhazOMyXitaAXsQlFVkeexvN0IjbrKr5hFjje5vKqSqJ5L
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=xjQjg--fAAAA:8 a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
    a=ag1SF4gXAAAA:8 a=oPBFecwIsE1NewbdIycA:9 a=QEXdDO2ut3YA:10
    a=L4vkcYpMSA5nFlNZ2tk3:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeEVFbG (ORCPT <rfc822;greg@kroah.com>);
        Tue, 22 May 2018 01:31:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751002AbeEVFbE (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 22 May 2018 01:31:04 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Monakov <amonakov@ispras.ru>,
        Ben Gardner <gardner.ben@gmail.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4.16 031/110] i2c: designware: fix poll-after-enable regression
Date: Mon, 21 May 2018 23:11:28 +0200
Message-Id: <20180521210506.512907648@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210503.823249477@linuxfoundation.org>
References: <20180521210503.823249477@linuxfoundation.org>
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

From: Alexander Monakov <amonakov@ispras.ru>

commit 06cb616b1bca7080824acfedb3d4c898e7a64836 upstream.

Not all revisions of DW I2C controller implement the enable status register.
On platforms where that's the case (e.g. BG2CD and SPEAr ARM SoCs), waiting
for enable will time out as reading the unimplemented register yields zero.

It was observed that reading the IC_ENABLE_STATUS register once suffices to
avoid getting it stuck on Bay Trail hardware, so replace polling with one
dummy read of the register.

Fixes: fba4adbbf670 ("i2c: designware: must wait for enable")
Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
Tested-by: Ben Gardner <gardner.ben@gmail.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Cc: stable@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/i2c/busses/i2c-designware-master.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -209,7 +209,10 @@ static void i2c_dw_xfer_init(struct dw_i
 	i2c_dw_disable_int(dev);
 
 	/* Enable the adapter */
-	__i2c_dw_enable_and_wait(dev, true);
+	__i2c_dw_enable(dev, true);
+
+	/* Dummy read to avoid the register getting stuck on Bay Trail */
+	dw_readl(dev, DW_IC_ENABLE_STATUS);
 
 	/* Clear and enable interrupts */
 	dw_readl(dev, DW_IC_CLR_INTR);
