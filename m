Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3552852-1521221496-2-5198873053447855105
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521221496; b=HRvIAfRqMWmnnJWAJHLyH2BgngyAYg4wENn74R+/2euWmJy
    jf9ri48fuMV1qdWe3V/s76h6cjcGYsMbEuG2MODzym9lFNZbLECwRQGLzUXWYbYk
    qxQdfsg/5f3Cai/ZcgQNZW/YUdXOBymaMGNwPGI3pRlH6S0Dkn8vlizsGnVKQI3h
    /ScAuC1RFuH1TUoh1WGzLkcrnziK49hyeVTdF1Us0PyzJOjUedKmA15TjGbX0GWC
    cClkLGVUGDdlvRwE+7HlDnqIJ6yWWbZcy+abyyp8Hc/Wc8x1HhBp5Ld0t2XnBAt1
    436TiDqfubiYVYK2g+Gu/Egn0v1zed85bfxweqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521221496; bh=IHPtuu8dDYAgAKzw+GJp2PMi51
    1QqwsYY2hV8J/KFwk=; b=JvJbfdG+VrWrx8CqKz76gZj03aWufKa+RzDSRUpVYr
    xpCQK1XRm+Azd3GDRW3DRIjvX0b+HOqfi847pYPByBuc7QocTS9MBcNAiHZ1ocQg
    y9+hLOiNsKd94Pv8xq+bwnKBW/EDCpxz9Yg7AvOzDjR578xAVFNlmliManjgrQR3
    p2yXySxnNOAsZrhRumXSLXaDQuBUir++GOIBHHfpZCmqQatnkJcaOb6N6EcSft4l
    qcPl7CDAYWr4ePk9W+DAg191hW4B2l3BAdXvqfjOYBoaWIa2la89hiy/bVMQWolD
    5Qy+Gr3CUWDoS3+Ab+RNdod5f15CzYCraGcnRlnjA4xA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932673AbeCPP1r (ORCPT <rfc822;greg@kroah.com>);
        Fri, 16 Mar 2018 11:27:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34798 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754269AbeCPP1p (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 16 Mar 2018 11:27:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jerry Hoemann <jerry.hoemann@hpe.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>
Subject: [PATCH 4.4 28/63] watchdog: hpwdt: Check source of NMI
Date: Fri, 16 Mar 2018 16:23:00 +0100
Message-Id: <20180316152303.139424550@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
References: <20180316152259.964532775@linuxfoundation.org>
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

From: Jerry Hoemann <jerry.hoemann@hpe.com>

commit 838534e50e2e5c1e644e30ab6cb28da88eb31368 upstream.

Do not claim the NMI (i.e. return NMI_DONE) if the source of
the NMI isn't the iLO watchdog or debug.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Wim Van Sebroeck <wim@iguana.be>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/watchdog/hpwdt.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -51,6 +51,7 @@ static char expect_release;
 static unsigned long hpwdt_is_open;
 
 static void __iomem *pci_mem_addr;		/* the PCI-memory address */
+static unsigned long __iomem *hpwdt_nmistat;
 static unsigned long __iomem *hpwdt_timer_reg;
 static unsigned long __iomem *hpwdt_timer_con;
 
@@ -473,6 +474,11 @@ static int hpwdt_time_left(void)
 	return TICKS_TO_SECS(ioread16(hpwdt_timer_reg));
 }
 
+static int hpwdt_my_nmi(void)
+{
+	return ioread8(hpwdt_nmistat) & 0x6;
+}
+
 #ifdef CONFIG_HPWDT_NMI_DECODING
 /*
  *	NMI Handler
@@ -485,6 +491,9 @@ static int hpwdt_pretimeout(unsigned int
 	if (!hpwdt_nmi_decoding)
 		goto out;
 
+	if ((ulReason == NMI_UNKNOWN) && !hpwdt_my_nmi())
+		return NMI_DONE;
+
 	spin_lock_irqsave(&rom_lock, rom_pl);
 	if (!die_nmi_called && !is_icru && !is_uefi)
 		asminline_call(&cmn_regs, cru_rom_addr);
@@ -840,6 +849,7 @@ static int hpwdt_init_one(struct pci_dev
 		retval = -ENOMEM;
 		goto error_pci_iomap;
 	}
+	hpwdt_nmistat	= pci_mem_addr + 0x6e;
 	hpwdt_timer_reg = pci_mem_addr + 0x70;
 	hpwdt_timer_con = pci_mem_addr + 0x72;
 
