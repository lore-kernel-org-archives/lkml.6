Return-Path: <SRS0=/Ixz=KV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958EDC46471
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB0C219CB
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Aug 2018 03:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eeEk48QL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB0C219CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbeHFFlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Aug 2018 01:41:19 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56804 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeHFFlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Aug 2018 01:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9XU9Tc+2s4Xjq++ogQe5Jx1yTr1jUpqprWLW371Rj1A=; b=eeEk48QLpaOujbZG9r2MbItchc
        LqeX8pMKdNMFV1+PlD2L0OV/sVaViumHnC5Qcqn7C9vICSJhwTswB06PShRqcu65WijabfLLy7ZYk
        qeM2pH6LrY3582dKxJG4uTmlHQ7XQO5rOYsma/Wg3/VJbBHMk9zjdTPVn5IJ3CzmZOL7ZDKq46oTd
        n3Q0bP8JiwBKCKs6yNIkUTHfOUBnyWRruVXasmDzxguQg1pXuBfku6+gXJgwDuK/ILDprL61X14KH
        iH8P3CHq5zxTLRa8E8yyPYYCIK3xX/eVAmLZAl+dLSoJdHN2ExFw5klZ3BGLG0YsDRH5dNRsokaT+
        5BfCRiHw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fmWHb-0005fi-56; Mon, 06 Aug 2018 03:34:12 +0000
To:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Yinghai Lu <yinghai@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        USB list <linux-usb@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] x86: corrections to Documentation/x86/earlyprintk.txt
Message-ID: <d0c40ac3-7659-6374-dbda-23d3d2577f30@infradead.org>
Date:   Sun, 5 Aug 2018 20:34:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix a few issues in Documentation/x86/earlyprintk.txt:

- correct typos, punctuation, missing word, wrong word
- change product name from Netchip to NetChip
- expand where to add "earlyprintk=dbg"

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: x86@kernel.org
Cc: linux-usb@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
 Documentation/x86/earlyprintk.txt |   25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

--- lnx-418-rc8.orig/Documentation/x86/earlyprintk.txt
+++ lnx-418-rc8/Documentation/x86/earlyprintk.txt
@@ -35,25 +35,25 @@ and two USB cables, connected like this:
 ( If your system does not list a debug port capability then you probably
   won't be able to use the USB debug key. )
 
- b.) You also need a Netchip USB debug cable/key:
+ b.) You also need a NetChip USB debug cable/key:
 
         http://www.plxtech.com/products/NET2000/NET20DC/default.asp
 
-     This is a small blue plastic connector with two USB connections,
+     This is a small blue plastic connector with two USB connections;
      it draws power from its USB connections.
 
  c.) You need a second client/console system with a high speed USB 2.0
      port.
 
- d.) The Netchip device must be plugged directly into the physical
+ d.) The NetChip device must be plugged directly into the physical
      debug port on the "host/target" system.  You cannot use a USB hub in
      between the physical debug port and the "host/target" system.
 
      The EHCI debug controller is bound to a specific physical USB
-     port and the Netchip device will only work as an early printk
+     port and the NetChip device will only work as an early printk
      device in this port.  The EHCI host controllers are electrically
      wired such that the EHCI debug controller is hooked up to the
-     first physical and there is no way to change this via software.
+     first physical port and there is no way to change this via software.
      You can find the physical port through experimentation by trying
      each physical port on the system and rebooting.  Or you can try
      and use lsusb or look at the kernel info messages emitted by the
@@ -65,9 +65,9 @@ and two USB cables, connected like this:
      to the hardware vendor, because there is no reason not to wire
      this port into one of the physically accessible ports.
 
- e.) It is also important to note, that many versions of the Netchip
+ e.) It is also important to note, that many versions of the NetChip
      device require the "client/console" system to be plugged into the
-     right and side of the device (with the product logo facing up and
+     right hand side of the device (with the product logo facing up and
      readable left to right).  The reason being is that the 5 volt
      power supply is taken from only one side of the device and it
      must be the side that does not get rebooted.
@@ -81,13 +81,18 @@ and two USB cables, connected like this:
       CONFIG_EARLY_PRINTK_DBGP=y
 
     And you need to add the boot command line: "earlyprintk=dbgp".
+
     (If you are using Grub, append it to the 'kernel' line in
-     /etc/grub.conf)
+     /etc/grub.conf.  If you are using Grub2 on a BIOS firmware system,
+     append it to the 'linux' line in /boot/grub2/grub.cfg. If you are
+     using Grub2 on an EFI firmware system, append it to the 'linux'
+     or 'linuxefi' line in /boot/grub2/grub.cfg or
+     /boot/efi/EFI/<distro>/grub.cfg.)
 
     On systems with more than one EHCI debug controller you must
     specify the correct EHCI debug controller number.  The ordering
     comes from the PCI bus enumeration of the EHCI controllers.  The
-    default with no number argument is "0" the first EHCI debug
+    default with no number argument is "0" or the first EHCI debug
     controller.  To use the second EHCI debug controller, you would
     use the command line: "earlyprintk=dbgp1"
 
@@ -111,7 +116,7 @@ and two USB cables, connected like this:
     see the raw output.
 
  c.) On Nvidia Southbridge based systems: the kernel will try to probe
-     and find out which port has debug device connected.
+     and find out which port has a debug device connected.
 
 3. Testing that it works fine:
 


