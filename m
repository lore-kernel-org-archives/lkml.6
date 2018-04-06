Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1404550-1523021767-2-1733990477521814486
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523021766; b=R+DXsMt2WyBa8ItRSO6nnegXkrvwjAO7BrRVtyYsqVxry9ep9a
    6utv1ViiAEscYzVxfT329QhKCyDCeQF5xEEp5QRr1iCIOiWOVIrGPh6jlJGpbAF+
    FebDkcYmM5CfnnKT36npUwZ4KWXehQITHylfaZOFDCkWHRy2euQWE9Q+kvuQ8owC
    7rb8bSgWsPW4nsoMnpOFrvgkIDcbwcbphgMAMbZ213STGQsAfzxJd7sXep/Z8ZyN
    OjCgXDkQ1k5ftHzZt5k+O9B7krzMt+LCiTiZvIBsxexXI4hBkaQ5Uz/rp8oYx20y
    O55/30cOm7Ez+q2OIpb6CLcPmNo4+H9TYGQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523021766; bh=/s5vwO+xlTyHAu021x1jF36VgizMG9
    +79OLXNmgD5JU=; b=dGiguzgOa7o1os/Iv2UFdkCa4J+nnB0IemmTht/QN9efqp
    fPISvj9sFgefOub2OdLXUOGd9i6MM22Wcqc3HsQqlphGFxZ1hhSQiJ1F8yEzFK8a
    n8uKmiJDsYUEvNE497UvfBnpA6yym5dnnFCFFri7qL3vsOBud/5eXUviApIekRbW
    YdRKq+ZbPQTWXHEw0c1wB/K1p2P4aIAv1TJdfLCu8SsfYZbPJ8bGwLLe0t3wER63
    7GYqV2/O8pkS67N/naiCdvIfAZ3B6Madh8vHu78GIG1nOF4WvcKQgf/l7FPOdOwU
    Aj75eTvB8IFOkFUc0xvBXrQ+IFtt46ofTEAKRsyQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKoE4ybmAi973K83RwiGba6X/rF1BLQ9RolWA5otW1HT/MJUUSQYlkfxd8+Secmv58vsRz2nlgkkE94zK2o063vppytpjM12LV9jzsjrhR5akQ2LJRy8
    u6u/CVGCmS5vXBbL0z7pQ2b2zkxbcw8peWNoywzdm5ZmJDvuNBkx25ku9RJju9yPEONnPplQbP+x+QTi6AAGoh5QF8enWyzeE6QDk4Oz5Y2kbsKq3/PNM2Yw
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=ttLlOQO2AAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=ePzkv_ZzBSQ0y2wHZ-EA:9
    a=QEXdDO2ut3YA:10 a=1BJeXTq6bvZE9X1NrNaC:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756144AbeDFNgE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 09:36:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59032 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756138AbeDFNgB (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Apr 2018 09:36:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alexander Gerasiov <gq@redlab-i.ru>
Subject: [PATCH 4.9 082/102] parport_pc: Add support for WCH CH382L PCI-E single parallel port card.
Date: Fri,  6 Apr 2018 15:24:03 +0200
Message-Id: <20180406084342.985576428@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180406084331.507038179@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
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

From: Alexander Gerasiov <gq@redlab-i.ru>

commit 823f7923833c6cc2b16e601546d607dcfb368004 upstream.

WCH CH382L is a PCI-E adapter with 1 parallel port. It is similair to CH382
but serial ports are not soldered on board. Detected as
Serial controller: Device 1c00:3050 (rev 10) (prog-if 05 [16850])

Signed-off-by: Alexander Gerasiov <gq@redlab-i.ru>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/parport/parport_pc.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2646,6 +2646,7 @@ enum parport_pc_pci_cards {
 	netmos_9901,
 	netmos_9865,
 	quatech_sppxp100,
+	wch_ch382l,
 };
 
 
@@ -2708,6 +2709,7 @@ static struct parport_pc_pci {
 	/* netmos_9901 */               { 1, { { 0, -1 }, } },
 	/* netmos_9865 */               { 1, { { 0, -1 }, } },
 	/* quatech_sppxp100 */		{ 1, { { 0, 1 }, } },
+	/* wch_ch382l */		{ 1, { { 2, -1 }, } },
 };
 
 static const struct pci_device_id parport_pc_pci_tbl[] = {
@@ -2797,6 +2799,8 @@ static const struct pci_device_id parpor
 	/* Quatech SPPXP-100 Parallel port PCI ExpressCard */
 	{ PCI_VENDOR_ID_QUATECH, PCI_DEVICE_ID_QUATECH_SPPXP_100,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, quatech_sppxp100 },
+	/* WCH CH382L PCI-E single parallel port card */
+	{ 0x1c00, 0x3050, 0x1c00, 0x3050, 0, 0, wch_ch382l },
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, parport_pc_pci_tbl);
