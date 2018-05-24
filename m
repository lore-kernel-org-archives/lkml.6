Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1862185-1527162175-2-729556331711484008
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527162174; b=IT4AbR7+wnmNvfzMynlFeiMjgxtCKRgzxVHcQN9Lmjxm66y3FB
    4S9TxJw/qjtGw1FVoIxRTnu4Xng/u0CdADb9ZojEnc0cPMMbAIn0PHnnAlkUtPPJ
    qq/mxiNGcJE/w0lUsRnTZJHMdJnehWFmyHx7qbnvSqATue/dQK4BVw/5gqvBdj1r
    VlcWJslqzzXGt/GjMJTE/G5woub8EJV0T7LVhEtuJjgFBVS8WSdoc3UBTgeCOxNC
    2+Doelg/x0nZGcwPKZxxjzKye7dBFQAZlT06DXLm0IS09xHTu6WtGwGvqgjdNFPm
    kiwo4b+0yGicm5X0fnPc/6TZ9VkWpIM4/2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527162174; bh=jeqQzYSGerE9y5aowuzk4fY7v1RjZ7
    /cN8ZczHj8Hbw=; b=LupTVpV5FFuED4OkC3xwM+9MbAk2ClfvR91pGfg+linXKH
    dGkaADWOc5TJcYixvRZYs1qJqWTfEG9N9Se5CUrBt0snQxABDIBeqYRx9D/6F2hg
    AETqZH4brDOl+VJufjyDJ63ghr0obv90uL1jdu3GT9Lqwyjioy/W0zmiEcfF25Ft
    Ucy4rE3OCjnjCmbluPHBp5QI1H1kEy5LVxGjMIkSDdvclS7vMFiorjwxYGea1jq+
    psO2kA0cal/1BoqUDS0KBTifqDqUOSfMKPQfHkCYiefUFi9atXwC1WoDgSkOwbDO
    +RdKOFGs0TGj0L0ah+tZqmxQBiNRawlpMoeOWHrw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=n472K/Ef x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=n472K/Ef x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGvisYOoki1mSOhkGElLVGtsRsZ1QYzBYzU+GbHrD9oy6uiouVKY8ndRDk+y1RwzbT+6mu3/wXsg/Im2YXPvWiupCRTTs9ImhgN2UZpuIDXij2FpeGzp
    VvsLjFZXzw5Z99oTTgVpmAL+ZHaxw51rkuJdN9ZF0EkvXoCQ3X1LNmri7kPjRztsAsdB5aus6a011ECXPHGk9FJit39luFKypMe94GpN5houmxCX3nNY/Ffc
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=ky6cq47XyTU6ZtwUwboA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969161AbeEXLmk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 07:42:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966909AbeEXJsY (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 05:48:24 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 38/96] xhci: zero usb device slot_id member when disabling and freeing a xhci slot
Date: Thu, 24 May 2018 11:38:21 +0200
Message-Id: <20180524093607.745292597@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
References: <20180524093605.602125311@linuxfoundation.org>
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

From: Mathias Nyman <mathias.nyman@linux.intel.com>

[ Upstream commit a400efe455f7b61ac9a801ac8d0d01f8c8d82dd5 ]

set udev->slot_id to zero when disabling and freeing the xhci slot.
Prevents usb core from calling xhci with a stale slot id.

xHC controller may be reset during resume to recover from some error.
All slots are unusable as they are disabled and freed.
xhci driver starts slot enumeration again from 1 in the order they are
enabled. In the worst case a stale udev->slot_id for one device matches
a newly enabled slot_id for a different device, causing us to
perform a action on the wrong device.

Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-mem.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -975,6 +975,8 @@ void xhci_free_virt_device(struct xhci_h
 	if (dev->out_ctx)
 		xhci_free_container_ctx(xhci, dev->out_ctx);
 
+	if (dev->udev && dev->udev->slot_id)
+		dev->udev->slot_id = 0;
 	kfree(xhci->devs[slot_id]);
 	xhci->devs[slot_id] = NULL;
 }
