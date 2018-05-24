Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1757396-1527157585-2-5121166485076436873
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
    1527157585; b=RJDWwdK0pF4xKeetPs9tR0VbAhs5kA0YEV3vi16QD52bZ2S3i3
    YlbnqeXOC/AGgXYzI3LGFdNnHW1gyKkNxf9GHyf96eyxS4zJYlkVWH1UGMyzwahf
    1yyyk62HXpBynmKf0mGJbtp5JQPno7jsn83x6qftIzTQf1A91LC5OLl2oHd3ngSB
    xEqXrLe3W/vroTHPpAQmf6hlTuU7wvj7fCd81Geq2DKbiZTvuI8wjHYaDIdry6KC
    mAgBT4R1gYsNAYxSEwtLRNHbDsnmtL0amYEOpIGnQVpekXOjAQI2kOY1+35lVG4J
    8Jy36iP2p2SxxPyfjreJDTASQuIoyEI32Thw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1527157585; bh=p1aFHun3s7+lA6VY3vlFjU19bWt+Jl
    FMX89cB3Mi3nM=; b=TczzQ5P2h2O99WvjYfhB2nZ2LP6s2V2Q3egv7LeuFVVXMp
    Osg67TA3ne9hPPQ/u+kigikLH56xjWq+YRzYgnO7G2zOAoJFwXz7sJ6UGaybmGJq
    7Pp1ToU/PTPDnV8KfgVrabC6923z6k9SumQuQjJZ7w7bVsVUajJ7l9LJjkCa7Lpo
    bdrdaf/ac/7Pkyi3HHfj2vQd9mWNfDInKnNILwUrAqdknUh4H9KkVUejMJHCYOdF
    O4i0cLnodmjeaHfhVapKBvRP3WdKG65WvIzbpsMXGKjcYcM8Ko6TGPCittWGqsN0
    QomcXqEDGppmAkukXL9NWScOk+GRQZcriHMl5YZA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=V4uoO+yt x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=V4uoO+yt x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfOPUZ1toPc8Ql6mNui8VMH3srkgO1sSOu/FR1cDlvJSRsYAX968X+Nyeh4Q7GZ3siVAY47KxvNM0XJxkisT9ce/lhZslsPbY6clzVS6DcB2k4PTTotlJ
    9TnftlUP8+KzGbEVg0qvfsW7UuHijqqu9zKzTcCUBcF4muIL5Fzgucce8WQRy6nC2B04q9sJuPBsd0VZDpfTMLGZyJjIFeyA0zy/gmK9BGuZIn9Q5J/x4UOR
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=yMhMjlubAAAA:8 a=ky6cq47XyTU6ZtwUwboA:9
    a=QEXdDO2ut3YA:10 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031126AbeEXK0H (ORCPT <rfc822;greg@kroah.com>);
        Thu, 24 May 2018 06:26:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031028AbeEXKB7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 24 May 2018 06:01:59 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 071/161] xhci: zero usb device slot_id member when disabling and freeing a xhci slot
Date: Thu, 24 May 2018 11:38:16 +0200
Message-Id: <20180524093027.003996417@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180524093018.331893860@linuxfoundation.org>
References: <20180524093018.331893860@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/host/xhci-mem.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -913,6 +913,8 @@ void xhci_free_virt_device(struct xhci_h
 	if (dev->out_ctx)
 		xhci_free_container_ctx(xhci, dev->out_ctx);
 
+	if (dev->udev && dev->udev->slot_id)
+		dev->udev->slot_id = 0;
 	kfree(xhci->devs[slot_id]);
 	xhci->devs[slot_id] = NULL;
 }
