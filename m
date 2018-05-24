Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1807417-1527159401-2-6536377275847196756
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
    1527159400; b=LlmhjwRWl0/DKLb2KbbJHRPmVW7jhWTBzuRUVpa4A6VkQyj4kn
    6rNOSbP+Z2JByCsE850UJMKE6g4AwlHAIC45hkwTmDVbo5INWK8emN8FmTxneWRL
    jJABU5m4Rvi4zDR5FjAiLbF0iD2KHa8wYGb/amBNQmNUfXNmlO1jaOCWxt5hrCPP
    KufyLsLdvvodbYV365x3op0T1RPViPAAFOxoaKxCAvU9kMnwjCjnUwjJ/R1QHDKI
    BjX7l8/cFIPwHwvsn0ZO/sszRh/9Qr5QT7CStjmLoGgG2rm2I7lXvinFUR3Rumdu
    Cu0tmhKAASh7qaf38f9MbEOqabedET/oLSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527159400; bh=2I0B3s2YYT/X2PTvo8t7AzS69c/KY1
    h0nGysse2VRv8=; b=WsDXwMdBT5TdB+pxn5ry1tAPXLrmDWAxO9S2lK5H5qWC6f
    4DJr19cN1bgrD4nOyWGbnClp2em3BNzJpfB0KgleaOH27APTYSNWiKyaQMkjp1rD
    gb9rCMFBwqUryqnGsq1H3ZdbxgYAfczMH4zNK8tfjWPtTFiXfw7UFxCOu3RJ03Eo
    yXJc4C+cWXNOQk2isd0dY7VcP5S9aIZwaaQlkKiaT5qcQWYbBk/EmGjNFDNzBaB8
    vyB+RAT9StCybwlbIe8JHGGYgyovp55NLevKeZmzQrBvVUFzzfuLwpxYtNqDnM+E
    voT3j00M/xVECNloY+gDwZW2XSr8pz32rRJXELmw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=dCWQ8z5l x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=dCWQ8z5l x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfK4od7v2nEDDNme7YzXXF1tqJcUGZojxMCjeOXyBag0RZNeT9t47gZDQlRwIwzyimn3uGIUbGj/pITdubTzyZ9+g+JETMcGLcxDbgVIByX3wPN6C9yMF
    ce2QSYDBIYZZ0jwBloaaNBlBBsmuFY/yuLQqKr3tSejKdUTNsy2tsEbRiJOWXzIXlVLZ8fvD3NKf1nU9AsRX+ZwiDuy1ln6q0AbvesrFvhUTHHKpQDy7+PQJ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=fAlHiBRuNEyz2WEnGOcA:9
    a=stblkIYUYUv5R3Pw:21 a=b8rDu3MFoQzz_wES:21 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030360AbeEXK4Z (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030321AbeEXJ4a (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:56:30 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 084/165] xhci: Show what USB release number the xHC supports from protocol capablity
Date: Thu, 24 May 2018 11:38:10 +0200
Message-Id: <20180524093625.416175685@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093621.979359379@linuxfoundation.org>
References: <20180524093621.979359379@linuxfoundation.org>
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

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit 0ee78c101425aae681c631ba59c6ac7f44b1d83a ]

xhci driver displays the supported xHC USB revision in a message during
driver load:

"Host supports USB 3.1 Enhanced SuperSpeed"

Get the USB minor revision number from the xhci protocol capability.
This will show the correct supported revisions for new USB 3.2 and later
hosts

Don't rely on the SBRN (serial bus revision number) register, it's often
showing 0x30 (USB3.0) for hosts that support USB 3.1

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -4764,6 +4764,7 @@ int xhci_gen_setup(struct usb_hcd *hcd,
 	 * quirks
 	 */
 	struct device		*dev = hcd->self.sysdev;
+	unsigned int		minor_rev;
 	int			retval;
 
 	/* Accept arbitrarily long scatter-gather lists */
@@ -4791,12 +4792,19 @@ int xhci_gen_setup(struct usb_hcd *hcd,
 		 */
 		hcd->has_tt = 1;
 	} else {
-		/* Some 3.1 hosts return sbrn 0x30, can't rely on sbrn alone */
-		if (xhci->sbrn == 0x31 || xhci->usb3_rhub.min_rev >= 1) {
-			xhci_info(xhci, "Host supports USB 3.1 Enhanced SuperSpeed\n");
+		/*
+		 * Some 3.1 hosts return sbrn 0x30, use xhci supported protocol
+		 * minor revision instead of sbrn
+		 */
+		minor_rev = xhci->usb3_rhub.min_rev;
+		if (minor_rev) {
 			hcd->speed = HCD_USB31;
 			hcd->self.root_hub->speed = USB_SPEED_SUPER_PLUS;
 		}
+		xhci_info(xhci, "Host supports USB 3.%x %s SuperSpeed\n",
+			  minor_rev,
+			  minor_rev ? "Enhanced" : "");
+
 		/* xHCI private pointer was set in xhci_pci_probe for the second
 		 * registered roothub.
 		 */
