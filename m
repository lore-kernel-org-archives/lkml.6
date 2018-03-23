Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1153886-1521807074-2-15617930990261527873
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
    t=1521807073; b=d/olMPPEkQCit+HubqgNBUw0wb4//bJk80GmDrrevZWqYbh
    398awda7ZZ1/I5CSXt+7zZp6T5V7sdiAeAexdELqxLsr/y/K97ILAtckuczXRR7E
    rzgR0LQeksY548tSaHtSoM08W8ZLJFkBjT50OTAZKHhtgR+WTp+x5lS9c3CalVuj
    TCIz5v1tEQDKb1enJP/a4qsSUhGazwUUCuqbqJ132Kn+0CdwwQrPXDW/HkTdh/Sj
    PZSlBlkJ2HQFWxkkOcc9wxAHokcS8okAfZkTkujCq4aHiU2k8SV5XZnd6S2WIRTF
    08PsZdB23F6+mWGFh0JGowurQOTE6Mqw9rQps2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521807073; bh=61sZBSQ93hRR0sk0KncVfMP4lb
    21QYhQFqtrGEAWyHg=; b=TCrJEbkY2cJcEGD1TpencJ97JcfL7/Dn0E+0XtQMoG
    azNop2QgKvXME7y7KhGQ6QHdg7GJIO2gxPEd7s2TS1RkTjrgEt5+765xAmhAK55z
    qi/vBisF6QGA+zJnjlxOvFDrGRXrd1qhEHaeNxnFzVJoaIsZRX1U08L72gyt3bZ/
    I7HWLIv29h/6kR95n1hyV+g1ifi/X1mNium/z0aEJEvCEGTCTfJRuG4As2pmRbiN
    kkAN8Glsc8CKJ27yRmnuePShzsQr/3kivh2n44oLFnjHjFs6E6dp1CxH7oU8vAc5
    zCq/E9OkazhSZSCvqBlgEyen0NGokY5W0DSyqdHzctIA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
        id S1752945AbeCWJ5u (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 05:57:50 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35446 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752914AbeCWJ5r (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 05:57:47 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.15 45/84] vgacon: Set VGA struct resource types
Date: Fri, 23 Mar 2018 10:53:59 +0100
Message-Id: <20180323095418.793264852@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323095411.913234798@linuxfoundation.org>
References: <20180323095411.913234798@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
