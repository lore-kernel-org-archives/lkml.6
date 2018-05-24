Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1886372-1527163516-2-1054428305519383331
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
    1527163516; b=b1VGzPC3WDie4zaya3IdnxiCUMuVB9z3dcp+m/VdLi/+AuVRT2
    9fV2uo8UbIOGX3a03GW2JTHmGUdAG+LDCezj1kf64IKjR2+UG8VRRph72Lf4JFhW
    paSWg9TXblWEnAPguBFU1OxpqtgQBV4VSm8hACspGu5ffwPqljc6tby4n9Zme/Zr
    GnzXJHZNrGllhcDI1BRt/ID3ld98Pr9bst+52CpZrwIqsG9t708SYcijQASdZOXN
    hYRKHrx96IA9NQq7/La16S0P4HAyDuPfdRffilGbo9/EUwYJGM+uKlXVkPHe4FlS
    j0yawWVBtpLOVWoWSwXjw9hbgSSMOdn0Rydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527163516; bh=8PfS/oXMGemrpxY1+3z9lA1CfiiKZT
    ceiZLHKcxclDg=; b=jpKyiALMW6J0St9D6zEpiJoDSZldzMt56aiws/nj7CRNJ0
    aiYT8/crpNVRyg5hoBjkL9j5w+UumJkPc+LizgNhFV36WklkAMU7qP/94RvikUIZ
    pfu18M8UCarm12M8oHxpDJeQLgCxu+HXJUklmkmjSDwndPnXgcgLU/QWFF6sd1Rc
    zy855+xLuUbQUO+pBG+EbWlGDQmzrkIrb+Hes/KdpSijF7dom0etjHiVnF1xbR+w
    +FCnyfp0cXQqefWQsif8bo7AEh3RuOYCVxrp1BYXOGCRnaSMFVwUhpPzcxFE/YSq
    3IkhReidtVP+oKpnlsLPla/PSd9tWkWFDL0KcDww==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=t74q8mdU x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=t74q8mdU x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfIyoGcz5BkYMvIhqBRXBLjQJXG+cNOHjZpaMHQFoGED5hnWDKa7Z5HOB8YiYpiaSHkjY1x1nhpr4n9oj5AgqOh6HvrSVyAvxz6BL7vkWYYMdeycLUQHk
    z80/j1gF6KMODHL7AsHmCz29XUcNRwKh36JT5bHGsYzbJSekyYQwDVU5PgvawLKPTQ8b6HHizHupHQ9GoBHdgl+pjc5bhqjpSDaSkWoP/1BLXLQCFqUAyvJ3
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=BLZoak4jdz2zqNjCJHsA:9
    a=RzOXaV8w69EVQCyD:21 a=Hg-IJv2aXcJdoT2Z:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966645AbeEXMEr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 08:04:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966641AbeEXJo0 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:44:26 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.4 41/92] spi: pxa2xx: Allow 64-bit DMA
Date: Thu, 24 May 2018 11:38:18 +0200
Message-Id: <20180524093202.956762538@linuxfoundation.org>
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

commit efc4a13724b852ddaa3358402a8dec024ffbcb17 upstream.

Currently the 32-bit device address only is supported for DMA. However,
starting from Intel Sunrisepoint PCH the DMA address of the device FIFO
can be 64-bit.

Change the respective variable to be compatible with DMA engine
expectations, i.e. to phys_addr_t.

Fixes: 34cadd9c1bcb ("spi: pxa2xx: Add support for Intel Sunrisepoint")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi-pxa2xx.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/spi/spi-pxa2xx.h
+++ b/drivers/spi/spi-pxa2xx.h
@@ -38,7 +38,7 @@ struct driver_data {
 
 	/* SSP register addresses */
 	void __iomem *ioaddr;
-	u32 ssdr_physical;
+	phys_addr_t ssdr_physical;
 
 	/* SSP masks*/
 	u32 dma_cr1;
