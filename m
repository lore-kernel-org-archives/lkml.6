Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521803878-2-1611103012155412351
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521803877; b=nTfZyLVsvak6ifUBQN3wlOIIQ/bVS0gSy9LYXfoycxR+m+s
    +EXOuf9nIueI994Zw3+XHJ0QW0jXiIx/JOW97ljoUZi9AdwTEM+gJ6FoFoKhu76k
    wJawzDJtaAv+UgGtfbN5kPwsBkaZpAbR9UXO1jcL0H0pL7UrYqkyIA6usdRtIOvH
    QhJnaXytrL+NJcmnqbSMBZAlPXJpHvjF+GcO5YHTCfgbvnFrHsL7bZTsmx21mvHX
    gYAfhobDrNdlWGaYXOcl/UpiPKqyRUOrNqmpOzexO/0sPRWcQqdqj9zDE0yANnPn
    /tUeuf12i++c9cSQeR1RPlNjm/0DZOwwdMXJTdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803877; bh=riXnYhyrZk95UqovGtvxCOx7zW
    ytm2HyQGyK/L+PHkI=; b=MY9jEPjuHdoNjMHutIKXl8MawsiMK80/X6oxnRWtZ/
    sMkUrffOVdrMnM4wIQGfQuFih8uGZjwWRPeWmd3qPfhxbxK+48c+JbQ0D0QjY8Xg
    292JWRuvc7EAt63V+EEwM3eSQoA3eI/WP/K203FOJyfvavgnzaLT1AqMq7ZBm4lX
    VMm6bGSF3+/ETkIgU1QgHGs3MODskBktoP6oGGi4QCMHHSHDLBR82debqXpiOTIR
    M5F69j0CKhm5R629w+i/IVOSdjb7Pk1GbFV3CerS+BJJrfEMsyrI53wNmxOHDA4V
    85U4MXIcJZYoYGK6YxqsPoR/STS04viE1fJuIPsVNccg==
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
        id S1752156AbeCWLR4 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:17:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42020 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755725AbeCWKJP (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:09:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sameer Wadgaonkar <sameer.wadgaonkar@unisys.com>,
        David Kershner <david.kershner@unisys.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 088/177] staging: unisys: visorhba: fix s-Par to boot with option CONFIG_VMAP_STACK set to y
Date: Fri, 23 Mar 2018 10:53:36 +0100
Message-Id: <20180323094209.170789235@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sameer Wadgaonkar <sameer.wadgaonkar@unisys.com>


[ Upstream commit 3c2bf0bd08123f3497bd3e84bd9088c937b0cb40 ]

The root issue is that we are not allowed to have items on the
stack being passed to "DMA" like operations. In this case we have
a vmcall and an inline completion of scsi command.

This patch fixes the issue by moving the variables on stack in
do_scsi_nolinuxstat() to heap memory.

Signed-off-by: Sameer Wadgaonkar <sameer.wadgaonkar@unisys.com>
Signed-off-by: David Kershner <david.kershner@unisys.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/unisys/visorhba/visorhba_main.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/staging/unisys/visorhba/visorhba_main.c
+++ b/drivers/staging/unisys/visorhba/visorhba_main.c
@@ -842,7 +842,7 @@ static void
 do_scsi_nolinuxstat(struct uiscmdrsp *cmdrsp, struct scsi_cmnd *scsicmd)
 {
 	struct scsi_device *scsidev;
-	unsigned char buf[36];
+	unsigned char *buf;
 	struct scatterlist *sg;
 	unsigned int i;
 	char *this_page;
@@ -857,6 +857,10 @@ do_scsi_nolinuxstat(struct uiscmdrsp *cm
 		if (cmdrsp->scsi.no_disk_result == 0)
 			return;
 
+		buf = kzalloc(sizeof(char) * 36, GFP_KERNEL);
+		if (!buf)
+			return;
+
 		/* Linux scsi code wants a device at Lun 0
 		 * to issue report luns, but we don't want
 		 * a disk there so we'll present a processor
@@ -868,6 +872,7 @@ do_scsi_nolinuxstat(struct uiscmdrsp *cm
 		if (scsi_sg_count(scsicmd) == 0) {
 			memcpy(scsi_sglist(scsicmd), buf,
 			       cmdrsp->scsi.bufflen);
+			kfree(buf);
 			return;
 		}
 
@@ -879,6 +884,7 @@ do_scsi_nolinuxstat(struct uiscmdrsp *cm
 			memcpy(this_page, buf + bufind, sg[i].length);
 			kunmap_atomic(this_page_orig);
 		}
+		kfree(buf);
 	} else {
 		devdata = (struct visorhba_devdata *)scsidev->host->hostdata;
 		for_each_vdisk_match(vdisk, devdata, scsidev) {
