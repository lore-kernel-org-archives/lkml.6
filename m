Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2591571-1524405375-2-1207970481048395925
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
    1524405374; b=MCQjL4bh2Gyz+ZZOzGCZdhEh4N0rga9BCyVQHg4u4/n7tovqnm
    1QGSRhvcvvUd2iHT1MFFNgy49FVuE5rBOVrM7vSVj2x/2Y/MLJqiVDyFRgtjJirb
    tovcXcbr3ghbYZf49RhldjMBGdCf30Ez7bNzcMjnzTUf+AUqEPPKswh1/En6/YqP
    9/mAzrOsQ4WDuVRSIkjg3uEdn3Qi71RK57NLIgyxaQdLf0rpVTXWmApGXpDzXBKc
    sP/9UsaXcw1GX+sYHGb0M2EGDLohQ0owX+UC6yLPMab+qZrB+XKMHFVTsi39mHFH
    3X/smefEsf8qCYoMqK71ou1cWHLVJqGUvIEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524405374; bh=0grk60B6DtT6MU4jFNVH849FLh/LTX
    aR+7cOY/amBO0=; b=vj21TE4Z8+TGreP0WWJcAUMHMu5a7kj2wR1KiKpeYPl46x
    X8Re/nDldR8yL8fDyHRsZEuoG64kYO1qet1o7u8jMjm3pFXnJVNRQ0Z3j4oij4qG
    Ok17fxT/F30XBDXIBnjTBi7bctnZNmwSGQnHqIvqe+Bkptqf8iz3e1mHhy8kJdCR
    pe08f39RcH2jaJgPlkRuQAhPo/CX0fD7BQgGupTmQn8kxvS/gfWMHLS+gCLqpy+C
    GDMXFdjU0kGrN4l7Zp9JQiGUsmzAFydyfD0yjB+2YazTKNtrqsKqsrIHJMlZbCq/
    3RPxQOS0RlnOF27Oqkf6WlCWjMoiA0zlXwzzaS7g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
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
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfER+84aejBot/E5yLz+t2TgwyUCEre6fvYRySMPXDuMbnuDGN1SJF/p/y2RP0g7dWmpT85lUzc23HQR+UdWYWzGI17MreuEuIvDkwkkqhuX3t3lYBB51
    vSCPzmr0f6OHVw/h2LVilNLeCqFg5R3NeelU1KJQgiYrcHBUfWCEEXY86RgxN0zl3a2sZ3wjG9kt5GycWsf/RECPvciHIZNkFpaPNOFflNXYpk8kuat4tBm4
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=pRq8SiSrAAAA:8 a=1XWaLZrsAAAA:8
    a=ag1SF4gXAAAA:8 a=2F0HSJvo52QICV2OOD8A:9 a=Bsb6VEtu94zgjH6v:21
    a=D_P7HJuxNn0wXDib:21 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
    a=lMx4IDplNLlmSqlV0VPG:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752661AbeDVN4L (ORCPT <rfc822;greg@kroah.com>);
        Sun, 22 Apr 2018 09:56:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44904 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753645AbeDVN4F (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 22 Apr 2018 09:56:05 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mike Lothian <mike@fireburn.co.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 4.16 038/196] ACPI / hotplug / PCI: Check presence of slot itself in get_slot_status()
Date: Sun, 22 Apr 2018 15:50:58 +0200
Message-Id: <20180422135106.061943727@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 13d3047c81505cc0fb9bdae7810676e70523c8bf upstream.

Mike Lothian reported that plugging in a USB-C device does not work
properly in his Dell Alienware system.  This system has an Intel Alpine
Ridge Thunderbolt controller providing USB-C functionality.  In these
systems the USB controller (xHCI) is hotplugged whenever a device is
connected to the port using ACPI-based hotplug.

The ACPI description of the root port in question is as follows:

  Device (RP01)
  {
      Name (_ADR, 0x001C0000)

      Device (PXSX)
      {
          Name (_ADR, 0x02)

          Method (_RMV, 0, NotSerialized)
          {
              // ...
          }
      }

Here _ADR 0x02 means device 0, function 2 on the bus under root port (RP01)
but that seems to be incorrect because device 0 is the upstream port of the
Alpine Ridge PCIe switch and it has no functions other than 0 (the bridge
itself).  When we get ACPI Notify() to the root port resulting from
connecting a USB-C device, Linux tries to read PCI_VENDOR_ID from device 0,
function 2 which of course always returns 0xffffffff because there is no
such function and we never find the device.

In Windows this works fine.

Now, since we get ACPI Notify() to the root port and not to the PXSX device
we should actually start our scan from there as well and not from the
non-existent PXSX device.  Fix this by checking presence of the slot itself
(function 0) if we fail to do that otherwise.

While there use pci_bus_read_dev_vendor_id() in get_slot_status(), which is
the recommended way to read Device and Vendor IDs of devices on PCI buses.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=198557
Reported-by: Mike Lothian <mike@fireburn.co.uk>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pci/hotplug/acpiphp_glue.c |   23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -541,6 +541,7 @@ static unsigned int get_slot_status(stru
 {
 	unsigned long long sta = 0;
 	struct acpiphp_func *func;
+	u32 dvid;
 
 	list_for_each_entry(func, &slot->funcs, sibling) {
 		if (func->flags & FUNC_HAS_STA) {
@@ -551,19 +552,27 @@ static unsigned int get_slot_status(stru
 			if (ACPI_SUCCESS(status) && sta)
 				break;
 		} else {
-			u32 dvid;
-
-			pci_bus_read_config_dword(slot->bus,
-						  PCI_DEVFN(slot->device,
-							    func->function),
-						  PCI_VENDOR_ID, &dvid);
-			if (dvid != 0xffffffff) {
+			if (pci_bus_read_dev_vendor_id(slot->bus,
+					PCI_DEVFN(slot->device, func->function),
+					&dvid, 0)) {
 				sta = ACPI_STA_ALL;
 				break;
 			}
 		}
 	}
 
+	if (!sta) {
+		/*
+		 * Check for the slot itself since it may be that the
+		 * ACPI slot is a device below PCIe upstream port so in
+		 * that case it may not even be reachable yet.
+		 */
+		if (pci_bus_read_dev_vendor_id(slot->bus,
+				PCI_DEVFN(slot->device, 0), &dvid, 0)) {
+			sta = ACPI_STA_ALL;
+		}
+	}
+
 	return (unsigned int)sta;
 }
 
