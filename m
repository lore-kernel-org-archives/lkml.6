Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2483311-1525767563-2-16891669432417762517
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
    1525767562; b=Fzfo+AkNqlF0vtg5QVLec9SeI1bmVGzW8nQq4qTXngHzf1s0oZ
    gReqqx2gT15nyWcH59C6HCPmamsPrrl6JHx0fNOoIX1OlSNPdTeCNgBwSgsIGy40
    RohXWy06N245m55pP8/pDwSulhLPQ7Kn/orFrlgaDeaKewfcY7314pG78znreA9P
    c19o6ZiH9STx9sxYIWmpMCR17HzWtgPrUyZYF6H3FPJWRvmt/ox63X7rlM8Y5BCe
    1LVEJnUQSvSBIwyDamMfY065RkAc8/iw+2ZVeGRK7OHo2twPdDGZ8VfkeeLts740
    hbiKfn+MULvZueHvditHm2v086JxDEqgxmqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525767562; bh=4KUK0ItAKLjxwmMeMc9Pvg45lC3gKr
    GODd/IuwYyN3E=; b=I3Byhssu7v+dqEKtzI2WtZ+lrmdfM05c46tsLj3dFGUVHB
    P2snuXG6K8u6laKudx47yvIYu2qmhY1O1mYmub/IBysOInn780HLhz8W5qwKDZyX
    z8ecwC/sGQssBqdVZZjKliKRgD40rKnsVudDxRj4PHNTnHBbTS9+l110cv+F4Fmv
    Vcas1R6Nc+zi+rKLSRLHwNxBIJIMI8EtBVSKGUotSGny5qlPQqrm/KwbqGVrMI9w
    408kYj7yk3TArawPHx+IK/bXAxYTXyDPIXywDL14p2cc2wjW1SWfcbNS6dLFl5Df
    n22esxrZdtvFX3MTO1w8JukGCe3WYekupYex+vZQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=zsqgGMTV x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=zsqgGMTV x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfFYchY/KAso1NH2rj97iEepbknlOD0PnIuu8jUqbVW5SF95tmpM6SYBRfG5PVv7HQfTl3M1MvjJsiigJUfMfnNRWGKUGrzywRLEKjs3uO8AGOuVUsY+y
    EyOt3wbuz+YE+5/NAeZKCEuZxs7cUHI5YgaaVSQ3HwqwI0afnelUAASELvP25CniYw6nZhaZDEHGOPsjwH2TFfEtr0XcG/v8RFZl63fHNcrQ0uey1Cn0iouM
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=2hd5eYSZck0yHY4QgSwA:9
    a=QEXdDO2ut3YA:10 a=aeg5Gbbo78KNqacMgKqU:22 a=AjGcO6oz07-iQ99wixmX:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933035AbeEHISB (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 04:18:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932999AbeEHIR4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 8 May 2018 04:17:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.9 30/32] usb: musb: trace: fix NULL pointer dereference in musb_g_tx()
Date: Tue,  8 May 2018 10:11:10 +0200
Message-Id: <20180508074013.539917378@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508074008.800421598@linuxfoundation.org>
References: <20180508074008.800421598@linuxfoundation.org>
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

From: Bin Liu <b-liu@ti.com>

commit 9aea9b6cc78d2b99b23d84fb2e0bc6e464c6569e upstream.

The usb_request pointer could be NULL in musb_g_tx(), where the
tracepoint call would trigger the NULL pointer dereference failure when
parsing the members of the usb_request pointer.

Move the tracepoint call to where the usb_request pointer is already
checked to solve the issue.

Fixes: fc78003e5345 ("usb: musb: gadget: add usb-request tracepoints")
Cc: stable@vger.kernel.org # v4.8+
Signed-off-by: Bin Liu <b-liu@ti.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/musb_gadget.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -442,7 +442,6 @@ void musb_g_tx(struct musb *musb, u8 epn
 	req = next_request(musb_ep);
 	request = &req->request;
 
-	trace_musb_req_tx(req);
 	csr = musb_readw(epio, MUSB_TXCSR);
 	musb_dbg(musb, "<== %s, txcsr %04x", musb_ep->end_point.name, csr);
 
@@ -481,6 +480,8 @@ void musb_g_tx(struct musb *musb, u8 epn
 		u8	is_dma = 0;
 		bool	short_packet = false;
 
+		trace_musb_req_tx(req);
+
 		if (dma && (csr & MUSB_TXCSR_DMAENAB)) {
 			is_dma = 1;
 			csr |= MUSB_TXCSR_P_WZC_BITS;
