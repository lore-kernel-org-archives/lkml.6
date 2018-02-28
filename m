Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519834296-2-2821877249781651588
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519834295; b=oggB5E5rMXSXNpZbUPQ9knZMzZMRM6qOXE8M3zEeSW5T982
    GWqgzSwl3EdPVAJzmMhy9UeAA8wTW55Gge57SCn3I46X8vlOgDaEoSYJlGUpcyNh
    aZHbtqynpu5UclMIbYggIWSK4JkmZWPfsGc2fDupLcU0Px1IofTbSmeCTqbDthAC
    ur/b3ZANuRdKURzeR45wgO4uB/EV4hA1qfURTVrbOCpKk2ZhwSfncVmicENisLVG
    eS8iHWMlKEL/RhT5MXCLoSnirLppXiM8ULoUa5KS06wfcp+CbWAaA83ot1FXt5Kc
    9x9Q5kyhn7jGkv7kFtqxpiihzI1c1s2HhUl7Aiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834295; bh=BOl7NGfO8+soNz2zeJD
    KIp6gdIxLaC5TTV2UiV8jbZo=; b=aE8+ThC4ZjgTACdSYwjxMsyKL0SEpZuvO18
    II/YNGB2p/6uccZrwpsATN3s6HhblpbBLjHskoshlIUZDw2UV32zSh05RsX1gqJK
    PAsUfvinYdbrex5BZAVWGMK9Jt3BPKUVupLDN/PmRbLbo2xcrAESwc5VOV+B4Wzp
    wDqfPb9zfusWYAI8dzrvshUYYXBKutjP9jyCSEt0b1Tienh0uqPKcNrqeJSbOf5z
    cdqcUjCdJ4CNwFV+/1NlsVB9cN3f3YktSpNTCt9GShW62I+Pa1SAWpWDTcDqd623
    NEScvpRhaSn0HeDrr4Ci78tiGVp3W+OSM59IL21PtsszVEA4zog==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933079AbeB1QIn (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:08:43 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34958 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932977AbeB1QIm (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:08:42 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Shuah Khan" <shuahkh@osg.samsung.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.713344213@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 164/254] usbip: remove kernel addresses from usb
 device and urb debug msgs
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan <shuahkh@osg.samsung.com>

commit e1346fd87c71a1f61de1fe476ec8df1425ac931c upstream.

usbip_dump_usb_device() and usbip_dump_urb() print kernel addresses.
Remove kernel addresses from usb device and urb debug msgs and improve
the message content.

Instead of printing parent device and bus addresses, print parent device
and bus names.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/staging/usbip/usbip_common.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

--- a/drivers/staging/usbip/usbip_common.c
+++ b/drivers/staging/usbip/usbip_common.c
@@ -103,7 +103,7 @@ static void usbip_dump_usb_device(struct
 	dev_dbg(dev, "       devnum(%d) devpath(%s) usb speed(%s)",
 		udev->devnum, udev->devpath, usb_speed_string(udev->speed));
 
-	pr_debug("tt %p, ttport %d\n", udev->tt, udev->ttport);
+	pr_debug("tt hub ttport %d\n", udev->ttport);
 
 	dev_dbg(dev, "                    ");
 	for (i = 0; i < 16; i++)
@@ -136,12 +136,8 @@ static void usbip_dump_usb_device(struct
 	}
 	pr_debug("\n");
 
-	dev_dbg(dev, "parent %p, bus %p\n", udev->parent, udev->bus);
-
-	dev_dbg(dev,
-		"descriptor %p, config %p, actconfig %p, rawdescriptors %p\n",
-		&udev->descriptor, udev->config,
-		udev->actconfig, udev->rawdescriptors);
+	dev_dbg(dev, "parent %s, bus %s\n", dev_name(&udev->parent->dev),
+		udev->bus->bus_name);
 
 	dev_dbg(dev, "have_langid %d, string_langid %d\n",
 		udev->have_langid, udev->string_langid);
@@ -249,9 +245,6 @@ void usbip_dump_urb(struct urb *urb)
 
 	dev = &urb->dev->dev;
 
-	dev_dbg(dev, "   urb                   :%p\n", urb);
-	dev_dbg(dev, "   dev                   :%p\n", urb->dev);
-
 	usbip_dump_usb_device(urb->dev);
 
 	dev_dbg(dev, "   pipe                  :%08x ", urb->pipe);
@@ -260,11 +253,9 @@ void usbip_dump_urb(struct urb *urb)
 
 	dev_dbg(dev, "   status                :%d\n", urb->status);
 	dev_dbg(dev, "   transfer_flags        :%08X\n", urb->transfer_flags);
-	dev_dbg(dev, "   transfer_buffer       :%p\n", urb->transfer_buffer);
 	dev_dbg(dev, "   transfer_buffer_length:%d\n",
 						urb->transfer_buffer_length);
 	dev_dbg(dev, "   actual_length         :%d\n", urb->actual_length);
-	dev_dbg(dev, "   setup_packet          :%p\n", urb->setup_packet);
 
 	if (urb->setup_packet && usb_pipetype(urb->pipe) == PIPE_CONTROL)
 		usbip_dump_usb_ctrlrequest(
@@ -274,8 +265,6 @@ void usbip_dump_urb(struct urb *urb)
 	dev_dbg(dev, "   number_of_packets     :%d\n", urb->number_of_packets);
 	dev_dbg(dev, "   interval              :%d\n", urb->interval);
 	dev_dbg(dev, "   error_count           :%d\n", urb->error_count);
-	dev_dbg(dev, "   context               :%p\n", urb->context);
-	dev_dbg(dev, "   complete              :%p\n", urb->complete);
 }
 EXPORT_SYMBOL_GPL(usbip_dump_urb);
 
