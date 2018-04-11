Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3397032-1523481769-2-3399237555608030250
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
    1523481769; b=QX1KegtfCAwHXtaA6rJqc/2+/7642qdvHyGuzko86gYzMvqmAu
    i1j0+pIe5k8hByWXvCqEwBgVKGgbtXCTU6qA79p769Vc/sFICW7eZzolWl6xATlu
    oTKJp1QbJj8nRfCS2/Vk3gIgvNkJ8x+TRTondtvXhnpFnR0sIZVHhP12+N4PfhGi
    PsyUo/b7sLJAoPvkgchMd52/SyHOXF/0CsqEunhx6dKUbIhKP7w3QvpqGmZ0mhGn
    4TLayRfeMleKpgi0RLc8A7nPEwpXStl4Ks09nevl+ogkZE4y/9BtadcBT5oQnQRy
    XCQxnAElcGZiKXMj3HdJ8YCgnt+wa0XE7sgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481769; bh=9gaC11S4ZGU1UlM0kOk5XCv0En+nkM
    HmM29Qhw9dlR0=; b=LfEe6DkhjQaQL1GjLapqhDyiHMs/OQDDeAs2i5RPi4jYHp
    I3JxIJz7wJWpwDXkd3geilao1ymnqjbF1Mtc5Jam6eVpSDKAEczRrKUOkxeuFSRr
    WqAOvdK0Rwz43MVwl1muAXXPDrpMoIa7cx2q3qn2MMP4OtCnqhEXrrnFHksujf2Z
    Yh7AcRP/U459eHhOSNVuHoEo1M9MiQDEDZItJeC+gKtF/iqwX4uNy5Hvb4GAjb8C
    jZFcPKlnbHz64LP1GWPBI643dnRWxnkOLobTIhvzdpSCuT+2ocXrtsFBVt5lX+8G
    SFPSw9o2U1MI9XaBkzBJdoXGgRJI8EMEZEldE+Kw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfBHJgtYpZYg61IZ0DvEdyza6MJ/8q65IIX97nLOisNiVdTzuaPE9C7md7GrEef/leIOX6lxLm93OljN6ZJJwRHmeltwfqe2KdNhb9dszM4rvge7xBEer
    F1KRyed2Qu8TLh1hbmLdIhpidKG0PkuL7DtirjC20gcwyZjxaHZhtqAdkgM1rYK5+yPb3k/pzBBSHGuRwti+PNR5VGLs1HEwKolKBFOplUR3OCGA0YhaZP0X
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=yMhMjlubAAAA:8 a=r7Wo1piAP4B2Vpw2BncA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754840AbeDKVWr (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 17:22:47 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55558 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754237AbeDKSiz (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:38:55 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 029/121] USB: ene_usb6250: fix first command execution
Date: Wed, 11 Apr 2018 20:35:32 +0200
Message-Id: <20180411183457.855880455@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
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

From: Alan Stern <stern@rowland.harvard.edu>


[ Upstream commit 4b309f1c4972c8f09e03ac64fc63510dbf5591a4 ]

In the ene_usb6250 sub-driver for usb-storage, the ene_transport()
routine is supposed to initialize the driver before executing the
current command, if the initialization has not already been performed.
However, a bug in the routine causes it to skip the command after
doing the initialization.  Also, the routine does not return an
appropriate error code if either the initialization or the command
fails.

As a result of the first bug, the first command (a SCSI INQUIRY) is
not carried out.  The results can be seen in the system log, in the
form of a warning message and empty or garbage INQUIRY data:

Apr 18 22:40:08 notebook2 kernel: scsi host6: scsi scan: INQUIRY result too short (5), using 36
Apr 18 22:40:08 notebook2 kernel: scsi 6:0:0:0: Direct-Access                                    PQ: 0 ANSI: 0

This patch fixes both errors.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-and-tested-by: Andreas Hartmann <andihartmann@01019freenet.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/storage/ene_ub6250.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/drivers/usb/storage/ene_ub6250.c
+++ b/drivers/usb/storage/ene_ub6250.c
@@ -2303,21 +2303,22 @@ static int ms_scsi_irp(struct us_data *u
 
 static int ene_transport(struct scsi_cmnd *srb, struct us_data *us)
 {
-	int result = 0;
+	int result = USB_STOR_XFER_GOOD;
 	struct ene_ub6250_info *info = (struct ene_ub6250_info *)(us->extra);
 
 	/*US_DEBUG(usb_stor_show_command(us, srb)); */
 	scsi_set_resid(srb, 0);
-	if (unlikely(!(info->SD_Status.Ready || info->MS_Status.Ready))) {
+	if (unlikely(!(info->SD_Status.Ready || info->MS_Status.Ready)))
 		result = ene_init(us);
-	} else {
+	if (result == USB_STOR_XFER_GOOD) {
+		result = USB_STOR_TRANSPORT_ERROR;
 		if (info->SD_Status.Ready)
 			result = sd_scsi_irp(us, srb);
 
 		if (info->MS_Status.Ready)
 			result = ms_scsi_irp(us, srb);
 	}
-	return 0;
+	return result;
 }
 
 
