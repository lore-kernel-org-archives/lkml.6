Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1851310-1525116473-5-1201946088700410826
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
    1525116472; b=QPEpmGANcNvTNjcvkS9UI+kToMFWSEdEgtShapLPWYA9bk1EjG
    ZAbgXR251kR9nbPOdplRt7il8yDNSUJs4LfOcm6hykgMBRchguRCDBOJ86akr7WU
    OxugwK7w/NAFrQZD6bpFh0mMgfPTrV2ZL4eF4jwRPsQABE6isuaWmtLTsV/uy1Ee
    6rbLNfFhURr4CLQxcPf+dc6XXYbpy+SNDxkhA+SCYTTkY3f3jaj/1lC4knKQxNMQ
    yufgGnrnyrCE6J7triLyR9XD4D/K94OrdFI2cvifDozPRrIKczr7lioJdvjuN/5F
    +qwATm5n45fp71wi/EBFammmTtfGNX5kGD7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525116472; bh=j/XotatkY8QSsS8/5HjcqkdvtHtWwY
    P1sBfFX7pLbag=; b=BTKjzgbLWe53x5ysv00uW5W4YUBNnqTAvbWicpxIx4vF4Q
    q4iIBhmMZy9U+o2Ig9PdQ/xT7ms4ce3ulOrp+AlwLn3QVPeqyvRlIuGAfqy3Fbqv
    JIo3jO3sf6EZcq+MjeFyK4LYbbV+DZS2j3XJHqbhcfqNd5zD+www6qWfgNepabAi
    gwG4axANiV3iumz6dJW0ex9k4yvK+tdh5IzrvgaR/ROJIwWO7W1YK73CpumpIan2
    v3MdN40+Il+5hq7WHngHCHrzQp/jsEe/Im8P1cc+u2W+5qhnp8kRa6f/ZYWogJNl
    U4s3GuCybbyRTwz7TJpMm+gi3IdoL0wjTt9rHlTw==
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
X-CM-Envelope: MS4wfDeCOvhgxbYUCqmRFVDJ099VJqfb9k+yeXfrYd7XaWPwVqyzfjCAHv71vJRYLQZU70YDgx5sZjVRHIHg1t5R20C/9XnLGpfZ8wxtzvYtDn7t5T0zjgvS
    wmr1NY6GX2ykgkzaHojXiVMTOktP8r9cnQG6tMQuhtu6M6i8OUAzzQ5cw/AA7r4gVg7Eon0e13yHSeTQViz7G07YRaJfiwWlDf4YQsp2RWSBStNVLMuKcWAD
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=uAS_uZ3KAAAA:8 a=VwQbUJbxAAAA:8 a=wMNdZWldAAAA:8 a=ag1SF4gXAAAA:8
    a=OW-9RmJhBqJQCZg57bsA:9 a=QEXdDO2ut3YA:10 a=_KzJdI3Ai4rueFdl_XLO:22
    a=AjGcO6oz07-iQ99wixmX:22 a=FUarYpL4UH3yWsho8X8J:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756051AbeD3T1s (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:27:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:34720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755263AbeD3T1q (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:27:46 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1027722E72
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Neuling <mikey@neuling.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH 4.14 90/91] powerpc/eeh: Fix race with driver un/bind
Date: Mon, 30 Apr 2018 12:25:12 -0700
Message-Id: <20180430184009.002164454@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184004.216234025@linuxfoundation.org>
References: <20180430184004.216234025@linuxfoundation.org>
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

From: Michael Neuling <mikey@neuling.org>

commit f0295e047fcf52ccb42561fb7de6942f5201b676 upstream.

The current EEH callbacks can race with a driver unbind. This can
result in a backtraces like this:

  EEH: Frozen PHB#0-PE#1fc detected
  EEH: PE location: S000009, PHB location: N/A
  CPU: 2 PID: 2312 Comm: kworker/u258:3 Not tainted 4.15.6-openpower1 #2
  Workqueue: nvme-wq nvme_reset_work [nvme]
  Call Trace:
    dump_stack+0x9c/0xd0 (unreliable)
    eeh_dev_check_failure+0x420/0x470
    eeh_check_failure+0xa0/0xa4
    nvme_reset_work+0x138/0x1414 [nvme]
    process_one_work+0x1ec/0x328
    worker_thread+0x2e4/0x3a8
    kthread+0x14c/0x154
    ret_from_kernel_thread+0x5c/0xc8
  nvme nvme1: Removing after probe failure status: -19
  <snip>
  cpu 0x23: Vector: 300 (Data Access) at [c000000ff50f3800]
      pc: c0080000089a0eb0: nvme_error_detected+0x4c/0x90 [nvme]
      lr: c000000000026564: eeh_report_error+0xe0/0x110
      sp: c000000ff50f3a80
     msr: 9000000000009033
     dar: 400
   dsisr: 40000000
    current = 0xc000000ff507c000
    paca    = 0xc00000000fdc9d80   softe: 0        irq_happened: 0x01
      pid   = 782, comm = eehd
  Linux version 4.15.6-openpower1 (smc@smc-desktop) (gcc version 6.4.0 (Buildroot 2017.11.2-00008-g4b6188e)) #2 SM                                             P Tue Feb 27 12:33:27 PST 2018
  enter ? for help
    eeh_report_error+0xe0/0x110
    eeh_pe_dev_traverse+0xc0/0xdc
    eeh_handle_normal_event+0x184/0x4c4
    eeh_handle_event+0x30/0x288
    eeh_event_handler+0x124/0x170
    kthread+0x14c/0x154
    ret_from_kernel_thread+0x5c/0xc8

The first part is an EEH (on boot), the second half is the resulting
crash. nvme probe starts the nvme_reset_work() worker thread. This
worker thread starts touching the device which see a device error
(EEH) and hence queues up an event in the powerpc EEH worker
thread. nvme_reset_work() then continues and runs
nvme_remove_dead_ctrl_work() which results in unbinding the driver
from the device and hence releases all resources. At the same time,
the EEH worker thread starts doing the EEH .error_detected() driver
callback, which no longer works since the resources have been freed.

This fixes the problem in the same way the generic PCIe AER code (in
drivers/pci/pcie/aer/aerdrv_core.c) does. It makes the EEH code hold
the device_lock() while performing the driver EEH callbacks and
associated code. This ensures either the callbacks are no longer
register, or if they are registered the driver will not be removed
from underneath us.

This has been broken forever. The EEH call backs were first introduced
in 2005 (in 77bd7415610) but it's not clear if a lock was needed back
then.

Fixes: 77bd74156101 ("[PATCH] powerpc: PCI Error Recovery: PPC64 core recovery routines")
Cc: stable@vger.kernel.org # v2.6.16+
Signed-off-by: Michael Neuling <mikey@neuling.org>
Reviewed-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/powerpc/kernel/eeh_driver.c |   61 ++++++++++++++++++++++++---------------
 1 file changed, 38 insertions(+), 23 deletions(-)

--- a/arch/powerpc/kernel/eeh_driver.c
+++ b/arch/powerpc/kernel/eeh_driver.c
@@ -207,18 +207,18 @@ static void *eeh_report_error(void *data
 
 	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
 		return NULL;
+
+	device_lock(&dev->dev);
 	dev->error_state = pci_channel_io_frozen;
 
 	driver = eeh_pcid_get(dev);
-	if (!driver) return NULL;
+	if (!driver) goto out_no_dev;
 
 	eeh_disable_irq(dev);
 
 	if (!driver->err_handler ||
-	    !driver->err_handler->error_detected) {
-		eeh_pcid_put(dev);
-		return NULL;
-	}
+	    !driver->err_handler->error_detected)
+		goto out;
 
 	rc = driver->err_handler->error_detected(dev, pci_channel_io_frozen);
 
@@ -227,7 +227,10 @@ static void *eeh_report_error(void *data
 	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
 
 	edev->in_error = true;
+out:
 	eeh_pcid_put(dev);
+out_no_dev:
+	device_unlock(&dev->dev);
 	return NULL;
 }
 
@@ -250,15 +253,14 @@ static void *eeh_report_mmio_enabled(voi
 	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
 		return NULL;
 
+	device_lock(&dev->dev);
 	driver = eeh_pcid_get(dev);
-	if (!driver) return NULL;
+	if (!driver) goto out_no_dev;
 
 	if (!driver->err_handler ||
 	    !driver->err_handler->mmio_enabled ||
-	    (edev->mode & EEH_DEV_NO_HANDLER)) {
-		eeh_pcid_put(dev);
-		return NULL;
-	}
+	    (edev->mode & EEH_DEV_NO_HANDLER))
+		goto out;
 
 	rc = driver->err_handler->mmio_enabled(dev);
 
@@ -266,7 +268,10 @@ static void *eeh_report_mmio_enabled(voi
 	if (rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
 	if (*res == PCI_ERS_RESULT_NONE) *res = rc;
 
+out:
 	eeh_pcid_put(dev);
+out_no_dev:
+	device_unlock(&dev->dev);
 	return NULL;
 }
 
@@ -289,20 +294,20 @@ static void *eeh_report_reset(void *data
 
 	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
 		return NULL;
+
+	device_lock(&dev->dev);
 	dev->error_state = pci_channel_io_normal;
 
 	driver = eeh_pcid_get(dev);
-	if (!driver) return NULL;
+	if (!driver) goto out_no_dev;
 
 	eeh_enable_irq(dev);
 
 	if (!driver->err_handler ||
 	    !driver->err_handler->slot_reset ||
 	    (edev->mode & EEH_DEV_NO_HANDLER) ||
-	    (!edev->in_error)) {
-		eeh_pcid_put(dev);
-		return NULL;
-	}
+	    (!edev->in_error))
+		goto out;
 
 	rc = driver->err_handler->slot_reset(dev);
 	if ((*res == PCI_ERS_RESULT_NONE) ||
@@ -310,7 +315,10 @@ static void *eeh_report_reset(void *data
 	if (*res == PCI_ERS_RESULT_DISCONNECT &&
 	     rc == PCI_ERS_RESULT_NEED_RESET) *res = rc;
 
+out:
 	eeh_pcid_put(dev);
+out_no_dev:
+	device_unlock(&dev->dev);
 	return NULL;
 }
 
@@ -361,10 +369,12 @@ static void *eeh_report_resume(void *dat
 
 	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
 		return NULL;
+
+	device_lock(&dev->dev);
 	dev->error_state = pci_channel_io_normal;
 
 	driver = eeh_pcid_get(dev);
-	if (!driver) return NULL;
+	if (!driver) goto out_no_dev;
 
 	was_in_error = edev->in_error;
 	edev->in_error = false;
@@ -374,13 +384,15 @@ static void *eeh_report_resume(void *dat
 	    !driver->err_handler->resume ||
 	    (edev->mode & EEH_DEV_NO_HANDLER) || !was_in_error) {
 		edev->mode &= ~EEH_DEV_NO_HANDLER;
-		eeh_pcid_put(dev);
-		return NULL;
+		goto out;
 	}
 
 	driver->err_handler->resume(dev);
 
+out:
 	eeh_pcid_put(dev);
+out_no_dev:
+	device_unlock(&dev->dev);
 	return NULL;
 }
 
@@ -400,22 +412,25 @@ static void *eeh_report_failure(void *da
 
 	if (!dev || eeh_dev_removed(edev) || eeh_pe_passed(edev->pe))
 		return NULL;
+
+	device_lock(&dev->dev);
 	dev->error_state = pci_channel_io_perm_failure;
 
 	driver = eeh_pcid_get(dev);
-	if (!driver) return NULL;
+	if (!driver) goto out_no_dev;
 
 	eeh_disable_irq(dev);
 
 	if (!driver->err_handler ||
-	    !driver->err_handler->error_detected) {
-		eeh_pcid_put(dev);
-		return NULL;
-	}
+	    !driver->err_handler->error_detected)
+		goto out;
 
 	driver->err_handler->error_detected(dev, pci_channel_io_perm_failure);
 
+out:
 	eeh_pcid_put(dev);
+out_no_dev:
+	device_unlock(&dev->dev);
 	return NULL;
 }
 
