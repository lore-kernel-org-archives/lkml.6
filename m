Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3443661-1520826737-2-2338603597092522324
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520826737; b=FUyL0gyGYWNSjyi2E9n0qCVJ+G94R9sP0xrWwFER2li5kab
    BxpxDWHekclAQqNsrsMBLbkH7NkuAuPdhmNf4wvdm7LuUmjUhh8EUqiSUrYN37qr
    eQgFzTIHQDxjs1gbDwIZH3Px/6fW1qE4KdXhubXCdxIprYX32QY+EFz9pxqsUElu
    f1x7/1byzoTTLLMz5mCk5socAw5JDtxivZWMOqBiUNYhWZdN6faRhZ83T8JkcESQ
    xZPJz063NDEzAqtEcuZlgFsrabV58L7PqIsxVLz5qey8Fwxp2JIlkZctVxW8D9Yn
    AeLYCwa5Pcr7GqhHMcinbwjWwUUKNrzexPTKkZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520826737; bh=QwAtpEUjsucDNdhBVbh
    giHacG/PMhuRqpc3nXe6seMQ=; b=iaiucQSm5B580Pl83H/b2bY3qL30ElwrMyw
    AZBFMO/bsA7EohcE1UTM3FaOUlcNtC36PVqS1pwjaciwXCoPOUy2jOwrmpGOuBLG
    TyWLw75UjZkPrAL+oF/Iocl7tOmiGbjWObVFm7m1GWt07bZGI9Iiu/7FLVeKIuGx
    Oq7rGY42bR+fF2EyS8hR0z/bSsaoang2uQGvDcnrwXUXf8PrKB4XbzQJD+W4L1Oi
    LAgskbzWhjTP56RWwn43Cg9CnQK3yXYXpPXGUVnEXjzSLV8fSLmVw7BLkwcCh65s
    mCiMTPUaof9jcHr7wkxcC3IYfqirV9C/sYmdxMaQsdsd2AqlJJQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932729AbeCLDwB (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:52:01 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41032 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932566AbeCLDHj (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:39 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Yusuke Goda" <yusuke.goda.sx@renesas.com>,
        "Kuninori Morimoto" <kuninori.morimoto.gx@renesas.com>,
        "Felipe Balbi" <balbi@ti.com>,
        "Takashi Yoshii" <takashi.yoshii.zj@renesas.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.813040390@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 013/104] usb: renesas_usbhs: tidyup original
 usbhsx_for_each_xxx macro
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

commit 925403f425a4a9c503f2fc295652647b1eb10d82 upstream.

Current usbhsx_for_each_xxx macro will read out-of-array's
memory after last loop operation.
It was not good C language operation, and the binary which was
compiled by (at least) gcc 4.8.1 is broken
This patch tidyup these issues

Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Reviewed-by: Takashi Yoshii <takashi.yoshii.zj@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/renesas_usbhs/mod_gadget.c | 6 +++---
 drivers/usb/renesas_usbhs/mod_host.c   | 6 +++---
 drivers/usb/renesas_usbhs/pipe.h       | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

--- a/drivers/usb/renesas_usbhs/mod_gadget.c
+++ b/drivers/usb/renesas_usbhs/mod_gadget.c
@@ -76,9 +76,9 @@ struct usbhsg_recip_handle {
 		struct usbhsg_gpriv, mod)
 
 #define __usbhsg_for_each_uep(start, pos, g, i)	\
-	for (i = start, pos = (g)->uep + i;	\
-	     i < (g)->uep_size;			\
-	     i++, pos = (g)->uep + i)
+	for ((i) = start;					\
+	     ((i) < (g)->uep_size) && ((pos) = (g)->uep + (i));	\
+	     (i)++)
 
 #define usbhsg_for_each_uep(pos, gpriv, i)	\
 	__usbhsg_for_each_uep(1, pos, gpriv, i)
--- a/drivers/usb/renesas_usbhs/mod_host.c
+++ b/drivers/usb/renesas_usbhs/mod_host.c
@@ -131,9 +131,9 @@ static const char usbhsh_hcd_name[] = "r
 	__usbhsh_for_each_hpipe(0, pos, hpriv, i)
 
 #define __usbhsh_for_each_udev(start, pos, h, i)	\
-	for (i = start, pos = (h)->udev + i;		\
-	     i < USBHSH_DEVICE_MAX;			\
-	     i++, pos = (h)->udev + i)
+	for ((i) = start;						\
+	     ((i) < USBHSH_DEVICE_MAX) && ((pos) = (h)->udev + (i));	\
+	     (i)++)
 
 #define usbhsh_for_each_udev(pos, hpriv, i)	\
 	__usbhsh_for_each_udev(1, pos, hpriv, i)
--- a/drivers/usb/renesas_usbhs/pipe.h
+++ b/drivers/usb/renesas_usbhs/pipe.h
@@ -54,9 +54,9 @@ struct usbhs_pipe_info {
  * pipe list
  */
 #define __usbhs_for_each_pipe(start, pos, info, i)	\
-	for (i = start, pos = (info)->pipe + i;		\
-	     i < (info)->size;				\
-	     i++, pos = (info)->pipe + i)
+	for ((i) = start;						\
+	     ((i) < (info)->size) && ((pos) = (info)->pipe + (i));	\
+	     (i)++)
 
 #define usbhs_for_each_pipe(pos, priv, i)			\
 	__usbhs_for_each_pipe(1, pos, &((priv)->pipe_info), i)
