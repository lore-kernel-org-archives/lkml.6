Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1468877-1518325055-2-3084816152098733369
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518325054; b=Thl8359NH5buvdiDUEsNa47HvUt6xsUBKKZV9wIrYPM+95V
    9V9PhU/HMa1aHADC32mgTtXhIEYGnFM5hQe/xNMAhHiADN9saRu1mWVj3zPO/Uil
    rRTNjtCuA5gMVIVJ544wcUrkHnr0xBjpoUYsQ9Jh6yeQDWTXQPaLJNGfT9QgVNTL
    tPZa1Bs5G9w/ulmSilYRzTbTbnskTm+b6dVwr2yGpeJJ/5yn5MGeCu8U83YrSm6j
    uHOJP7seRRq7tMtohd2Hq449hqEmVsGn7NVX6NM5qukCvZGn9t3ftcAkY68TqCz5
    61iXLBKl/yVXNWu/giNWn3Uxw1zhNeyq9vNlu0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518325054; bh=6P3aT4kmTsDNjbRmfTz
    4jrpO8Qs7hEYIghBTcp30wgU=; b=ICC225e7NbW931Oj8JHXY68i0sx3pxhZwGh
    6hcVvsE9F1H809huBo6xowWvVi4Nc34bL9AmexKAV44o3N/+tekJ5NRiQIGoLOhH
    EXgGimPNCjx3jFmXuH4zOcvg9iaVpD7igSosWYEyMlPKMl6yvlc7jn03K5EAaBY+
    PwkzxSUY9AbFf96sbV1+S6pIgsR0FTdMvxy1CoRjt1GaRNaMTzEaXtnslYScdwJR
    /Ih++KFfiBv0T3u21kP5c0nLmhPajt68adVhj6U6EdXKOxgGHMeQYOK8soqe3gSW
    xGjhf/SeHWjHqPZ2grHnWgZz1pBlLPxb8OddJb2enhBUtFdVKbg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753548AbeBKE4A (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:56:00 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41673 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752784AbeBKEd4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:56 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Dongdong Liu" <liudongdong3@huawei.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Gabriele Paoloni" <gabriele.paoloni@huawei.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.640554736@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 010/136] PCI/AER: Report non-fatal errors only to the
 affected endpoint
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Gabriele Paoloni <gabriele.paoloni@huawei.com>

commit 86acc790717fb60fb51ea3095084e331d8711c74 upstream.

Previously, if an non-fatal error was reported by an endpoint, we
called report_error_detected() for the endpoint, every sibling on the
bus, and their descendents.  If any of them did not implement the
.error_detected() method, do_recovery() failed, leaving all these
devices unrecovered.

For example, the system described in the bugzilla below has two devices:

  0000:74:02.0 [19e5:a230] SAS controller, driver has .error_detected()
  0000:74:03.0 [19e5:a235] SATA controller, driver lacks .error_detected()

When a device such as 74:02.0 reported a non-fatal error, do_recovery()
failed because 74:03.0 lacked an .error_detected() method.  But per PCIe
r3.1, sec 6.2.2.2.2, such an error does not compromise the Link and
does not affect 74:03.0:

  Non-fatal errors are uncorrectable errors which cause a particular
  transaction to be unreliable but the Link is otherwise fully functional.
  Isolating Non-fatal from Fatal errors provides Requester/Receiver logic
  in a device or system management software the opportunity to recover from
  the error without resetting the components on the Link and disturbing
  other transactions in progress.  Devices not associated with the
  transaction in error are not impacted by the error.

Report non-fatal errors only to the endpoint that reported them.  We really
want to check for AER_NONFATAL here, but the current code structure doesn't
allow that.  Looking for pci_channel_io_normal is the best we can do now.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=197055
Fixes: 6c2b374d7485 ("PCI-Express AER implemetation: AER core and aerdriver")
Signed-off-by: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
[bhelgaas: changelog]
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/pci/pcie/aer/aerdrv_core.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/pci/pcie/aer/aerdrv_core.c
+++ b/drivers/pci/pcie/aer/aerdrv_core.c
@@ -360,7 +360,14 @@ static pci_ers_result_t broadcast_error_
 		 * If the error is reported by an end point, we think this
 		 * error is related to the upstream link of the end point.
 		 */
-		pci_walk_bus(dev->bus, cb, &result_data);
+		if (state == pci_channel_io_normal)
+			/*
+			 * the error is non fatal so the bus is ok, just invoke
+			 * the callback for the function that logged the error.
+			 */
+			cb(dev, &result_data);
+		else
+			pci_walk_bus(dev->bus, cb, &result_data);
 	}
 
 	return result_data.result;
