Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1340521-1526937563-5-18037492522509920990
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526937563; b=YAQ/HoSHwvRcuOhKCbSXwBlCh9mmVNKY9qYeLPfCDApEkjBtdE
    bIvPleg9RlP3vRsRO3A9WoX0Had8CQ37Gm36C++ePw9aB4OHRG1YhUxst2aJ2Y2/
    kD7c+6UdOKeClRziwnDqKCn6lwq/Xs/FUjZPPQRlYvZ4Jt/kZZHLzlsb6iSgGIFZ
    wGGTbwKxl2rweHI90Yd2X5Z9GkNP4No8RMalDhSLjjhIfeB0P/0EDv3uwCU5dEaj
    1eND2WMmf93aShm+92HvCpAaoLm/tR2pCvBqrUVpRGhnhybAzqGmuSWKFPKH5jHS
    giPnDh0mN0QtesTQ0Jrz0plBDiw6d2ChC2Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1526937563; bh=JwqvhcjZUgJ/0nvkfqT3rwTR2jzMNf
    w/bxuxjwDrQgc=; b=SqBR8+a5rLqgkPztwaAwKGI9Qntk44EhkcktHhyeawA5gq
    nSt0BJhV6oxYPuHT98yBv8jNnCUgkWrXFbP4KzBlJbUki2UZHX4CgYfLuLeWY21C
    yr+w8zbTOz22b4Dpjc6qRarjdsG6thKZlsyqCZJXyrZ11LYloq3Mymu3/BpYR9/k
    DlaaS3XEAi+2SUayKm63qiHsn/O3PWpUKH96r7RzvFDDtgaSXuHQT3vkrouESBJH
    xrUMgXqkstFE0Fd09W70KxGkZyJQ1wFRI1VNKztD+MMzTTS4OvsMBkcMFFsD38TJ
    ZnajFXjAq0iE9igTuVgZsgQd3F5+g7FuSzL1Xurw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=Tvn/RG1/ x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=Tvn/RG1/ x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfGynhNzHb5QQjpylk77kFBXi5zT8R9h++daVqQJk9+2zXTDRhlBYKZ+nyDWIvlo+jhpdB6MjwKbVLF7nS0NBSSwYlNQgt1lBuFBwf3OXUT+FM4JXcKVU
    rX84AP8Asc0SMYDES551EEasqazCeRpMakjfcv00XoCsEI7m0IuYMuexlRCdItiHuB+/35nOQ1lzvcUy7c4Ee/hV1jheWTGM5Eb+fzBxMYkJz6WWschMUrsE
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=BLZoak4jdz2zqNjCJHsA:9
    a=hTJd3nM-DXW1XHX1:21 a=Hg-IJv2aXcJdoT2Z:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752859AbeEUVTU (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 17:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752933AbeEUVTR (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 21 May 2018 17:19:17 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 09/95] spi: pxa2xx: Allow 64-bit DMA
Date: Mon, 21 May 2018 23:10:59 +0200
Message-Id: <20180521210449.243652283@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
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
