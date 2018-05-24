Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1691122-1527154970-2-16713801359319117126
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES endasv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527154970; b=Y389zDG8CetwrzNutA3Q22SXSG+RpP11Q3N0+/nmfkB7nAfMc9
    gU1ruGpz8EXbAm4O/tdbKhpuPQKuwK73J1PhqIUHAuZSjFBycKlXG+iF8DOf8M45
    q5rUSiqMAdhdSq0hG86rFKS8T6wnzeVhGHNTRffctR54kj1CH+vhEJLix4jDJmmg
    Gu8TtVBFHoyv1kyn1U0+qDyDLheaCnc8VMHcuA9BuKh2Ts8UpFTdD267viBNrol5
    Y7BIdaux070eixpiwFtaVSOOWHLFB+AiUDw+QkSFkhqks1tLJqQ3ohMgbr9d8vCK
    Yc6H8Yrgp29wpLC4fhs+c8R/KaeXADw1dlfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527154970; bh=gziWDr3OUZr0xaw4Xp+0YpleaUzRXS
    etadjW4vRhTxg=; b=nSfai6mudv7S7wEMSySdBwxxF/G53FbhiD8B/ZQCmZTTdf
    gFyHFSQBPII+JMLxAHsdFPvwAim4Pzy8m+3cPcM0yiIqO4tCFPkPwa2Tu53zjMP4
    1qipNpF151VjGQoGINMUw3mNYmnz6oDsdeAeZtkwhvvIi9qxSSGYCx6uegWBI507
    2Oj0Pn0KeogVnVjoWh6JgfOmrjEO/JhSoF2A+NCHfJnI2SKhRSdW2c9IH6cgVYQF
    CbTIqGYuM+BZsOvQQNpzIpCTmllMjshHD7dhrD+FgwkidpWZkq9pEZChxddxV2rM
    EhRj2DeDDO2vbOTUelv5SniDDVv/QDYzhzNlH5vw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=a0cG34i3 x-bits=1024 x-keytype=rsa
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
      header.i=@kernel.org header.b=a0cG34i3 x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfPlxBCI6TMgt14J5ogxEA58UGMDaEV3DTwgER5VzBr9NkSRi21mbjbofBnc8R4G10O/bh7JfPKjQgfMLClOGyzKalnYL8lXlExbcv3WhG2/lS9w7PKmr
    i5U/ZkfpuRGX6LNw4lw4P1o4WXZPF2ZMC7BtEdv6TMPZZsOMsAgU+KGDYYfaBJfI8Jb2jLaeQ1Lqo7uc6v11jCS1cFCio0uNqOrYcnjJ6o0rl+Ww2Pz428S/
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=hD80L64hAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=KslZaVS1h0vLkMwhe8wA:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966148AbeEXJmp (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 05:42:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54282 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966374AbeEXJmj (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:42:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH 3.18 23/45] usbip: usbip_host: refine probe and disconnect debug msgs to be useful
Date: Thu, 24 May 2018 11:38:31 +0200
Message-Id: <20180524093123.627328362@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093120.599252450@linuxfoundation.org>
References: <20180524093120.599252450@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit 28b68acc4a88dcf91fd1dcf2577371dc9bf574cc upstream.

Refine probe and disconnect debug msgs to be useful and say what is
in progress.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/stub_dev.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -317,7 +317,7 @@ static int stub_probe(struct usb_device
 	struct bus_id_priv *busid_priv;
 	int rc;
 
-	dev_dbg(&udev->dev, "Enter\n");
+	dev_dbg(&udev->dev, "Enter probe\n");
 
 	/* check we should claim or not by busid_table */
 	busid_priv = get_busid_priv(udev_busid);
@@ -415,7 +415,7 @@ static void stub_disconnect(struct usb_d
 	struct bus_id_priv *busid_priv;
 	int rc;
 
-	dev_dbg(&udev->dev, "Enter\n");
+	dev_dbg(&udev->dev, "Enter disconnect\n");
 
 	busid_priv = get_busid_priv(udev_busid);
 	if (!busid_priv) {
