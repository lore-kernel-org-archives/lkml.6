Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2591571-1524405879-2-17665937651934611551
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524405878; b=Drn/LM6lED+UZrc0NXbit6ElSVeU56cX5A8Im4uSP25w0IX+ED
    m1Qy0mHsa7AMCpHWBx2K4PDNDx/ta+hQDgR/6Qvx153uGYnMkF8bM3NneaIoKao1
    ZaJexC3WK1BnEjWeCVIa9YM7JaGOBbcWGkHjJvyX9IAlEc6BxLSUaTsUVtPkyd5G
    4Je3GfS///D/b5Wpnd1qV27fmid4cfcc4XD0kSGVbE8Fxl11SK2RK20TOfAEkfGB
    BTZO0m3F1agBsVukiV//RmmTr3YtBcAfd616tBHD1s7hZkyyVMcudInsns2KN6Ix
    ++701Of0yGaIv8nMCY7CYfm1iQTLZ0D39kzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405878; bh=OutEEglHrXniSorJ3q5HJXi/KTUhCr
    zaDzFBQrFEuBY=; b=mqfCCW2qZyIP7Z5wAWpvgxqnIsP8UbEEr7JK7dxke/nndz
    8uizz5ZZYJSPI7mSIR9TqRTy9R0zhRo2tdqC5paiRlEfzl7wNSXz6EvH7wQKGBaq
    8jIjA8djEUiVxx8zpZzCS/xle42CwDGU49O0rQw0BOGbPJf7z/pkPGFF7iHsePiE
    OJMcc/FYc3V7LMS7P+8fvXaKE3ZgLeOM5lBZ8tQAeJvABxYxzCmI1WAnQzJwMWCj
    IvLLrFm8fPb172ywdBkF/RqPnXMxzko9k4r3A4N+fhOnobP9JWPinoZquXiV6lvi
    tvOPtdKOAh48Ng91jMFOr6PVE6QQQe/oYd5xlMDg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfO4T9US2g6nIDSZ3L9P+jUyTnI2+JNs5vQEbc+P32UKtBW+RcwoG7wMVK3cs6gqS05J4/XswYqPzlHrZip98g2Fim7U+BboD2GjlwPrewJ4nJv6c4YfP
    RzLB1D1Wddul4RIsC1bihPKvUsOelCxJC0e8jEqJDBgyH37jzbcpObcM+d2e2cA2oRhmCaWKzz2/a2qTeSNhUDZoO9dYoVvBENKuSPRoo5P1tnFTMQLH0NSS
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=3Rq6X1I58VWYUlHXiHkA:9
    a=Cue8BvKLl97AKjEq:21 a=lYtg8cpXjCE3KycZ:21 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754011AbeDVOEf (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:04:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50234 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755239AbeDVOEb (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:04:31 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 4.14 028/164] spi: Fix unregistration of controller with fixed SPI bus number
Date: Sun, 22 Apr 2018 15:51:35 +0200
Message-Id: <20180422135136.558151906@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
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

From: Jarkko Nikula <jarkko.nikula@linux.intel.com>

commit 613bd1ea387bb48b7c9a71a0bb451ac15cfbbc01 upstream.

Commit 9b61e302210e (spi: Pick spi bus number from Linux idr or spi alias)
ceased to unregister SPI buses with fixed bus numbers. Moreover this is
visible only if CONFIG_SPI_DEBUG=y is set or when trying to re-register
the same SPI controller.

rmmod spi_pxa2xx_platform (with CONFIG_SPI_DEBUG=y):
[   26.788362] spi_master spi1: attempting to delete unregistered controller [spi1]

modprobe spi_pxa2xx_platform:
[   37.883137] sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:19.0/pxa2xx-spi.12/spi_master/spi1'
[   37.894984] CPU: 1 PID: 1467 Comm: modprobe Not tainted 4.16.0-rc4+ #21
[   37.902384] Call Trace:
...
[   38.122680] kobject_add_internal failed for spi1 with -EEXIST, don't try to register things with the same name in the same directory.
[   38.136154] WARNING: CPU: 1 PID: 1467 at lib/kobject.c:238 kobject_add_internal+0x2a5/0x2f0
...
[   38.513817] pxa2xx-spi pxa2xx-spi.12: problem registering spi master
[   38.521036] pxa2xx-spi: probe of pxa2xx-spi.12 failed with error -17

Fix this by not returning immediately from spi_unregister_controller() if
idr_find() doesn't find controller with given ID/bus number. It finds
only those controllers that were registered with dynamic SPI bus
numbers. Only conditional cleanup between dynamic and fixed bus numbers
is to remove allocated IDR.

Fixes: 9b61e302210e (spi: Pick spi bus number from Linux idr or spi alias)
Cc: stable@vger.kernel.org
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/spi/spi.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2258,12 +2258,6 @@ void spi_unregister_controller(struct sp
 	mutex_lock(&board_lock);
 	found = idr_find(&spi_master_idr, id);
 	mutex_unlock(&board_lock);
-	if (found != ctlr) {
-		dev_dbg(&ctlr->dev,
-			"attempting to delete unregistered controller [%s]\n",
-			dev_name(&ctlr->dev));
-		return;
-	}
 	if (ctlr->queued) {
 		if (spi_destroy_queue(ctlr))
 			dev_err(&ctlr->dev, "queue remove failed\n");
@@ -2276,7 +2270,8 @@ void spi_unregister_controller(struct sp
 	device_unregister(&ctlr->dev);
 	/* free bus id */
 	mutex_lock(&board_lock);
-	idr_remove(&spi_master_idr, id);
+	if (found == ctlr)
+		idr_remove(&spi_master_idr, id);
 	mutex_unlock(&board_lock);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_controller);
