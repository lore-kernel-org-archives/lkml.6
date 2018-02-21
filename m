Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1474421-1519217774-2-12099101771453902442
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
    t=1519217773; b=Og/jzeNZVgauOLQGAhpmeDD2pizL/oBKaiB96EV+IFUHYhd
    0zSYIFjFRNb2IQhztB0uWO1KeL/zX+XcM70fOwhQV0oLaoyg9XNDRpvajeSTRPiK
    kpo0ew9L2+a0nQYHvrjAOmum9c0w/9pgiK42ywvmk9Q01COmwX472Gv9sHux+gMx
    PzGrCDqZA+2ReRhOPuDrYhOLvU4w5gG6Y6aAyYF/qGXzM15FORbIrsm1+qS5BITL
    3XjRxCliNYrSKhVWd7TxNj17oI+Y0iYuqR4yXlH5SEr/SQL+4FPyRGuWXTe4RZ6w
    YXgeKiSyAfNZ3NgipgzS8vIFRgCbn7mrlH9LrVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519217773; bh=i71+13xTy0/AyKNnv4dBZe3DUR
    EbxRmsFaR8nW5cJfM=; b=CbUotkrZC9sPAFZCybxdM2jbIePBoa+bwrb1NVq3T7
    k+RQnPe3fmQlufRyJmF7hnHQYpOyYzF4yaartLbCvIJQK8YupMLG1ynL8wwywikb
    TzbXe7j/PNZxKvR8c0sBb/lCWhMA2JsHnEUzkQ1NbURTvD8x++AiF2CP4II6adDr
    A5pxVH+2siZKdTKHIEzHOza1ngucr/L2a5flsdHoG6vJNNqlQhO/YYBHPJBGWE8B
    FKtgUE9CKWgevt+963gOwo9feh8Z/O1bKZ71RuUcbA0AOHFFrd05SaP1zmWbIoKH
    inHU4hwWUvxgOenR8AeeFbWdmlhyNrfeoLWYg3KRGLnw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934394AbeBUM4L (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Feb 2018 07:56:11 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:34664 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932700AbeBUM4I (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Feb 2018 07:56:08 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 4.9 12/77] MIPS: Fix typo BIG_ENDIAN to CPU_BIG_ENDIAN
Date: Wed, 21 Feb 2018 13:48:21 +0100
Message-Id: <20180221124432.667118278@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
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

From: Corentin Labbe <clabbe.montjoie@gmail.com>

commit 2e6522c565522a2e18409c315c49d78c8b74807b upstream.

MIPS_GENERIC selects some options conditional on BIG_ENDIAN which does
not exist.

Replace BIG_ENDIAN with CPU_BIG_ENDIAN which is the correct kconfig
name. Note that BMIPS_GENERIC does the same which confirms that this
patch is needed.

Fixes: eed0eabd12ef0 ("MIPS: generic: Introduce generic DT-based board support")
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Reviewed-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.9+
Patchwork: https://patchwork.linux-mips.org/patch/18495/
[jhogan@kernel.org: Clean up commit message]
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/Kconfig |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -112,12 +112,12 @@ config MIPS_GENERIC
 	select SYS_SUPPORTS_MULTITHREADING
 	select SYS_SUPPORTS_RELOCATABLE
 	select SYS_SUPPORTS_SMARTMIPS
-	select USB_EHCI_BIG_ENDIAN_DESC if BIG_ENDIAN
-	select USB_EHCI_BIG_ENDIAN_MMIO if BIG_ENDIAN
-	select USB_OHCI_BIG_ENDIAN_DESC if BIG_ENDIAN
-	select USB_OHCI_BIG_ENDIAN_MMIO if BIG_ENDIAN
-	select USB_UHCI_BIG_ENDIAN_DESC if BIG_ENDIAN
-	select USB_UHCI_BIG_ENDIAN_MMIO if BIG_ENDIAN
+	select USB_EHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
+	select USB_EHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
+	select USB_OHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
+	select USB_OHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
+	select USB_UHCI_BIG_ENDIAN_DESC if CPU_BIG_ENDIAN
+	select USB_UHCI_BIG_ENDIAN_MMIO if CPU_BIG_ENDIAN
 	select USE_OF
 	help
 	  Select this to build a kernel which aims to support multiple boards,
