Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1568560-1519219142-2-8277181929546032402
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enca,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519219141; b=gpznoxRJQ7+rUQ899P9mC+bzESrDiPQSzDVgLeSkLbBZ/sD
    vJmAVLYIn2tv+exJz6yBSuP/WcXrsvG/bdmpvyAQsgYjK+fiZt7lmgqbrFV1XCVD
    Gf5UIYW0CCJSszwkwA7BcwpXQG1HMe792pCygvU6uDxYkNiDJtNc14Dh4eBwJgwX
    zAjAs5IuDNTuEWmmF4OIIQBG07tPL8FFdPmRPS/QTe1Mo4rkXNTpG1+whf1Ig5aW
    XQLXO0IJSmjYwMjgdKax9gc5DwQkGoQYiCEAuv9QsVd/yzPI8+8LZgWLI78EpAa0
    yCLp2Ip9aRmqbvs00M287dgCQ0lJQdg5QefY8Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519219141; bh=tnQBVv5cm873I51Fukdu0C1e/Y
    kY9HCbQLRWGv9owyE=; b=Gffxozh9Q9uBUUHzO305gXhxYftxwblLSAOsbPtpvc
    2JLOJAMhz09BIiqllnxcxo4cnlWeYSPMKZO7LCSxUOeFkJh1Bozitv30/eddgtW0
    W3/U2YLQy3Yil4F2lROiI739QXfKhClJ1q/P/ScJyLaR4x77D51E1+P9BcbcuEHq
    EvWTDogab3fThxFtJLvSa18N3pMJMytOdBfilkS3tDmRtPx/RN26r4vjlcH9VVMf
    VPFv14G92Ixk+62FFnQPn4QOoZQYLXvAY5eODGZLAZFv2tr++8phefc9wMvgzGLa
    /+S4/xySObcM1Ck9ku7FJ9BeZ9Yi5Sbr1RXhuGj06U6Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754520AbeBUNMg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 08:12:36 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:45724 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933532AbeBUNMe (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 21 Feb 2018 08:12:34 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>, linux-usb@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH 4.15 152/163] usb: Move USB_UHCI_BIG_ENDIAN_* out of USB_SUPPORT
Date: Wed, 21 Feb 2018 13:49:41 +0100
Message-Id: <20180221124538.399406513@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <jhogan@kernel.org>

commit ec897569ad7dbc6d595873a487c3fac23f463f76 upstream.

Move the Kconfig symbols USB_UHCI_BIG_ENDIAN_MMIO and
USB_UHCI_BIG_ENDIAN_DESC out of drivers/usb/host/Kconfig, which is
conditional upon USB && USB_SUPPORT, so that it can be freely selected
by platform Kconfig symbols in architecture code.

For example once the MIPS_GENERIC platform selects are fixed in commit
2e6522c56552 ("MIPS: Fix typo BIG_ENDIAN to CPU_BIG_ENDIAN"), the MIPS
32r6_defconfig warns like so:

warning: (MIPS_GENERIC) selects USB_UHCI_BIG_ENDIAN_MMIO which has unmet direct dependencies (USB_SUPPORT && USB)
warning: (MIPS_GENERIC) selects USB_UHCI_BIG_ENDIAN_DESC which has unmet direct dependencies (USB_SUPPORT && USB)

Fixes: 2e6522c56552 ("MIPS: Fix typo BIG_ENDIAN to CPU_BIG_ENDIAN")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Corentin Labbe <clabbe.montjoie@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: linux-usb@vger.kernel.org
Cc: linux-mips@linux-mips.org
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Patchwork: https://patchwork.linux-mips.org/patch/18559/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/Kconfig      |    8 ++++++++
 drivers/usb/host/Kconfig |    8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -19,6 +19,14 @@ config USB_EHCI_BIG_ENDIAN_MMIO
 config USB_EHCI_BIG_ENDIAN_DESC
 	bool
 
+config USB_UHCI_BIG_ENDIAN_MMIO
+	bool
+	default y if SPARC_LEON
+
+config USB_UHCI_BIG_ENDIAN_DESC
+	bool
+	default y if SPARC_LEON
+
 menuconfig USB_SUPPORT
 	bool "USB support"
 	depends on HAS_IOMEM
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -625,14 +625,6 @@ config USB_UHCI_ASPEED
        bool
        default y if ARCH_ASPEED
 
-config USB_UHCI_BIG_ENDIAN_MMIO
-	bool
-	default y if SPARC_LEON
-
-config USB_UHCI_BIG_ENDIAN_DESC
-	bool
-	default y if SPARC_LEON
-
 config USB_FHCI_HCD
 	tristate "Freescale QE USB Host Controller support"
 	depends on OF_GPIO && QE_GPIO && QUICC_ENGINE


