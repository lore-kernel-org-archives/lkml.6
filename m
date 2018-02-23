Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519414933-2-12243338226074817804
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519414932; b=ORPh9Od7nxRYxBhyhohYvLYAlwyhttTroucvsIQ+u9Jcv7G
    4aiiN4j8acqx4gs7bwYvWEAloE9e7L6ohmw8q08LBTNAfcrR7b4Oz+N2J1QfOMdN
    76tM8btKsZCHR3o1j/G0f2jl31YgVodAybQtgk4k6CjPfetyzFrGfDZPDnATNB1G
    qzEeIjBk0CCKF5styL/CKaYn/EaLAvGgL5ZWEHnEkb1rrVI6SzR0uyxfx7QkwOIQ
    y6+yb+cs6a7aFJ65nP7lfzY1+F6zeUussBIoGb0deKWm+No6obAl6dw83QEjFUyt
    Vw3QvDRe5e4sf3QsJk/q+mVTypG05AqwiZQ0kOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519414932; bh=pxQ8sAJQL87f97bfbeZ/iaSM6S
    XJmRR5LiyKdTBhDhA=; b=iMfa8HSImgZ3Yq2Bbuh887alsEL6SjaFoAqJHQXDuI
    nDhPQSj+CHPmtrqQ8wfUyYMEpvGzp7Sz2ZRK0UAkCOqpyo/FSkdVjGPTYTx9niNS
    T6NUdWLaeGuY9bMBD1U7nFbudfkrwzNTm9z04+20J4gNVjPpL12665lNY1BqfH4P
    d/R7AYKwDRDolXbACs5AjrwAXEp4V3bo0/ZyN3AbPJbIFQ2YzneZRj0kyMDlxag4
    iw5SD2tC/5hQo5v+/0Jmiy/RlaI+lkRRalyqCj1Xo242cpmcC2J82oHax1ejUeQI
    7BYrsFe24Tda01iGopzKiaN2bdSBWksEeTeZ5Nf5grjQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934428AbeBWSsk (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:48:40 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44974 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934087AbeBWSsh (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:48:37 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 4.9 140/145] usb: phy: msm add regulator dependency
Date: Fri, 23 Feb 2018 19:27:26 +0100
Message-Id: <20180223170742.815122912@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
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

From: Arnd Bergmann <arnd@arndb.de>

On linux-4.4 and linux-4.9 we get a warning about an array that is
never initialized when CONFIG_REGULATOR is disabled:

drivers/usb/phy/phy-msm-usb.c: In function 'msm_otg_probe':
drivers/usb/phy/phy-msm-usb.c:1911:14: error: 'regs[0].consumer' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  motg->vddcx = regs[0].consumer;
  ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
drivers/usb/phy/phy-msm-usb.c:1912:14: error: 'regs[1].consumer' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  motg->v3p3  = regs[1].consumer;
  ~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~
drivers/usb/phy/phy-msm-usb.c:1913:14: error: 'regs[2].consumer' may be used uninitialized in this function [-Werror=maybe-uninitialized]
  motg->v1p8  = regs[2].consumer;

This adds a Kconfig dependency for it. In newer kernels, the driver no
longer exists, so this is only needed for stable kernels.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/phy/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -147,6 +147,7 @@ config USB_MSM_OTG
 	depends on (USB || USB_GADGET) && (ARCH_QCOM || COMPILE_TEST)
 	depends on USB_GADGET || !USB_GADGET # if USB_GADGET=m, this can't be 'y'
 	depends on RESET_CONTROLLER
+	depends on REGULATOR
 	depends on EXTCON
 	select USB_PHY
 	help
