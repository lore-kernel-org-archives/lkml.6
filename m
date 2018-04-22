Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2630128-1524406276-2-3155727766965668880
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
    1524406276; b=U1I/RwwHi3lxEQDAYa6RB51w9cG5WzvKHlG5vg5FagMfnBW1pF
    Qw4+k4teacBRr0B/yBOucygISgVo+XDGcFlD+FQ4pwK/IQt+NR07mB/JYhYK9niX
    wafQDlSJgpFg2tejEFW2T+HS0p3MeM/jucnuDTwIlvh5oLfRP/5ZNkicj5VMVMye
    1XieKyuYxwLe0VjkJhAt+0pth1JBPBovAk1PquhDm+JfAG//usZnKvOpkFYHqWa3
    oTiQqEEfU8omH4hvJJkZBFlxVY8evnWr8QIJ7JAbrK/vd0DTgLu9/v9w758qr9d2
    V4XU1XV5Yvtc8Qt2+1ww3EZSApUGoaIspsiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524406276; bh=NtIifyQv6KPb/3aRrNRoHYWVhpmVCX
    dyanE/dQXjL8E=; b=f5EE3DU/BiBdaKD1XeVaScoyHut+pZpbRH1mbTkMSFh8Wn
    HSL1RMng4pp4HIbGNrCgq8GOaYJiccrpSL0QK5P4KJG2POS2H7Rp2jpK2Dy8TRT+
    jlfM6qI87MRmaV8Tlvf9Z/bxTeaNBHpPMD1eogjg4f+N6viS1zNy0d1OmPjz3WUb
    Bxeo5m0ss+cg8rXXbcZbc+TefNMmNhew3E0YH2Hdm1XPSMxbmlOIZ0bfRDTZdK6U
    gLmdZgAX81duE10UQqucd1iBMrBwUoUADLetI7NYPXie4h5W4g7uPTlXR0q/CAv+
    EpiucJ+dzinmhR/B2hzPALaVh0ZLuqT8UhEQMi2g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfD3QplmaiQEOGZBfKVL1J0+j2CwMCsiCHNry3Lv1I5onNDFA9Hf2mKcIPGaDY6Y7uBqhM43xXgZezapAX1hdQmSIB7uThQLzaUeIZCk+5I7ulU7JjrRX
    s1TpafYuuYPA0T9I5GBabWum5ZEgmdDxo0c+WtV1jA557Ug0o5j2znyLO7F91iHjY9VVTy/2T6Uk1jOZeLI5AwZHk2z/uDFma4PuHeZmzdFPqOM4Ye6n5xgx
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=sozttTNsAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=FP32eTSNluC7FgubNOMA:9
    a=l_6TX5hoT36MldPN:21 a=PEUQkDWFTaGcJO7T:21 a=QEXdDO2ut3YA:10
    a=aeg5Gbbo78KNqacMgKqU:22 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756231AbeDVOLM (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 10:11:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54212 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756019AbeDVOLK (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 10:11:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Bin Liu <b-liu@ti.com>
Subject: [PATCH 4.9 10/95] usb: musb: gadget: misplaced out of bounds check
Date: Sun, 22 Apr 2018 15:52:39 +0200
Message-Id: <20180422135210.847117081@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
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

From: Heinrich Schuchardt <xypron.glpk@gmx.de>

commit af6f8529098aeb0e56a68671b450cf74e7a64fcd upstream.

musb->endpoints[] has array size MUSB_C_NUM_EPS.
We must check array bounds before accessing the array and not afterwards.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Bin Liu <b-liu@ti.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/musb/musb_gadget_ep0.c |   14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

--- a/drivers/usb/musb/musb_gadget_ep0.c
+++ b/drivers/usb/musb/musb_gadget_ep0.c
@@ -114,15 +114,19 @@ static int service_tx_status_request(
 		}
 
 		is_in = epnum & USB_DIR_IN;
-		if (is_in) {
-			epnum &= 0x0f;
+		epnum &= 0x0f;
+		if (epnum >= MUSB_C_NUM_EPS) {
+			handled = -EINVAL;
+			break;
+		}
+
+		if (is_in)
 			ep = &musb->endpoints[epnum].ep_in;
-		} else {
+		else
 			ep = &musb->endpoints[epnum].ep_out;
-		}
 		regs = musb->endpoints[epnum].regs;
 
-		if (epnum >= MUSB_C_NUM_EPS || !ep->desc) {
+		if (!ep->desc) {
 			handled = -EINVAL;
 			break;
 		}
