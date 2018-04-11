Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3374234-1523481769-2-3351054620183285042
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
    1523481768; b=XyV1Lkz6zNJxi4M9ZEar4x2yTfJMbwkc1OLmIPZW/RP4RqF6ll
    hrWNaORx9jGaswzbVodHAo6ZnDa4yEoyIl+2zOpenwFFPI8nRmP1tfLc2Rf22pKt
    MtYKF58hdNYekOmNtFbCWt1q7HwbpTT+p0K2k8ipyWwnJCcAXdpzzSwx3RBrfY+S
    35ic8t3nxhFvhqXUztI5jud47+6Gx9jwQavr4lI8+dqEk9ZRnCvPhISs0wE+u4am
    Z0b88IzerZA+mqFHmHi/ESVh4LRj2jpPYjCtQ6Y3Cvec2FU6cvbakXbVSE3KRy5H
    AllA9NORhFTjPlzIdBV7CMBAbzAEfcJVWwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523481768; bh=pf3sduLY0vqLtl7jIF3WRMYgWKN03h
    GomrQLpOODhms=; b=PL1ay6l+VWPhyAbImmlAfTDYX0ZVeyTJx+RqccfFANzPSH
    8aTTVcnoauuko1p9DHcy2x4R8QKywg916r4HBTcMATk06XDeiqnWe1altUamWQxs
    YgHElCyc/+Fk6XMxGetSORI2UHmlOuqtmtyx4qe9U1NQqD1lHKqO2HxNxy4iYU0Q
    Am2KacZK8xVpW1PoyOEXteJnKU2+hXiKquRqnShO+7q+cHb0487G3kJilaxCwW6H
    mlqZ9qEf9fEyED3jYziAr/IZxuysWX1VR5WbOQIXOKRwTeT+cR+1ivCtn+68AEjJ
    zwhtR9JVWtO+d0YFLQkUthR87iY+e9x2K+DvJQAA==
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
X-CM-Envelope: MS4wfEqCbku0dpcuZjF7Ftl7Gma4y5V0dh7OAnugUL+r67AlNM/Z3gpTyAD+//5iujhCoXy0NuUNARnYitrR6f3x22TzcsI3q7N+YlHQzHYHrR3QKLAH2e1o
    jdV++qg9OqZzx+mMee/74nAJhXv12lyuRR89Y2aa6IxWHN+8EXjsy+rzeK6sgLn+Lu2XM9o08/c2SEY0esumDOi9cqo7/ToTO6GmBzVvB48fywcSkTctpkQ/
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=yMhMjlubAAAA:8 a=Y-UeaLEg1Km7jvj322IA:9 a=QEXdDO2ut3YA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755052AbeDKVWa (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 17:22:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55574 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754254AbeDKSjA (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:39:00 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 031/121] USB: ene_usb6250: fix SCSI residue overwriting
Date: Wed, 11 Apr 2018 20:35:34 +0200
Message-Id: <20180411183457.977472380@linuxfoundation.org>
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


[ Upstream commit aa18c4b6e0e39bfb00af48734ec24bc189ac9909 ]

In the ene_usb6250 sub-driver for usb-storage, the SCSI residue is not
reported correctly.  The residue is initialized to 0, but this value
is overwritten whenever the driver sends firmware to the card reader
before performing the current command.  As a result, a valid READ or
WRITE operation appears to have failed, causing the SCSI core to retry
the command multiple times and eventually fail.

This patch fixes the problem by resetting the SCSI residue to 0 after
sending firmware to the device.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-and-tested-by: Andreas Hartmann <andihartmann@01019freenet.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/storage/ene_ub6250.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/storage/ene_ub6250.c
+++ b/drivers/usb/storage/ene_ub6250.c
@@ -1950,6 +1950,8 @@ static int ene_load_bincode(struct us_da
 	bcb->CDB[0] = 0xEF;
 
 	result = ene_send_scsi_cmd(us, FDIR_WRITE, buf, 0);
+	if (us->srb != NULL)
+		scsi_set_resid(us->srb, 0);
 	info->BIN_FLAG = flag;
 	kfree(buf);
 
