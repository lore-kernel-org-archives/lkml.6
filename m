Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339499-1523479961-2-9951911071356260499
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
    1523479960; b=bolDYnCOEjX8CRWskx+BiOy4vdGqqUsuuKODUH3oPsmqfy2ecl
    /DMYUqbygt1WA35n/5ZJIfKxiEae0Wcd4zs8CwueMH8SF4hzwmXZvutmicLTFwaw
    yoTlkNm+ZeUtNamqs3LJRpriXHW2ZBG3558C9RInuUASCJ5mbnr/J95NNXbLJLo6
    FD25OL3156BoiKRHMVLKCpaEym8W37s0HBD/47Vf4aDTmNvZ65wp9KPmXsl5zwS6
    P1AkHb54LNqf5miwRcHSCc+jTBAIgLLNfKIC3nt7UDD3AUx0MUc+OGQl3FaiQvWE
    X8/MiAsZ/7CoPEXKC67SIRsTvyDgpQVzbfig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523479960; bh=PL1jhu4Jylh6sNc7avSJlO9H3zNvnC
    zTI8TIbLIAzIs=; b=sZ1Gp1sk6OEcAdVupRF6x+EqVcXwR5HX6UM26vKrFaDsjT
    U7g39LOKqB67gz4lMR7TKWyvDJEBFynW1bh/lAfFFYWqw/KQW3aB3ktYUVCB85u3
    gOeiCLza0u+czE3PyRAPiafxDQ41v4WDbWNHmvZhB9uYfN8rofS82c/vtERZLBwg
    Esivh74J7WMsE+BJbiwo/IgN8lHNl8EIGDwRl2h8LDBai1bU7MlOF+v5mIgR5zzg
    NHOoSW43gwWdlkptA01Uss3eJUSoe1QlX7VnQ+iWck32ai3Q+R2xyjHWXZXR9eEA
    uwlGgPzjZS5zsabJC9Cy9nnfaXZdLIFTJsxU67rQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfGTf0IxR0SMjxfeCKiIR2atzVA4dLPgaSptJnEBNICW40OARTiaeLoT7pDA2beAmBohdoFbaUZ752GW0I37P0uzdphXtv9cFAMm/Ds0F7Jfipl0+DnyF
    K01URYLt9szc2tALTA/uqBdljlbwS3pKz0qC0jrMtneb+aPA1uLI2cBjUaBRr7n2HXXMZrvOvShPnfUehRyKorD/gkWtRo06yv4TdRbAaci9yUTw4/mRo4Kg
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=yMhMjlubAAAA:8 a=r7Wo1piAP4B2Vpw2BncA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755509AbeDKSpY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:45:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58560 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755500AbeDKSpV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:45:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 044/190] USB: ene_usb6250: fix first command execution
Date: Wed, 11 Apr 2018 20:34:50 +0200
Message-Id: <20180411183552.695455701@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2306,21 +2306,22 @@ static int ms_scsi_irp(struct us_data *u
 
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
 
 static struct scsi_host_template ene_ub6250_host_template;
