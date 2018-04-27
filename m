Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-288473-1524838450-2-5707162307650980852
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
    1524838448; b=YaW+0kWQl0FUBStpl9Kf2EgkrZI8AME9CFN/bzizZ2SgskcFZN
    7Livrjl1VR3C1t2YQtHfUdPKMaSnW/bb25Pa+MZFcoPtExuyu343D1AXIyBBSCUn
    c50d7pNklksr0fud0IXq6JJHD/S2U9QdEJRJOe6nJjsgvv6F/kI1+SSwoRU9iLiE
    v1pvqcaSseC7AUIWgD5My1ZwBg76YnLb9liJQN+sAWJdRWMFE9FEjglEap3zK5aO
    UmX8zTV1PBJlUaSNGGXr3ewCjZsZccGHttWyd6hghyQAMmRY0LPk9XPucqSeynOq
    O9wqwheT2XJjKzQ78NNOQYsbAhDAgjH4KYLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524838448; bh=8aiCHPc+5IoqmYintlT8wEEIVlhVaC
    Z/59CX0q3Htp8=; b=jF8zyPe0q5d80jigx+2V9uQpArdP0rmAkHtLflRHBoRzBa
    FvLxRkCEV1K3N0UUyVVRV2RcTOzjEspOHMnMb77SrUuYE9wnBvtG8AtJFSt3KHjs
    VaAqVXRjH/XdQc7P+RVRHvhUXWvd9cg+P1IOV+0Ltgea+d+y7PZQcKhxjS6fLMw7
    31LX3Vfffij1dhyCsAodrW1v850FJSW+uuhfvD0aSQD8wNVA3g7mwOZt9lTkM6HO
    ds2Y3HcE7c3CYCd4kCSKMARyls0MUCIMxREwSyvdq8dWMsViQeIDm9Miabq07GYK
    t43+TGOy1suITEszL8rZTIkEsC9zfM++v6zwxoIA==
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
X-CM-Envelope: MS4wfBECgQ4hi4EoaE9IulB6/dLZHL6tM0jwcuio1koO/+4n5VVI80XwhJM9A0ny0eby99UXSFQ96eHyfZIv++X6NiW8m7jVWbwcepJ2EcBY59h3kb/Ei4/m
    rz+IQL+rbgZiRGOAZnqsmKfLpTcDZAlaoEv/QwT9mfneM0UZmkUGW6O0ggIcw/8eS3RSbiizIqu68npGTNPjtW+ixwt6fKzAhf79BwbDhzK1ZqAh1sXi1BmV
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=ag1SF4gXAAAA:8 a=kFCnFo_P6FiZIUNO428A:9
    a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935128AbeD0OOC (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:14:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:57606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935090AbeD0ONS (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:13:18 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA23218D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [PATCH 4.16 77/81] s390/dasd: fix IO error for newly defined devices
Date: Fri, 27 Apr 2018 15:59:19 +0200
Message-Id: <20180427135747.731238095@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
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

From: Stefan Haberland <sth@linux.vnet.ibm.com>

commit 5d27a2bf6e14f5c7d1033ad1e993fcd0eba43e83 upstream.

When a new CKD storage volume is defined at the storage server, Linux
may be relying on outdated information about that volume, which leads to
the following errors:

1. Command Reject Errors for minidisk on z/VM:

dasd-eckd.b3193d: 0.0.XXXX: An error occurred in the DASD device driver,
		  reason=09
dasd(eckd): I/O status report for device 0.0.XXXX:
dasd(eckd): in req: 00000000XXXXXXXX CC:00 FC:04 AC:00 SC:17 DS:02 CS:00
	    RC:0
dasd(eckd): device 0.0.2046: Failing CCW: 00000000XXXXXXXX
dasd(eckd): Sense(hex)  0- 7: 80 00 00 00 00 00 00 00
dasd(eckd): Sense(hex)  8-15: 00 00 00 00 00 00 00 00
dasd(eckd): Sense(hex) 16-23: 00 00 00 00 e1 00 0f 00
dasd(eckd): Sense(hex) 24-31: 00 00 40 e2 00 00 00 00
dasd(eckd): 24 Byte: 0 MSG 0, no MSGb to SYSOP

2. Equipment Check errors on LPAR or for dedicated devices on z/VM:

dasd(eckd): I/O status report for device 0.0.XXXX:
dasd(eckd): in req: 00000000XXXXXXXX CC:00 FC:04 AC:00 SC:17 DS:0E CS:40
	    fcxs:01 schxs:00 RC:0
dasd(eckd): device 0.0.9713: Failing TCW: 00000000XXXXXXXX
dasd(eckd): Sense(hex)  0- 7: 10 00 00 00 13 58 4d 0f
dasd(eckd): Sense(hex)  8-15: 67 00 00 00 00 00 00 04
dasd(eckd): Sense(hex) 16-23: e5 18 05 33 97 01 0f 0f
dasd(eckd): Sense(hex) 24-31: 00 00 40 e2 00 04 58 0d
dasd(eckd): 24 Byte: 0 MSG f, no MSGb to SYSOP

Fix this problem by using the up-to-date information provided during
online processing via the device specific SNEQ to detect the case of
outdated LCU data. If there is a difference, perform a re-read of that
data.

Cc: stable@vger.kernel.org
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/s390/block/dasd_alias.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

--- a/drivers/s390/block/dasd_alias.c
+++ b/drivers/s390/block/dasd_alias.c
@@ -592,13 +592,22 @@ static int _schedule_lcu_update(struct a
 int dasd_alias_add_device(struct dasd_device *device)
 {
 	struct dasd_eckd_private *private = device->private;
-	struct alias_lcu *lcu;
+	__u8 uaddr = private->uid.real_unit_addr;
+	struct alias_lcu *lcu = private->lcu;
 	unsigned long flags;
 	int rc;
 
-	lcu = private->lcu;
 	rc = 0;
 	spin_lock_irqsave(&lcu->lock, flags);
+	/*
+	 * Check if device and lcu type differ. If so, the uac data may be
+	 * outdated and needs to be updated.
+	 */
+	if (private->uid.type !=  lcu->uac->unit[uaddr].ua_type) {
+		lcu->flags |= UPDATE_PENDING;
+		DBF_DEV_EVENT(DBF_WARNING, device, "%s",
+			      "uid type mismatch - trigger rescan");
+	}
 	if (!(lcu->flags & UPDATE_PENDING)) {
 		rc = _add_device_to_lcu(lcu, device, device);
 		if (rc)
