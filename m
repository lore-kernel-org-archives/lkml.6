Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3937186-1523632646-2-13905448804772890814
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523632644; b=aJphDVlzEkeFdRb83PTKY9sqwoUfV7jpHJYmo5gS1ZtQtgSM5z
    2Lug6rxNEL64aoCq6D31AIDD1/3LmBy7NE342v5q7+q/U0DmAKO3yJFNqCtAdY/n
    Fj4pfxM/lcZtRgjoNbaN0RFDJaTvE6ULtHKILqySfoAH8KkP3QNXQP+/VlVP21xo
    yS5bky3QIunRwvi2Xvzgwq+vE9tNmfViN7bUW2XJe6Y6gwVfqaBN/IOatBsE3pFd
    +yEL4qBbfkyPdEB6msS+48fztZSyxh4bGtPePwfvgvbRzXE8CDno6hrSP+Z/5uDj
    MNRKxb2dNk0AewAQ8tnZGMjDnFP9/iMxxkaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1523632644; bh=
    DApIBj83uucsvs+Btg5W9uiY9pac9JjnK+GPjUXaFrA=; b=uOZ1BB9ahMtuHjv5
    lkvncqvCnEEHoDC++C+0rEmgTwTuwRFOadFCjArBNw7qn0J2dn85hYt53bwOUWk/
    L4GupJqfrtSBTiLobhGy+nZjdBPJ+qtCaSbWHF/ABruINzgcaaPbaYaGaACty1Gk
    r++6MPZcmvnk+TbT4egT97asQL0StX44SUUztlAPb1A9McixGTiWE9wO7oFgPH19
    byJOnP7CRpUb+4AnORYl2SSX1YEoXedKN3BD3BM8wlpL11jFryuDZ77gZZqTiyCT
    aB9K9BZhZOCZSC3u1rtqIkj6K0iOy7WboYhrUa0Uih0fVCh/yAoRsAPMHHvqtd/l
    T21hgQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=T4hw1St4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Mx6KVTnD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=T4hw1St4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Mx6KVTnD;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFX14E39EdHa8HiSxgloYULPAAN51fO4oOMbE4D2JSQJ7sEjh4MLr3+FPGtLW+yD1Kin8cBL7nZbJcwWpOWOKJQDSp9eE/OsCvVsfLuFV098yMGu6Tbm
    wBwVYFeH/crdzdZ0YDN9I00QhXy8rTuGPF6lRr41AVJ43vakzhxQllcu1pzxz2oZ9yT/7pUClxht8mfykyrycHUeTNSwRjYaRvzVg1LNu3XOJsxO+FgZRKsQ
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8
    a=ea7MOwMRq6Y8oEVSpCIA:9 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbeDMPRU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 13 Apr 2018 11:17:20 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44284 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751116AbeDMPRT (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Fri, 13 Apr 2018 11:17:19 -0400
X-Google-Smtp-Source: AIpwx4+Dpz2x8cZrMYZ3B3QwQPNxmsv9DFgnM6ybQR0WEZWcPSnjoz965deVChXD+1+W7f3OzoN31Q==
From: Johan Hovold <johan@kernel.org>
To: Bin Liu <b-liu@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan@kernel.org>
Subject: [PATCH 3/3] USB: musb: dsps: propagate device-tree node
Date: Fri, 13 Apr 2018 17:15:05 +0200
Message-Id: <20180413151505.32663-4-johan@kernel.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180413151505.32663-1-johan@kernel.org>
References: <20180413151505.32663-1-johan@kernel.org>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

To be able to use DSPS-based controllers with device-tree descriptions
of the USB topology, we need to associate the glue device's device-tree
node with the child controller device.

Note that this can also be used to eventually let USB core manage
generic phys.

Also note that the other glue drivers will require similar changes to be
able to describe their buses in DT.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/musb/musb_dsps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 6a60bc0490c5..23dba59045a7 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -786,6 +786,7 @@ static int dsps_create_musb_pdev(struct dsps_glue *glue,
 	musb->dev.parent		= dev;
 	musb->dev.dma_mask		= &musb_dmamask;
 	musb->dev.coherent_dma_mask	= musb_dmamask;
+	device_set_of_node_from_dev(&musb->dev, &parent->dev);
 
 	glue->musb = musb;
 
-- 
2.17.0

