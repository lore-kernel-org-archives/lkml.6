Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-947063-1521799356-2-5885714528669201802
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521799355; b=QRH1PrfOqZ2xx8MbloVVW+hJHSIrc7ooPMyVJXXj7+RRNFD
    gAoLdS8fZhV4j9R96JV3VPUH64dh9gYRjjN9qAHrAyBFPA21wqAv4zK5YdTLIoUe
    aC79b90SAdBRu2qLk2GMZ0mMFZT7w6sPoe2xQ4rF0K5wNB1Fm4T1Qf5Rd7Q07W1r
    /hJpIi394ixKemBYGoiqpSYILXmOD2W7S8sYeQOZL5o1rCKjbxz00fohDaJSVZFt
    Ro8XKvjyWIFoTHHb/PNjaXdeHr6lKmcZZhhpFDzZkFSsPCXKAv/KqTryAPUZuOVL
    dZS8qqhVMxfw/MmHIfHcJgzOgRnit9KfuRMebNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521799355; bh=8ZFJXBu4ztPL+hKRuf7Vi1K+ga
    OT123/8yy+QmBX2Pg=; b=v2U3OLteU0V9k4AKdRPTJUhGsZClRFTB65QmOV8MW5
    OKvlGUhXiNCj2Vi17wr1/eYbLiaOLN7m9BMxXJD62K1IRfxkekiwbeXQmeWZLVUB
    +dipAXWXPsEjHbatmNGD6QUJULUenedygMrwd37wwjg6drSAMUP/fZ8w/0oak7+l
    XFCicW8xkaUtPyZl9o6vTTpIjxSZdJ68Ds+QcmxEDwmcGRi4te3dgl+JQo4+6vJ5
    lw++6JazwZa9mja5wsOuuPGsqjqhIYT9E1AU5woszu6+7UBVIHwvh7+HmTeo7Ppf
    LsV+HhJdiE1u3j6mDDvK5gQsdD5WIHJLnChsXe/c0FIA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754228AbeCWKCd (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:02:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:38320 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752717AbeCWKC3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:02:29 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 39/77] vgacon: Set VGA struct resource types
Date: Fri, 23 Mar 2018 10:54:13 +0100
Message-Id: <20180323094144.890114577@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094142.260022880@linuxfoundation.org>
References: <20180323094142.260022880@linuxfoundation.org>
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

From: Bjorn Helgaas <bhelgaas@google.com>


[ Upstream commit c82084117f79bcae085e40da526253736a247120 ]

Set the resource type when we reserve VGA-related I/O port resources.

The resource code doesn't actually look at the type, so it inserts
resources without a type in the tree correctly even without this change.
But if we ever print a resource without a type, it looks like this:

  vga+ [??? 0x000003c0-0x000003df flags 0x0]

Setting the type means it will be printed correctly as:

  vga+ [io  0x000003c0-0x000003df]

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/alpha/kernel/console.c    |    1 +
 drivers/video/console/vgacon.c |   34 ++++++++++++++++++++++++++--------
 2 files changed, 27 insertions(+), 8 deletions(-)

--- a/arch/alpha/kernel/console.c
+++ b/arch/alpha/kernel/console.c
@@ -21,6 +21,7 @@
 struct pci_controller *pci_vga_hose;
 static struct resource alpha_vga = {
 	.name	= "alpha-vga+",
+	.flags	= IORESOURCE_IO,
 	.start	= 0x3C0,
 	.end	= 0x3DF
 };
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -422,7 +422,10 @@ static const char *vgacon_startup(void)
 		vga_video_port_val = VGA_CRT_DM;
 		if ((screen_info.orig_video_ega_bx & 0xff) != 0x10) {
 			static struct resource ega_console_resource =
-			    { .name = "ega", .start = 0x3B0, .end = 0x3BF };
+			    { .name	= "ega",
+			      .flags	= IORESOURCE_IO,
+			      .start	= 0x3B0,
+			      .end	= 0x3BF };
 			vga_video_type = VIDEO_TYPE_EGAM;
 			vga_vram_size = 0x8000;
 			display_desc = "EGA+";
@@ -430,9 +433,15 @@ static const char *vgacon_startup(void)
 					 &ega_console_resource);
 		} else {
 			static struct resource mda1_console_resource =
-			    { .name = "mda", .start = 0x3B0, .end = 0x3BB };
+			    { .name	= "mda",
+			      .flags	= IORESOURCE_IO,
+			      .start	= 0x3B0,
+			      .end	= 0x3BB };
 			static struct resource mda2_console_resource =
-			    { .name = "mda", .start = 0x3BF, .end = 0x3BF };
+			    { .name	= "mda",
+			      .flags	= IORESOURCE_IO,
+			      .start	= 0x3BF,
+			      .end	= 0x3BF };
 			vga_video_type = VIDEO_TYPE_MDA;
 			vga_vram_size = 0x2000;
 			display_desc = "*MDA";
@@ -454,15 +463,21 @@ static const char *vgacon_startup(void)
 			vga_vram_size = 0x8000;
 
 			if (!screen_info.orig_video_isVGA) {
-				static struct resource ega_console_resource
-				    = { .name = "ega", .start = 0x3C0, .end = 0x3DF };
+				static struct resource ega_console_resource =
+				    { .name	= "ega",
+				      .flags	= IORESOURCE_IO,
+				      .start	= 0x3C0,
+				      .end	= 0x3DF };
 				vga_video_type = VIDEO_TYPE_EGAC;
 				display_desc = "EGA";
 				request_resource(&ioport_resource,
 						 &ega_console_resource);
 			} else {
-				static struct resource vga_console_resource
-				    = { .name = "vga+", .start = 0x3C0, .end = 0x3DF };
+				static struct resource vga_console_resource =
+				    { .name	= "vga+",
+				      .flags	= IORESOURCE_IO,
+				      .start	= 0x3C0,
+				      .end	= 0x3DF };
 				vga_video_type = VIDEO_TYPE_VGAC;
 				display_desc = "VGA+";
 				request_resource(&ioport_resource,
@@ -494,7 +509,10 @@ static const char *vgacon_startup(void)
 			}
 		} else {
 			static struct resource cga_console_resource =
-			    { .name = "cga", .start = 0x3D4, .end = 0x3D5 };
+			    { .name	= "cga",
+			      .flags	= IORESOURCE_IO,
+			      .start	= 0x3D4,
+			      .end	= 0x3D5 };
 			vga_video_type = VIDEO_TYPE_CGA;
 			vga_vram_size = 0x2000;
 			display_desc = "*CGA";
